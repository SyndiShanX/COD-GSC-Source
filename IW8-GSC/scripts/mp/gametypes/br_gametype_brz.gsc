/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_brz.gsc
****************************************************/

function init() {
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("ignoreZombiesLastStandWipe");
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerShouldRespawn", &ref_12691);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerSkipLootPickup", &ref_1269c);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerSkipKioskUse", &ref_1269b);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("vipRespawnPlayer", &ref_142cc);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToTeamLives", &addtoteamlives);
  scripts\mp\gametypes\br_gametypes::ref_12b11("removeFromTeamLives", &removefromteamlives);
  scripts\mp\gametypes\br_gametypes::ref_12b11("allowMeleeVehicleDamage", &brking_cleanupents);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12604);
  scripts\mp\gametypes\br_gametypes::ref_12b11("remainingPlayersAliveOnTeam", &ref_12bba);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("shouldLastStandDamageScale", &ref_13308);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
  scripts\mp\gametypes\br_gametypes::ref_12b11("exfilStart", &onnewequipmentpickup);
  scripts\mp\gametypes\br_gametypes::ref_12b11("gulagWinnerRespawn", &gulagwinnerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &ref_11b80);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &scripts\mp\gametypes\br_alt_mode_zxp::modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyVehicleDamage", &scripts\mp\gametypes\br_alt_mode_zxp::ref_11ca1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("ignoreVehicleExplosiveDamage", &scripts\mp\gametypes\br_alt_mode_zxp::standard_health);
  scripts\mp\gametypes\br_gametypes::ref_12b11("regenHealthAdd", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1264b);
  scripts\mp\gametypes\br_gametypes::ref_12b11("regenDelaySpeed", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1264a);
  scripts\mp\gametypes\br_gametypes::ref_12b11("lastStandAllowed", &scripts\mp\gametypes\br_alt_mode_zxp::watch_flight_collision);
  scripts\mp\gametypes\br_gametypes::ref_12b11("kioskRevivePlayer", &scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerDamaged", &scripts\mp\gametypes\br_alt_mode_zxp::onplayerdamaged);
  scripts\mp\gametypes\br_gametypes::ref_12b11("endGame", &scripts\mp\gametypes\br_alt_mode_zxp::spawnangle);
  level.disable_super_in_turret.ref_146c6 = 0;
  level.disable_super_in_turret.ref_11b76 = getdvarint("scr_br_zxp_maxTagsVisible", 0);
  level.disable_super_in_turret.ref_11b74 = getdvarfloat("scr_br_zxp_maxRadius", 0);
  level.disable_super_in_turret.ref_11b75 = level.disable_super_in_turret.ref_11b74 * level.disable_super_in_turret.ref_11b74;
  level.disable_super_in_turret.ref_13a25 = getdvarint("scr_br_zxp_autoPickup", 1);
  level.disable_super_in_turret.spawndomplates = getdvarint("scr_br_zxp_human_powers", 0);
  level.disable_super_in_turret.ref_146b2 = getdvarint("scr_br_zxp_zombie_drop_tags", 0);
  level.disable_super_in_turret.ref_11b5b = getdvarint("scr_br_zxp_max_tags", 0);
  level.disable_super_in_turret.spawndomplateflagtestmap = getdvarint("scr_br_zxp_human_loadout_restore", 0);
  level.disable_super_in_turret.ref_12cb0 = [];
  level.disable_super_in_turret.ref_12cb1 = [];
  game["dialog"]["zmb_teammate_back_human"] = "zombie_teammate_back_human";
  level.br_infils_disabled = 0;
  thread toggleusbstickinhand();
}

function toggleusbstickinhand() {
  waittillframeend();
  thread scripts\mp\gametypes\br_alt_mode_zxp::ref_1472d();
  thread ref_11cfb();
}

function ref_11cfb() {
  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_1);

      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];
        var_5 = scripts\mp\gametypes\br_public::rotationids(var_1, var_4);

        if(var_5 > 0) {
          var_6 = use_emp_drone(var_1, var_4);

          if(!var_6) {
            votesys_init(var_1, var_4);
            scripts\mp\utility\script::laststand_dogtags("monitorAllZombieTeamFixup - found invalid team");
          }
        }
      }
    }

    wait 1;
  }
}

