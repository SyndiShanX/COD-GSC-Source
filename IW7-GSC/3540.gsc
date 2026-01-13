/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3540.gsc
**************************************/

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
    level waittill("player_spawned", var_0);
    var_0 thread updatenukepassive();
    var_0 thread watchweaponchanged();
  }
}

watchweaponchanged() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0) && var_0 != "none") {
      setmodeswitchkillweapon(self, var_0);
      giveweaponpassives(var_0);
      scripts\mp\weapons::func_12F5D(var_0);
    }

    scripts\engine\utility::waittill_any("weapon_change", "giveLoadout");
  }
}

giveweaponpassives(var_0) {
  clearpassives();
  var_1 = scripts\mp\loot::getpassivesforweapon(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      giveplayerpassive(var_3);
    }
  }

  self notify("weapon_passives_given");
}

giveplayerpassive(var_0) {
  scripts\mp\utility\game::giveperk(var_0);
  self.weaponpassives[self.weaponpassives.size] = var_0;
}

clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(var_1 in self.weaponpassives) {
      scripts\mp\utility\game::removeperk(var_1);
    }
  }

  self.weaponpassives = [];
}

forgetpassives() {
  self.weaponpassives = [];
}

definepassivevalue(var_0) {
  if(!isDefined(self.passivevalues)) {
    self.passivevalues = [];
  }

  if(!isDefined(self.passivevalues[var_0])) {
    self.passivevalues[var_0] = 0.0;
  }
}

getpassivevalue(var_0) {
  definepassivevalue(var_0);
  return self.passivevalues[var_0];
}

setpassivevalue(var_0, var_1) {
  definepassivevalue(var_0);
  self.passivevalues[var_0] = var_1;
}

teamsmatch(var_0, var_1) {
  if(level.teambased) {
    return var_0.team == var_1.team;
  }

  return var_0 == var_1;
}

updateweaponpassivesonuse(var_0, var_1) {
  if(var_0 scripts\mp\utility\game::_hasperk("passive_backfire")) {
    var_0 thread func_8978(var_0, var_1);
  }

  if(var_0 scripts\mp\utility\game::_hasperk("passive_sonar")) {
    var_0 thread func_89E5(var_0, var_1);
  }
}

func_8978(var_0, var_1) {
  if(isDefined(var_0.tookweaponfrom)) {
    var_2 = var_0.tookweaponfrom[var_1];

    if(isDefined(var_2) && var_2 != var_0) {
      playFX(scripts\engine\utility::getfx("seeker_explosion"), var_0.origin);
      var_0 getrandomarmkillstreak(9999, var_2.origin, var_2, var_2, "MOD_EXPLOSIVE", var_1);
    }
  }
}

func_12EB2(var_0) {
  var_1 = weaponclipsize(var_0);
  self setweaponammoclip(var_0, var_1);
}

updateweaponpassivesondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_0 scripts\mp\utility\game::_hasperk("passive_infinite_ammo")) {
    var_0 thread func_12EB2(var_0 getcurrentweapon());
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_minimap_damage") && isDefined(var_0) && !var_0 scripts\mp\utility\game::_hasperk("specialty_gpsjammer")) {
    var_1 thread func_89C5(var_1, var_0);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_fire_damage")) {
    var_1 thread func_89A2(var_1, var_0, var_4);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_cold_damage")) {
    var_1 thread func_8986(var_1, var_0, var_4);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_critical_sequential_damage")) {
    var_1 thread func_898A(var_1, var_0, var_4);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_sonic")) {
    var_1 thread func_89E6(var_1, var_0);
  }
}

loadoutweapongiven(var_0) {
  var_1 = scripts\mp\utility\game::getweaponrootname(var_0);
  checkprestigeextraclassicammo(var_0, var_1);
}

checkprestigeextraclassicammo(var_0, var_1) {
  var_2 = var_1 + "_extra_ammo";

  if(isDefined(level.prestigeextras[var_2])) {
    if(self getteamdompoints(var_2, "prestigeExtras", 1)) {
      var_3 = weaponmaxammo(var_0);
      var_4 = self getweaponammostock(var_0);
      var_5 = (var_3 - var_4) * 0.5;
      self setweaponammostock(var_0, int(min(var_4 + var_5, var_3)));
    }
  }
}

func_89C5(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = scripts\mp\objidpoolmanager::requestminimapid(10);

    if(var_2 == -1) {
      return;
    }
    scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "active", (0, 0, 0), "cb_compassping_enemy");
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_2, var_1);
    scripts\mp\objidpoolmanager::minimap_objective_team(var_2, var_0.team);
    var_3 = 3;
    var_1 scripts\engine\utility::waittill_any_timeout(var_3, "damage_begin", "death", "disconnect");
    scripts\mp\objidpoolmanager::returnminimapid(var_2);
  }
}

func_89E5(var_0, var_1) {
  if(!scripts\mp\utility\game::isstrstart(var_1, "alt")) {
    return;
  }
  var_2 = self getweaponammoclip(var_1);
  triggerportableradarpingteam(var_0.origin, var_0.team, 500, 500);
}

func_898A(var_0, var_1, var_2) {
  var_3 = var_0 getpassivevalue("passive_critical_sequential_damage");
  var_0 setpassivevalue("passive_critical_sequential_damage", var_3 + 1);
}

func_8986(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(weaponclass(var_2) == "sniper" || issubstr(var_2, "iw7_longshot"), -0.2, -0.1);
  thread passivecolddamagewatchvictim(var_0, var_1, var_3, 1.5);
}

passivecolddamagewatchvictim(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 notify("passiveColdDamageWatchVictim");
  var_1 endon("passiveColdDamageWatchVictim");
  var_4 = var_0 getentitynumber();
  var_5 = gettime() + var_3 * 1000;
  var_6 = self.passivecolddamage;

  if(!isDefined(var_6)) {
    var_6 = spawnStruct();
    var_6.curspeedmod = 0;
    var_6.speedmods = [];
    var_6.endtimes = [];
    var_1.passivecolddamage = var_6;
  }

  var_6.speedmods[var_4] = var_2;
  var_6.endtimes[var_4] = var_5;
  var_1 setscriptablepartstate("weaponPassiveColdDamage", "active");
  var_7 = var_6.curspeedmod;
  var_8 = var_7;

  for(;;) {
    var_9 = gettime();

    foreach(var_11, var_2 in var_6.speedmods) {
      var_5 = var_6.endtimes[var_11];

      if(var_5 < var_9) {
        var_6.speedmods[var_11] = undefined;
        var_6.endtimes[var_11] = undefined;
        continue;
      }

      if(var_2 < var_8) {
        var_8 = var_2;
      }
    }

    var_6.curspeedmod = var_8;

    if(var_6.curspeedmod != var_7) {
      var_1 scripts\mp\weapons::updatemovespeedscale();
    }

    if(var_6.speedmods.size <= 0) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  passivecolddamageresetdata(var_1);
  passivecolddamageresetscriptable(var_1);
}

passivecolddamagegetspeedmod(var_0) {
  if(isDefined(var_0.passivecolddamage)) {
    return var_0.passivecolddamage.curspeedmod;
  }

  return 0;
}

passivecolddamageresetscriptable(var_0) {
  var_0 setscriptablepartstate("weaponPassiveColdDamage", "neutral");
}

passivecolddamageresetdata(var_0) {
  var_0.passivecolddamage = undefined;
  var_0 scripts\mp\weapons::updatemovespeedscale();
}

func_89A2(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = var_1 getpassivevalue("passive_fire_damage");

    if(var_3 <= 0) {
      var_1 thread func_10D9E(var_2, var_0, "passive_fire_damage", "player_plasma_friendly", "player_plasma_enemy", "j_mainroot", "player_plasma_screen_stand");
      var_1 thread startdamageovertime(var_2, var_0, 2, 0.5, 2, "passive_fire_damage");
    } else
      setpassivevalue("passive_fire_damage", 2);
  }
}

