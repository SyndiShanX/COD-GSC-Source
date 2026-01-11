/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3540.gsc
***************************************/

weaponpassivesinit() {
  level thread func_13B0C();
  level._effect["loot_mo_money_kill"] = loadfx("vfx\iw7\_requests\mp\vfx_mo_money_cash_exp");
  level._effect["player_plasma_friendly"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["player_plasma_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["player_plasma_friendly"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["player_plasma_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["player_plasma_screen_stand"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["passive_gore"] = loadfx("vfx\iw7\_requests\mp\vfx_meatbag_large.vfx");
  level._effect["passive_gore_robot"] = loadfx("vfx\iw7\core\impact\robot\vfx_mp_c6_melee.vfx");
}

func_13B0C() {
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 thread updatenukepassive();
    var_00 thread watchweaponchanged();
  }
}

watchweaponchanged() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_00 = self getcurrentweapon();

    if(isDefined(var_00) && var_00 != "none") {
      setmodeswitchkillweapon(self, var_00);
      giveweaponpassives(var_00);
      scripts\mp\weapons::func_12F5D(var_00);
    }

    scripts\engine\utility::waittill_any("weapon_change", "giveLoadout");
  }
}

giveweaponpassives(var_00) {
  clearpassives();
  var_01 = scripts\mp\loot::getpassivesforweapon(var_00);

  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      giveplayerpassive(var_03);
    }
  }

  self notify("weapon_passives_given");
}

giveplayerpassive(var_00) {
  scripts\mp\utility\game::giveperk(var_00);
  self.weaponpassives[self.weaponpassives.size] = var_00;
}

clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(var_01 in self.weaponpassives) {
      scripts\mp\utility\game::removeperk(var_01);
    }
  }

  self.weaponpassives = [];
}

forgetpassives() {
  self.weaponpassives = [];
}

definepassivevalue(var_00) {
  if(!isDefined(self.passivevalues)) {
    self.passivevalues = [];
  }

  if(!isDefined(self.passivevalues[var_00])) {
    self.passivevalues[var_00] = 0.0;
  }
}

getpassivevalue(var_00) {
  definepassivevalue(var_00);
  return self.passivevalues[var_00];
}

setpassivevalue(var_00, var_01) {
  definepassivevalue(var_00);
  self.passivevalues[var_00] = var_01;
}

teamsmatch(var_00, var_01) {
  if(level.teambased) {
    return var_0.team == var_1.team;
  }

  return var_00 == var_01;
}

updateweaponpassivesonuse(var_00, var_01) {
  if(var_00 scripts\mp\utility\game::_hasperk("passive_backfire")) {
    var_00 thread func_8978(var_00, var_01);
  }

  if(var_00 scripts\mp\utility\game::_hasperk("passive_sonar")) {
    var_00 thread func_89E5(var_00, var_01);
  }
}

func_8978(var_00, var_01) {
  if(isDefined(var_0.tookweaponfrom)) {
    var_02 = var_0.tookweaponfrom[var_01];

    if(isDefined(var_02) && var_02 != var_00) {
      playFX(scripts\engine\utility::getfx("seeker_explosion"), var_0.origin);
      var_00 getrandomarmkillstreak(9999, var_2.origin, var_02, var_02, "MOD_EXPLOSIVE", var_01);
    }
  }
}

func_12EB2(var_00) {
  var_01 = weaponclipsize(var_00);
  self setweaponammoclip(var_00, var_01);
}

updateweaponpassivesondamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(var_00 scripts\mp\utility\game::_hasperk("passive_infinite_ammo")) {
    var_00 thread func_12EB2(var_00 getcurrentweapon());
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_minimap_damage") && isDefined(var_00) && !var_00 scripts\mp\utility\game::_hasperk("specialty_gpsjammer")) {
    var_01 thread func_89C5(var_01, var_00);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_fire_damage")) {
    var_01 thread func_89A2(var_01, var_00, var_04);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_cold_damage")) {
    var_01 thread func_8986(var_01, var_00, var_04);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_critical_sequential_damage")) {
    var_01 thread func_898A(var_01, var_00, var_04);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_sonic")) {
    var_01 thread func_89E6(var_01, var_00);
  }
}

loadoutweapongiven(var_00) {
  var_01 = scripts\mp\utility\game::getweaponrootname(var_00);
  checkprestigeextraclassicammo(var_00, var_01);
}

checkprestigeextraclassicammo(var_00, var_01) {
  var_02 = var_01 + "_extra_ammo";

  if(isDefined(level.prestigeextras[var_02])) {
    if(self getteamdompoints(var_02, "prestigeExtras", 1)) {
      var_03 = weaponmaxammo(var_00);
      var_04 = self getweaponammostock(var_00);
      var_05 = (var_03 - var_04) * 0.5;
      self setweaponammostock(var_00, int(min(var_04 + var_05, var_03)));
    }
  }
}

func_89C5(var_00, var_01) {
  if(isDefined(var_00) && isDefined(var_01)) {
    var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);

    if(var_02 == -1) {
      return;
    }
    scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", (0, 0, 0), "cb_compassping_enemy");
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02, var_01);
    scripts\mp\objidpoolmanager::minimap_objective_team(var_02, var_0.team);
    var_03 = 3;
    var_01 scripts\engine\utility::waittill_any_timeout(var_03, "damage_begin", "death", "disconnect");
    scripts\mp\objidpoolmanager::returnminimapid(var_02);
  }
}

func_89E5(var_00, var_01) {
  if(!scripts\mp\utility\game::isstrstart(var_01, "alt")) {
    return;
  }
  var_02 = self getweaponammoclip(var_01);
  triggerportableradarpingteam(var_0.origin, var_0.team, 500, 500);
}

func_898A(var_00, var_01, var_02) {
  var_03 = var_00 getpassivevalue("passive_critical_sequential_damage");
  var_00 setpassivevalue("passive_critical_sequential_damage", var_03 + 1);
}

func_8986(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::ter_op(weaponclass(var_02) == "sniper" || issubstr(var_02, "iw7_longshot"), -0.2, -0.1);
  thread passivecolddamagewatchvictim(var_00, var_01, var_03, 1.5);
}