function ref_126f1() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(game["liveLobbyCompleted"])) {
    scripts\mp\hud_message::showsplash("br_gametype_zxp_prematch_welcome");
  }

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);

  if(isalive(self) && !scripts\mp\gametypes\br_public::ref_125f3()) {
    thread ref_125db();
  }

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_zxp_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function ref_13148() {
  var_0 = -15;
  var_1 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player(1);
  var_2 = max(0, var_1 + var_0);
  var_3 = getdvarfloat("scr_br_dropbag_delay", var_2);
  scripts\mp\gametypes\br_gametypes::ref_12b10("dropBagDelay", var_3);
}

function ref_14691(var_0) {
  scripts\mp\gametypes\br_public::brleaderdialog("zmb_opening", 0, var_0);
  wait 1;
  scripts\mp\gametypes\br_public::brleaderdialog("zmb_infil_tutorial_01", 0, var_0);
}

function ref_12051() {
  self endon("disconnect");
  var_0 = self;
  wait 3;

  while(!var_0 isonground()) {
    wait 2;
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("zmb_infil_tutorial_02", var_0);
}

function ref_11b16() {
  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b16();
}

function ref_12691(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::iswaitingtoentergulag(self)) {
    return 1;
  }

  return scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_11b80(var_0, var_1) {
  var_2 = 0;
  var_3 = use_emp_drone(var_0.team, var_0.squadindex, var_0);

  if(!istrue(self.gulag) && scripts\mp\gametypes\br_zones::updatelocationbesttimehud("plague", var_0)) {
    if(var_3) {
      var_2 = var_0 scripts\mp\gametypes\br_alt_mode_zxp::ref_126d2(var_1);
    }
  } else if(!var_0 scripts\mp\gametypes\br_public::ref_125f3()) {
    var_2 = var_0 scripts\mp\gametypes\br_gulag::trygulagspawn();
  }

  if(scripts\mp\flags::gameflag("prematch_done") && !var_2) {
    if(var_0 scripts\mp\gametypes\br_public::ref_125f3()) {
      thread scripts\mp\gametypes\br_alt_mode_zxp::ref_12538();
    }

    scripts\mp\gametypes\br::ref_11b15(var_0);

    if(!var_3) {
      votesys_init(var_0.team, var_0.squadindex, var_0);
    }
  }

  return !var_2;
}

function use_emp_drone(var_0, var_1, var_2) {
  var_3 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1);

  foreach(var_6 in var_4) {
    if(isDefined(var_2) && var_6 == var_2) {
      continue;
    }

    if(istrue(var_3) && var_6 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      return true;
    }

    var_7 = var_6 scripts\mp\gametypes\br_public::ref_125f3() || var_6 scripts\mp\gametypes\br_alt_mode_zxp::ref_125e9();

    if(!var_7 && isalive(var_6) && !istrue(var_6.inlaststand)) {
      return true;
    }

    if(istrue(var_6.inlaststand) && (istrue(var_6.shouldgetnewspawnpoint) || var_6 scripts\mp\gametypes\br_gulag::ref_12517())) {
      return true;
    }
  }

  return false;
}

function votesys_init(var_0, var_1, var_2) {
  var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_2) && var_2 == var_5) {
      continue;
    }

    if(isalive(var_5)) {
      var_5 suicide();
      continue;
    }

    if(var_5 scripts\mp\gametypes\br_alt_mode_zxp::ref_125e9()) {
      var_5 scripts\mp\gametypes\br_alt_mode_zxp::ref_12681(0, 0);
      scripts\mp\gametypes\br::ref_11b15(var_5);
      var_5 scripts\mp\playerlogic::removefromalivecount();
    }
  }
}