func_AD69(var_0, var_1) {
  self endon(var_1);
  scripts\engine\utility::waittill_any("death", "disconnect", var_1);
  func_11067(var_1);
}

func_AD68(var_0, var_1) {
  var_0 endon(var_1);
  scripts\engine\utility::waittill_any("disconnect");
  var_0 func_11067(var_1);
}

func_10D9E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnfxforclient(scripts\engine\utility::getfx(var_6), self getEye(), self);

  foreach(var_9 in level.players) {
    if(var_9 == self) {
      triggerfx(var_7);
      continue;
    }

    if(isDefined(var_3) && isDefined(var_4)) {
      var_10 = scripts\engine\utility::ter_op(teamsmatch(self, var_1), var_3, var_4);
      playfxontagforclients(scripts\engine\utility::getfx(var_10), self, var_5, var_9);
    }
  }

  self waittill(var_2);
  func_11073(var_3, var_4, var_5, var_7);
}

func_11073(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(var_1)) {
    stopFXOnTag(scripts\engine\utility::getfx(var_0), self, var_2);
    stopFXOnTag(scripts\engine\utility::getfx(var_1), self, var_2);
  }

  var_3 delete();
}

startdamageovertime(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_5);
  setpassivevalue(var_5, var_4);
  thread func_AD69(var_1, var_5);
  var_1 thread func_AD68(self, var_5);
  var_6 = "MOD_UNKNOWN";

  if(var_3 > var_4) {
    return;
  }
  if(self.health <= 0) {
    func_11067(var_5);
  }

  var_7 = var_2;

  if(self.health <= var_7) {
    self getrandomarmkillstreak(var_2, self.origin, var_1, undefined, var_6, var_0);
  }

  while(getpassivevalue(var_5) > 0) {
    if(self.health <= 0) {
      func_11067(var_5);
    }

    if(self.health > 15 && self.health - var_2 < 15) {
      var_2 = var_2 - (15 - (self.health - var_2));
    }

    if(self.health > var_7 && self.health <= 15) {
      var_2 = 1;
    }

    if(var_2 > 0) {
      self getrandomarmkillstreak(var_2, self.origin, var_1, undefined, var_6, var_0);
    }

    setpassivevalue(var_5, getpassivevalue(var_5) - var_3);
    wait(var_3);
  }

  func_11067(var_5);
}

func_11067(var_0) {
  setpassivevalue(var_0, 0);
  self notify(var_0);
}