passivecolddamagewatchvictim(var_00, var_01, var_02, var_03) {
  var_01 endon("death");
  var_01 endon("disconnect");
  var_01 notify("passiveColdDamageWatchVictim");
  var_01 endon("passiveColdDamageWatchVictim");
  var_04 = var_00 getentitynumber();
  var_05 = gettime() + var_03 * 1000;
  var_06 = self.passivecolddamage;

  if(!isDefined(var_06)) {
    var_06 = spawnStruct();
    var_6.curspeedmod = 0;
    var_6.speedmods = [];
    var_6.endtimes = [];
    var_1.passivecolddamage = var_06;
  }

  var_6.speedmods[var_04] = var_02;
  var_6.endtimes[var_04] = var_05;
  var_01 setscriptablepartstate("weaponPassiveColdDamage", "active");
  var_07 = var_6.curspeedmod;
  var_08 = var_07;

  for(;;) {
    var_09 = gettime();

    foreach(var_11, var_02 in var_6.speedmods) {
      var_05 = var_6.endtimes[var_11];

      if(var_05 < var_09) {
        var_6.speedmods[var_11] = undefined;
        var_6.endtimes[var_11] = undefined;
        continue;
      }

      if(var_02 < var_08) {
        var_08 = var_02;
      }
    }

    var_6.curspeedmod = var_08;

    if(var_6.curspeedmod != var_07) {
      var_01 scripts\mp\weapons::updatemovespeedscale();
    }

    if(var_6.speedmods.size <= 0) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  passivecolddamageresetdata(var_01);
  passivecolddamageresetscriptable(var_01);
}

passivecolddamagegetspeedmod(var_00) {
  if(isDefined(var_0.passivecolddamage)) {
    return var_0.passivecolddamage.curspeedmod;
  }

  return 0;
}

passivecolddamageresetscriptable(var_00) {
  var_00 setscriptablepartstate("weaponPassiveColdDamage", "neutral");
}

passivecolddamageresetdata(var_00) {
  var_0.passivecolddamage = undefined;
  var_00 scripts\mp\weapons::updatemovespeedscale();
}

func_89A2(var_00, var_01, var_02) {
  if(isDefined(var_00) && isDefined(var_01)) {
    var_03 = var_01 getpassivevalue("passive_fire_damage");

    if(var_03 <= 0) {
      var_01 thread func_10D9E(var_02, var_00, "passive_fire_damage", "player_plasma_friendly", "player_plasma_enemy", "j_mainroot", "player_plasma_screen_stand");
      var_01 thread startdamageovertime(var_02, var_00, 2, 0.5, 2, "passive_fire_damage");
    } else
      setpassivevalue("passive_fire_damage", 2);
  }
}

func_AD69(var_00, var_01) {
  self endon(var_01);
  scripts\engine\utility::waittill_any("death", "disconnect", var_01);
  func_11067(var_01);
}

func_AD68(var_00, var_01) {
  var_00 endon(var_01);
  scripts\engine\utility::waittill_any("disconnect");
  var_00 func_11067(var_01);
}

func_10D9E(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = spawnfxforclient(scripts\engine\utility::getfx(var_06), self getEye(), self);

  foreach(var_09 in level.players) {
    if(var_09 == self) {
      triggerfx(var_07);
      continue;
    }

    if(isDefined(var_03) && isDefined(var_04)) {
      var_10 = scripts\engine\utility::ter_op(teamsmatch(self, var_01), var_03, var_04);
      playfxontagforclients(scripts\engine\utility::getfx(var_10), self, var_05, var_09);
    }
  }

  self waittill(var_02);
  func_11073(var_03, var_04, var_05, var_07);
}

func_11073(var_00, var_01, var_02, var_03) {
  if(isDefined(var_00) && isDefined(var_01)) {
    stopFXOnTag(scripts\engine\utility::getfx(var_00), self, var_02);
    stopFXOnTag(scripts\engine\utility::getfx(var_01), self, var_02);
  }

  var_03 delete();
}

startdamageovertime(var_00, var_01, var_02, var_03, var_04, var_05) {
  self endon(var_05);
  setpassivevalue(var_05, var_04);
  thread func_AD69(var_01, var_05);
  var_01 thread func_AD68(self, var_05);
  var_06 = "MOD_UNKNOWN";

  if(var_03 > var_04) {
    return;
  }
  if(self.health <= 0) {
    func_11067(var_05);
  }

  var_07 = var_02;

  if(self.health <= var_07) {
    self getrandomarmkillstreak(var_02, self.origin, var_01, undefined, var_06, var_00);
  }

  while(getpassivevalue(var_05) > 0) {
    if(self.health <= 0) {
      func_11067(var_05);
    }

    if(self.health > 15 && self.health - var_02 < 15) {
      var_02 = var_02 - (15 - (self.health - var_02));
    }

    if(self.health > var_07 && self.health <= 15) {
      var_02 = 1;
    }

    if(var_02 > 0) {
      self getrandomarmkillstreak(var_02, self.origin, var_01, undefined, var_06, var_00);
    }

    setpassivevalue(var_05, getpassivevalue(var_05) - var_03);
    wait(var_03);
  }

  func_11067(var_05);
}

func_11067(var_00) {
  setpassivevalue(var_00, 0);
  self notify(var_00);
}

func_12F61(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!scripts\mp\utility\game::playersareenemies(var_01, var_02)) {
    return;
  }
  if(var_01 scripts\mp\utility\game::_hasperk("passive_berserk")) {
    var_01 thread quadfeederon();
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_headshot_ammo")) {
    var_01 thread func_89AE(var_05, var_01, var_02, var_04, var_06);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_last_shots_ammo")) {
    var_01 thread func_89C2(var_05, var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_extra_xp")) {
    var_01 thread func_89A0(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_nuke")) {
    var_01 thread func_89CC(var_01, var_02, var_05);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_streak_ammo")) {
    var_01 thread func_89EB(var_01, var_05);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_move_speed_on_kill")) {
    var_01 thread func_89C8(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_cooldown_on_kill")) {
    var_01 thread func_8988(var_01);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_health_regen_on_kill")) {
    var_01 thread func_89B1(var_01);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_refresh")) {
    var_01 thread func_89DB(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_fire_kill")) {
    var_01 thread func_89A3(var_01, var_02, var_05);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_random_perks")) {
    var_01 thread func_89D9(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_headshot_super")) {
    var_01 thread func_89B0(var_05, var_01, var_02, var_04, var_06);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_hitman")) {
    var_01 thread func_89B3(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_scorestreak_pack")) {
    var_01 thread func_89E0(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_sonic")) {
    var_01 thread func_89E7(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_headshot")) {
    var_01 thread func_89AF(var_05, var_01, var_02, var_04, var_06, var_07);
  }

  if((var_01 scripts\mp\utility\game::_hasperk("passive_meleekill") || var_01 scripts\mp\utility\game::_hasperk("passive_meleekill_silent")) && var_04 == "MOD_MELEE") {
    var_01 thread func_89AB(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_gore")) {
    var_01 thread func_89AB(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_visor_detonation")) {
    var_01 thread handlevisordetonationpassive(var_05, var_01, var_02, var_04, var_06);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_railgun_overload") || var_01 scripts\mp\utility\game::_hasperk("passive_overkill")) {
    var_01 thread handleoverloadpassive(var_05, var_01, var_02, var_04, var_06, var_03);
  }

  if(ismark2weapon(var_05)) {
    var_01 thread handlemark2xpbonus(var_01, var_05);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_double_kill_reload")) {
    var_01 thread handledoublekillreload(var_05);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_jump_super")) {
    thread handlejumpsuperonkillpassive(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_melee_super")) {
    thread handlemeleesuperonkillpassive(var_01, var_02, var_04);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_double_kill_super")) {
    thread handledoublekillsuperpassive(var_01, var_02);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_melee_cone_expl")) {
    thread handlemeleeconeexplodeonkillpassive(var_01, var_02, var_05, var_04);
  }

  if(var_01 scripts\mp\utility\game::_hasperk("passive_leader_kill_score")) {
    thread handleleaderkillscorepassive(var_01, var_02, var_05);
  }

  thread updatemodeswitchweaponkills(var_01, var_02, var_05);
}

func_F79A() {
  thread func_13AD0();
}

func_12CF0() {
  self notify("remove_minimap_decoys_passive");
}

func_13AD0() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_minimap_decoys_passive");

  for(;;) {
    self waittill("begin_firing");
    thread func_49ED();
  }
}

func_49ED() {
  self notify("stop_minimap_decoys");
  self endon("death");
  self endon("disconnect");
  self endon("stop_minimap_decoys");
  childthread func_B7B0();

  for(;;) {
    thread func_49EC(self.origin, scripts\mp\utility\game::getotherteam(self.team));
    wait 0.25;
  }
}

func_B7B0() {
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_notify_and_time("end_firing", 1.0);
  self notify("stop_minimap_decoys");
}

func_49EC(var_00, var_01) {
  wait(randomfloatrange(0, 0.1));

  if(!isDefined(self) || !scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_02 == -1) {
    return;
  }
  var_03 = (randomintrange(-150, 150), randomintrange(-150, 150), randomintrange(-150, 150));
  scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", self.origin + var_03, "cb_compassping_enemy");
  scripts\mp\objidpoolmanager::minimap_objective_team(var_02, var_01);
  var_04 = randomfloatrange(0.4, 0.65);
  scripts\engine\utility::waittill_any_timeout(var_04, "death", "disconnect", "stop_minimap_decoys");
  scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

func_F73F() {}

func_12CCE() {}

func_89AE(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_01) || !isDefined(var_00) || !var_01 scripts\mp\utility\game::_hasperk("passive_headshot_ammo")) {
    return;
  }
  if(!scripts\mp\utility\game::isheadshot(var_00, var_04, var_03, var_01)) {
    return;
  }
  var_01 checkpassivemessage("passive_headshot_ammo");
  var_05 = weaponclipsize(var_00);
  var_06 = var_05 * 1.0;
  var_07 = var_01 getweaponammoclip(var_00);
  var_08 = min(var_07 + var_06, var_05);
  var_01 setweaponammoclip(var_00, int(var_08));

  if(var_01 isdualwielding()) {
    var_07 = var_01 getweaponammoclip(var_00, "left");
    var_08 = min(var_07 + var_06, var_05);
    var_01 setweaponammoclip(var_00, int(var_08), "left");
  }
}

handlevisordetonationpassive(var_00, var_01, var_02, var_03, var_04) {
  var_01 endon("joined_team");
  var_01 endon("joined_spectator");
  var_01 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_01) || !isDefined(var_00) || !var_01 scripts\mp\utility\game::_hasperk("passive_visor_detonation")) {
    return;
  }
  if(!scripts\mp\utility\game::isheadshot(var_00, var_04, var_03, var_01)) {
    return;
  }
  var_05 = var_02 gettagorigin("tag_eye");
  var_06 = var_2.angles;
  wait 0.1;
  thread activatevisordetonationpassive(self, var_00, var_05, var_06);
}

activatevisordetonationpassive(var_00, var_01, var_02, var_03) {
  var_04 = spawn("script_model", var_02);
  var_4.angles = var_03;
  var_4.weapon_name = var_01;
  var_04 setotherent(var_00);
  var_04 setentityowner(var_00);
  var_04 setModel("passive_mp_visorDetonation");
  wait 1;
  var_04 delete();
}

handleoverloadpassive(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_01 endon("joined_team");
  var_01 endon("joined_spectator");
  var_01 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_01) || !isDefined(var_00) || !var_01 scripts\mp\utility\game::_hasperk("passive_railgun_overload") && !var_01 scripts\mp\utility\game::_hasperk("passive_overkill")) {
    return;
  }
  if(!(isDefined(var_2.hitbychargedshot) && var_2.hitbychargedshot == var_01)) {
    return;
  }
  var_06 = var_02 gettagorigin("tag_eye");
  var_07 = var_2.angles;
  wait 0.1;
  var_2.hitbychargedshot = undefined;
  thread activateoverloadpassive(self, var_00, var_06, var_07);
  var_01 thread func_89AB(var_01, var_02);
}

activateoverloadpassive(var_00, var_01, var_02, var_03) {
  var_04 = spawn("script_model", var_02);
  var_4.angles = var_03;
  var_4.weapon_name = var_01;
  var_04 setotherent(var_00);
  var_04 setentityowner(var_00);
  var_04 setModel("passive_mp_visorDetonation");
  wait 1;
  var_04 delete();
}

ismark2weapon(var_00) {
  var_01 = getweaponvariantindex(var_00);
  return isDefined(var_01) && var_01 >= 32;
}

handlemark2xpbonus(var_00, var_01) {
  var_02 = getdvarfloat("mk2_bonus", 0.15);
  var_03 = scripts\mp\utility\game::getweapongroup(var_01);
  var_04 = var_03 + "_mk_ii_bonus";

  if(isDefined(level.prestigeextras[var_04])) {
    if(self getteamdompoints(var_04, "prestigeExtras", 1)) {
      var_02 = getdvarfloat("mk2_extra_bonus", 0.3);
    }
  }

  var_05 = scripts\mp\rank::getscoreinfovalue("kill");
  var_00 scripts\mp\rank::giverankxp("kill", int(var_05 * var_02));
}

testpassivemessage(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = "";
  }

  var_02 = 0;
  var_03 = scripts\mp\passives::getpassivedeathwatching(var_00);
  var_04 = "";

  if(isDefined(var_03)) {
    var_04 = var_03 + var_01;
    var_02 = scripts\mp\hud_message::testmiscmessage(var_04);
  }

  if(var_02) {
    return;
  }
  return;
}

checkpassivemessage(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = "";
  }

  var_02 = scripts\mp\passives::getpassivedeathwatching(var_00);

  if(isDefined(var_02)) {
    if(isendstr(var_01, "_camo")) {
      var_03 = scripts\mp\utility\game::strip_suffix(var_01, "_camo");
      var_01 = var_03;
    }

    scripts\mp\hud_message::showmiscmessage(var_02 + var_01);
  }
}

func_F82F() {
  thread func_12F0F();
}

func_12D27() {
  self notify("kill_scrambler_passive");
  func_4114();
}

func_12F0F() {
  self endon("death");
  self endon("disconnect");
  self endon("kill_scrambler_passive");

  for(;;) {
    self waittill("killed_enemy", var_00, var_01, var_02);
    self notify("start_scrambler_passive");
    self makescrambler();
    thread func_6CE3();
  }
}

func_6CE3() {
  self endon("death");
  self endon("disconnect");
  self endon("kill_scrambler_passive");
  self endon("start_scrambler_passive");
  wait 1.0;
  func_4114();
}

func_4114() {
  self clearscrambler();
}

func_F77D() {
  var_00 = self getcurrentweapon();

  if(isDefined(var_00)) {
    var_01 = weaponclipsize(var_00);
    var_02 = func_7F60(var_01);
    self setclientomnvar("ui_last_shots_clip_size", var_02);
  }
}

unsetkineticwave() {
  self setclientomnvar("ui_last_shots_clip_size", -1);
}

func_89C2(var_00, var_01, var_02) {
  if(!isDefined(var_01) || !isDefined(var_00) || !var_01 scripts\mp\utility\game::_hasperk("passive_last_shots_ammo")) {
    return;
  }
  var_03 = weaponclipsize(var_00);
  var_04 = func_7F60(var_03);
  var_05 = 0;
  var_05 = func_3E60(var_01, var_00, "right", var_03, var_04);

  if(var_01 isdualwielding()) {
    var_05 = func_3E60(var_01, var_00, "left", var_03, var_04) || var_05;
  }

  if(var_05) {
    var_01 scripts\mp\hud_message::showmiscmessage("scavenger");
  }
}

func_3E60(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_00 getweaponammoclip(var_01, var_02);

  if(var_05 >= var_04) {
    return 0;
  }

  var_06 = var_03 * 1;
  var_07 = min(var_05 + var_06, var_03);
  var_00 setweaponammoclip(var_01, int(var_07), var_02);
  return 1;
}

func_7F60(var_00) {
  return int(max(1.0, var_00 * 0.2));
}

func_F740() {
  var_00 = self getcurrentweapon();
  thread func_8CB9(var_00);
}

func_12CCF() {
  self notify("removeHealthOnKillPassive");
}

func_8CB9(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeHealthOnKillPassive");

  for(;;) {
    self waittill("killed_enemy", var_01, var_02, var_03);

    if(isalive(self) && var_02 == var_00 && self.health < self.maxhealth) {
      var_04 = int(self.maxhealth * 0.15);
      var_05 = self.health + var_04;

      if(self.health + var_05 > self.maxhealth) {
        var_05 = self.maxhealth;
      }

      self.health = var_05;
    }
  }
}

func_F6D6() {}

func_12CA7() {}

handledoublekillreload(var_00) {
  var_01 = self.func_DDC2 + 1;

  if(var_01 % 2 == 0) {
    scripts\mp\hud_message::showmiscmessage("scavenger");
    var_02 = weaponclipsize(var_00);
    var_03 = self getweaponammostock(var_00);
    var_04 = self getweaponammoclip(var_00);
    var_05 = min(var_02 - var_04, var_03);
    var_06 = min(var_04 + var_05, var_02);
    self setweaponammoclip(var_00, int(var_06));
    self setweaponammostock(var_00, int(var_03 - var_05));

    if(self isdualwielding()) {
      var_03 = self getweaponammostock(var_00);
      var_04 = self getweaponammoclip(var_00, "left");
      var_05 = min(var_02 - var_04, var_03);
      var_06 = min(var_04 + var_05, var_02);
      self setweaponammoclip(var_00, int(var_06), "left");
      self setweaponammostock(var_00, int(var_03 - var_05));
    }

    checkpassivemessage("passive_double_kill_reload");
  }
}

func_F6F0() {
  var_00 = self getcurrentweapon();
  thread func_6A02(var_00);
}

func_12CB0() {
  self notify("removeExplosiveKillsPassive");
}

func_6A02(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeExplosiveKillsPassive");

  for(;;) {
    self waittill("killed_enemy", var_01, var_02, var_03);

    if(var_02 == var_00) {
      if(func_9E84(self, var_02, var_03, self.origin, var_01)) {
        thread func_582E(var_01, var_02);
      }
    }
  }
}

func_9E84(var_00, var_01, var_02, var_03, var_04) {
  if(isalive(var_00) && !var_00 scripts\mp\utility\game::isusingremote() && (var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_HEAD_SHOT") && !scripts\mp\utility\game::iskillstreakweapon(var_01) && !isDefined(var_0.assistedsuicide)) {
    var_05 = scripts\mp\utility\game::getweapongroup(var_01);

    switch (var_05) {
      case "weapon_pistol":
        var_06 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var_06 = 1200;
        break;
      case "weapon_lmg":
      case "weapon_dmr":
      case "weapon_assault":
        var_06 = 1500;
        break;
      case "weapon_rail":
      case "weapon_sniper":
        var_06 = 2000;
        break;
      case "weapon_shotgun":
        var_06 = 500;
        break;
      case "weapon_projectile":
      default:
        var_06 = 1536;
        break;
    }

    var_07 = var_06 * var_06;

    if(distancesquared(var_03, var_4.origin) > var_07) {
      return 1;
    }
  }

  return 0;
}

func_582E(var_00, var_01) {
  var_02 = var_0.origin + (0, 0, 50);
  var_00 playSound("detpack_explo_default");
  playFX(level.mine_explode, var_02);
  radiusdamage(var_02, 200, 140, 50, self, "MOD_EXPLOSIVE", var_01);
}

func_F79B() {
  var_00 = self getcurrentweapon();

  if(doesshareammo(var_00)) {
    var_00 = scripts\mp\utility\game::func_E0CF(var_00);
  }

  thread func_B8D5(var_00);
}

func_12CF1() {
  self notify("removeMissRefundPassive");
}

func_B8D5(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  for(;;) {
    self waittill("shot_missed", var_01);

    if(var_01 == var_00) {
      if(randomfloat(1.0) > 0.75) {
        var_02 = self getweaponammostock(var_00);
        self setweaponammostock(var_00, var_02 + 1);
      }
    }
  }
}

doesshareammo(var_00) {
  return scripts\mp\weapons::isaltmodeweapon(var_00) && !issubstr(var_00, "+gl") && !issubstr(var_00, "+shotgun");
}

func_F7AA() {
  self.weaponpassivespeedmod = 0.03;
  scripts\mp\weapons::updatemovespeedscale();
}

func_12CF5() {
  self.weaponpassivespeedmod = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

setrechambermovespeedpassive() {
  self.weaponpassivefastrechamberspeedmod = -0.05;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetrechambermovespeedpassive() {
  self.weaponpassivefastrechamberspeedmod = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

func_F6FD() {}

func_12CBA() {}

func_89A0(var_00, var_01) {
  if(isDefined(var_01)) {
    playFX(scripts\engine\utility::getfx("loot_mo_money_kill"), var_1.origin + (0, 0, 45));
  }

  var_00 checkpassivemessage("passive_extra_xp");
  scripts\mp\awards::givemidmatchaward("mo_money");
}

getpassivedeathwatching(var_00, var_01) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    return 0;
  }

  if(!isDefined(var_0.passivedeathwatcher[var_01])) {
    return 0;
  }

  if(var_0.passivedeathwatcher[var_01]) {
    return 1;
  }

  return 0;
}

setpassivedeathwatching(var_00, var_01, var_02) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    var_0.passivedeathwatcher = [];
  }

  var_0.passivedeathwatcher[var_01] = var_02;
}

clearpassivedeathwatching(var_00, var_01) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    var_0.passivedeathwatcher = [];
  }

  var_0.passivedeathwatcher[var_01] = undefined;
}

func_F7BD() {}

func_12CF8() {}

updatenukepassive(var_00) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_passives_given");

    if((scripts\mp\utility\game::_hasperk("passive_nuke") || hasnukepassiveinloadout() || isDefined(self.pers["passive_nuke_key"]) && self.pers["passive_nuke_key"] > 0) && !getpassivedeathwatching(self, "passive_nuke_key")) {
      thread func_C1C7();
      setpassivedeathwatching(self, "passive_nuke_key", 1);
    }
  }
}