function ref_1269c(var_0) {
  return scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_1269b(var_0) {
  return scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_13308(var_0) {
  var_1 = isPlayer(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::ref_125f3();
  var_2 = isPlayer(var_0.victim) && var_0.victim scripts\mp\gametypes\br_public::ref_125f3();

  if(var_1 && !var_2 && var_0.meansofdeath == "MOD_MELEE") {
    return false;
  }

  return true;
}

function brking_cleanupents(var_0) {
  var_1 = isPlayer(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::ref_125f3();
  return var_1;
}

function ref_12728() {
  playFX(scripts\engine\utility::getfx("zombie_trans"), self.origin);
  self notify("endSuperJumpFov");
  ref_1272e(0);
  var_0 = gettime() + 3000;

  while(self isgestureplaying() && var_0 > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(var_0 > gettime() && (self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]())) {
    waitframe();
  }

  self enableoffhandweapons();
  self giveandfireoffhand("stim_zmb_mp");
  wait 2;
}

function ref_1272e(var_0) {
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

function ref_126fa(var_0) {
  if(!istrue(var_0) && !scripts\mp\gametypes\br_public::ref_125f3()) {
    return;
  }

  scripts\mp\gametypes\br_alt_mode_zxp::ref_12681(0);
  scripts\mp\gametypes\br_alt_mode_zxp::ref_12727(0);

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

  self.ref_12ca8 = 1;
  var_1 = self.origin;
  var_2 = self.origin;
  var_3 = self getplayerangles();
  var_4 = 0;

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    var_5 = ref_125dd();
    var_2 = var_5[0];
    var_3 = var_5[1];
    var_1 = var_5[2];
    var_5 = undefined;
  } else {
    var_6 = ref_125de();
    var_2 = var_6[0];
    var_3 = var_6[1];
    var_4 = var_6[2];
    var_6 = undefined;
    var_1 = var_2;
  }

  self.plotarmor = 1;
  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  ref_12728();

  if(!var_4) {
    scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait 1;
  } else {
    waitframe();
  }

  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
  self.pers["class"] = "gamemode";
  self.class = "gamemode";
  self.forcespawnangles = var_3;
  self.forcespawnorigin = var_1;
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self skydive_deployparachute();
  thread scripts\mp\gametypes\br::defend_wave_2();
  ref_1272e(1);
  self lerpfovbypreset("default_2seconds");

  if(level.disable_super_in_turret.ref_1470d) {
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }

  if(level.disable_super_in_turret.ref_1470c) {
    scripts\mp\gametypes\br_alt_mode_zxp::ref_125da();

    if(!level.disable_super_in_turret.ref_1470d) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    self visionsetnakedforplayer("", 0);
  }

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    self.plotarmor = undefined;
    scripts\mp\gametypes\br_alt_mode_zxp::ref_126bd(var_2, var_3, var_1);
  } else {
    if(!var_4) {
      scripts\mp\gametypes\br_public::ref_126ed();
      scripts\mp\gametypes\br_public::ref_1252b();
      playFX(scripts\engine\utility::getfx("zombie_trans"), self.origin);
    }

    if(!var_4) {
      scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }

    thread ref_1252c();
  }

  if(istrue(level.disable_super_in_turret.spawndomplateflagtestmap) && scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa()) {
    ref_125fb();
  } else {
    var_7 = scripts\mp\gametypes\br::disablealltablets();
    scripts\mp\gametypes\br::searchcircleorigin(var_7, 0);
  }

  scripts\mp\gametypes\br_armor::searchcirclesize();
  thread scripts\mp\gametypes\br::defend_wave_2();
  scripts\mp\gametypes\br_alt_mode_zxp::ref_1262b(0);
  scripts\mp\hud_message::showsplash("br_gametype_zxp_change_human");
  self.plotarmor = undefined;
  thread ref_125d9();
  self.ref_12ca8 = undefined;

  foreach(var_9 in level.teamdata[self.team]["players"]) {
    if(self != var_9) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("zmb_teammate_back_human", var_9);
    }
  }
}

function ref_125dd() {
  var_0 = getdvarint("scr_br_zxp_spawnheightoffset", 3000);
  var_1 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_2 = scripts\mp\gametypes\br_gulag::ref_125be(0, var_1, var_0);
  var_3 = scripts\mp\gametypes\br_gulag::ref_1263e(var_2);
  return [var_2.origin, var_2.angles, var_3];
}

function ref_125de() {
  var_0 = ref_125d8();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];
  var_0 = undefined;

  if(!var_3) {
    scripts\mp\gametypes\br_public::ref_126b9(var_1);
  }

  return [var_1, var_2, var_3];
}

function ref_125d8() {
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

function remove_marker_when_player_disconnects(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;
  var_4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;

  if(scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo(var_3, var_4)) {
    var_5 = vectortoangles(var_1 * -1);
    return [var_3, var_5];
  }

  return [undefined, undefined];
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

function ref_125fb() {
  self takeallweapons(0, 1);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  var_0 = getcompleteweaponname("iw8_fists_mp");

  if(self.ref_1472f.ref_12889.size < 2) {
    self giveweapon(var_0);
  }

  var_1 = 0;

  foreach(var_3 in self.ref_1472f.ref_12889) {
    var_4 = createheadicon(var_3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);

    if(!var_1) {
      self assignweaponprimaryslot(var_4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
      var_1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_4);
  }

  foreach(var_7 in self.ref_1472f.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }

    var_9 = self.ref_1472f.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_4, var_12 in self.ref_1472f.brtruck_ontimelimit) {
    self setweaponammostock(var_4, var_12);
    var_3 = getcompleteweaponname(getweaponbasename(var_4));
    var_13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_4, var_12 in self.ref_1472f.brtdm_config) {
    self setweaponammoclip(var_4, var_12);
  }

  foreach(var_4, var_12 in self.ref_1472f.brtruck_cleanupents) {
    self setweaponammoclip(var_4, var_12, "left");
  }

  waitframe();
  var_16 = var_0;

  if(isDefined(self.ref_1472f.current) && self.ref_1472f.current != getcompleteweaponname("none")) {
    var_16 = self.ref_1472f.current;
  }

  self switchtoweaponimmediate(var_16);

  if(isDefined(self.ref_1472f.super)) {
    var_17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.ref_1472f.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(var_17, 0);
  }

  thread scripts\cp_mp\gestures::ref_13e1a();
  self.ref_1472f = undefined;
}

function addtoteamlives(var_0, var_1) {
  var_0 scripts\mp\gametypes\br_alt_mode_zxp::addtoteamlives(var_0, var_1);
}

function removefromteamlives(var_0, var_1) {
  var_0 scripts\mp\gametypes\br_alt_mode_zxp::removefromteamlives(var_0, var_1);
}

function ref_1472e(var_0) {
  if(level.disable_super_in_turret.spawndomplateflagtestmap && !var_0 scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa()) {
    var_0 scripts\mp\gametypes\br_alt_mode_zxp::ref_125fc();
    return;
  }
}

function gulagwinnerrespawn(var_0) {
  if(level.disable_super_in_turret.spawndomplateflagtestmap && scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa()) {
    ref_125fb();
    return;
  }
}

function ref_12702() {
  self.itemsdropped = 0;
  var_0 = level.disable_super_in_turret.ref_146c6 % 10;
  level.disable_super_in_turret.ref_146c6++;
  var_1 = verifybunkercode("zombie_death", var_0);

  if(isDefined(var_1)) {
    var_2 = scripts\mp\gametypes\br_lootcache::ref_11a42(var_1, 0);
    return;
  }
}

function ref_12604() {
  if(scripts\mp\gametypes\br_public::ref_125f3()) {
    return;
  }

  scripts\mp\gametypes\br::ref_11e23();
}

function droponplayerdeath(var_0) {
  if(scripts\mp\gametypes\br_public::ref_125f3() || istrue(self.isjuggernaut)) {
    return true;
  }

  if(level.disable_super_in_turret.spawndomplateflagtestmap) {
    scripts\mp\gametypes\br_alt_mode_zxp::ref_125fc();
  }

  return false;
}

function onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_1)) {
    return;
  }

  var_3 = var_0.hitloc;

  if(isDefined(var_3) && var_1 scripts\mp\gametypes\br_public::ref_125f3() && (var_3 == "head" || var_3 == "helmet")) {
    var_4 = 0;
    var_2 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var_4, 1);
  }

  var_1 setscriptablepartstate("skydiveVfx", "default", 0);
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