func_12F61(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!scripts\mp\utility\game::playersareenemies(var_1, var_2)) {
    return;
  }
  if(var_1 scripts\mp\utility\game::_hasperk("passive_berserk")) {
    var_1 thread quadfeederon();
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_headshot_ammo")) {
    var_1 thread func_89AE(var_5, var_1, var_2, var_4, var_6);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_last_shots_ammo")) {
    var_1 thread func_89C2(var_5, var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_extra_xp")) {
    var_1 thread func_89A0(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_nuke")) {
    var_1 thread func_89CC(var_1, var_2, var_5);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_streak_ammo")) {
    var_1 thread func_89EB(var_1, var_5);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_move_speed_on_kill")) {
    var_1 thread func_89C8(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_cooldown_on_kill")) {
    var_1 thread func_8988(var_1);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_health_regen_on_kill")) {
    var_1 thread func_89B1(var_1);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_refresh")) {
    var_1 thread func_89DB(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_fire_kill")) {
    var_1 thread func_89A3(var_1, var_2, var_5);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_random_perks")) {
    var_1 thread func_89D9(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_headshot_super")) {
    var_1 thread func_89B0(var_5, var_1, var_2, var_4, var_6);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_hitman")) {
    var_1 thread func_89B3(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_scorestreak_pack")) {
    var_1 thread func_89E0(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_sonic")) {
    var_1 thread func_89E7(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_headshot")) {
    var_1 thread func_89AF(var_5, var_1, var_2, var_4, var_6, var_7);
  }

  if((var_1 scripts\mp\utility\game::_hasperk("passive_meleekill") || var_1 scripts\mp\utility\game::_hasperk("passive_meleekill_silent")) && var_4 == "MOD_MELEE") {
    var_1 thread func_89AB(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_gore")) {
    var_1 thread func_89AB(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_visor_detonation")) {
    var_1 thread handlevisordetonationpassive(var_5, var_1, var_2, var_4, var_6);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_railgun_overload") || var_1 scripts\mp\utility\game::_hasperk("passive_overkill")) {
    var_1 thread handleoverloadpassive(var_5, var_1, var_2, var_4, var_6, var_3);
  }

  if(ismark2weapon(var_5)) {
    var_1 thread handlemark2xpbonus(var_1, var_5);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_double_kill_reload")) {
    var_1 thread handledoublekillreload(var_5);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_jump_super")) {
    thread handlejumpsuperonkillpassive(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_melee_super")) {
    thread handlemeleesuperonkillpassive(var_1, var_2, var_4);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_double_kill_super")) {
    thread handledoublekillsuperpassive(var_1, var_2);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_melee_cone_expl")) {
    thread handlemeleeconeexplodeonkillpassive(var_1, var_2, var_5, var_4);
  }

  if(var_1 scripts\mp\utility\game::_hasperk("passive_leader_kill_score")) {
    thread handleleaderkillscorepassive(var_1, var_2, var_5);
  }

  thread updatemodeswitchweaponkills(var_1, var_2, var_5);
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

func_49EC(var_0, var_1) {
  wait(randomfloatrange(0, 0.1));

  if(!isDefined(self) || !scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  var_2 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_2 == -1) {
    return;
  }
  var_3 = (randomintrange(-150, 150), randomintrange(-150, 150), randomintrange(-150, 150));
  scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "active", self.origin + var_3, "cb_compassping_enemy");
  scripts\mp\objidpoolmanager::minimap_objective_team(var_2, var_1);
  var_4 = randomfloatrange(0.4, 0.65);
  scripts\engine\utility::waittill_any_timeout(var_4, "death", "disconnect", "stop_minimap_decoys");
  scripts\mp\objidpoolmanager::returnminimapid(var_2);
}

func_F73F() {}

func_12CCE() {}

func_89AE(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1) || !isDefined(var_0) || !var_1 scripts\mp\utility\game::_hasperk("passive_headshot_ammo")) {
    return;
  }
  if(!scripts\mp\utility\game::isheadshot(var_0, var_4, var_3, var_1)) {
    return;
  }
  var_1 checkpassivemessage("passive_headshot_ammo");
  var_5 = weaponclipsize(var_0);
  var_6 = var_5 * 1.0;
  var_7 = var_1 getweaponammoclip(var_0);
  var_8 = min(var_7 + var_6, var_5);
  var_1 setweaponammoclip(var_0, int(var_8));

  if(var_1 isdualwielding()) {
    var_7 = var_1 getweaponammoclip(var_0, "left");
    var_8 = min(var_7 + var_6, var_5);
    var_1 setweaponammoclip(var_0, int(var_8), "left");
  }
}

handlevisordetonationpassive(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("joined_team");
  var_1 endon("joined_spectator");
  var_1 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_1) || !isDefined(var_0) || !var_1 scripts\mp\utility\game::_hasperk("passive_visor_detonation")) {
    return;
  }
  if(!scripts\mp\utility\game::isheadshot(var_0, var_4, var_3, var_1)) {
    return;
  }
  var_5 = var_2 gettagorigin("tag_eye");
  var_6 = var_2.angles;
  wait 0.1;
  thread activatevisordetonationpassive(self, var_0, var_5, var_6);
}

activatevisordetonationpassive(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4.weapon_name = var_1;
  var_4 setotherent(var_0);
  var_4 setentityowner(var_0);
  var_4 setModel("passive_mp_visorDetonation");
  wait 1;
  var_4 delete();
}

handleoverloadpassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("joined_team");
  var_1 endon("joined_spectator");
  var_1 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_1) || !isDefined(var_0) || !var_1 scripts\mp\utility\game::_hasperk("passive_railgun_overload") && !var_1 scripts\mp\utility\game::_hasperk("passive_overkill")) {
    return;
  }
  if(!(isDefined(var_2.hitbychargedshot) && var_2.hitbychargedshot == var_1)) {
    return;
  }
  var_6 = var_2 gettagorigin("tag_eye");
  var_7 = var_2.angles;
  wait 0.1;
  var_2.hitbychargedshot = undefined;
  thread activateoverloadpassive(self, var_0, var_6, var_7);
  var_1 thread func_89AB(var_1, var_2);
}

activateoverloadpassive(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4.weapon_name = var_1;
  var_4 setotherent(var_0);
  var_4 setentityowner(var_0);
  var_4 setModel("passive_mp_visorDetonation");
  wait 1;
  var_4 delete();
}

ismark2weapon(var_0) {
  var_1 = getweaponvariantindex(var_0);
  return isDefined(var_1) && var_1 >= 32;
}

handlemark2xpbonus(var_0, var_1) {
  var_2 = getdvarfloat("mk2_bonus", 0.15);
  var_3 = scripts\mp\utility\game::getweapongroup(var_1);
  var_4 = var_3 + "_mk_ii_bonus";

  if(isDefined(level.prestigeextras[var_4])) {
    if(self getteamdompoints(var_4, "prestigeExtras", 1)) {
      var_2 = getdvarfloat("mk2_extra_bonus", 0.3);
    }
  }

  var_5 = scripts\mp\rank::getscoreinfovalue("kill");
  var_0 scripts\mp\rank::giverankxp("kill", int(var_5 * var_2));
}

testpassivemessage(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = 0;
  var_3 = scripts\mp\passives::getpassivedeathwatching(var_0);
  var_4 = "";

  if(isDefined(var_3)) {
    var_4 = var_3 + var_1;
    var_2 = scripts\mp\hud_message::testmiscmessage(var_4);
  }

  if(var_2) {
    return;
  }
  return;
}

checkpassivemessage(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = scripts\mp\passives::getpassivedeathwatching(var_0);

  if(isDefined(var_2)) {
    if(isendstr(var_1, "_camo")) {
      var_3 = scripts\mp\utility\game::strip_suffix(var_1, "_camo");
      var_1 = var_3;
    }

    scripts\mp\hud_message::showmiscmessage(var_2 + var_1);
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
    self waittill("killed_enemy", var_0, var_1, var_2);
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
  var_0 = self getcurrentweapon();

  if(isDefined(var_0)) {
    var_1 = weaponclipsize(var_0);
    var_2 = func_7F60(var_1);
    self setclientomnvar("ui_last_shots_clip_size", var_2);
  }
}

unsetkineticwave() {
  self setclientomnvar("ui_last_shots_clip_size", -1);
}

func_89C2(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !isDefined(var_0) || !var_1 scripts\mp\utility\game::_hasperk("passive_last_shots_ammo")) {
    return;
  }
  var_3 = weaponclipsize(var_0);
  var_4 = func_7F60(var_3);
  var_5 = 0;
  var_5 = func_3E60(var_1, var_0, "right", var_3, var_4);

  if(var_1 isdualwielding()) {
    var_5 = func_3E60(var_1, var_0, "left", var_3, var_4) || var_5;
  }

  if(var_5) {
    var_1 scripts\mp\hud_message::showmiscmessage("scavenger");
  }
}

func_3E60(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 getweaponammoclip(var_1, var_2);

  if(var_5 >= var_4) {
    return 0;
  }

  var_6 = var_3 * 1;
  var_7 = min(var_5 + var_6, var_3);
  var_0 setweaponammoclip(var_1, int(var_7), var_2);
  return 1;
}

func_7F60(var_0) {
  return int(max(1.0, var_0 * 0.2));
}

func_F740() {
  var_0 = self getcurrentweapon();
  thread func_8CB9(var_0);
}

func_12CCF() {
  self notify("removeHealthOnKillPassive");
}

func_8CB9(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeHealthOnKillPassive");

  for(;;) {
    self waittill("killed_enemy", var_1, var_2, var_3);

    if(isalive(self) && var_2 == var_0 && self.health < self.maxhealth) {
      var_4 = int(self.maxhealth * 0.15);
      var_5 = self.health + var_4;

      if(self.health + var_5 > self.maxhealth) {
        var_5 = self.maxhealth;
      }

      self.health = var_5;
    }
  }
}

func_F6D6() {}

func_12CA7() {}

handledoublekillreload(var_0) {
  var_1 = self.var_DDC2 + 1;

  if(var_1 % 2 == 0) {
    scripts\mp\hud_message::showmiscmessage("scavenger");
    var_2 = weaponclipsize(var_0);
    var_3 = self getweaponammostock(var_0);
    var_4 = self getweaponammoclip(var_0);
    var_5 = min(var_2 - var_4, var_3);
    var_6 = min(var_4 + var_5, var_2);
    self setweaponammoclip(var_0, int(var_6));
    self setweaponammostock(var_0, int(var_3 - var_5));

    if(self isdualwielding()) {
      var_3 = self getweaponammostock(var_0);
      var_4 = self getweaponammoclip(var_0, "left");
      var_5 = min(var_2 - var_4, var_3);
      var_6 = min(var_4 + var_5, var_2);
      self setweaponammoclip(var_0, int(var_6), "left");
      self setweaponammostock(var_0, int(var_3 - var_5));
    }

    checkpassivemessage("passive_double_kill_reload");
  }
}

func_F6F0() {
  var_0 = self getcurrentweapon();
  thread func_6A02(var_0);
}

func_12CB0() {
  self notify("removeExplosiveKillsPassive");
}

func_6A02(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeExplosiveKillsPassive");

  for(;;) {
    self waittill("killed_enemy", var_1, var_2, var_3);

    if(var_2 == var_0) {
      if(func_9E84(self, var_2, var_3, self.origin, var_1)) {
        thread func_582E(var_1, var_2);
      }
    }
  }
}

func_9E84(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && !var_0 scripts\mp\utility\game::isusingremote() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT") && !scripts\mp\utility\game::iskillstreakweapon(var_1) && !isDefined(var_0.assistedsuicide)) {
    var_5 = scripts\mp\utility\game::getweapongroup(var_1);

    switch (var_5) {
      case "weapon_pistol":
        var_6 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var_6 = 1200;
        break;
      case "weapon_lmg":
      case "weapon_dmr":
      case "weapon_assault":
        var_6 = 1500;
        break;
      case "weapon_rail":
      case "weapon_sniper":
        var_6 = 2000;
        break;
      case "weapon_shotgun":
        var_6 = 500;
        break;
      case "weapon_projectile":
      default:
        var_6 = 1536;
        break;
    }

    var_7 = var_6 * var_6;

    if(distancesquared(var_3, var_4.origin) > var_7) {
      return 1;
    }
  }

  return 0;
}

func_582E(var_0, var_1) {
  var_2 = var_0.origin + (0, 0, 50);
  var_0 playSound("detpack_explo_default");
  playFX(level.mine_explode, var_2);
  radiusdamage(var_2, 200, 140, 50, self, "MOD_EXPLOSIVE", var_1);
}

func_F79B() {
  var_0 = self getcurrentweapon();

  if(doesshareammo(var_0)) {
    var_0 = scripts\mp\utility\game::func_E0CF(var_0);
  }

  thread func_B8D5(var_0);
}

func_12CF1() {
  self notify("removeMissRefundPassive");
}

func_B8D5(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  for(;;) {
    self waittill("shot_missed", var_1);

    if(var_1 == var_0) {
      if(randomfloat(1.0) > 0.75) {
        var_2 = self getweaponammostock(var_0);
        self setweaponammostock(var_0, var_2 + 1);
      }
    }
  }
}

doesshareammo(var_0) {
  return scripts\mp\weapons::isaltmodeweapon(var_0) && !issubstr(var_0, "+gl") && !issubstr(var_0, "+shotgun");
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

func_89A0(var_0, var_1) {
  if(isDefined(var_1)) {
    playFX(scripts\engine\utility::getfx("loot_mo_money_kill"), var_1.origin + (0, 0, 45));
  }

  var_0 checkpassivemessage("passive_extra_xp");
  scripts\mp\awards::givemidmatchaward("mo_money");
}

getpassivedeathwatching(var_0, var_1) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    return 0;
  }

  if(!isDefined(var_0.passivedeathwatcher[var_1])) {
    return 0;
  }

  if(var_0.passivedeathwatcher[var_1]) {
    return 1;
  }

  return 0;
}

setpassivedeathwatching(var_0, var_1, var_2) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    var_0.passivedeathwatcher = [];
  }

  var_0.passivedeathwatcher[var_1] = var_2;
}