hasnukepassiveinloadout() {
  var_00 = 0;
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    var_04 = scripts\mp\loot::getpassivesforweapon(var_03);

    if(isDefined(var_04) && var_4.size > 0) {
      foreach(var_06 in var_04) {
        if(var_06 == "passive_nuke") {
          var_00 = 1;
          break;
        }
      }

      if(scripts\mp\utility\game::istrue(var_00)) {
        break;
      }
    }
  }

  return var_00;
}

func_89CC(var_00, var_01, var_02) {
  self endon("disconnect");

  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00) && !scripts\mp\utility\game::issimultaneouskillenabled() || !isDefined(var_02) || !isDefined(var_01)) {
    return;
  }
  var_03 = !scripts\mp\utility\game::isreallyalive(var_00) && scripts\mp\utility\game::issimultaneouskillenabled();

  if(level.gametype == "infect") {
    var_04 = [];
    var_4[var_4.size] = "passive_nuke";
  } else {
    var_04 = scripts\mp\loot::getpassivesforweapon(var_02);

    if(!isDefined(var_04) || var_4.size == 0) {
      return;
    }
  }

  var_05 = 0;

  foreach(var_07 in var_04) {
    if(var_07 == "passive_nuke") {
      var_05 = 1;
      break;
    }
  }

  if(!var_05) {
    return;
  }
  if(var_03) {
    waittillframeend;

    if(!scripts\mp\utility\game::istrue(self.simultaneouskill)) {
      return;
    }
  }

  if(!isDefined(var_0.pers["passive_nuke_key"])) {
    var_0.pers["passive_nuke_key"] = 1;
  } else {
    var_0.pers["passive_nuke_key"]++;
  }

  if(var_0.pers["passive_nuke_key"] >= 25) {
    var_00 checkpassivemessage("passive_nuke");
    var_00 thread scripts\mp\hud_message::showkillstreaksplash("nuke");
    var_00 scripts\mp\killstreaks\killstreaks::awardkillstreak("nuke", var_00);
    var_0.pers["passive_nuke_key"] = 0;
    var_00 scripts\mp\missions::func_D991("ch_darkops_nuke");
  } else if(var_0.pers["passive_nuke_key"] == 24)
    var_00 thread scripts\mp\hud_message::showsplash("nuke_kill_single");
  else if(var_0.pers["passive_nuke_key"] == 2) {
    var_00 thread func_C1C8();
  } else if(var_0.pers["passive_nuke_key"] >= 20) {
    var_00 thread func_C1C8();
  } else if(var_0.pers["passive_nuke_key"] >= 5) {
    if(var_0.pers["passive_nuke_key"] % 5 == 0) {
      var_00 thread func_C1C8();
    }
  }
}