function ref_13326(var_0) {
  if(!ref_13325(var_0)) {
    return false;
  }

  if(!scripts\mp\gametypes\br_public::ref_125f3()) {
    return false;
  }

  return true;
}

function ref_13302(var_0) {
  if(!ref_13325(var_0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125f3()) {
    return false;
  }

  return true;
}

function resetdangercircleorigin() {
  var_0 = undefined;

  foreach(var_2 in level.disable_super_in_turret.ref_12cb0) {
    if(!isDefined(var_0) || var_2.lastusedtime < var_0.lastusedtime) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function spawndogtags() {
  var_0 = 16;
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(level.disable_super_in_turret.ref_12cb1.size > 0) {
    var_4 = level.disable_super_in_turret.ref_12cb1.size - 1;
    var_1 = level.disable_super_in_turret.ref_12cb1[var_4];
    level.disable_super_in_turret.ref_12cb1[var_4] = undefined;
    loadoutprimaryaddblueprintattachments(var_1);
    var_2 = 1;
    var_3 = var_1.trigger;
    var_5 = var_1.visuals;
  } else {
    jumpiffalse(level.disable_super_in_turret.ref_12cb0.size >= level.disable_super_in_turret.ref_11b5b) LOC_000000b4;
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
  var_3.ref_133e5 = 1;
  var_3.onuse = &onuse;
  var_3 scripts\mp\gameobjects::setusetime(var_8);
  var_3 scripts\mp\gametypes\br_public::timeoutonabandonedcallback();
  var_3.inuse = 1;
  var_3.lastusedtime = gettime();
  var_9 = "" + var_3 getentitynumber();
  level.disable_super_in_turret.ref_12cb0[var_9] = var_3;
  return var_3;
}

function ref_13238(var_0, var_1) {
  var_2 = 36;
  var_3 = (0, 0, 36);
  var_4 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_1, 30);
  var_5 = var_4 + (0, 0, var_2);
  var_0.curorigin = var_5;

  if(level.disable_super_in_turret.ref_13a25) {
    var_0.trigger.origin = var_5;
  }

  var_0.visuals[0].origin = var_5;
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.interactteam = "any";
  ref_1337a(var_0.visuals[0]);
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
      objective_icon(var_0.objidnum, "icon_minimap_syringe");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
    }
  }

  playsoundatpos(var_5, "mp_killconfirm_tags_drop");
  var_0.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
}

function ref_13662(var_0, var_1) {
  var_2 = spawndogtags();
  ref_13238(var_2, var_0.origin);

  if(istrue(var_0.isjuggernaut)) {
    var_3 = 2;
    var_4 = getdvarint("scr_br_zxp_numDropJugg", var_3);
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

function ref_1332e(var_0) {
  if(!ref_13325(var_0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125f3() && self.ref_11f39 > 0) {
    return true;
  }

  return false;
}

function ref_136ba(var_0, var_1) {
  var_2 = spawndogtags();
  ref_13238(var_2, var_0.origin);

  if(self.ref_11f39 > 1) {
    var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();

    for(var_4 = 1; var_4 < self.ref_11f39; var_4++) {
      var_5 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0, undefined, undefined, 0);

      if(!isDefined(var_5) || var_5.origin == (0, 0, 0)) {
        var_5.origin = var_0.origin;
      }

      var_2 = spawndogtags();
      ref_13238(var_2, var_5.origin);
    }

    return;
  }
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

function removetags(var_0) {
  loadoutprimaryaddblueprintattachments(var_0);
  var_1 = "" + var_0 getentitynumber();
  level.disable_super_in_turret.ref_12cb0[var_1] = undefined;
  level.disable_super_in_turret.ref_12cb1[level.disable_super_in_turret.ref_12cb1.size] = var_0;
  playFX(level._effect["stim_pickup"], var_0.curorigin);
  playsoundatpos(var_0.curorigin, "zxp_tags_pickup");
}

function headlessinfilplayers(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 scripts\mp\gametypes\br_public::ref_125f3()) {
      continue;
    }

    var_3 = var_2 getnodeoffset_code(7);

    if(var_3 != -1 && var_3 == var_0.objidnum) {
      var_2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }
}

function ref_126e6(var_0) {
  foreach(var_2 in level.disable_super_in_turret.ref_12cb0) {
    if(isDefined(var_2.visuals[0])) {
      ref_12cb2(var_2.visuals[0], self);
    }
  }
}

function ref_12cb2(var_0) {
  if(var_0 scripts\mp\gametypes\br_public::ref_125f3()) {
    self showtoplayer(var_0);

    if(!level.disable_super_in_turret.ref_13a25) {
      self enableplayeruse(var_0);
      return;
    }

    return;
  }

  self hidefromplayer(var_0);

  if(!level.disable_super_in_turret.ref_13a25) {
    self disableplayeruse(var_0);
    return;
  }
}

function ref_1337a() {
  self hide();

  if(!level.disable_super_in_turret.ref_13a25) {
    self makeusable();
    self setCursorHint("HINT_NOICON");
    self setHintString(&"MP_ZXP/PICKUP");
    self setuseprioritymax();
  }

  foreach(var_1 in level.players) {
    ref_12cb2(var_1);
  }
}

function onuse(var_0) {
  scripts\mp\gametypes\br_alt_mode_zxp::onuse(var_0);
}

function ref_12730() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  var_0 = 0.5;

  for(;;) {
    var_1 = self getnodeoffset_code(7);
    var_2 = sortbydistance(level.disable_super_in_turret.ref_12cb0, self.origin);
    var_3 = 0;

    foreach(var_5 in var_2) {
      var_6 = undefined;

      if(var_3 < level.disable_super_in_turret.ref_11b76 && level.disable_super_in_turret.ref_11b75 > 0) {
        var_6 = distance2dsquared(self.origin, var_5.origin);
      }

      if(var_3 < level.disable_super_in_turret.ref_11b76 && (level.disable_super_in_turret.ref_11b75 == 0 || var_6 < level.disable_super_in_turret.ref_11b75)) {
        var_3++;
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_5.objidnum, self);
        continue;
      }

      var_3 = level.disable_super_in_turret.ref_11b76;
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_5.objidnum, self);

      if(var_1 != -1 && var_1 == var_5.objidnum) {
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
      }
    }

    wait var_0;
  }
}