clearpassivedeathwatching(var_0, var_1) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    var_0.passivedeathwatcher = [];
  }

  var_0.passivedeathwatcher[var_1] = undefined;
}

func_F7BD() {}

func_12CF8() {}

updatenukepassive(var_0) {
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
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = scripts\mp\loot::getpassivesforweapon(var_3);

    if(isDefined(var_4) && var_4.size > 0) {
      foreach(var_6 in var_4) {
        if(var_6 == "passive_nuke") {
          var_0 = 1;
          break;
        }
      }

      if(scripts\mp\utility\game::istrue(var_0)) {
        break;
      }
    }
  }

  return var_0;
}

func_89CC(var_0, var_1, var_2) {
  self endon("disconnect");

  if(!isDefined(var_0) || !scripts\mp\utility\game::isreallyalive(var_0) && !scripts\mp\utility\game::issimultaneouskillenabled() || !isDefined(var_2) || !isDefined(var_1)) {
    return;
  }
  var_3 = !scripts\mp\utility\game::isreallyalive(var_0) && scripts\mp\utility\game::issimultaneouskillenabled();

  if(level.gametype == "infect") {
    var_4 = [];
    var_4[var_4.size] = "passive_nuke";
  } else {
    var_4 = scripts\mp\loot::getpassivesforweapon(var_2);

    if(!isDefined(var_4) || var_4.size == 0) {
      return;
    }
  }

  var_5 = 0;

  foreach(var_7 in var_4) {
    if(var_7 == "passive_nuke") {
      var_5 = 1;
      break;
    }
  }

  if(!var_5) {
    return;
  }
  if(var_3) {
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
    var_0 checkpassivemessage("passive_nuke");
    var_0 thread scripts\mp\hud_message::showkillstreaksplash("nuke");
    var_0 scripts\mp\killstreaks\killstreaks::awardkillstreak("nuke", var_0);
    var_0.pers["passive_nuke_key"] = 0;
    var_0 scripts\mp\missions::func_D991("ch_darkops_nuke");
  } else if(var_0.pers["passive_nuke_key"] == 24)
    var_0 thread scripts\mp\hud_message::showsplash("nuke_kill_single");
  else if(var_0.pers["passive_nuke_key"] == 2) {
    var_0 thread func_C1C8();
  } else if(var_0.pers["passive_nuke_key"] >= 20) {
    var_0 thread func_C1C8();
  } else if(var_0.pers["passive_nuke_key"] >= 5) {
    if(var_0.pers["passive_nuke_key"] % 5 == 0) {
      var_0 thread func_C1C8();
    }
  }
}

func_C1C8() {
  var_0 = 25 - self.pers["passive_nuke_key"];
  thread scripts\mp\hud_message::showsplash("nuke_kill", var_0);
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
    self func_85C1(65);
    var_0 = self func_85C0();

    if(var_0 < 0) {
      var_0 = 100;
    }

    var_0 = max(var_0 - 10, 0);
    self getweaponrankinfomaxxp(int(var_0));
  }

  self notify("stop_quadFeeder_timer");
  thread timeoutquadfeeder(1.5);
}

timeoutquadfeeder(var_0) {
  self endon("end_quadFeederEffect");
  self endon("stop_quadFeeder_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelquadfeeder();
  wait(var_0);
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
    self func_85C2();
    var_0 = self func_85C0();
    var_0 = min(var_0 + 20, 100);
    self getweaponrankinfomaxxp(int(var_0));
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
  var_0 = self getcurrentweapon();
  scripts\mp\utility\game::func_1824("kill", 0.1, var_0);
  thread func_4112(var_0);
}

func_12D23() {
  self notify("score_bonus_kills_removed");
}

func_4112(var_0) {
  self endon("disconnect");
  self waittill("score_bonus_kills_removed");
  scripts\mp\utility\game::func_E165("kill", 0.1, var_0);
}

func_F82B() {
  var_0 = [];

  foreach(var_6, var_2 in level.scoreinfo) {
    var_3 = issubstr(var_6, "_mode_");
    var_4 = issubstr(var_6, "_score");
    var_5 = var_2["value"];

    if(var_3 && var_4 && var_5 > 0) {
      var_0[var_0.size] = func_4A0B(var_6, 0.2);
    }
  }

  foreach(var_8 in var_0) {
    scripts\mp\utility\game::func_1824(var_8.var_67E5, var_8.var_2C80, var_8.weapon);
  }

  thread func_4113(var_0);
}

func_12D24() {
  self notify("score_bonus_objectives_removed");
}

func_4A0B(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_67E5 = var_0;
  var_3.var_2C80 = var_1;
  var_3.weapon = var_2;
  return var_3;
}

func_4113(var_0) {
  self endon("disconnect");
  self waittill("score_bonus_objectives_removed");

  foreach(var_2 in var_0) {
    scripts\mp\utility\game::func_E165(var_2.var_67E5, var_2.var_2C80, var_2.weapon);
  }
}

func_F746() {
  self endon("passive_hivemind_cancel");
  func_12EAA(level.players);
  thread func_905E();
  thread func_905F();
}

func_12CD1() {
  foreach(var_1 in self.var_905B) {
    var_2 = self.var_905A[var_1];
    scripts\mp\utility\game::outlinedisable(var_1, var_2);
  }

  self.var_905B = undefined;
  self.var_905A = undefined;
  self notify("passive_hivemind_cancel");
}

func_12EA9(var_0) {
  func_12EAA([var_0]);
}

func_12EAA(var_0) {
  if(!isDefined(self.var_905B)) {
    self.var_905B = [];
  }

  if(!isDefined(self.var_905A)) {
    self.var_905A = [];
  }

  foreach(var_2 in var_0) {
    if(var_2 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_2) || !isDefined(var_2.team)) {
      continue;
    }
    var_3 = func_7F04(var_2);

    if(level.teambased && self.team == var_2.team && var_2.health > 0) {
      if(var_3 < 0) {
        wait 0.1;

        if(!isDefined(var_2)) {
          continue;
        }
        var_4 = scripts\mp\utility\game::outlineenableforplayer(var_2, "cyan", self, 0, 1, "level_script");
        self.var_905B[self.var_905B.size] = var_4;
        self.var_905A[var_4] = var_2;
        thread func_905D(var_2);
        thread func_9060(var_2);
        thread func_905C(var_2);
      }

      continue;
    }

    if(var_3 >= 0) {
      var_5 = [];
      var_6 = [];
      scripts\mp\utility\game::outlinedisable(var_3, var_2);

      foreach(var_4 in self.var_905B) {
        var_8 = self.var_905A[var_4];

        if(var_8 == var_2) {
          continue;
        }
        var_5[var_5.size] = var_4;
        var_6[var_4] = var_8;
      }

      self.var_905B = var_5;
      self.var_905A = var_6;
      var_2 notify("passive_hivemind_listen_cancel");
    }
  }
}