func_C1C8() {
  var_00 = 25 - self.pers["passive_nuke_key"];
  thread scripts\mp\hud_message::showsplash("nuke_kill", var_00);
}

func_C1C7() {
  self endon("disconnect");
  self waittill("death");

  if(scripts\mp\utility\game::issimultaneouskillenabled()) {
    scripts\engine\utility::waitframe();
  }

  self.pers["passive_nuke_key"] = undefined;
  clearpassivedeathwatching(self, "passive_nuke_key");
}

setquadfeederpassive() {}

quadfeederon() {
  if(!scripts\mp\utility\game::istrue(self.quadfeeder)) {
    self.quadfeeder = 1;
    setpassivevalue("passive_berserk", 1);
    scripts\mp\utility\game::giveperk("specialty_overcharge");
    self _meth_85C1(65);
    var_00 = self _meth_85C0();

    if(var_00 < 0) {
      var_00 = 100;
    }

    var_00 = max(var_00 - 10, 0);
    self getweaponrankinfomaxxp(int(var_00));
  }

  self notify("stop_quadFeeder_timer");
  thread timeoutquadfeeder(1.5);
}

timeoutquadfeeder(var_00) {
  self endon("end_quadFeederEffect");
  self endon("stop_quadFeeder_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelquadfeeder();
  wait(var_00);
  unsetquadfeedereffect();
}

listencancelquadfeeder() {
  self endon("end_quadFeederEffect");
  self endon("stop_quadFeeder_timer");
  self endon("disconnect");
  scripts\engine\utility::waittill_any("death", "weapon_change");
  unsetquadfeedereffect();
}

unsetquadfeedereffect() {
  if(scripts\mp\utility\game::istrue(self.quadfeeder)) {
    self.quadfeeder = 0;
    setpassivevalue("passive_berserk", undefined);
    scripts\mp\utility\game::removeperk("specialty_overcharge");
    self _meth_85C2();
    var_00 = self _meth_85C0();
    var_00 = min(var_00 + 20, 100);
    self getweaponrankinfomaxxp(int(var_00));
    self notify("end_quadFeederEffect");
  }
}

unsetquadfeederpassive() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  unsetquadfeedereffect();
}

func_F865() {}

func_12D3B() {}

func_F82A() {
  var_00 = self getcurrentweapon();
  scripts\mp\utility\game::func_1824("kill", 0.1, var_00);
  thread func_4112(var_00);
}

func_12D23() {
  self notify("score_bonus_kills_removed");
}

func_4112(var_00) {
  self endon("disconnect");
  self waittill("score_bonus_kills_removed");
  scripts\mp\utility\game::func_E165("kill", 0.1, var_00);
}

func_F82B() {
  var_00 = [];

  foreach(var_06, var_02 in level.scoreinfo) {
    var_03 = issubstr(var_06, "_mode_");
    var_04 = issubstr(var_06, "_score");
    var_05 = var_2["value"];

    if(var_03 && var_04 && var_05 > 0) {
      var_0[var_0.size] = func_4A0B(var_06, 0.2);
    }
  }

  foreach(var_08 in var_00) {
    scripts\mp\utility\game::func_1824(var_8.func_67E5, var_8.func_2C80, var_8.weapon);
  }

  thread func_4113(var_00);
}

func_12D24() {
  self notify("score_bonus_objectives_removed");
}

func_4A0B(var_00, var_01, var_02) {
  var_03 = spawnStruct();
  var_3.func_67E5 = var_00;
  var_3.func_2C80 = var_01;
  var_3.weapon = var_02;
  return var_03;
}

func_4113(var_00) {
  self endon("disconnect");
  self waittill("score_bonus_objectives_removed");

  foreach(var_02 in var_00) {
    scripts\mp\utility\game::func_E165(var_2.func_67E5, var_2.func_2C80, var_2.weapon);
  }
}

func_F746() {
  self endon("passive_hivemind_cancel");
  func_12EAA(level.players);
  thread func_905E();
  thread func_905F();
}

func_12CD1() {
  foreach(var_01 in self.func_905B) {
    var_02 = self.func_905A[var_01];
    scripts\mp\utility\game::outlinedisable(var_01, var_02);
  }

  self.func_905B = undefined;
  self.func_905A = undefined;
  self notify("passive_hivemind_cancel");
}

func_12EA9(var_00) {
  func_12EAA([var_00]);
}

func_12EAA(var_00) {
  if(!isDefined(self.func_905B)) {
    self.func_905B = [];
  }

  if(!isDefined(self.func_905A)) {
    self.func_905A = [];
  }

  foreach(var_02 in var_00) {
    if(var_02 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_02) || !isDefined(var_2.team)) {
      continue;
    }
    var_03 = func_7F04(var_02);

    if(level.teambased && self.team == var_2.team && var_2.health > 0) {
      if(var_03 < 0) {
        wait 0.1;

        if(!isDefined(var_02)) {
          continue;
        }
        var_04 = scripts\mp\utility\game::outlineenableforplayer(var_02, "cyan", self, 0, 1, "level_script");
        self.func_905B[self.func_905B.size] = var_04;
        self.func_905A[var_04] = var_02;
        thread func_905D(var_02);
        thread func_9060(var_02);
        thread func_905C(var_02);
      }

      continue;
    }

    if(var_03 >= 0) {
      var_05 = [];
      var_06 = [];
      scripts\mp\utility\game::outlinedisable(var_03, var_02);

      foreach(var_04 in self.func_905B) {
        var_08 = self.func_905A[var_04];

        if(var_08 == var_02) {
          continue;
        }
        var_5[var_5.size] = var_04;
        var_6[var_04] = var_08;
      }

      self.func_905B = var_05;
      self.func_905A = var_06;
      var_02 notify("passive_hivemind_listen_cancel");
    }
  }
}

func_7F04(var_00) {
  if(!isDefined(self.func_905B) || !isDefined(self.func_905A)) {
    return -1;
  }

  foreach(var_02 in self.func_905B) {
    var_03 = self.func_905A[var_02];

    if(var_03 == var_00) {
      return var_02;
    }
  }

  return -1;
}

func_905D(var_00) {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");
  var_00 endon("passive_hivemind_listen_cancel");
  var_00 waittill("disconnect");
  thread func_12EA9(var_00);
}

