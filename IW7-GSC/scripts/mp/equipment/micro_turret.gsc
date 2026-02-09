/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\micro_turret.gsc
*************************************************/

func_B703() {
  if(!isDefined(level.microturrets)) {
    level.microturrets = [];
  }
}

func_B70A() {}

func_B718(var_0) {
  thread func_B6F5();
  if(isDefined(self.var_B710)) {
    self.var_B710 = undefined;
    func_B6F9(var_0);
  }
}

microturret_use() {
  scripts\mp\utility::func_1254();
  self setscriptablepartstate("killstreak", "visor_active", 0);
  self.var_B710 = 1;
  func_5232();
  thread func_139EE();
  thread func_139EC();
  thread func_139ED();
  thread watcharbitraryup();
}

func_B6F9(var_0) {
  self notify("microTurret_end");
  if(!scripts\mp\utility::istrue(var_0)) {
    scripts\mp\utility::func_11DB();
  }

  self setscriptablepartstate("killstreak", "neutral", 0);
  func_5236(var_0);
  var_1 = self.var_B710;
  self.var_B710 = undefined;
  return scripts\mp\utility::istrue(var_1);
}

func_B711(var_0, var_1, var_2) {
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_turret", undefined, 0.75);
  self notify("microTurret_spawned");
  if(!isDefined(self.microturrets)) {
    self.microturrets = [];
  }

  if(self.microturrets.size >= microturret_getmaxnum()) {
    self.microturrets[0] thread func_B6F6();
  }

  var_3 = spawnturret("misc_turret", var_0, "micro_turret_gun_mp");
  var_3 setModel("micro_turret_wm");
  var_3.angles = var_1;
  var_3.owner = self;
  var_3.team = self.team;
  var_3.weapon_name = "micro_turret_mp";
  var_3 playSound("mp_super_miniturret_plant");
  var_3 thread microturret_beepsounds();
  var_3 getvalidattachments();
  var_3 makeunusable();
  if(level.teambased) {
    var_3 setturretteam(self.team);
  }

  var_3.var_1A4A = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  var_3.var_1A4A linkto(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  microturret_addtoarrays(var_3, self);
  var_3 thread func_B71E();
  var_3 thread func_B71C();
  var_3 setdefaultdroppitch(0);
  var_3 give_player_session_tokens("sentry_offline");
  var_3 setsentryowner(self);
  var_3 setleftarc(180);
  var_3 setrightarc(180);
  var_3 settoparc(90);
  var_3 give_crafted_gascan(45);
  var_3 setotherent(self);
  var_3 give_player_tickets(1);
  var_4 = scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  var_5 = scripts\engine\utility::ter_op(var_4, 209, 119);
  var_6 = scripts\engine\utility::ter_op(var_4, "hitequip", "");
  var_3 thread scripts\mp\damage::monitordamage(var_5, var_6, ::func_B6FF, ::func_B6FE, 0, 0);
  var_3.killcament = func_B6F3(var_3);
  if(isDefined(var_2)) {
    var_3 scripts\mp\weapons::explosivehandlemovers(var_2);
  }

  var_3.stunned = 0;
  var_3 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlinesuperequipment(var_3, self);
  var_3 thread func_B6EA();
  thread func_B71D();
  self.var_B710 = undefined;
  scripts\mp\supers::func_DE3B(9999000);
  scripts\mp\utility::printgameaction("microturret placed", self);
}

microturret_beepsounds() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(3);
    if(!isDefined(self.carriedby)) {
      self playSound("mp_super_miniturret_beep");
    }
  }
}

func_B6F6() {
  thread func_B700();
}

func_B6F5() {
  self notify("microTurret_destroyAll");
  if(isDefined(self.microturrets)) {
    foreach(var_1 in self.microturrets) {
      var_1 func_B6F6();
    }
  }

  self.microturrets = undefined;
}

func_B70B() {
  self setscriptablepartstate("effects", "activeArmed", 0);
  self setturretminimapvisible(1, "micro_turret");
  self setdefaultdroppitch(0);
  self give_player_session_tokens("manual_target");
  func_B70F();
  self.planted = 1;
  if(!issentient(self)) {
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);
  }
}