func_7F04(var_0) {
  if(!isDefined(self.var_905B) || !isDefined(self.var_905A)) {
    return -1;
  }

  foreach(var_2 in self.var_905B) {
    var_3 = self.var_905A[var_2];

    if(var_3 == var_0) {
      return var_2;
    }
  }

  return -1;
}

func_905D(var_0) {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");
  var_0 endon("passive_hivemind_listen_cancel");
  var_0 waittill("disconnect");
  thread func_12EA9(var_0);
}

func_9060(var_0) {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");
  var_0 endon("passive_hivemind_listen_cancel");
  var_0 waittill("joined_team");
  thread func_12EA9(var_0);
}

func_905C(var_0) {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");
  var_0 endon("passive_hivemind_listen_cancel");
  var_0 waittill("death");
  thread func_12EA9(var_0);
}

func_905E() {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");

  for(;;) {
    level waittill("player_spawned", var_0);
    thread func_12EA9(var_0);
  }
}

func_905F() {
  self endon("disconnect");
  self endon("passive_hivemind_cancel");

  for(;;) {
    level waittill("joined_spectator", var_0);
    thread func_12EA9(var_0);
  }
}

func_F74B() {
  self endon("passive_hunter_killer_cancel");
  thread func_12EAE(level.players);
  thread func_91EA();

  foreach(var_1 in level.players) {
    thread func_91EC(var_1);
    thread func_91EB(var_1);
  }
}

func_12CD4() {
  self notify("passive_hunter_killer_cancel");

  foreach(var_1 in self.var_91E9) {
    var_2 = self.var_91E8[var_1];
    scripts\mp\utility\game::outlinedisable(var_1, var_2);
  }

  self.var_91E9 = undefined;
  self.var_91E8 = undefined;
}

func_91EC(var_0) {
  self endon("passive_hunter_killer_cancel");
  var_0 waittill("disconnect");
  thread func_12EAD(var_0);
}

func_91EB(var_0) {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread func_12EAD(var_0);
  }
}

func_91ED(var_0) {
  self endon("passive_hunter_killer_cancel");
  var_0 endon("passive_hunter_killer_listen_cancel");

  for(;;) {
    wait 1.0;
    thread func_12EAD(var_0);
  }
}

func_91EA() {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    level waittill("connected", var_0);
    thread func_12EAD(var_0);
    thread func_91EC(var_0);
    thread func_91EB(var_0);
  }
}

func_7F09(var_0) {
  if(!isDefined(self.var_91E9) || !isDefined(self.var_91E8)) {
    return -1;
  }

  foreach(var_2 in self.var_91E9) {
    var_3 = self.var_91E8[var_2];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_0) {
      return var_2;
    }
  }

  return -1;
}

func_12EAD(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;
  thread func_12EAE(var_1);
}

