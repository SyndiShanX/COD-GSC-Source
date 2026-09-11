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
    foreach(var1 in level.teamnamelist) {
      var2 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var1);

      for(var3 = 0; var3 < var2.size; var3++) {
        var4 = var2[var3];
        var5 = scripts\mp\gametypes\br_public::rotationids(var1, var4);

        if(var5 > 0) {
          var6 = use_emp_drone(var1, var4);

          if(!var6) {
            votesys_init(var1, var4);
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
  var0 = -15;
  var1 = scripts\mp\gametypes\br_circle::relic_amped_pick_random_valid_player(1);
  var2 = max(0, var1 + var0);
  var3 = getdvarfloat("scr_br_dropbag_delay", var2);
  scripts\mp\gametypes\br_gametypes::ref_12b10("dropBagDelay", var3);
}

function ref_14691(var0) {
  scripts\mp\gametypes\br_public::brleaderdialog("zmb_opening", 0, var0);
  wait 1;
  scripts\mp\gametypes\br_public::brleaderdialog("zmb_infil_tutorial_01", 0, var0);
}

function ref_12051() {
  self endon("disconnect");
  var0 = self;
  wait 3;

  while(!var0 isonground()) {
    wait 2;
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("zmb_infil_tutorial_02", var0);
}

function ref_11b16() {
  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b16();
}

function ref_12691(var0) {
  if(!istrue(level.br_prematchstarted)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::iswaitingtoentergulag(self)) {
    return 1;
  }

  return scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_11b80(var0, var1) {
  var2 = 0;
  var3 = use_emp_drone(var0.team, var0.squadindex, var0);

  if(!istrue(self.gulag) && scripts\mp\gametypes\br_zones::updatelocationbesttimehud("plague", var0)) {
    if(var3) {
      var2 = var0 scripts\mp\gametypes\br_alt_mode_zxp::ref_126d2(var1);
    }
  } else if(!var0 scripts\mp\gametypes\br_public::ref_125f3()) {
    var2 = var0 scripts\mp\gametypes\br_gulag::trygulagspawn();
  }

  if(scripts\mp\flags::gameflag("prematch_done") && !var2) {
    if(var0 scripts\mp\gametypes\br_public::ref_125f3()) {
      thread scripts\mp\gametypes\br_alt_mode_zxp::ref_12538();
    }

    scripts\mp\gametypes\br::ref_11b15(var0);

    if(!var3) {
      votesys_init(var0.team, var0.squadindex, var0);
    }
  }

  return !var2;
}

function use_emp_drone(var0, var1, var2) {
  var3 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var1);

  foreach(var6 in var4) {
    if(isDefined(var2) && var6 == var2) {
      continue;
    }

    if(istrue(var3) && var6 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      return true;
    }

    var7 = var6 scripts\mp\gametypes\br_public::ref_125f3() || var6 scripts\mp\gametypes\br_alt_mode_zxp::ref_125e9();

    if(!var7 && isalive(var6) && !istrue(var6.inlaststand)) {
      return true;
    }

    if(istrue(var6.inlaststand) && (istrue(var6.shouldgetnewspawnpoint) || var6 scripts\mp\gametypes\br_gulag::ref_12517())) {
      return true;
    }
  }

  return false;
}

function votesys_init(var0, var1, var2) {
  var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var1);

  foreach(var5 in var3) {
    if(isDefined(var2) && var2 == var5) {
      continue;
    }

    if(isalive(var5)) {
      var5 suicide();
      continue;
    }

    if(var5 scripts\mp\gametypes\br_alt_mode_zxp::ref_125e9()) {
      var5 scripts\mp\gametypes\br_alt_mode_zxp::ref_12681(0, 0);
      scripts\mp\gametypes\br::ref_11b15(var5);
      var5 scripts\mp\playerlogic::removefromalivecount();
    }
  }
}

function ref_1269c(var0) {
  return scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_1269b(var0) {
  return scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_13308(var0) {
  var1 = isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
  var2 = isPlayer(var0.victim) && var0.victim scripts\mp\gametypes\br_public::ref_125f3();

  if(var1 && !var2 && var0.meansofdeath == "MOD_MELEE") {
    return false;
  }

  return true;
}

function brking_cleanupents(var0) {
  var1 = isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
  return var1;
}

function ref_12728() {
  playFX(scripts\engine\utility::getfx("zombie_trans"), self.origin);
  self notify("endSuperJumpFov");
  ref_1272e(0);
  var0 = gettime() + 3000;

  while(self isgestureplaying() && var0 > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(var0 > gettime() && (self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]())) {
    waitframe();
  }

  self enableoffhandweapons();
  self giveandfireoffhand("stim_zmb_mp");
  wait 2;
}

function ref_1272e(var0) {
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

function ref_126fa(var0) {
  if(!istrue(var0) && !scripts\mp\gametypes\br_public::ref_125f3()) {
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
  var1 = self.origin;
  var2 = self.origin;
  var3 = self getplayerangles();
  var4 = 0;

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    var5 = ref_125dd();
    var2 = var5[0];
    var3 = var5[1];
    var1 = var5[2];
    var5 = undefined;
  } else {
    var6 = ref_125de();
    var2 = var6[0];
    var3 = var6[1];
    var4 = var6[2];
    var6 = undefined;
    var1 = var2;
  }

  self.plotarmor = 1;
  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  ref_12728();

  if(!var4) {
    scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait 1;
  } else {
    waitframe();
  }

  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
  self.pers["class"] = "gamemode";
  self.class = "gamemode";
  self.forcespawnangles = var3;
  self.forcespawnorigin = var1;
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
    scripts\mp\gametypes\br_alt_mode_zxp::ref_126bd(var2, var3, var1);
  } else {
    if(!var4) {
      scripts\mp\gametypes\br_public::ref_126ed();
      scripts\mp\gametypes\br_public::ref_1252b();
      playFX(scripts\engine\utility::getfx("zombie_trans"), self.origin);
    }

    if(!var4) {
      scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }

    thread ref_1252c();
  }

  if(istrue(level.disable_super_in_turret.spawndomplateflagtestmap) && scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa()) {
    ref_125fb();
  } else {
    var7 = scripts\mp\gametypes\br::disablealltablets();
    scripts\mp\gametypes\br::searchcircleorigin(var7, 0);
  }

  scripts\mp\gametypes\br_armor::searchcirclesize();
  thread scripts\mp\gametypes\br::defend_wave_2();
  scripts\mp\gametypes\br_alt_mode_zxp::ref_1262b(0);
  scripts\mp\hud_message::showsplash("br_gametype_zxp_change_human");
  self.plotarmor = undefined;
  thread ref_125d9();
  self.ref_12ca8 = undefined;

  foreach(var9 in level.teamdata[self.team]["players"]) {
    if(self != var9) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("zmb_teammate_back_human", var9);
    }
  }
}

function ref_125dd() {
  var0 = getdvarint("scr_br_zxp_spawnheightoffset", 3000);
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

function remove_marker_when_player_disconnects(var0, var1, var2) {
  var3 = var0 + var1 * var2;
  var4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;

  if(scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo(var3, var4)) {
    var5 = vectortoangles(var1 * -1);
    return [var3, var5];
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
  var0 = getcompleteweaponname("iw8_fists_mp");

  if(self.ref_1472f.ref_12889.size < 2) {
    self giveweapon(var0);
  }

  var1 = 0;

  foreach(var3 in self.ref_1472f.ref_12889) {
    var4 = createheadicon(var3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var3);

    if(!var1) {
      self assignweaponprimaryslot(var4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var3);
      var1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var4);
  }

  foreach(var7 in self.ref_1472f.offhands) {
    var8 = scripts\mp\equipment::getequipmentreffromweapon(var7);

    if(!isDefined(var8)) {
      continue;
    }

    var9 = self.ref_1472f.nvidiaansel_overridecollisionradius[var8];

    if(!isDefined(var9)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(var8, var9);
  }

  foreach(var4, var12 in self.ref_1472f.brtruck_ontimelimit) {
    self setweaponammostock(var4, var12);
    var3 = getcompleteweaponname(getweaponbasename(var4));
    var13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var3);

    if(isDefined(var13)) {
      self.br_ammo[var13] = var12;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var13);
    }
  }

  foreach(var4, var12 in self.ref_1472f.brtdm_config) {
    self setweaponammoclip(var4, var12);
  }

  foreach(var4, var12 in self.ref_1472f.brtruck_cleanupents) {
    self setweaponammoclip(var4, var12, "left");
  }

  waitframe();
  var16 = var0;

  if(isDefined(self.ref_1472f.current) && self.ref_1472f.current != getcompleteweaponname("none")) {
    var16 = self.ref_1472f.current;
  }

  self switchtoweaponimmediate(var16);

  if(isDefined(self.ref_1472f.super)) {
    var17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.ref_1472f.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(var17, 0);
  }

  thread scripts\cp_mp\gestures::ref_13e1a();
  self.ref_1472f = undefined;
}

function addtoteamlives(var0, var1) {
  var0 scripts\mp\gametypes\br_alt_mode_zxp::addtoteamlives(var0, var1);
}

function removefromteamlives(var0, var1) {
  var0 scripts\mp\gametypes\br_alt_mode_zxp::removefromteamlives(var0, var1);
}

function ref_1472e(var0) {
  if(level.disable_super_in_turret.spawndomplateflagtestmap && !var0 scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa()) {
    var0 scripts\mp\gametypes\br_alt_mode_zxp::ref_125fc();
    return;
  }
}

function gulagwinnerrespawn(var0) {
  if(level.disable_super_in_turret.spawndomplateflagtestmap && scripts\mp\gametypes\br_alt_mode_zxp::ref_125fa()) {
    ref_125fb();
    return;
  }
}

function ref_12702() {
  self.itemsdropped = 0;
  var0 = level.disable_super_in_turret.ref_146c6 % 10;
  level.disable_super_in_turret.ref_146c6++;
  var1 = verifybunkercode("zombie_death", var0);

  if(isDefined(var1)) {
    var2 = scripts\mp\gametypes\br_lootcache::ref_11a42(var1, 0);
    return;
  }
}

function ref_12604() {
  if(scripts\mp\gametypes\br_public::ref_125f3()) {
    return;
  }

  scripts\mp\gametypes\br::ref_11e23();
}

function droponplayerdeath(var0) {
  if(scripts\mp\gametypes\br_public::ref_125f3() || istrue(self.isjuggernaut)) {
    return true;
  }

  if(level.disable_super_in_turret.spawndomplateflagtestmap) {
    scripts\mp\gametypes\br_alt_mode_zxp::ref_125fc();
  }

  return false;
}

function onplayerkilled(var0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var1 = var0.victim;
  var2 = var0.attacker;

  if(!isDefined(var2) || !isPlayer(var2) || !isDefined(var1)) {
    return;
  }

  var3 = var0.hitloc;

  if(isDefined(var3) && var1 scripts\mp\gametypes\br_public::ref_125f3() && (var3 == "head" || var3 == "helmet")) {
    var4 = 0;
    var2 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var4, 1);
  }

  var1 setscriptablepartstate("skydiveVfx", "default", 0);
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

function ref_13326(var0) {
  if(!ref_13325(var0)) {
    return false;
  }

  if(!scripts\mp\gametypes\br_public::ref_125f3()) {
    return false;
  }

  return true;
}

function ref_13302(var0) {
  if(!ref_13325(var0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125f3()) {
    return false;
  }

  return true;
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
  ref_1337a(var0.visuals[0]);
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
      objective_icon(var0.objidnum, "icon_minimap_syringe");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var0.objidnum);
    }
  }

  playsoundatpos(var5, "mp_killconfirm_tags_drop");
  var0.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
}

function ref_13662(var0, var1) {
  var2 = spawndogtags();
  ref_13238(var2, var0.origin);

  if(istrue(var0.isjuggernaut)) {
    var3 = 2;
    var4 = getdvarint("scr_br_zxp_numDropJugg", var3);
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

function ref_1332e(var0) {
  if(!ref_13325(var0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125f3() && self.ref_11f39 > 0) {
    return true;
  }

  return false;
}

function ref_136ba(var0, var1) {
  var2 = spawndogtags();
  ref_13238(var2, var0.origin);

  if(self.ref_11f39 > 1) {
    var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();

    for(var4 = 1; var4 < self.ref_11f39; var4++) {
      var5 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var3, var0.origin, var0.angles, var0, undefined, undefined, 0);

      if(!isDefined(var5) || var5.origin == (0, 0, 0)) {
        var5.origin = var0.origin;
      }

      var2 = spawndogtags();
      ref_13238(var2, var5.origin);
    }

    return;
  }
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

function removetags(var0) {
  loadoutprimaryaddblueprintattachments(var0);
  var1 = "" + var0 getentitynumber();
  level.disable_super_in_turret.ref_12cb0[var1] = undefined;
  level.disable_super_in_turret.ref_12cb1[level.disable_super_in_turret.ref_12cb1.size] = var0;
  playFX(level._effect["stim_pickup"], var0.curorigin);
  playsoundatpos(var0.curorigin, "zxp_tags_pickup");
}

function headlessinfilplayers(var0) {
  foreach(var2 in level.players) {
    if(!var2 scripts\mp\gametypes\br_public::ref_125f3()) {
      continue;
    }

    var3 = var2 getnodeoffset_code(7);

    if(var3 != -1 && var3 == var0.objidnum) {
      var2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }
}

function ref_126e6(var0) {
  foreach(var2 in level.disable_super_in_turret.ref_12cb0) {
    if(isDefined(var2.visuals[0])) {
      ref_12cb2(var2.visuals[0], self);
    }
  }
}

function ref_12cb2(var0) {
  if(var0 scripts\mp\gametypes\br_public::ref_125f3()) {
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

function ref_1337a() {
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

function onuse(var0) {
  scripts\mp\gametypes\br_alt_mode_zxp::onuse(var0);
}

function ref_12730() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
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

function ref_125ce() {
  foreach(var1 in level.disable_super_in_turret.ref_12cb0) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.objidnum, self);
  }
}

function gulagisspawnpositionwithindangercircle(var0) {
  if(istrue(level.disable_super_in_turret.ref_146e7)) {
    if(getdvarint("scr_br_zxp_respawn_can_shutdown", 0) == 0) {
      return;
    }

    var1 = scripts\mp\gametypes\br_gulag::remove_engineer_class();

    if(var0 >= var1) {
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
  var0 = "hudsmall";
  var1 = 0.8;
  var2 = -100;
  var3 = -290;
  var4 = 90;
  var5 = scripts\mp\gametypes\br_gulag::run_hud_logic();
  var6 = init_relic_trex(var0, var1);
  var6 scripts\mp\hud_util::setpoint("RIGHT", "CENTER", var3, var2);
  var6.label = &"MP_ZXP/RESPAWN_ALLOWED";
  var7 = scripts\mp\hud_util::createservertimer(var0, var1);
  var7 scripts\mp\hud_util::setpoint("LEFT", "CENTER", var3, var2);
  var7 settenthstimer(var5);
  var8 = getdvarint("scr_br_display_gulag_close_message", var4);
  var9 = var5 - var8;

  if(var9 > 0) {
    wait var9;
    var7.color = (1, 0, 0);
    var7 thread scripts\mp\gametypes\br_alt_mode_zxp::spawn_vindia_assault3();
    wait var8;
  } else {
    wait var5;
  }

  wait 2;
  var7 destroy();
  var6 destroy();
}

function ref_142cc(var0, var1) {
  if(scripts\mp\gametypes\br_public::ref_125f3()) {
    scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning(var0);
    return;
  }

  scripts\mp\gametypes\br_vip_quest::ref_142c6(self, var0, var1);
}

function init_relic_trex(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = newteamhudelem(var2);
  } else {
    var3 = newhudelem();
  }

  var3.elemtype = "font";
  var3.font = var1;
  var3.fontscale = var2;
  var3.basefontscale = var2;
  var3.x = 0;
  var3.y = 0;
  var3.width = 0;
  var3.height = int(level.fontheight * var2);
  var3.xoffset = 0;
  var3.yoffset = 0;
  var3.children = [];
  var3 scripts\mp\hud_util::setparent(level.uiparent);
  var3.hidden = 0;
  var3.alpha = 1;
  return var3;
}

function gulagisfaded() {
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.default_player_connect_black_screen[0] = 1;
}

function init_relic_aggressive_melee() {
  var0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var1 = level.br_level.br_circleradii[1];
  var2 = scripts\mp\gametypes\br_c130::createtestc130path(var0, var1);
  return var2;
}

function being_hacked() {
  thread vehomn_getleveldata();
}

function vehomn_getleveldata() {
  level endon("game_ended");
  self endon("death");
  var0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var1;

  foreach(var3 in level.players) {
    if(isDefined(var3) && isDefined(var3.br_infil_type) && var3.br_infil_type == "c130" && !isDefined(var3.jumptype)) {
      var3.jumptype = "outOfBounds";
      var3 notify("halo_kick_c130");
    }
  }
}

function ref_12bba(var0) {
  return scripts\mp\gametypes\br_alt_mode_zxp::ref_12bba(var0);
}

function onnewequipmentpickup(var0) {
  foreach(var2 in level.players) {
    var2 hudoutlinedisable();

    if(var2 scripts\mp\gametypes\br_public::ref_125f3()) {
      var2 setscriptablepartstate("compassicon", "defaulticon");
      var2 unsetperk("specialty_radarblip", 1);

      if(level.disable_super_in_turret.ref_1470c) {
        if(!level.disable_super_in_turret.ref_1470d) {
          var2 setscriptablepartstate("headVFX", "neutral");
        }

        var2 visionsetnakedforplayer("", 0);
      }

      if(!isDefined(scripts\engine\utility::array_find(var0, var2))) {
        var2 playerhide();
        var2 setscriptablepartstate("zombie", "off");
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

function ref_125d5(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");
  var2 = 750;

  if(istrue(self.hoopty_truck_initomnvars)) {
    var3 = getdvarint("scr_br_zxp_push_double_tap_ms", var2);
    var4 = gettime() - self.hoopty_truck_initomnvars;

    if(var4 <= var3) {
      ref_1252c();
      thread scripts\mp\gametypes\br_alt_mode_zxp::ref_1262c(var0, var1);
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

  var0 = 650;
  var1 = getdvarint("scr_br_zxp_push_radius", var0);
  var2 = incrementpersistentstat(level.players, self.origin, var1);

  foreach(var4 in var2) {
    if(var4 scripts\mp\gametypes\br_public::ref_125f3() && var4.team != self.team && isalive(var4)) {
      scripts\mp\gametypes\br_alt_mode_zxp::ref_125d7(var4, var1);
    }
  }

  var6 = anglesToForward(self.angles);
  playFX(level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var6);
  playsoundatpos(self.origin, "sentry_explode_smoke");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 1.5, self.origin, var1);
}

function ref_125d6(var0, var1) {
  self.hoopty_truck_initomnvars = undefined;
}

function ref_11ba8(var0) {
  var1 = var0.meansofdeath;
  var2 = var0.victim;
  var3 = var0.hitloc;

  if(isPlayer(var2) && var2 scripts\mp\gametypes\br_public::ref_125f3() && (var3 == "head" || var3 == "helmet")) {
    var1 = "MOD_HEAD_SHOT_ZOMBIE";
  }

  return var1;
}

function dangercircletick(var0, var1) {
  var2 = var1 * var1;

  foreach(var4 in level.disable_super_in_turret.ref_12cb0) {
    if(isDefined(var4.visuals) && distance2dsquared(var4.origin, var0) > var2) {
      thread removetags(var4);
    }
  }
}