function ref_125ce() {
  foreach(var_1 in level.disable_super_in_turret.ref_12cb0) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.objidnum, self);
  }
}

function gulagisspawnpositionwithindangercircle(var_0) {
  if(istrue(level.disable_super_in_turret.ref_146e7)) {
    if(getdvarint("scr_br_zxp_respawn_can_shutdown", 0) == 0) {
      return;
    }

    var_1 = scripts\mp\gametypes\br_gulag::remove_engineer_class();

    if(var_0 >= var_1) {
      level.disable_super_in_turret.ref_146e7 = 0;
      return;
    }

    return;
  }
}

function ref_13284() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }

  if(getdvarint("scr_br_zxp_respawn_can_shutdown", 0) == 0) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_0 = "hudsmall";
  var_1 = 0.8;
  var_2 = -100;
  var_3 = -290;
  var_4 = 90;
  var_5 = scripts\mp\gametypes\br_gulag::run_hud_logic();
  var_6 = init_relic_trex(var_0, var_1);
  var_6 scripts\mp\hud_util::setpoint("RIGHT", "CENTER", var_3, var_2);
  var_6.label = &"MP_ZXP/RESPAWN_ALLOWED";
  var_7 = scripts\mp\hud_util::createservertimer(var_0, var_1);
  var_7 scripts\mp\hud_util::setpoint("LEFT", "CENTER", var_3, var_2);
  var_7 settenthstimer(var_5);
  var_8 = getdvarint("scr_br_display_gulag_close_message", var_4);
  var_9 = var_5 - var_8;

  if(var_9 > 0) {
    wait var_9;
    var_7.color = (1, 0, 0);
    var_7 thread scripts\mp\gametypes\br_alt_mode_zxp::spawn_vindia_assault3();
    wait var_8;
  } else {
    wait var_5;
  }

  wait 2;
  var_7 destroy();
  var_6 destroy();
}