func_12EAE(var_0) {
  if(!isDefined(self.var_91E9)) {
    self.var_91E9 = [];
  }

  if(!isDefined(self.var_91E8)) {
    self.var_91E8 = [];
  }

  foreach(var_2 in var_0) {
    if(var_2 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_2) || !isDefined(var_2.team)) {
      continue;
    }
    var_3 = func_7F09(var_2);
    var_4 = var_2.maxhealth / 2;
    var_5 = var_2.health;

    if(level.teambased && self.team != var_2.team && var_5 <= var_4 && var_5 > 0) {
      if(var_3 < 0 && !var_2 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
        var_6 = scripts\mp\utility\game::outlineenableforplayer(var_2, "red", self, 1, 0, "level_script");
        self.var_91E9[self.var_91E9.size] = var_6;
        self.var_91E8[var_6] = var_2;
        thread func_91ED(var_2);
      }

      continue;
    }

    if(var_3 >= 0) {
      var_7 = [];
      var_8 = [];
      scripts\mp\utility\game::outlinedisable(var_3, var_2);

      foreach(var_6 in self.var_91E9) {
        var_10 = self.var_91E8[var_6];

        if(var_10 == var_2) {
          continue;
        }
        var_7[var_7.size] = var_6;
        var_8[var_6] = var_10;
      }

      self.var_91E9 = var_7;
      self.var_91E8 = var_8;
      var_2 notify("passive_hunter_killer_listen_cancel");
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
  var_0 = undefined;

  for(;;) {
    var_1 = self getstance();

    if(self issprintsliding() || (var_1 == "crouch" || var_1 == "prone") && self isonground()) {
      var_0 = undefined;

      if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_slide_blastshield"))) {
        setpassivevalue("passive_slide_blastshield", 1);
        checkpassivemessage("passive_slide_blastshield", "_start");
        scripts\mp\utility\game::giveperk("specialty_blastshield");
      }
    } else if(!isDefined(var_0))
      var_0 = gettime() + 250.0;
    else if(gettime() >= var_0) {
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
  var_0 = undefined;

  for(;;) {
    if(self getstance() == "prone") {
      if(!isDefined(var_0)) {
        var_0 = gettime() + 250.0;
      } else if(gettime() >= var_0) {
        if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_prone_blindeye"))) {
          setpassivevalue("passive_prone_blindeye", 1);
          checkpassivemessage("passive_prone_blindeye", "_start");
          scripts\mp\utility\game::giveperk("specialty_blindeye");
        }
      }
    } else {
      var_0 = undefined;

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
  var_0 = undefined;

  for(;;) {
    var_1 = self getstance();

    if(var_1 == "crouch" || var_1 == "prone" || lengthsquared(self getvelocity()) == 0) {
      if(!isDefined(var_0)) {
        var_0 = gettime() + 750.0;
      } else if(gettime() > var_0) {
        if(!scripts\mp\utility\game::istrue(getpassivevalue("passive_stationary_engineer"))) {
          setpassivevalue("passive_stationary_engineer", 1);
          checkpassivemessage("passive_stationary_engineer", "_start");
          scripts\mp\utility\game::giveperk("specialty_engineer");
        }
      }
    } else {
      var_0 = undefined;

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

setstackvalues(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stackvalues)) {
    self.stackvalues = [];
  }

  if(!isDefined(self.stackvalues[var_0])) {
    var_4 = spawnStruct();
    var_4.id = var_0;
    var_4.stacksmax = var_1;
    var_4.stackscurrent = var_2;
    var_4.decaytime = var_3;
    self.stackvalues[var_0] = var_4;
  }
}

getstackvalues(var_0) {
  if(!isDefined(self.stackvalues)) {
    return undefined;
  }

  if(!isDefined(self.stackvalues[var_0])) {
    return undefined;
  }

  var_1 = self.stackvalues[var_0];
  return var_1;
}

getstackcount(var_0) {
  var_1 = getstackvalues(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1.stackscurrent;
}

addstackcount(var_0, var_1) {}

func_89EB(var_0, var_1) {
  var_2 = var_0.killsthislife.size + 1;

  if(var_2 >= 5) {
    var_3 = weaponclipsize(var_1);
    var_4 = int(max(var_3 * 0.2, 1));
    var_5 = var_0 getweaponammostock(var_1);
    var_0 setweaponammostock(var_1, var_5 + var_4);
    var_0 scripts\mp\hud_message::showmiscmessage("scavenger");
  }
}

func_89C8(var_0, var_1) {
  var_2 = "passive_move_speed_on_kill";
  var_0 notify(var_2);
  var_0 endon(var_2);

  if(!isDefined(var_0.weaponpassivespeedonkillmod) || var_0.weaponpassivespeedonkillmod != 0.04) {
    var_0.weaponpassivespeedonkillmod = 0.04;
    var_0 scripts\mp\weapons::updatemovespeedscale();
  }

  var_0 scripts\engine\utility::waittill_any_timeout(3.5, "death", "disconnect");

  if(!isDefined(var_0)) {
    return;
  }
  var_0.weaponpassivespeedonkillmod = 0;
  var_0 scripts\mp\weapons::updatemovespeedscale();
  var_0 checkpassivemessage("passive_move_speed_on_kill");
}

func_8988(var_0) {
  var_0 scripts\mp\utility\game::func_DE39(2.5);
  var_0 checkpassivemessage("passive_cooldown_on_kill");
}

func_89B1(var_0) {
  var_0 notify("force_regeneration");
  var_0 checkpassivemessage("passive_health_regen_on_kill");
}

func_89DB(var_0, var_1) {
  if(!isDefined(var_0) || !scripts\mp\utility\game::isreallyalive(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!getpassivedeathwatching(var_0, "passive_refresh_key")) {
    var_0 thread func_DE76();
    var_0 setpassivedeathwatching(var_0, "passive_refresh_key", 1);
  }

  if(!isDefined(var_0.pers["passive_refresh_key"])) {
    var_0.pers["passive_refresh_key"] = 1;
  } else {
    var_0.pers["passive_refresh_key"]++;
  }

  if(var_0.pers["passive_refresh_key"] >= 5) {
    var_0 checkpassivemessage("passive_refresh");
    var_0 thread scripts\mp\hud_message::showkillstreaksplash("refresh");
    var_0 scripts\mp\powers::func_1813(1);
    var_0.pers["passive_refresh_key"] = 0;
  } else if(var_0.pers["passive_refresh_key"] == 4)
    var_0 thread scripts\mp\hud_message::showsplash("refresh_kill_single");
  else if(var_0.pers["passive_refresh_key"] == 3) {
    var_0 thread func_DE77();
  }
}

func_DE77() {
  var_0 = 5 - self.pers["passive_refresh_key"];
  thread scripts\mp\hud_message::showsplash("refresh_kill", var_0);
}

func_DE76() {
  self endon("disconnect");
  self waittill("death");
  self.pers["passive_refresh_key"] = undefined;
  clearpassivedeathwatching(self, "passive_refresh_key");
}

func_89B3(var_0, var_1) {
  if(!isDefined(var_0) || !scripts\mp\utility\game::isreallyalive(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = var_1.name;

  if(teamsmatch(var_0, var_1)) {
    return;
  }
  if(!isDefined(var_0.var_903C)) {
    var_0.var_903C = [];
  } else if(func_903B(var_0, var_2)) {
    return;
  }
  var_0.var_903C[var_0.var_903C.size] = var_2;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(teamsmatch(var_0, var_6)) {
      continue;
    }
    var_7 = var_6.name;

    if(func_903B(var_0, var_7)) {
      var_3++;
    }

    var_4++;
  }

  var_9 = var_4 - var_3;

  if(var_9 <= 3) {
    var_0 func_903E(var_9);
  }

  if(var_9 <= 0) {
    var_10 = 0;

    if(var_4 >= 3) {
      var_10 = 200;
    } else if(var_4 >= 2) {
      var_10 = 100;
    } else {
      var_10 = 75;
    }

    var_11 = var_10 * var_4;
    var_0 checkpassivemessage("passive_hitman");
    var_0 thread scripts\mp\supers::stopshellshock(var_11);
    var_0.var_903C = [];
  }
}

func_903B(var_0, var_1) {
  if(!isDefined(var_0.var_903C)) {
    return 0;
  }

  foreach(var_3 in var_0.var_903C) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

func_903E(var_0) {
  var_0 = int(max(0, var_0));

  switch (var_0) {
    case 0:
      thread scripts\mp\hud_message::showkillstreaksplash("hitman_kill_all");
      break;
    case 1:
      thread scripts\mp\hud_message::showsplash("hitman_kill_single");
      break;
    default:
      thread scripts\mp\hud_message::showsplash("hitman_kill", var_0);
      break;
  }
}

func_903D() {
  self endon("disconnect");
  self waittill("death");
  self.var_903C = undefined;
}

func_89E0(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 endon("diconnect");
  var_0 scripts\mp\archetypes\archengineer::createentityeventdata(var_0, var_1, "scorestreak");
  var_0 checkpassivemessage("passive_scorestreak_pack");
  checkpassivemessage("passive_scorestreak_pack");
}

func_89AB(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 endon("diconnect");
  level thread handlegoreeffect(var_1);
  wait 0.05;
  var_2 = var_1 func_8113();

  if(isDefined(var_2)) {
    var_2 hide();
    var_2.permanentcustommovetransition = 1;
  }

  checkpassivemessage("passive_gore");
}

handlegoreeffect(var_0) {
  var_1 = var_0 gettagorigin("j_spine4");

  if(var_0.loadoutarchetype == "archetype_scout") {
    playFX(level._effect["passive_gore_robot"], var_1, (1, 0, 0));
  } else {
    playFX(level._effect["passive_gore"], var_1, (1, 0, 0));
  }

  playLoopSound(var_1, "gib_fullbody");
  scripts\mp\shellshock::_earthquake(0.5, 1.5, var_1, 120);
}

func_89E7(var_0, var_1) {
  var_0 checkpassivemessage("passive_pack_scorestreak");
}

func_89E6(var_0, var_1) {}

func_89AF(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!scripts\mp\utility\game::isheadshot(var_0, var_4, var_3, var_1)) {
    return;
  }
}

func_89D9(var_0, var_1) {
  if(!isDefined(var_0) || !scripts\mp\utility\game::isreallyalive(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!getpassivedeathwatching(var_0, "passive_random_perks_key")) {
    var_0 thread func_DCC3();
    var_0 setpassivedeathwatching(var_0, "passive_random_perks_key", 1);
  }

  if(!isDefined(var_0.pers["passive_random_perks_key"])) {
    var_0.var_DCC2 = [];
    var_0.pers["passive_random_perks_key"] = 1;
  } else {
    if(isDefined(var_0.var_DCC2) && var_0.var_DCC2.size >= 3) {
      return;
    }
    var_0.pers["passive_random_perks_key"]++;
  }

  if(!isDefined(var_0.var_DCC2)) {
    var_0.var_DCC2 = [];
  }

  if(var_0.pers["passive_random_perks_key"] >= 3) {
    var_2 = var_0 scripts\mp\perks::func_7DE8();

    if(isDefined(var_2) && var_2.size > 0) {
      var_3 = randomintrange(0, var_2.size - 1);
      var_4 = var_2[var_3];

      if(!isDefined(var_4)) {
        return;
      }
      var_0 checkpassivemessage("passive_random_perks", "_" + var_4);
      var_0 scripts\mp\utility\game::giveperk(var_4);
      var_5 = scripts\engine\utility::ter_op(isDefined(var_0.var_DCC2), var_0.var_DCC2.size, 0);
      var_0.var_DCC2[var_5] = var_4;
    }

    var_0.pers["passive_random_perks_key"] = 0;
  }
}

func_11753(var_0) {
  var_1 = var_0 scripts\mp\perks::func_7DE8();

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      testpassivemessage("passive_random_perks", "_" + var_3);
    }
  }
}

func_DCC3() {
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self.var_DCC2)) {
    foreach(var_1 in self.var_DCC2) {
      scripts\mp\utility\game::removeperk(var_1);
    }
  }

  self.var_DCC2 = undefined;
  self.pers["passive_random_perks_key"] = undefined;
  clearpassivedeathwatching(self, "passive_random_perks_key");
}

func_89B0(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1) || !isDefined(var_0) || !var_1 scripts\mp\utility\game::_hasperk("passive_headshot_super")) {
    return;
  }
  if(!scripts\mp\utility\game::isheadshot(var_0, var_4, var_3, var_1)) {
    return;
  }
  var_1 thread scripts\mp\supers::stopshellshock(100);
  var_1 checkpassivemessage("passive_headshot_super");
}

func_89A3(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_1.origin, 0, 50, 100);
  var_3.owner = var_0;
  scripts\mp\utility\game::playteamfxforclient(var_0.team, var_1.origin, "player_plasma_friendly", "player_plasma_enemy", 5);
  var_3 thread func_AD70(var_2);
  var_3 thread func_AD71();
  var_0 checkpassivemessage("passive_fire_kill");
}

func_AD70(var_0) {
  self endon("passive_fire_kill_delete");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1) || !isDefined(self) || !isDefined(self.owner)) {
      break;
    }
    if(!isplayer(var_1)) {
      continue;
    }
    if(teamsmatch(self.owner, var_1)) {
      continue;
    }
    var_2 = var_1 getpassivevalue("passive_fire_kill");

    if(var_2 <= 0) {
      var_1 thread func_10D9E(var_0, self.owner, "passive_fire_kill", "player_plasma_friendly", "player_plasma_enemy", "j_mainroot", "player_plasma_screen_stand");
      var_1 thread startdamageovertime(var_0, self.owner, 5, 0.5, 4, "passive_fire_kill");
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
  var_0 = self getEye();
  var_1 = anglesToForward(self getplayerangles());
  var_2 = 200;
  var_3 = var_1 * var_2;
  var_4 = func_11755(var_0, var_0 + var_3);
  var_5 = var_4 - var_0;
  var_6 = 25;
  var_7 = (0, 0, 0);
  var_8 = 100;
  var_9 = 0;
  var_10 = 1;
  var_11 = 0.15;

  for(;;) {
    var_9++;
    var_12 = var_0 + var_1 * (var_6 * var_9);
    var_13 = var_12 - var_0;

    if(!func_1174A(var_5, var_13)) {
      break;
    }
    var_14 = var_12 + (0, 0, var_8 * -1);
    var_15 = func_11755(var_12, var_14);

    if(var_15 == var_14) {
      continue;
    }
    var_16 = var_10 + var_11 * var_9;
    scripts\mp\utility\game::playteamfxforclient(self.team, var_15, "player_plasma_friendly", "player_plasma_enemy", var_16);
  }
}