func_9060(var_00) {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");
  var_00 endon("passive_hivemind_listen_cancel");
  var_00 waittill("joined_team");
  thread func_12EA9(var_00);
}

func_905C(var_00) {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");
  var_00 endon("passive_hivemind_listen_cancel");
  var_00 waittill("death");
  thread func_12EA9(var_00);
}

func_905E() {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");

  for(;;) {
    level waittill("player_spawned", var_00);
    thread func_12EA9(var_00);
  }
}

func_905F() {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");

  for(;;) {
    level waittill("joined_spectator", var_00);
    thread func_12EA9(var_00);
  }
}

func_F74B() {
  self endon("passive_hunter_killer_cancel");
  thread func_12EAE(level.players);
  thread func_91EA();

  foreach(var_01 in level.players) {
    thread func_91EC(var_01);
    thread func_91EB(var_01);
  }
}

func_12CD4() {
  self notify("passive_hunter_killer_cancel");

  foreach(var_01 in self.func_91E9) {
    var_02 = self.func_91E8[var_01];
    scripts\mp\utility\game::outlinedisable(var_01, var_02);
  }

  self.func_91E9 = undefined;
  self.func_91E8 = undefined;
}

func_91EC(var_00) {
  self endon("passive_hunter_killer_cancel");
  var_00 waittill("disconnect");
  thread func_12EAD(var_00);
}

func_91EB(var_00) {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
    thread func_12EAD(var_00);
  }
}

func_91ED(var_00) {
  self endon("passive_hunter_killer_cancel");
  var_00 endon("passive_hunter_killer_listen_cancel");

  for(;;) {
    wait 1.0;
    thread func_12EAD(var_00);
  }
}

func_91EA() {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    level waittill("connected", var_00);
    thread func_12EAD(var_00);
    thread func_91EC(var_00);
    thread func_91EB(var_00);
  }
}

func_7F09(var_00) {
  if(!isDefined(self.func_91E9) || !isDefined(self.func_91E8)) {
    return -1;
  }

  foreach(var_02 in self.func_91E9) {
    var_03 = self.func_91E8[var_02];

    if(!isDefined(var_03)) {
      continue;
    }
    if(var_03 == var_00) {
      return var_02;
    }
  }

  return -1;
}

func_12EAD(var_00) {
  var_01 = [];
  var_1[var_1.size] = var_00;
  thread func_12EAE(var_01);
}

func_12EAE(var_00) {
  if(!isDefined(self.func_91E9)) {
    self.func_91E9 = [];
  }

  if(!isDefined(self.func_91E8)) {
    self.func_91E8 = [];
  }

  foreach(var_02 in var_00) {
    if(var_02 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_02) || !isDefined(var_2.team)) {
      continue;
    }
    var_03 = func_7F09(var_02);
    var_04 = var_2.maxhealth / 2;
    var_05 = var_2.health;

    if(level.teambased && self.team != var_2.team && var_05 <= var_04 && var_05 > 0) {
      if(var_03 < 0 && !var_02 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
        var_06 = scripts\mp\utility\game::outlineenableforplayer(var_02, "red", self, 1, 0, "level_script");
        self.func_91E9[self.func_91E9.size] = var_06;
        self.func_91E8[var_06] = var_02;
        thread func_91ED(var_02);
      }

      continue;
    }

    if(var_03 >= 0) {
      var_07 = [];
      var_08 = [];
      scripts\mp\utility\game::outlinedisable(var_03, var_02);

      foreach(var_06 in self.func_91E9) {
        var_10 = self.func_91E8[var_06];

        if(var_10 == var_02) {
          continue;
        }
        var_7[var_7.size] = var_06;
        var_8[var_06] = var_10;
      }

      self.func_91E9 = var_07;
      self.func_91E8 = var_08;
      var_02 notify("passive_hunter_killer_listen_cancel");
    }
  }
}

func_F758() {}

func_12CD9() {}

unsetdoublekillsuperpassive() {
  self notify("unset_passive_double_kill_super");
  self.passivedoublekillpending = undefined;
}

setwallrunquieterpassive() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWallrunQuieter");
  thread wallrunquieterwatchfordeath();

  for(;;) {
    if(self iswallrunning() || !self isonground()) {
      if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_wallrun_quieter"))) {
        setpassivevalue("passive_wallrun_quieter", 1);
        checkpassivemessage("passive_wallrun_quieter", "_start");
        scripts\mp\utility\game::giveperk("specialty_quieter");
      }
    } else if(scripts\mp\utility\game::istrue(getpassivevalue("passive_wallrun_quieter"))) {
      setpassivevalue("passive_wallrun_quieter", undefined);
      checkpassivemessage("passive_wallrun_quieter", "_end");
      scripts\mp\utility\game::removeperk("specialty_quieter");
    }

    scripts\engine\utility::waitframe();
  }
}

wallrunquieterwatchfordeath() {
  self endon("disconnect");
  self endon("unsetWallrunQuieter");
  self waittill("death");
  setpassivevalue("passive_wallrun_quieter", undefined);
}

unsetwallrunquieterpassive() {
  self notify("unsetWallrunQuieter");

  if(scripts\mp\utility\game::istrue(getpassivevalue("passive_wallrun_quieter"))) {
    setpassivevalue("passive_wallrun_quieter", undefined);
    checkpassivemessage("passive_wallrun_quieter", "_end");
    scripts\mp\utility\game::removeperk("specialty_quieter");
  }
}