func_B70C() {
  self setturretminimapvisible(0);
  self laseroff();
  self setdefaultdroppitch(45);
  self give_player_session_tokens("sentry_offline");
  func_B6F2();
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  func_B6F1();
}

func_B70F() {
  if(!isDefined(self.owner)) {
    return;
  }

  var_0 = self.owner;
  var_1 = var_0.team;
  if(level.teambased && !scripts\mp\utility::istrue(self.var_115D1)) {
    scripts\mp\entityheadicons::setteamheadicon(var_1, (0, 0, 50));
    self.var_115D1 = 1;
    return;
  }

  if(!scripts\mp\utility::istrue(self.var_D3AA)) {
    scripts\mp\entityheadicons::setplayerheadicon(var_0, (0, 0, 50));
    self.var_D3AA = 1;
  }
}

func_B6F2() {
  if(scripts\mp\utility::istrue(self.var_115D1)) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
    self.var_115D1 = undefined;
  }

  if(scripts\mp\utility::istrue(self.var_D3AA)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
    self.var_D3AA = undefined;
  }
}

func_B71C() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);
    var_5 = 119;
    if(self.owner scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
      var_5 = 209;
    }

    var_6 = int(ceil(var_5 / 1));
    if(isDefined(var_3) && var_3 == "kineticpulse_emp_mp") {
      var_6 = int(ceil(var_5 / 1));
    }

    var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, self.origin);
    var_3 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, "emp_grenade_mp");
    var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, "MOD_EXPLOSIVE");
    thread func_B6F8(var_1);
    self dodamage(var_6, var_2, var_0, undefined, var_4, var_3);
  }
}

func_B6F8(var_0) {
  self endon("death");
  if(isDefined(self.var_11198) && self.var_11198 < gettime() + var_0 * 1000) {
    return;
  }

  self.stunned = 1;
  self.var_11198 = gettime() + var_0 * 1000;
  self notify("stunned");
  self endon("stunned");
  wait(var_0);
  self.stunned = 0;
  self.var_11198 = undefined;
}

func_B6EA() {
  self endon("death");
  level endon("game_ended");
  self.var_1E2D = 34;
  wait(1);
  for(;;) {
    func_B70B();
    if(!self.stunned && !func_B701()) {
      func_B717();
    }

    func_B712();
    if(!self.stunned && func_B701()) {
      func_B6EB();
    }

    if(self.stunned) {
      func_B713();
    }

    scripts\engine\utility::waitframe();
  }
}

func_B717() {
  self endon("stunned");
  self give_player_session_tokens("manual");
  self laseroff();
  if(func_B701()) {
    func_B6F1();
  }

  thread func_B709();
  for(;;) {
    var_0 = anglesToForward(self gettagangles("tag_flash"));
    var_1 = [];
    var_2 = gettime();
    foreach(var_4 in level.var_69D6) {
      if(var_4.throwtime + 1500 > var_2) {
        var_1[var_1.size] = var_4;
      }
    }

    var_6 = scripts\engine\utility::array_combine(level.characters, var_1, level.spidergrenade.activeagents, level.spidergrenade.proxies);
    var_7 = [];
    var_8 = [];
    foreach(var_10 in var_6) {
      if(!func_B71A(var_10)) {
        continue;
      }

      var_11 = var_10.origin - self gettagorigin("tag_dummy");
      var_12 = vectornormalize(var_11);
      var_13 = vectordot(var_11, var_12);
      var_14 = scripts\engine\utility::anglebetweenvectorsunit(var_0, var_12);
      var_15 = 1 - var_13 / 800;
      var_10 = 1 - var_14 / 180;
      var_11 = var_15 * 0.5 + var_10 * 0.8;
      var_7[var_7.size] = var_10;
      var_8[var_8.size] = var_11;
    }

    for(;;) {
      var_13 = 0;
      for(var_14 = 0; var_14 < var_7.size - 1; var_14++) {
        var_15 = var_7[var_14];
        var_16 = var_8[var_14];
        if(var_16 < var_8[var_14]) {
          var_7[var_14] = var_7[var_14 + 1];
          var_8[var_14] = var_8[var_14 + 1];
          var_7[var_14 + 1] = var_15;
          var_8[var_14 + 1] = var_16;
          var_13 = 1;
        }
      }

      if(!var_13) {
        break;
      }
    }

    for(var_14 = 0; var_14 < var_7.size; var_14++) {
      var_17 = var_7[var_14];
      var_18 = func_B714(var_17);
      if(isDefined(var_18)) {
        func_B70D(var_17, var_18);
        return;
      }
    }

    wait(0.1);
  }
}