func_1174A(var_0, var_1) {
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

func_11749(var_0, var_1) {
  if(var_0 > 0 && var_1 > var_0) {
    return 0;
  }

  if(var_0 < 0 && var_1 < var_0) {
    return 0;
  }

  return 1;
}

func_11755(var_0, var_1) {
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
  var_3 = physics_raycast(var_0, var_1, var_2, [self], 0, "physicsquery_closest");

  if(isDefined(var_3) && var_3.size > 0) {
    return var_3[0]["position"];
  }

  return var_1;
}

func_8974(var_0, var_1) {
  if(!isDefined(var_0) || !scripts\mp\utility\game::isreallyalive(var_0) || !isDefined(var_1) || var_0.var_2049) {
    return;
  }
  if(var_0.var_204A == 0 && level.gametype != "infect") {
    var_0.var_204A = 1;
    var_0 thread scripts\mp\hud_message::showsplash("specialty_scavenger");
    var_0 scripts\mp\utility\game::giveperk("specialty_scavenger");
  } else
    var_0.var_204A++;

  if(var_0.var_204A == 3) {
    var_0 thread scripts\mp\hud_message::showsplash("specialty_quickdraw");
    var_0 scripts\mp\utility\game::giveperk("specialty_quickdraw");
  }

  if(var_0.var_204A == 5) {
    var_0 thread scripts\mp\hud_message::showsplash("specialty_bulletaccuracy");
    var_0 scripts\mp\utility\game::giveperk("specialty_bulletaccuracy");
  }

  if(var_0.var_204A == 7) {
    var_0 thread scripts\mp\hud_message::showsplash("specialty_specialist");
    var_0 scripts\mp\utility\game::giveperk("specialty_lightweight");
    var_0 scripts\mp\utility\game::giveperk("specialty_quieter");
    var_0 scripts\mp\utility\game::giveperk("specialty_selectivehearing");
    var_0 scripts\mp\utility\game::giveperk("specialty_gung_ho");
    var_0.var_2049 = 1;
  }
}

handlejumpsuperonkillpassive(var_0, var_1) {
  if(var_0 isonground()) {
    return;
  }
  if(var_0 iswallrunning()) {
    return;
  }
  var_0 scripts\mp\supers::stopshellshock(100);
  var_0 checkpassivemessage("passive_jump_super");
}

handlemeleesuperonkillpassive(var_0, var_1, var_2) {
  if(var_2 != "MOD_MELEE") {
    return;
  }
  var_0 scripts\mp\supers::stopshellshock(500);
  var_0 checkpassivemessage("passive_melee_super");
}

handledoublekillsuperpassive(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("unset_passive_double_kill_super");
  var_0 notify("watchDoubleKillSuperPassive");
  var_0 endon("watchDoubleKillSuperPassive");

  if(!scripts\mp\utility\game::istrue(var_0.passivedoublekillpending)) {
    var_0.passivedoublekillpending = 1;
  } else {
    var_0.passivedoublekillpending = undefined;
    var_0 scripts\mp\supers::stopshellshock(200);
    var_0 checkpassivemessage("passive_double_kill_super");
    return;
  }

  wait 4;
  var_0.passivedoublekillpending = undefined;
}

setmodeswitchkillweapon(var_0, var_1) {
  if(!(scripts\mp\class::weaponhaspassive(var_1, getweaponvariantindex(var_1), "passive_mode_switch_score") || scripts\mp\class::weaponhaspassive(var_1, getweaponvariantindex(var_1), "passive_mode_switch_score_epic"))) {
    return;
  }
  var_2 = var_0.modeswitchkills;

  if(!isDefined(var_2)) {
    resetmodeswitchkillweapons(var_0);
  }

  var_3 = getmodeswitchkillweaponkey(var_1);
  var_4 = var_2.arr[var_3];

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
    var_4.numkills = 0;
    var_4.killinaltmode = undefined;
    var_2.arr[var_3] = var_4;
  }
}

unsetmodeswitchkillweapon(var_0, var_1) {
  var_2 = var_0.modeswitchkills;

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = getmodeswitchkillweaponkey(var_1);
  var_2.arr[var_3] = undefined;
}

resetmodeswitchkillweapons(var_0) {
  var_1 = spawnStruct();
  var_1.arr = [];
  var_0.modeswitchkills = var_1;
  thread watchmodeswitchkillweaponsdrop(var_0);
}