setslideblastshield() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetSlideBlastShield");
  thread slideblastshieldwatchfordeath();
  var_00 = undefined;

  for(;;) {
    var_01 = self getstance();

    if(self issprintsliding() || (var_01 == "crouch" || var_01 == "prone") && self isonground()) {
      var_00 = undefined;

      if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_slide_blastshield"))) {
        setpassivevalue("passive_slide_blastshield", 1);
        checkpassivemessage("passive_slide_blastshield", "_start");
        scripts\mp\utility\game::giveperk("specialty_blastshield");
      }
    } else if(!isDefined(var_00))
      var_00 = gettime() + 250.0;
    else if(gettime() >= var_00) {
      if(scripts\mp\utility\game::istrue(getpassivevalue("passive_slide_blastshield"))) {
        setpassivevalue("passive_slide_blastshield", undefined);
        checkpassivemessage("passive_slide_blastshield", "_end");
        scripts\mp\utility\game::removeperk("specialty_blastshield");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

slideblastshieldwatchfordeath() {
  self endon("disconnect");
  self endon("unsetSlideBlastShield");
  self waittill("death");
  setpassivevalue("passive_slide_blastshield", undefined);
}

unsetslideblastshield() {
  self notify("unsetSlideBlastShield");

  if(scripts\mp\utility\game::istrue(getpassivevalue("passive_slide_blastshield"))) {
    setpassivevalue("passive_slide_blastshield", undefined);
    checkpassivemessage("passive_slide_blastshield", "_end");
    scripts\mp\utility\game::removeperk("specialty_blastshield");
  }
}

setproneblindeye() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetProneBlindEye");
  thread proneblindeyewatchfordeath();
  var_00 = undefined;

  for(;;) {
    if(self getstance() == "prone") {
      if(!isDefined(var_00)) {
        var_00 = gettime() + 250.0;
      } else if(gettime() >= var_00) {
        if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_prone_blindeye"))) {
          setpassivevalue("passive_prone_blindeye", 1);
          checkpassivemessage("passive_prone_blindeye", "_start");
          scripts\mp\utility\game::giveperk("specialty_blindeye");
        }
      }
    } else {
      var_00 = undefined;

      if(scripts\mp\utility\game::istrue(getpassivevalue("passive_prone_blindeye"))) {
        setpassivevalue("passive_prone_blindeye", undefined);
        checkpassivemessage("passive_prone_blindeye", "_end");
        scripts\mp\utility\game::removeperk("specialty_blindeye");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

proneblindeyewatchfordeath() {
  self endon("disconnect");
  self endon("unsetProneBlindEye");
  self waittill("death");
  setpassivevalue("passive_prone_blindeye", undefined);
}

unsetproneblindeye() {
  self notify("unsetProneBlindEye");

  if(scripts\mp\utility\game::istrue(getpassivevalue("passive_prone_blindeye"))) {
    setpassivevalue("passive_prone_blindeye", undefined);
    checkpassivemessage("passive_prone_blindeye", "_end");
    scripts\mp\utility\game::removeperk("specialty_blindeye");
  }
}

setstationaryengineer() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetStationaryEngineer");
  thread stationaryengineerwatchfordeath();
  var_00 = undefined;

  for(;;) {
    var_01 = self getstance();

    if(var_01 == "crouch" || var_01 == "prone" || lengthsquared(self getvelocity()) == 0) {
      if(!isDefined(var_00)) {
        var_00 = gettime() + 750.0;
      } else if(gettime() > var_00) {
        if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_stationary_engineer"))) {
          setpassivevalue("passive_stationary_engineer", 1);
          checkpassivemessage("passive_stationary_engineer", "_start");
          scripts\mp\utility\game::giveperk("specialty_engineer");
        }
      }
    } else {
      var_00 = undefined;

      if(scripts\mp\utility\game::istrue(getpassivevalue("passive_stationary_engineer"))) {
        setpassivevalue("passive_stationary_engineer", undefined);
        checkpassivemessage("passive_stationary_engineer", "_end");
        scripts\mp\utility\game::removeperk("specialty_engineer");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

unsetstationaryengineer() {
  self notify("unsetStationaryEngineer");

  if(scripts\mp\utility\game::istrue(getpassivevalue("passive_stationary_engineer"))) {
    setpassivevalue("passive_stationary_engineer", undefined);
    checkpassivemessage("passive_stationary_engineer", "_end");
    scripts\mp\utility\game::removeperk("specialty_engineer");
  }
}

stationaryengineerwatchfordeath() {
  self endon("disconnect");
  self endon("unsetStationaryEngineer");
  self waittill("death");
  setpassivevalue("passive_stationary_engineer", undefined);
}

setdoppleganger() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetDoppleganger");
  thread dopplegangerwatchfordeath();

  for(;;) {
    scripts\engine\utility::waitframe();
  }
}

dopplegangerwatchfordeath() {
  self endon("disconnect");
  self endon("unsetDoppleganger");
  self waittill("death");
  setpassivevalue("passive_doppleganger", undefined);
}

unsetdoppleganger() {
  self notify("unsetDoppleganger");

  if(scripts\mp\utility\game::istrue(getpassivevalue("passive_doppleganger"))) {
    setpassivevalue("passive_doppleganger", undefined);
    checkpassivemessage("passive_doppleganger", "_end");
    scripts\mp\utility\game::removeperk("specialty_doppleganger");
  }
}

setcollatstreak() {
  setpassivevalue("passive_collat_streak", ::collatstreakgive);
}

unsetcollatstreak() {
  self.lastcollattime = undefined;
  setpassivevalue("passive_collat_streak", undefined);
}

collatstreakgive() {
  if(!isDefined(self.lastcollattime) || self.lastcollattime < gettime()) {
    scripts\mp\killstreaks\killstreaks::awardkillstreak("venom", self);
    scripts\mp\hud_message::showkillstreaksplash("venom");
    self.lastcollattime = gettime();
  }
}

func_F884() {}

func_12D48() {}

setstackvalues(var_00, var_01, var_02, var_03) {
  if(!isDefined(self.stackvalues)) {
    self.stackvalues = [];
  }

  if(!isDefined(self.stackvalues[var_00])) {
    var_04 = spawnStruct();
    var_4.id = var_00;
    var_4.stacksmax = var_01;
    var_4.stackscurrent = var_02;
    var_4.decaytime = var_03;
    self.stackvalues[var_00] = var_04;
  }
}

getstackvalues(var_00) {
  if(!isDefined(self.stackvalues)) {
    return undefined;
  }

  if(!isDefined(self.stackvalues[var_00])) {
    return undefined;
  }

  var_01 = self.stackvalues[var_00];
  return var_01;
}

getstackcount(var_00) {
  var_01 = getstackvalues(var_00);

  if(!isDefined(var_01)) {
    return 0;
  }

  return var_1.stackscurrent;
}

addstackcount(var_00, var_01) {}

func_89EB(var_00, var_01) {
  var_02 = var_0.killsthislife.size + 1;

  if(var_02 >= 5) {
    var_03 = weaponclipsize(var_01);
    var_04 = int(max(var_03 * 0.2, 1));
    var_05 = var_00 getweaponammostock(var_01);
    var_00 setweaponammostock(var_01, var_05 + var_04);
    var_00 scripts\mp\hud_message::showmiscmessage("scavenger");
  }
}

func_89C8(var_00, var_01) {
  var_02 = "passive_move_speed_on_kill";
  var_00 notify(var_02);
  var_00 endon(var_02);

  if(!isDefined(var_0.weaponpassivespeedonkillmod) || var_0.weaponpassivespeedonkillmod != 0.04) {
    var_0.weaponpassivespeedonkillmod = 0.04;
    var_00 scripts\mp\weapons::updatemovespeedscale();
  }

  var_00 scripts\engine\utility::waittill_any_timeout(3.5, "death", "disconnect");

  if(!isDefined(var_00)) {
    return;
  }
  var_0.weaponpassivespeedonkillmod = 0;
  var_00 scripts\mp\weapons::updatemovespeedscale();
  var_00 checkpassivemessage("passive_move_speed_on_kill");
}

func_8988(var_00) {
  var_00 scripts\mp\utility\game::func_DE39(2.5);
  var_00 checkpassivemessage("passive_cooldown_on_kill");
}

func_89B1(var_00) {
  var_00 notify("force_regeneration");
  var_00 checkpassivemessage("passive_health_regen_on_kill");
}

func_89DB(var_00, var_01) {
  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00) || !isDefined(var_01)) {
    return;
  }
  if(!getpassivedeathwatching(var_00, "passive_refresh_key")) {
    var_00 thread func_DE76();
    var_00 setpassivedeathwatching(var_00, "passive_refresh_key", 1);
  }

  if(!isDefined(var_0.pers["passive_refresh_key"])) {
    var_0.pers["passive_refresh_key"] = 1;
  } else {
    var_0.pers["passive_refresh_key"]++;
  }

  if(var_0.pers["passive_refresh_key"] >= 5) {
    var_00 checkpassivemessage("passive_refresh");
    var_00 thread scripts\mp\hud_message::showkillstreaksplash("refresh");
    var_00 scripts\mp\powers::func_1813(1);
    var_0.pers["passive_refresh_key"] = 0;
  } else if(var_0.pers["passive_refresh_key"] == 4)
    var_00 thread scripts\mp\hud_message::showsplash("refresh_kill_single");
  else if(var_0.pers["passive_refresh_key"] == 3) {
    var_00 thread func_DE77();
  }
}

func_DE77() {
  var_00 = 5 - self.pers["passive_refresh_key"];
  thread scripts\mp\hud_message::showsplash("refresh_kill", var_00);
}

func_DE76() {
  self endon("disconnect");
  self waittill("death");
  self.pers["passive_refresh_key"] = undefined;
  clearpassivedeathwatching(self, "passive_refresh_key");
}

func_89B3(var_00, var_01) {
  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00) || !isDefined(var_01)) {
    return;
  }
  var_02 = var_1.name;

  if(teamsmatch(var_00, var_01)) {
    return;
  }
  if(!isDefined(var_0.func_903C)) {
    var_0.func_903C = [];
  } else if(func_903B(var_00, var_02)) {
    return;
  }
  var_0.func_903C[var_0.func_903C.size] = var_02;
  var_03 = 0;
  var_04 = 0;

  foreach(var_06 in level.players) {
    if(teamsmatch(var_00, var_06)) {
      continue;
    }
    var_07 = var_6.name;

    if(func_903B(var_00, var_07)) {
      var_3++;
    }

    var_4++;
  }

  var_09 = var_04 - var_03;

  if(var_09 <= 3) {
    var_00 func_903E(var_09);
  }

  if(var_09 <= 0) {
    var_10 = 0;

    if(var_04 >= 3) {
      var_10 = 200;
    } else if(var_04 >= 2) {
      var_10 = 100;
    } else {
      var_10 = 75;
    }

    var_11 = var_10 * var_04;
    var_00 checkpassivemessage("passive_hitman");
    var_00 thread scripts\mp\supers::stopshellshock(var_11);
    var_0.func_903C = [];
  }
}

func_903B(var_00, var_01) {
  if(!isDefined(var_0.func_903C)) {
    return 0;
  }

  foreach(var_03 in var_0.func_903C) {
    if(var_03 == var_01) {
      return 1;
    }
  }

  return 0;
}

func_903E(var_00) {
  var_00 = int(max(0, var_00));

  switch (var_00) {
    case 0:
      thread scripts\mp\hud_message::showkillstreaksplash("hitman_kill_all");
      break;
    case 1:
      thread scripts\mp\hud_message::showsplash("hitman_kill_single");
      break;
    default:
      thread scripts\mp\hud_message::showsplash("hitman_kill", var_00);
      break;
  }
}

func_903D() {
  self endon("disconnect");
  self waittill("death");
  self.func_903C = undefined;
}

func_89E0(var_00, var_01) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 endon("diconnect");
  var_00 scripts\mp\archetypes\archengineer::createentityeventdata(var_00, var_01, "scorestreak");
  var_00 checkpassivemessage("passive_scorestreak_pack");
  checkpassivemessage("passive_scorestreak_pack");
}

func_89AB(var_00, var_01) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 endon("diconnect");
  level thread handlegoreeffect(var_01);
  wait 0.05;
  var_02 = var_01 _meth_8113();

  if(isDefined(var_02)) {
    var_02 hide();
    var_2.permanentcustommovetransition = 1;
  }

  checkpassivemessage("passive_gore");
}

handlegoreeffect(var_00) {
  var_01 = var_00 gettagorigin("j_spine4");

  if(var_0.loadoutarchetype == "archetype_scout") {
    playFX(level._effect["passive_gore_robot"], var_01, (1, 0, 0));
  } else {
    playFX(level._effect["passive_gore"], var_01, (1, 0, 0));
  }

  playLoopSound(var_01, "gib_fullbody");
  scripts\mp\shellshock::_earthquake(0.5, 1.5, var_01, 120);
}

func_89E7(var_00, var_01) {
  var_00 checkpassivemessage("passive_pack_scorestreak");
}

func_89E6(var_00, var_01) {}

func_89AF(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!scripts\mp\utility\game::isheadshot(var_00, var_04, var_03, var_01)) {
    return;
  }
}