func_B6EB() {
  self endon("stunned");
  self endon("lostTarget");
  self give_player_session_tokens("manual");
  self laseron();
  thread func_B721();
  func_B704();
  func_B6EC();
}

func_B6EC() {
  var_0 = weaponfiretime("micro_turret_gun_mp");
  if(isDefined(self.var_1A4A) && isPlayer(self.var_1A4A)) {
    level thread scripts\mp\battlechatter_mp::saytoself(self.var_1A4A, "plr_killstreak_target");
  }

  for(;;) {
    if(func_B701()) {
      var_1 = self func_8161(0);
      if(!isDefined(self.var_1A4A)) {
        self settargetentity(self.var_1A4A);
      }

      if(func_B715() && isDefined(self func_8161(1))) {
        self shootturret();
        self.var_1E2D--;
        if(self.var_1E2D <= 0) {
          func_B6F6();
        }
      }

      wait(var_0);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_B713() {
  self setscriptablepartstate("effects", "activeStunned", 0);
  func_B70C();
}

func_B721() {
  self endon("death");
  self endon("stunned");
  level endon("game_ended");
  func_B722();
  func_B6F1();
  self notify("lostTarget");
}

func_B722() {
  var_0 = func_B6FD();
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 = undefined;
  var_2 = func_B6FD();
  while(isDefined(var_2) && var_2 == var_0) {
    var_2 = func_B6FD();
    if(!isDefined(var_2) || var_2 != var_0) {
      break;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_blindeye")) {
      break;
    }

    if(isDefined(var_1) && gettime() > var_1) {
      break;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_2)) {
      if(!isDefined(var_1)) {
        var_1 = gettime() + 500;
      }

      wait(0.1);
      continue;
    }

    var_3 = func_B714(var_2);
    if(!isDefined(var_3)) {
      if(!isDefined(var_1)) {
        var_1 = gettime() + 500;
      }

      wait(0.1);
      continue;
    }

    func_B70D(var_2, var_3);
    var_1 = undefined;
    wait(0.1);
  }
}

func_B704() {
  var_0 = func_B6FD();
  if(isPlayer(var_0) || isagent(var_0)) {
    thread func_B705(var_0);
  }

  wait(0.65);
  self notify("lockOnEnded");
}

func_B705(var_0) {
  self endon("death");
  self endon("lockOnEnded");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 0.2;
  for(;;) {
    var_0 playlocalsound("mp_super_miniturret_lockon");
    wait(var_2);
    var_1 = var_1 + var_2;
  }
}

func_B6FE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  var_5 = microturret_handlesuperandexplosivedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\supers::modifysuperequipmentdamage(var_0, var_1, var_2, var_5, var_4);
  return var_5;
}

func_B6FF(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_0))) {
    if(var_0 scripts\mp\missions::func_66B8("specialty_blindeye")) {
      var_0 scripts\mp\missions::func_D991("ch_perk_kills_blindeye");
    }

    var_0 scripts\mp\missions::func_D991("ch_killjoy_six_ability");
    var_0 thread scripts\mp\events::supershutdown(self.owner);
    var_0 notify("destroyed_equipment");
  }

  thread func_B700();
}