watchmodeswitchkillweaponsdrop(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notify("watchModeSwitchKillWeaponsDrop");
  var_0 endon("watchModeSwitchKillWeaponsDrop");
  var_1 = var_0.modeswitchkills;

  for(;;) {
    var_2 = var_0 getweaponslistprimaries();
    var_3 = [];
    var_4 = [];

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      var_6 = var_2[var_5];
      var_3[var_5] = scripts\mp\utility\game::getweaponrootname(var_6);
      var_4[var_5] = getweaponvariantindex(var_6);
    }

    var_7 = getarraykeys(var_1.arr);
    var_8 = [];
    var_9 = [];

    for(var_5 = 0; var_5 < var_7.size; var_5++) {
      var_10 = var_7[var_5];
      var_11 = strtok(var_10, "_");
      var_8[var_5] = var_11[0];
      var_9[var_5] = var_11[1];
    }

    for(var_5 = 0; var_5 < var_7.size; var_5++) {
      for(var_12 = 0; var_12 < var_2.size; var_12++) {
        if(var_8[var_5] != var_3[var_12]) {
          continue;
        }
        if(var_9[var_5] != var_4[var_12]) {
          continue;
        }
        unsetmodeswitchkillweapon(var_0, var_2[var_12]);
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

updatemodeswitchweaponkills(var_0, var_1, var_2) {
  var_3 = var_0.modeswitchkills;

  if(!isDefined(var_3)) {
    return;
  }
  if(scripts\mp\utility\game::func_8238(var_2) != "primary") {
    return;
  }
  var_4 = scripts\mp\utility\game::getweaponrootname(var_2);
  var_5 = getweaponvariantindex(var_2);

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = var_4 + "_" + var_5;
  var_7 = var_3.arr[var_6];

  if(!isDefined(var_7)) {
    return;
  }
  var_8 = var_0 func_8519(var_2);

  if(!isDefined(var_7.killinaltmode) || var_7.killinaltmode == var_8) {
    var_7.numkills++;

    if(var_7.numkills >= 2) {
      var_9 = var_7.numkills - 2;

      if(scripts\engine\utility::mod(var_9, 2) == 0) {
        var_0 checkpassivemessage("passive_mode_switch_score");
      }
    }
  } else {
    var_7.numkills = 1;

    if(var_0 scripts\mp\utility\game::_hasperk("passive_mode_switch_score_epic")) {
      var_10 = "mode_switch_kill_epic";
    } else {
      var_10 = "mode_switch_kill";
    }

    var_0 thread scripts\mp\rank::scoreeventpopup(var_10);
    var_11 = scripts\mp\rank::getscoreinfovalue(var_10);
    var_0 thread scripts\mp\rank::scorepointspopup(var_11);
    var_0 scripts\mp\killstreaks\killstreaks::func_83A7(var_10, var_11);
  }

  var_7.killinaltmode = var_8;
}

getmodeswitchkillweaponkey(var_0) {
  return scripts\mp\utility\game::getweaponrootname(var_0) + "_" + getweaponvariantindex(var_0);
}

handlemeleeconeexplodeonkillpassive(var_0, var_1, var_2, var_3) {
  if(!var_0 func_8519(var_2)) {
    return;
  }
  if(var_3 != "MOD_MELEE") {
    return;
  }
  var_4 = var_0 gettagorigin("j_spineupper");
  var_5 = var_0 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = anglestoup(var_5);
  var_8 = var_4 - var_6 * 128;
  var_9 = 453;
  thread meleeconeexplodeworldfx(var_4, var_5, var_0);
  thread meleeconeexplodeattackerfx(var_0);
  var_1 thread scripts\mp\damage::enqueuecorpsetablefunc("passive_melee_cone_expl", ::meleeconeexplodevictimcorpsefx);

  foreach(var_11 in level.players) {
    if(var_11 == var_0) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_11)) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, var_11)) {
      continue;
    }
    if(level.friendlyfire == 0 && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_0, var_11))) {
      continue;
    }
    if(!scripts\mp\utility\game::pointvscone(var_11 gettagorigin("tag_eye"), var_8, var_6, var_7, var_9, 128, 18)) {
      if(!scripts\mp\utility\game::pointvscone(var_11 gettagorigin("tag_origin"), var_8, var_6, var_7, var_9, 128, 18)) {
        if(!scripts\mp\utility\game::pointvscone(var_11 gettagorigin("j_mainroot"), var_8, var_6, var_7, var_9, 128, 18)) {
          continue;
        }
      }
    }

    if(var_11 damageconetrace(var_4, var_0) <= 0) {
      continue;
    }
    var_12 = min(325, distance(var_4, var_11 getEye()));
    var_13 = 1 - var_12 / 325;
    var_14 = 80 + var_13 * 60;
    var_11 getrandomarmkillstreak(var_14, var_4, var_0, var_0, "MOD_EXPLOSIVE", var_2);

    if(scripts\mp\utility\game::isreallyalive(var_11)) {
      thread meleeconeexplodevictimfx(var_11);
      continue;
    }

    var_11 thread scripts\mp\damage::enqueuecorpsetablefunc("passive_melee_cone_expl", ::meleeconeexplodevictimcorpsefx);
  }
}

meleeconeexplodeworldfx(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);
  var_0 = var_0 + var_3 * 10;
  var_4 = spawn("script_model", var_0);
  var_4.angles = var_1;
  var_4 setotherent(var_2);
  var_4 setentityowner(var_2);
  var_4 setModel("passive_mp_meleeConeExpl");

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_2)) {
    var_4 setscriptablepartstate("effects", "activePhase");
  } else {
    var_4 setscriptablepartstate("effects", "active");
  }

  wait 0.2;
  physicsexplosionsphere(var_0, 128, 0, 1);
  wait 0.2;
  var_4 delete();
}

meleeconeexplodeattackerfx(var_0) {
  var_0 endon("disconnect");
  var_0 notify("meleeConeExplodeAttackerVfx");
  var_0 endon("meleeConeExplodeAttackerVfx");
  var_0 setscriptablepartstate("weaponPassiveMeleeConeExplAttacker", "active");
  scripts\engine\utility::waittill_any_timeout(0.2);
  var_0 setscriptablepartstate("weaponPassiveMeleeConeExplAttacker", "neutral");
}

meleeconeexplodevictimfx(var_0) {
  var_0 endon("disconnect");
  var_0 notify("meleeConeExplodeVictimVfx");
  var_0 endon("meleeConeExplodeVictimVfx");
  var_0 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "active", 0);
  var_0 scripts\engine\utility::waittill_any_timeout(2.75);
  var_0 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "neutral", 0);
}

meleeconeexplodevictimcorpsefx(var_0) {
  var_0 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "active", 0);
  wait 2.75;

  if(isDefined(var_0)) {
    var_0 setscriptablepartstate("weaponPassiveMeleeConeExplVictim", "neutral", 0);
  }
}

handleleaderkillscorepassive(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_2) != scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_0 getcurrentprimaryweapon())) {
    return;
  }
  var_3 = [];

  if(!level.teambased) {
    var_3 = scripts\engine\utility::array_remove(level.players, var_0);
  } else {
    var_3 = scripts\mp\utility\game::getteamarray(scripts\mp\utility\game::getotherteam(var_0.team));
  }

  var_4 = 1;

  foreach(var_6 in var_3) {
    if(var_1.score >= var_6.score) {
      continue;
    }
    var_4 = 0;
    break;
  }

  if(!var_4) {
    return;
  }
  var_8 = "leader_kill_" + int(min(var_3.size, 5));
  var_0 thread scripts\mp\rank::scoreeventpopup(var_8);
  var_9 = scripts\mp\rank::getscoreinfovalue(var_8);
  var_0 thread scripts\mp\rank::scorepointspopup(var_9);
  var_0 scripts\mp\killstreaks\killstreaks::func_83A7(var_8, var_9);
}

handlepowermeleeondamagepassive(var_0, var_1, var_2, var_3) {
  if(var_3 != "MOD_MELEE") {
    return;
  }
  var_4 = var_0 gettagorigin("j_spineupper");
  var_5 = var_0 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = anglestoup(var_5);
  thread meleeconeexplodeattackerfx(var_0);
  wait 0.01;
}