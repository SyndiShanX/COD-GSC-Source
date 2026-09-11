/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58276.gsc
***********************************************/

function init() {
  level._effect["vfx_killmonger_screen_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_killmonger_scrnfx");
  level._effect["vfx_killmonger_blood_trail"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_marked_blood_trail");
  level._effect["vfx_killmonger_smoke_trail"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_killmonger_trail");
  level._effect["vfx_killmonger_victim_explosion"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_victim_explosion");
  game["dialog"]["powerup_killmonger"] = "power_up_killmonger";
  var0 = spawnStruct();
  var0.ref_138fd = "killmonger";
  var0.parachute_get_path = getdvarfloat("scr_brPowerups_killmonger_buff_duration", 45);
  var0.parachuteoverheadwarningprematchtimeoutms = getdvarfloat("scr_brPowerups_killmonger_ping_interval", 2);
  var0.spotlight_model = getdvarint("scr_brPowerups_killmong_ping_radius", 2500);
  var0.parachuteoverheadwarningheight = getdvarfloat("scr_brPowerups_killmonger_outline_duration", 1.8);
  var0.parachutedeploydelay = getdvarfloat("scr_brPowerups_killmonger_footsteps_duration", 1.8);
  var0.asm_playfacialanim_mp = &asm_playfacialanim_mp;
  var0.ref_12a35 = &ref_12a35;
  var0.ref_1449e = &ref_1449e;
  var0.isdeathshieldskippingenabled = &isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::ref_12af4(var0);
}

function asm_playfacialanim_mp() {
  self.ref_1265d = 0;
  self.ref_11e08 = 2;
  self.player.ref_1282d = 1;
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("powerup_killmonger", self.player);
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastoffhand");
  self.player scripts\mp\utility\perk::giveperk("specialty_quickswap");
  self.player scripts\mp\utility\perk::giveperk("specialty_stalker");
  self.player scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  ref_1353c();
  self.player playlocalsound("mp_powerup_activate_killmonger_plr");
  _keypadscriptableused_bunkeralt::ref_12425(self.player, "br_rumble_powerup_killmonger_activated");
}

function ref_1449e() {
  level endon("game_ended");
  self endon("death");
  self.player endon("death_or_disconnect");
  self endon("stop_powerup");
  var0 = 0;

  while(gettime() < self.mp_layover_patch) {
    var1 = gettime();

    if(var1 - var0 >= self.ref_12e2d.parachuteoverheadwarningprematchtimeoutms * 1000) {
      thread ref_13ed8();
      thread ref_13341();
      var0 = gettime();
    }

    waitframe();
  }
}

function isdeathshieldskippingenabled() {
  self notify("singleton_deactivate_func");
  self endon("singleton_deactivate_func");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
  self.player scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  self.player scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self.player scripts\mp\utility\perk::removeperk("specialty_stalker");
  self.player scripts\mp\utility\perk::removeperk("specialty_sprintfire");
  self.player.ref_1282d = 0;
  self.player lerpfovbypreset("default_2seconds");
  lb_dmg_factor_tail_rotor();

  if(isalive(self.player)) {
    self.player playlocalsound("mp_powerup_deactivate_killmonger_plr");
    return;
  }
}

function ref_12a35() {
  open_starting_safehouse_door(self.ref_12e2d.parachute_get_path);
  self.player playlocalsound("mp_powerup_reactivate_killmonger_plr");
  self.player lerpfovbypreset("zombiedefault");
}

function ref_11ff1(var0) {
  if(isDefined(var0.attacker.ref_1282d)) {
    if(var0.attacker.ref_1282d) {
      playFX(scripts\engine\utility::getfx("vfx_killmonger_victim_explosion"), var0.victim.origin);
      var1 = easepower("brloot_rumble_powerup_sfx", var0.victim.origin);
      var1 setscriptablepartstate("sfx", "killmonger_victim_death_3D");
      var0.attacker playlocalsound("mp_powerup_victim_death_killmonger_plr");
      var2 = var0.attacker _keypadscriptableused_bunkeralt::ref_1249c("killmonger");
      var2.ref_1265d++;

      if(var2.ref_1265d % 3 == 0) {
        var3 = clamp(var2.ref_11e08 + 1, 2, 2);
        var2.ref_11e08 = var3;
      }

      var4 = (var2.ref_11e08 - 1) * 75;
      var2.player thread scripts\mp\rank::giverankxp("br_rumble_killmonger_kill_bonus", var4, var0.objweapon);
      var2.player thread scripts\mp\rank::scoreeventpopup("br_rumble_killmonger_kill_bonus");
      return;
    }

    return;
  }
}

function open_starting_safehouse_door(var0) {
  self.mp_layover_patch = gettime() + var0 * 1000;
  self.player thread _keypadscriptableused_bunkeralt::ref_13f7e(undefined, 3, 2);
}

function ref_1353c() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_killmonger_smoke_trail"), self.player, "j_spine4");
  stopfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_smoke_trail"), self.player, "j_spine4", self.player);
}

function lb_dmg_factor_tail_rotor() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_killmonger_smoke_trail"), self.player, "j_spine4");
  self.player playlocalsound("mp_powerup_deactivate_killmonger_plr");
}

function ref_13341() {
  level endon("game_ended");
  self.player endon("remove_tracker_perk");
  self.player endon("disconnect");
  thread ref_12bd0();
  self.player scripts\mp\utility\perk::giveperk("specialty_tracker");
  wait self.ref_12e2d.parachutedeploydelay;
  self.player scripts\mp\utility\perk::removeperk("specialty_tracker");
  self.player notify("remove_tracker_perk");
}

function ref_12bd0() {
  level endon("game_ended");
  self endon("remove_tracker_perk");
  self endon("disconnect");
  scripts\engine\utility::ref_143a6("death", "joined_team", "joined_spectators");
  scripts\mp\utility\perk::removeperk("specialty_tracker");
  self notify("remove_tracker_perk");
}

function ref_13ed8() {
  var0 = self.player;
  var1 = self.player.origin;
  var2 = self.player.angles;
  var3 = init_hacking_consoles_internal(var0, var1);
  var4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var5 = scripts\common\utility::playersinsphere(var1, self.ref_12e2d.spotlight_model);
  var6 = prematchinitblueprintloadouts(var1, self.ref_12e2d.spotlight_model);

  if(var6.size) {
    var5 = scripts\engine\utility::array_combine(var5, var6);
  }

  self.ref_12ed0 = var5;

  if(var5.size > 0) {
    var7 = scripts\engine\utility::ter_op(self.player.team == "axis", "allies", "axis");
  }

  foreach(var9 in var5) {
    if(!scripts\mp\utility\player::isreallyalive(var9) || !scripts\cp_mp\utility\player_utility::playersareenemies(var0, var9)) {
      continue;
    }

    thread c4vehiclemultkill(var9, var0, var3);
    thread c4_placing_bc(var9, var0);
  }

  triggerportableradarping(var1, var0, self.ref_12e2d.spotlight_model, 500, "specialty_snapshot_immunity");
}

function c4_placing_bc(var0, var1) {
  level endon("game_ended");
  self.player endon("disconnect");

  if(isagent(var0)) {
    return;
  }

  if(isDefined(var0) && isDefined(var1)) {
    var2 = playfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_blood_trail"), var0, "j_spine4", var1);
  }

  wait self.ref_12e2d.parachuteoverheadwarningheight / 1.8;

  if(isDefined(var0) && isDefined(var1)) {
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_blood_trail"), var0, "j_spine4", var1);
    return;
  }
}

function c4vehiclemultkill(var0, var1, var2) {
  var3 = var0 getentitynumber();
  var2.targets[var3] = var0;
  var2.endtimes[var3] = gettime() + self.ref_12e2d.parachuteoverheadwarningheight * 1000;
  var2.outlineids[var3] = scripts\mp\utility\outline::outlineenableforplayer(var0, var1, "killmonger_snapshot", "equipment");

  if(isPlayer(var0) || isbot(var0)) {}

  thread ref_13fb1();
  var0.lastsnapshotgrenadetime = gettime();
  var1 scripts\mp\damage::combatrecordtacticalstat("equip_snapshot_grenade");
  var1 scripts\mp\utility\stats::incpersstat("snapshotHits", 1);
}

function init_hacking_consoles_internal(var0, var1) {
  var2 = undefined;

  if(true) {
    var2 = spawnStruct();
    var2.owner = var0;
    var2.position = var1;
    var2.isalive = 1;
    var2.targets = [];
    var2.endtimes = [];
    var2.outlineids = [];
  }

  return var2;
}

function ref_13fb1() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");

  if(!istrue(self.isalive)) {
    return;
  }

  self notify("update");
  self endon("update");
  thread ref_13430();

  while(self.targets.size > 0) {
    foreach(var5, var1 in self.targets) {
      var1 = self.targets[var5];
      var2 = self.endtimes[var5];
      var3 = self.outlineids[var5];

      if(!scripts\mp\utility\player::isreallyalive(var1) || gettime() >= var2) {
        scripts\mp\utility\outline::outlinedisable(var3, var1);
        var4 = isPlayer(var1);

        if(isDefined(var1) && var4) {
          var1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
        }

        self.targets[var5] = undefined;
        self.endtimes[var5] = undefined;
        self.outlineids[var5] = undefined;
      }
    }

    waitframe();
  }

  thread ref_13431();
}