func_89D9(var_00, var_01) {
  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00) || !isDefined(var_01)) {
    return;
  }
  if(!getpassivedeathwatching(var_00, "passive_random_perks_key")) {
    var_00 thread func_DCC3();
    var_00 setpassivedeathwatching(var_00, "passive_random_perks_key", 1);
  }

  if(!isDefined(var_0.pers["passive_random_perks_key"])) {
    var_0.func_DCC2 = [];
    var_0.pers["passive_random_perks_key"] = 1;
  } else {
    if(isDefined(var_0.func_DCC2) && var_0.func_DCC2.size >= 3) {
      return;
    }
    var_0.pers["passive_random_perks_key"]++;
  }

  if(!isDefined(var_0.func_DCC2)) {
    var_0.func_DCC2 = [];
  }

  if(var_0.pers["passive_random_perks_key"] >= 3) {
    var_02 = var_00 scripts\mp\perks::func_7DE8();

    if(isDefined(var_02) && var_2.size > 0) {
      var_03 = randomintrange(0, var_2.size - 1);
      var_04 = var_2[var_03];

      if(!isDefined(var_04)) {
        return;
      }
      var_00 checkpassivemessage("passive_random_perks", "_" + var_04);
      var_00 scripts\mp\utility\game::giveperk(var_04);
      var_05 = scripts\engine\utility::ter_op(isDefined(var_0.func_DCC2), var_0.func_DCC2.size, 0);
      var_0.func_DCC2[var_05] = var_04;
    }

    var_0.pers["passive_random_perks_key"] = 0;
  }
}

func_11753(var_00) {
  var_01 = var_00 scripts\mp\perks::func_7DE8();

  if(isDefined(var_01) && var_1.size > 0) {
    foreach(var_03 in var_01) {
      testpassivemessage("passive_random_perks", "_" + var_03);
    }
  }
}

func_DCC3() {
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self.func_DCC2)) {
    foreach(var_01 in self.func_DCC2) {
      scripts\mp\utility\game::removeperk(var_01);
    }
  }

  self.func_DCC2 = undefined;
  self.pers["passive_random_perks_key"] = undefined;
  clearpassivedeathwatching(self, "passive_random_perks_key");
}

func_89B0(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_01) || !isDefined(var_00) || !var_01 scripts\mp\utility\game::_hasperk("passive_headshot_super")) {
    return;
  }
  if(!scripts\mp\utility\game::isheadshot(var_00, var_04, var_03, var_01)) {
    return;
  }
  var_01 thread scripts\mp\supers::stopshellshock(100);
  var_01 checkpassivemessage("passive_headshot_super");
}

func_89A3(var_00, var_01, var_02) {
  var_03 = spawn("trigger_radius", var_1.origin, 0, 50, 100);
  var_3.owner = var_00;
  scripts\mp\utility\game::playteamfxforclient(var_0.team, var_1.origin, "player_plasma_friendly", "player_plasma_enemy", 5);
  var_03 thread func_AD70(var_02);
  var_03 thread func_AD71();
  var_00 checkpassivemessage("passive_fire_kill");
}

func_AD70(var_00) {
  self endon("passive_fire_kill_delete");

  for(;;) {
    self waittill("trigger", var_01);

    if(!isDefined(var_01) || !isDefined(self) || !isDefined(self.owner)) {
      break;
    }
    if(!isplayer(var_01)) {
      continue;
    }
    if(teamsmatch(self.owner, var_01)) {
      continue;
    }
    var_02 = var_01 getpassivevalue("passive_fire_kill");

    if(var_02 <= 0) {
      var_01 thread func_10D9E(var_00, self.owner, "passive_fire_kill", "player_plasma_friendly", "player_plasma_enemy", "j_mainroot", "player_plasma_screen_stand");
      var_01 thread startdamageovertime(var_00, self.owner, 5, 0.5, 4, "passive_fire_kill");
      continue;
    }

    setpassivevalue("passive_fire_kill", 4);
  }
}

func_AD71() {
  wait 5;

  if(!isDefined(self)) {
    return;
  }
  self notify("passive_fire_kill_delete");
  self delete();
}

func_3E01() {
  if(scripts\mp\utility\game::_hasperk("passive_critical_chance_damage")) {
    if(randomintrange(1, 10) == 1) {
      scripts\mp\utility\game::giveperk("specialty_moredamage");
    }
  }

  if(scripts\mp\utility\game::_hasperk("passive_critical_sequential_damage")) {
    if(getpassivevalue("passive_critical_sequential_damage") >= 4) {
      setpassivevalue("passive_critical_sequential_damage", -1);
      scripts\mp\utility\game::giveperk("specialty_moredamage");
    }
  }
}

func_1174D() {
  var_00 = self getEye();
  var_01 = anglesToForward(self getplayerangles());
  var_02 = 200;
  var_03 = var_01 * var_02;
  var_04 = func_11755(var_00, var_00 + var_03);
  var_05 = var_04 - var_00;
  var_06 = 25;
  var_07 = (0, 0, 0);
  var_08 = 100;
  var_09 = 0;
  var_10 = 1;
  var_11 = 0.15;

  for(;;) {
    var_9++;
    var_12 = var_00 + var_01 * (var_06 * var_09);
    var_13 = var_12 - var_00;

    if(!func_1174A(var_05, var_13)) {
      break;
    }
    var_14 = var_12 + (0, 0, var_08 * -1);
    var_15 = func_11755(var_12, var_14);

    if(var_15 == var_14) {
      continue;
    }
    var_16 = var_10 + var_11 * var_09;
    scripts\mp\utility\game::playteamfxforclient(self.team, var_15, "player_plasma_friendly", "player_plasma_enemy", var_16);
  }
}

func_1174A(var_00, var_01) {
  if(!func_11749(var_0[0], var_1[0])) {
    return 0;
  }

  if(!func_11749(var_0[1], var_1[1])) {
    return 0;
  }

  if(!func_11749(var_0[2], var_1[2])) {
    return 0;
  }

  return 1;
}

func_11749(var_00, var_01) {
  if(var_00 > 0 && var_01 > var_00) {
    return 0;
  }

  if(var_00 < 0 && var_01 < var_00) {
    return 0;
  }

  return 1;
}

func_11755(var_00, var_01) {
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
  var_03 = physics_raycast(var_00, var_01, var_02, [self], 0, "physicsquery_closest");

  if(isDefined(var_03) && var_3.size > 0) {
    return var_3[0]["position"];
  }

  return var_01;
}

func_8974(var_00, var_01) {
  if(!isDefined(var_00) || !scripts\mp\utility\game::isreallyalive(var_00) || !isDefined(var_01) || var_0.func_2049) {
    return;
  }
  if(var_0.func_204A == 0 && level.gametype != "infect") {
    var_0.func_204A = 1;
    var_00 thread scripts\mp\hud_message::showsplash("specialty_scavenger");
    var_00 scripts\mp\utility\game::giveperk("specialty_scavenger");
  } else
    var_0.func_204A++;

  if(var_0.func_204A == 3) {
    var_00 thread scripts\mp\hud_message::showsplash("specialty_quickdraw");
    var_00 scripts\mp\utility\game::giveperk("specialty_quickdraw");
  }

  if(var_0.func_204A == 5) {
    var_00 thread scripts\mp\hud_message::showsplash("specialty_bulletaccuracy");
    var_00 scripts\mp\utility\game::giveperk("specialty_bulletaccuracy");
  }

  if(var_0.func_204A == 7) {
    var_00 thread scripts\mp\hud_message::showsplash("specialty_specialist");
    var_00 scripts\mp\utility\game::giveperk("specialty_lightweight");
    var_00 scripts\mp\utility\game::giveperk("specialty_quieter");
    var_00 scripts\mp\utility\game::giveperk("specialty_selectivehearing");
    var_00 scripts\mp\utility\game::giveperk("specialty_gung_ho");
    var_0.func_2049 = 1;
  }
}

handlejumpsuperonkillpassive(var_00, var_01) {
  if(var_00 isonground()) {
    return;
  }
  if(var_00 iswallrunning()) {
    return;
  }
  var_00 scripts\mp\supers::stopshellshock(100);
  var_00 checkpassivemessage("passive_jump_super");
}

handlemeleesuperonkillpassive(var_00, var_01, var_02) {
  if(var_02 != "MOD_MELEE") {
    return;
  }
  var_00 scripts\mp\supers::stopshellshock(500);
  var_00 checkpassivemessage("passive_melee_super");
}

handledoublekillsuperpassive(var_00, var_01) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 endon("unset_passive_double_kill_super");
  var_00 notify("watchDoubleKillSuperPassive");
  var_00 endon("watchDoubleKillSuperPassive");

  if(!scripts\mp\utility\game::istrue(var_0.passivedoublekillpending)) {
    var_0.passivedoublekillpending = 1;
  } else {
    var_0.passivedoublekillpending = undefined;
    var_00 scripts\mp\supers::stopshellshock(200);
    var_00 checkpassivemessage("passive_double_kill_super");
    return;
  }

  wait 4;
  var_0.passivedoublekillpending = undefined;
}

setmodeswitchkillweapon(var_00, var_01) {
  if(!(scripts\mp\class::weaponhaspassive(var_01, getweaponvariantindex(var_01), "passive_mode_switch_score") || scripts\mp\class::weaponhaspassive(var_01, getweaponvariantindex(var_01), "passive_mode_switch_score_epic"))) {
    return;
  }
  var_02 = var_0.modeswitchkills;

  if(!isDefined(var_02)) {
    resetmodeswitchkillweapons(var_00);
  }

  var_03 = getmodeswitchkillweaponkey(var_01);
  var_04 = var_2.arr[var_03];

  if(!isDefined(var_04)) {
    var_04 = spawnStruct();
    var_4.numkills = 0;
    var_4.killinaltmode = undefined;
    var_2.arr[var_03] = var_04;
  }
}