func_B700() {
  self notify("death");
  self.var_1A4A delete();
  microturret_removefromarrays(self, self.owner);
  func_B70C();
  self setscriptablepartstate("effects", "activeDestroyed");
  wait(3);
  scripts\mp\weapons::equipmentdeletevfx(self.origin, self.angles);
  scripts\mp\utility::printgameaction("microturret destroyed", self.owner);
  self delete();
}

func_139EE() {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  for(;;) {
    self waittill("equip_deploy_succeeded", var_0, var_1, var_2, var_3);
    if(var_0 == "deploy_microturret_mp") {
      thread func_B711(var_1, var_2, var_3);
    }
  }
}

func_139EC() {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  for(;;) {
    self waittill("equip_deploy_failed", var_0, var_1, var_2, var_3);
    if(var_0 == "deploy_microturret_mp") {
      self setweaponammoclip("deploy_microturret_mp", 100);
    }
  }
}

func_139ED() {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  level waittill("game_ended");
  scripts\mp\supers::func_DE3B(9999000);
}

watcharbitraryup() {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  scripts\engine\utility::waitframe();
  while(!scripts\mp\utility::isinarbitraryup()) {
    scripts\engine\utility::waitframe();
  }

  scripts\mp\supers::superdisabledinarbitraryupmessage();
  scripts\mp\supers::func_DE3B(9999000);
}

func_5232() {
  self.var_B6FB = 1;
  scripts\engine\utility::allow_usability(0);
  scripts\mp\powers::func_D729();
  scripts\mp\utility::func_1C47(0);
}

func_5236(var_0) {
  if(!scripts\mp\utility::istrue(var_0)) {
    if(scripts\mp\utility::istrue(self.var_B6FB)) {
      scripts\engine\utility::allow_usability(1);
      scripts\mp\powers::func_D72F();
      scripts\mp\utility::func_1C47(1);
    }
  }

  self.var_B6FB = undefined;
}

func_B71E() {
  self endon("death");
  self.owner waittill("disconnect");
  thread func_B6F6();
}

func_B71D() {
  self endon("disconnect");
  self endon("microTurret_destroyAll");
  self notify("microTurret_watchForGameEnd");
  self endon("microTurret_watchForGameEnd");
  level scripts\engine\utility::waittill_any("game_ended", "bro_shot_start");
  thread func_B6F5();
}

microturret_addtoarrays(var_0, var_1) {
  var_1.microturrets[var_1.microturrets.size] = var_0;
  level.microturrets[var_0 getentitynumber()] = var_0;
}

microturret_removefromarrays(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.microturrets)) {
    var_1.microturrets = scripts\engine\utility::array_remove(var_1.microturrets, var_0);
  }

  level.microturrets[var_0 getentitynumber()] = undefined;
}

func_B6F3(var_0) {
  var_1 = var_0 gettagorigin("tag_laser");
  var_2 = spawn("script_model", var_0.origin + anglestoup(var_0.angles) * 30);
  var_2 setModel("tag_origin");
  var_2 setscriptmoverkillcam("explosive");
  var_2 linkto(var_0);
  var_2 thread func_B6F0(var_0);
  return var_2;
}

func_B6F0(var_0) {
  self endon("death");
  var_0 waittill("death");
  wait(10);
  self delete();
}

func_B714(var_0) {
  var_1 = undefined;
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_ainosight", "physicscontents_sky"]);
  var_3 = self gettagorigin("tag_dummy");
  if(isPlayer(var_0) || isagent(var_0) && !scripts\mp\utility::func_9F72(var_0)) {
    var_4 = "j_spine4";
    var_5 = var_0 gettagorigin(var_4);
    if(!isDefined(var_1) && !scripts\mp\utility::func_C7A0(var_3, var_5)) {
      var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
      var_7 = !isDefined(var_6) || var_6.size == 0;
      var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
    }

    if(!isDefined(var_1)) {
      var_4 = "tag_eye";
      var_5 = var_0 gettagorigin(var_4);
      if(!isDefined(var_1) && !scripts\mp\utility::func_C7A0(var_3, var_5)) {
        var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
        var_7 = !isDefined(var_6) || var_6.size == 0;
        var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
      }
    }

    if(!isDefined(var_1)) {
      var_5 = var_0.origin;
      if(!isDefined(var_1) && !scripts\mp\utility::func_C7A0(var_3, var_5)) {
        var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
        var_7 = !isDefined(var_6) || var_6.size == 0;
        var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
      }
    }
  } else {
    var_4 = "tag_origin";
    var_5 = var_1 gettagorigin(var_5);
    if(!isDefined(var_1) && !scripts\mp\utility::func_C7A0(var_3, var_5)) {
      var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
      var_7 = !isDefined(var_6) || var_6.size == 0;
      var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
    }
  }

  return var_1;
}