function ref_13430() {
  self endon("death");
  self endon("update");
  self endon("stop_powerup");
  ref_1342f();
  thread ref_13431();
}

function ref_1342f() {
  self endon("stop_powerup");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

function ref_13431() {
  self notify("death");
  self.isalive = 0;

  foreach(var1 in self.targets) {
    var1 = self.targets[var3];
    var2 = self.outlineids[var3];
    scripts\mp\utility\outline::outlinedisable(var2, var1);

    if(isDefined(var1) && (isPlayer(var1) || isbot(var1))) {
      var1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
    }
  }
}

function prematchinitblueprintloadouts(var0, var1) {
  var2 = prematchinitloadouts(var0, var1);
  var3 = [];
  var4 = var1 * var1;

  foreach(var6 in var2) {
    var7 = distancesquared(var6.origin, var0);

    if(var7 < var4) {
      var3 = var6;
    }
  }

  return var3;
}

function prematchinitloadouts(var0, var1) {
  var2 = physics_createcontents(["physicscontents_actor"]);
  var3 = (var1, var1, var1);
  var4 = var0 - var3;
  var5 = var0 + var3;
  var6 = physics_aabbbroadphasequery(var4, var5, var2, []);
  return var6;
}

function isplatepouch() {
  scripts\mp\gametypes\br_dev::ref_12b21(&isplacementplayerobstructed);
  thread isplayerbrsquadleader();
}

function isplayerbrsquadleader() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }
}

function isplacementplayerobstructed(var0, var1) {
  var2 = "";

  switch (var0) {
    case "rmbl_give_killmonger_powerup":
      level.player _keypadscriptableused_bunkeralt::ref_1393a("killmonger");
      break;
    case "rmbl_spawn_killmonger_powerup":
      var3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("brloot_rumble_powerup_killmonger", var3);
      break;
    case "rmbl_give_teammate_killmonger_powerup":
      var4 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      var4 = scripts\engine\utility::array_remove(var4, level.player);
      var4[randomintrange(0, var4.size)] _keypadscriptableused_bunkeralt::ref_1393a("killmonger");
      break;
    case "rmbl_give_enemy_killmonger_powerup":
      var5 = scripts\engine\utility::ter_op(level.player.team == "axis", "allies", "axis");
      var4 = scripts\mp\utility\teams::getteamdata(var5, "players");
      var4[randomintrange(0, var4.size)] _keypadscriptableused_bunkeralt::ref_1393a("killmonger");
      break;
  }
}