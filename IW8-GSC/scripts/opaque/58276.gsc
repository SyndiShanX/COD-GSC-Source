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
  var_0 = spawnStruct();
  var_0.ref_138fd = "killmonger";
  var_0.parachute_get_path = getdvarfloat("scr_brPowerups_killmonger_buff_duration", 45);
  var_0.parachuteoverheadwarningprematchtimeoutms = getdvarfloat("scr_brPowerups_killmonger_ping_interval", 2);
  var_0.spotlight_model = getdvarint("scr_brPowerups_killmong_ping_radius", 2500);
  var_0.parachuteoverheadwarningheight = getdvarfloat("scr_brPowerups_killmonger_outline_duration", 1.8);
  var_0.parachutedeploydelay = getdvarfloat("scr_brPowerups_killmonger_footsteps_duration", 1.8);
  var_0.asm_playfacialanim_mp = &asm_playfacialanim_mp;
  var_0.ref_12a35 = &ref_12a35;
  var_0.ref_1449e = &ref_1449e;
  var_0.isdeathshieldskippingenabled = &isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::ref_12af4(var_0);
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
  var_0 = 0;

  while(gettime() < self.mp_layover_patch) {
    var_1 = gettime();

    if(var_1 - var_0 >= self.ref_12e2d.parachuteoverheadwarningprematchtimeoutms * 1000) {
      thread ref_13ed8();
      thread ref_13341();
      var_0 = gettime();
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

function ref_11ff1(var_0) {
  if(isDefined(var_0.attacker.ref_1282d)) {
    if(var_0.attacker.ref_1282d) {
      playFX(scripts\engine\utility::getfx("vfx_killmonger_victim_explosion"), var_0.victim.origin);
      var_1 = easepower("brloot_rumble_powerup_sfx", var_0.victim.origin);
      var_1 setscriptablepartstate("sfx", "killmonger_victim_death_3D");
      var_0.attacker playlocalsound("mp_powerup_victim_death_killmonger_plr");
      var_2 = var_0.attacker _keypadscriptableused_bunkeralt::ref_1249c("killmonger");
      var_2.ref_1265d++;

      if(var_2.ref_1265d % 3 == 0) {
        var_3 = clamp(var_2.ref_11e08 + 1, 2, 2);
        var_2.ref_11e08 = var_3;
      }

      var_4 = (var_2.ref_11e08 - 1) * 75;
      var_2.player thread scripts\mp\rank::giverankxp("br_rumble_killmonger_kill_bonus", var_4, var_0.objweapon);
      var_2.player thread scripts\mp\rank::scoreeventpopup("br_rumble_killmonger_kill_bonus");
      return;
    }

    return;
  }
}

function open_starting_safehouse_door(var_0) {
  self.mp_layover_patch = gettime() + var_0 * 1000;
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
  var_0 = self.player;
  var_1 = self.player.origin;
  var_2 = self.player.angles;
  var_3 = init_hacking_consoles_internal(var_0, var_1);
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_5 = scripts\common\utility::playersinsphere(var_1, self.ref_12e2d.spotlight_model);
  var_6 = prematchinitblueprintloadouts(var_1, self.ref_12e2d.spotlight_model);

  if(var_6.size) {
    var_5 = scripts\engine\utility::array_combine(var_5, var_6);
  }

  self.ref_12ed0 = var_5;

  if(var_5.size > 0) {
    var_7 = scripts\engine\utility::ter_op(self.player.team == "axis", "allies", "axis");
  }

  foreach(var_9 in var_5) {
    if(!scripts\mp\utility\player::isreallyalive(var_9) || !scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_9)) {
      continue;
    }

    thread c4vehiclemultkill(var_9, var_0, var_3);
    thread c4_placing_bc(var_9, var_0);
  }

  triggerportableradarping(var_1, var_0, self.ref_12e2d.spotlight_model, 500, "specialty_snapshot_immunity");
}

function c4_placing_bc(var_0, var_1) {
  level endon("game_ended");
  self.player endon("disconnect");

  if(isagent(var_0)) {
    return;
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = playfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_blood_trail"), var_0, "j_spine4", var_1);
  }

  wait self.ref_12e2d.parachuteoverheadwarningheight / 1.8;

  if(isDefined(var_0) && isDefined(var_1)) {
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_blood_trail"), var_0, "j_spine4", var_1);
    return;
  }
}

function c4vehiclemultkill(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_2.targets[var_3] = var_0;
  var_2.endtimes[var_3] = gettime() + self.ref_12e2d.parachuteoverheadwarningheight * 1000;
  var_2.outlineids[var_3] = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "killmonger_snapshot", "equipment");

  if(isPlayer(var_0) || isbot(var_0)) {}

  thread ref_13fb1();
  var_0.lastsnapshotgrenadetime = gettime();
  var_1 scripts\mp\damage::combatrecordtacticalstat("equip_snapshot_grenade");
  var_1 scripts\mp\utility\stats::incpersstat("snapshotHits", 1);
}

function init_hacking_consoles_internal(var_0, var_1) {
  var_2 = undefined;

  if(true) {
    var_2 = spawnStruct();
    var_2.owner = var_0;
    var_2.position = var_1;
    var_2.isalive = 1;
    var_2.targets = [];
    var_2.endtimes = [];
    var_2.outlineids = [];
  }

  return var_2;
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
    foreach(var_5, var_1 in self.targets) {
      var_1 = self.targets[var_5];
      var_2 = self.endtimes[var_5];
      var_3 = self.outlineids[var_5];

      if(!scripts\mp\utility\player::isreallyalive(var_1) || gettime() >= var_2) {
        scripts\mp\utility\outline::outlinedisable(var_3, var_1);
        var_4 = isPlayer(var_1);

        if(isDefined(var_1) && var_4) {
          var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
        }

        self.targets[var_5] = undefined;
        self.endtimes[var_5] = undefined;
        self.outlineids[var_5] = undefined;
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

  foreach(var_1 in self.targets) {
    var_1 = self.targets[var_3];
    var_2 = self.outlineids[var_3];
    scripts\mp\utility\outline::outlinedisable(var_2, var_1);

    if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1))) {
      var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
    }
  }
}

function prematchinitblueprintloadouts(var_0, var_1) {
  var_2 = prematchinitloadouts(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4) {
      var_3 = var_6;
    }
  }

  return var_3;
}

function prematchinitloadouts(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_actor"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = physics_aabbbroadphasequery(var_4, var_5, var_2, []);
  return var_6;
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

function isplacementplayerobstructed(var_0, var_1) {
  var_2 = "";

  switch (var_0) {
    case "rmbl_give_killmonger_powerup":
      level.player _keypadscriptableused_bunkeralt::ref_1393a("killmonger");
      break;
    case "rmbl_spawn_killmonger_powerup":
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("brloot_rumble_powerup_killmonger", var_3);
      break;
    case "rmbl_give_teammate_killmonger_powerup":
      var_4 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      var_4 = scripts\engine\utility::array_remove(var_4, level.player);
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::ref_1393a("killmonger");
      break;
    case "rmbl_give_enemy_killmonger_powerup":
      var_5 = scripts\engine\utility::ter_op(level.player.team == "axis", "allies", "axis");
      var_4 = scripts\mp\utility\teams::getteamdata(var_5, "players");
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::ref_1393a("killmonger");
      break;
  }
}