function ref_142cc(var_0, var_1) {
  if(scripts\mp\gametypes\br_public::ref_125f3()) {
    scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning(var_0);
    return;
  }

  scripts\mp\gametypes\br_vip_quest::ref_142c6(self, var_0, var_1);
}

function init_relic_trex(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "font";
  var_3.font = var_1;
  var_3.fontscale = var_2;
  var_3.basefontscale = var_2;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_2);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 scripts\mp\hud_util::setparent(level.uiparent);
  var_3.hidden = 0;
  var_3.alpha = 1;
  return var_3;
}

function gulagisfaded() {
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.default_player_connect_black_screen[0] = 1;
}

function init_relic_aggressive_melee() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function being_hacked() {
  thread vehomn_getleveldata();
}

function vehomn_getleveldata() {
  level endon("game_ended");
  self endon("death");
  var_0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "c130" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "outOfBounds";
      var_3 notify("halo_kick_c130");
    }
  }
}

function ref_12bba(var_0) {
  return scripts\mp\gametypes\br_alt_mode_zxp::ref_12bba(var_0);
}

function onnewequipmentpickup(var_0) {
  foreach(var_2 in level.players) {
    var_2 hudoutlinedisable();

    if(var_2 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_2 setscriptablepartstate("compassicon", "defaulticon");
      var_2 unsetperk("specialty_radarblip", 1);

      if(level.disable_super_in_turret.ref_1470c) {
        if(!level.disable_super_in_turret.ref_1470d) {
          var_2 setscriptablepartstate("headVFX", "neutral");
        }

        var_2 visionsetnakedforplayer("", 0);
      }

      if(!isDefined(scripts\engine\utility::array_find(var_0, var_2))) {
        var_2 playerhide();
        var_2 setscriptablepartstate("zombie", "off");
      }
    }
  }
}