unsetmodeswitchkillweapon(var_00, var_01) {
  var_02 = var_0.modeswitchkills;

  if(!isDefined(var_02)) {
    return;
  }
  var_03 = getmodeswitchkillweaponkey(var_01);
  var_2.arr[var_03] = undefined;
}

resetmodeswitchkillweapons(var_00) {
  var_01 = spawnStruct();
  var_1.arr = [];
  var_0.modeswitchkills = var_01;
  thread watchmodeswitchkillweaponsdrop(var_00);
}

watchmodeswitchkillweaponsdrop(var_00) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 notify("watchModeSwitchKillWeaponsDrop");
  var_00 endon("watchModeSwitchKillWeaponsDrop");
  var_01 = var_0.modeswitchkills;

  for(;;) {
    var_02 = var_00 getweaponslistprimaries();
    var_03 = [];
    var_04 = [];

    for(var_05 = 0; var_05 < var_2.size; var_5++) {
      var_06 = var_2[var_05];
      var_3[var_05] = ::scripts\mp\utility\game::getweaponrootname(var_06);
      var_4[var_05] = getweaponvariantindex(var_06);
    }

    var_07 = getarraykeys(var_1.arr);
    var_08 = [];
    var_09 = [];

    for(var_05 = 0; var_05 < var_7.size; var_5++) {
      var_10 = var_7[var_05];
      var_11 = strtok(var_10, "_");
      var_8[var_05] = var_11[0];
      var_9[var_05] = var_11[1];
    }

    for(var_05 = 0; var_05 < var_7.size; var_5++) {
      for(var_12 = 0; var_12 < var_2.size; var_12++) {
        if(var_8[var_05] != var_3[var_12]) {
          continue;
        }
        if(var_9[var_05] != var_4[var_12]) {
          continue;
        }
        unsetmodeswitchkillweapon(var_00, var_2[var_12]);
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

updatemodeswitchweaponkills(var_00, var_01, var_02) {
  var_03 = var_0.modeswitchkills;

  if(!isDefined(var_03)) {
    return;
  }
  if(scripts\mp\utility\game::_meth_8238(var_02) != "primary") {
    return;
  }
  var_04 = scripts\mp\utility\game::getweaponrootname(var_02);
  var_05 = getweaponvariantindex(var_02);

  if(!isDefined(var_05)) {
    return;
  }
  var_06 = var_04 + "_" + var_05;
  var_07 = var_3.arr[var_06];

  if(!isDefined(var_07)) {
    return;
  }
  var_08 = var_00 _meth_8519(var_02);

  if(!isDefined(var_7.killinaltmode) || var_7.killinaltmode == var_08) {
    var_7.numkills++;

    if(var_7.numkills >= 2) {
      var_09 = var_7.numkills - 2;

      if(scripts\engine\utility::mod(var_09, 2) == 0) {
        var_00 checkpassivemessage("passive_mode_switch_score");
      }
    }
  } else {
    var_7.numkills = 1;

    if(var_00 scripts\mp\utility\game::_hasperk("passive_mode_switch_score_epic")) {
      var_10 = "mode_switch_kill_epic";
    } else {
      var_10 = "mode_switch_kill";
    }

    var_00 thread scripts\mp\rank::scoreeventpopup(var_10);
    var_11 = scripts\mp\rank::getscoreinfovalue(var_10);
    var_00 thread scripts\mp\rank::scorepointspopup(var_11);
    var_00 scripts\mp\killstreaks\killstreaks::_meth_83A7(var_10, var_11);
  }

  var_7.killinaltmode = var_08;
}

getmodeswitchkillweaponkey(var_00) {
  return scripts\mp\utility\game::getweaponrootname(var_00) + "_" + getweaponvariantindex(var_00);
}

handlemeleeconeexplodeonkillpassive(var_00, var_01, var_02, var_03) {
  if(!var_00 _meth_8519(var_02)) {
    return;
  }
  if(var_03 != "MOD_MELEE") {
    return;
  }
  var_04 = var_00 gettagorigin("j_spineupper");
  var_05 = var_00 getplayerangles();
  var_06 = anglesToForward(var_05);
  var_07 = anglestoup(var_05);
  var_08 = var_04 - var_06 * 128;
  var_09 = 453;
  thread meleeconeexplodeworldfx(var_04, var_05, var_00);
  thread meleeconeexplodeattackerfx(var_00);
  var_01 thread scripts\mp\damage::enqueuecorpsetablefunc("passive_melee_cone_expl", ::meleeconeexplodevictimcorpsefx);

  foreach(var_11 in level.players) {
    if(var_11 == var_00) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_11)) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_00, var_11)) {
      continue;
    }
    if(level.friendlyfire == 0 && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_00, var_11))) {
      continue;
    }
    if(!scripts\mp\utility\game::pointvscone(var_11 gettagorigin("tag_eye"), var_08, var_06, var_07, var_09, 128, 18)) {
      if(!scripts\mp\utility\game::pointvscone(var_11 gettagorigin("tag_origin"), var_08, var_06, var_07, var_09, 128, 18)) {
        if(!scripts\mp\utility\game::pointvscone(var_11 gettagorigin("j_mainroot"), var_08, var_06, var_07, var_09, 128, 18)) {
          continue;
        }
      }
    }

    if(var_11 damageconetrace(var_04, var_00) <= 0) {
      continue;
    }
    var_12 = min(325, distance(var_04, var_11 getEye()));
    var_13 = 1 - var_12 / 325;
    var_14 = 80 + var_13 * 60;
    var_11 getrandomarmkillstreak(var_14, var_04, var_00, var_00, "MOD_EXPLOSIVE", var_02);

    if(scripts\mp\utility\game::isreallyalive(var_11)) {
      thread meleeconeexplodevictimfx(var_11);
      continue;
    }

    var_11 thread scripts\mp\damage::enqueuecorpsetablefunc("passive_melee_cone_expl", ::meleeconeexplodevictimcorpsefx);
  }
}

meleeconeexplodeworldfx(var_00, var_01, var_02) {
  var_03 = anglesToForward(var_01);
  var_00 = var_00 + var_03 * 10;
  var_04 = spawn("script_model", var_00);
  var_4.angles = var_01;
  var_04 setotherent(var_02);
  var_04 setentityowner(var_02);
  var_04 setModel("passive_mp_meleeConeExpl");

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
    var_04 setscriptablepartstate("effects", "activePhase");
  } else {
    var_04 setscriptablepartstate("effects", "active");
  }

  wait 0.2;
  physicsexplosionsphere(var_00, 128, 0, 1);
  wait 0.2;
  var_04 delete();
}

meleeconeexplodeattackerfx(var_00) {
  var_00 endon("disconnect");
  var_00 notify("meleeConeExplodeAttackerVfx");
  var_00 endon("meleeConeExplodeAttackerVfx");
  var_00 setscriptablepartstate("weaponPassiveMeleeConeExplAttacker", "active");
  scripts\engine\utility::waittill_any_timeout(0.2);
  var_00 setscriptablepartstate("weaponPassiveMeleeConeExplAttacker", "neutral");
}

meleeconeexplodevictimfx(var_00) {
  var_00 endon("disconnect");
  var_00 notify("meleeConeExplodeVictimVfx");
  var_00 endon("meleeConeExplodeVictimVfx");
  var_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "active", 0);
  var_00 scripts\engine\utility::waittill_any_timeout(2.75);
  var_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "neutral", 0);
}

meleeconeexplodevictimcorpsefx(var_00) {
  var_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "active", 0);
  wait 2.75;

  if(isDefined(var_00)) {
    var_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "neutral", 0);
  }
}

handleleaderkillscorepassive(var_00, var_01, var_02) {
  if(scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_02) != scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00 getcurrentprimaryweapon())) {
    return;
  }
  var_03 = [];

  if(!level.teambased) {
    var_03 = scripts\engine\utility::array_remove(level.players, var_00);
  } else {
    var_03 = scripts\mp\utility\game::getteamarray(scripts\mp\utility\game::getotherteam(var_0.team));
  }

  var_04 = 1;

  foreach(var_06 in var_03) {
    if(var_1.score >= var_6.score) {
      continue;
    }
    var_04 = 0;
    break;
  }

  if(!var_04) {
    return;
  }
  var_08 = "leader_kill_" + int(min(var_3.size, 5));
  var_00 thread scripts\mp\rank::scoreeventpopup(var_08);
  var_09 = scripts\mp\rank::getscoreinfovalue(var_08);
  var_00 thread scripts\mp\rank::scorepointspopup(var_09);
  var_00 scripts\mp\killstreaks\killstreaks::_meth_83A7(var_08, var_09);
}

handlepowermeleeondamagepassive(var_00, var_01, var_02, var_03) {
  if(var_03 != "MOD_MELEE") {
    return;
  }
  var_04 = var_00 gettagorigin("j_spineupper");
  var_05 = var_00 getplayerangles();
  var_06 = anglesToForward(var_05);
  var_07 = anglestoup(var_05);
  thread meleeconeexplodeattackerfx(var_00);
  wait 0.01;
}