func_B70D(var_0, var_1) {
  if(!isDefined(self.var_1A4A)) {
    return 0;
  }

  self.var_1A4A.var_23EA = var_0;
  self.var_1A4A.var_23EB = var_1;
  self.var_1A4A linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  self settargetentity(self.var_1A4A);
}

func_B6F1() {
  if(isDefined(self.var_1A4A)) {
    self.var_1A4A linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    self.var_1A4A.var_23EA = undefined;
    self.var_1A4A.var_23EB = undefined;
  }

  self cleartargetentity();
}

func_B701() {
  return isDefined(self.var_1A4A) && isDefined(self.var_1A4A.var_23EA);
}

func_B6FD() {
  if(func_B701()) {
    return self.var_1A4A.var_23EA;
  }

  return undefined;
}

func_B715() {
  return isDefined(self.var_1A4A) && isDefined(self.var_1A4A.var_23EB);
}

func_B71A(var_0) {
  var_1 = var_0;
  if(!isDefined(var_0)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  if(var_0 scripts\mp\utility::_hasperk("specialty_blindeye") && !scripts\mp\utility::func_9F72(var_0)) {
    return 0;
  }

  if(isPlayer(var_0) || isagent(var_0)) {
    if(!scripts\mp\utility::isreallyalive(var_0)) {
      return 0;
    }

    if(scripts\mp\utility::func_9F22(var_0)) {
      var_1 = var_0.owner;
    }

    if(scripts\mp\utility::func_9F72(var_0)) {
      var_1 = var_0.owner;
    }
  } else {
    var_1 = var_0.owner;
  }

  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_1))) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 640000) {
    return 0;
  }

  return 1;
}

func_B709() {
  self endon("death");
  self endon("microTurret_stopIdleMovements");
  self settargetentity(self.var_1A4A);
  self.var_1A4A unlink();
  for(;;) {
    self.var_1A4A.origin = (randomintrange(-100, 100), randomintrange(-100, 100), 50) + self.origin;
    self playSound("mp_super_miniturret_servos");
    wait(randomfloatrange(0.75, 1.25));
  }
}

func_B712() {
  self notify("microTurret_stopIdleMovements");
}

microturret_getmaxnum() {
  var_0 = 1;
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_0++;
  }

  return var_0;
}

microturret_onruggedequipmentunset() {
  self endon("disconnect");
  if(!isDefined(self.microturrets) || self.microturrets.size <= 0) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    self waittill("giveLoadout");
    if(!isDefined(self.microturrets) || self.microturrets.size <= 0) {
      return;
    }
  }

  var_0 = microturret_getmaxnum();
  var_1 = max(0, self.microturrets.size - var_0);
  for(var_2 = 0; var_2 < var_1; var_2++) {
    self.microturrets[0] thread func_B6F6();
  }
}

microturret_handlesuperandexplosivedamage(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = getweaponbasename(var_0);
  if(isDefined(var_4)) {
    var_0 = var_4;
  }

  switch (var_0) {
    case "micro_turret_gun_mp":
      var_3 = 5;
      break;

    case "iw7_penetrationrail_mp":
      var_3 = 2.3;
      break;

    case "iw7_atomizer_mp":
      var_3 = 1.5;
      break;
  }

  if(isexplosivedamagemod(var_1) && var_3 < 1.5) {
    var_3 = 1.5;
  }

  return int(ceil(var_3 * var_2));
}