function ref_13252() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }

  level.disable_super_in_turret.human = spawnStruct();
  level.disable_super_in_turret.human.powers = [];
  scripts\mp\gametypes\br_alt_mode_zxp::battlepassxpmultipliers(level.disable_super_in_turret.human, "push", ["+stance", "+movedown"], &ref_125d5, 1, undefined, &ref_125d6, undefined, &"MP_ZXP/PUSH", undefined, 60);
}

function ref_125db() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }

  thread scripts\mp\gametypes\br_alt_mode_zxp::ref_126b4(level.disable_super_in_turret.human);
}

function ref_125d5(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");
  var_2 = 750;

  if(istrue(self.hoopty_truck_initomnvars)) {
    var_3 = getdvarint("scr_br_zxp_push_double_tap_ms", var_2);
    var_4 = gettime() - self.hoopty_truck_initomnvars;

    if(var_4 <= var_3) {
      ref_1252c();
      thread scripts\mp\gametypes\br_alt_mode_zxp::ref_1262c(var_0, var_1);
      self.hoopty_truck_initomnvars = undefined;
      return;
    }
  }

  self.hoopty_truck_initomnvars = gettime();
}

function ref_1252c() {
  if(!getdvarint("scr_br_zxp_human_spawn_concuss", 0)) {
    return;
  }

  var_0 = 650;
  var_1 = getdvarint("scr_br_zxp_push_radius", var_0);
  var_2 = incrementpersistentstat(level.players, self.origin, var_1);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\gametypes\br_public::ref_125f3() && var_4.team != self.team && isalive(var_4)) {
      scripts\mp\gametypes\br_alt_mode_zxp::ref_125d7(var_4, var_1);
    }
  }

  var_6 = anglesToForward(self.angles);
  playFX(level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var_6);
  playsoundatpos(self.origin, "sentry_explode_smoke");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 1.5, self.origin, var_1);
}

function ref_125d6(var_0, var_1) {
  self.hoopty_truck_initomnvars = undefined;
}

function ref_11ba8(var_0) {
  var_1 = var_0.meansofdeath;
  var_2 = var_0.victim;
  var_3 = var_0.hitloc;

  if(isPlayer(var_2) && var_2 scripts\mp\gametypes\br_public::ref_125f3() && (var_3 == "head" || var_3 == "helmet")) {
    var_1 = "MOD_HEAD_SHOT_ZOMBIE";
  }

  return var_1;
}

function dangercircletick(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.disable_super_in_turret.ref_12cb0) {
    if(isDefined(var_4.visuals) && distance2dsquared(var_4.origin, var_0) > var_2) {
      thread removetags(var_4);
    }
  }
}