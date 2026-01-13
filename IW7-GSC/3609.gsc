/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3609.gsc
*********************************************/

func_1127D() {
  var_0 = spawnStruct();
  var_0.trophies = [];
  var_0.var_1141B = [];
  var_0.var_1141B[0] = "fx_01_jnt";
  var_0.var_1141B[1] = "fx_02_jnt";
  var_0.var_1141B[2] = "fx_03_jnt";
  var_0.var_1141B[3] = "fx_04_jnt";
  level.supertrophy = var_0;
}

func_11296(var_0) {
  var_1 = self.supertrophies;
  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_3 thread func_11274();
    }

    self.supertrophies = undefined;
  }

  if(isDefined(self.var_11293)) {
    self.var_11293 = undefined;
    func_11276(var_0);
  }
}

func_11297() {
  scripts\mp\utility::func_1254();
  self setscriptablepartstate("killstreak", "visor_active", 0);
  self.var_11293 = 1;
  func_11272();
  thread func_1129D();
  thread func_1129B();
  thread func_1129C();
  thread watcharbitraryup();
  return 1;
}

func_11276(var_0) {
  self notify("superTrophy_end");
  if(!scripts\mp\utility::istrue(var_0)) {
    scripts\mp\utility::func_11DB();
  }

  self setscriptablepartstate("killstreak", "neutral", 0);
  func_11273(var_0);
  var_1 = self.var_11293;
  self.var_11293 = undefined;
  return scripts\mp\utility::istrue(var_1);
}

func_11274() {
  self notify("death");
  supertrophy_removefromarrays(self, self.triggerportableradarping);
  if(isDefined(self.objstruct)) {
    self.objstruct func_11275();
  }

  if(isDefined(self.triggerportableradarping)) {
    scripts\mp\utility::printgameaction("supertrophy destroyed", self.triggerportableradarping);
  }

  self setCanDamage(0);
  self func_854A();
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait(3);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
  wait(0.1);
  self delete();
}

func_11299() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self setscriptablepartstate("effects", "activeDeployStart", 0);
  self.objstruct = func_11270();
  wait(1.25);
  self setscriptablepartstate("effects", "activeDeployEnd", 0);
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.triggerportableradarping);
  thread scripts\mp\weapons::outlinesuperequipment(self, self.triggerportableradarping);
  thread scripts\mp\entityheadicons::setheadicon_factionimage(self.triggerportableradarping, (0, 0, 50), 0);
  thread scripts\mp\perks\_perk_equipmentping::runequipmentping(self);
  thread func_1129F();
  thread func_1129E();
}

func_11278(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_0)) {
    return 0;
  }

  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  var_5 = func_1127B(var_1, var_2, var_5);
  var_5 = supertrophy_handlesuperdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\supers::modifysuperequipmentdamage(var_0, var_1, var_2, var_5, var_4);
  return var_5;
}

func_11279(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_0))) {
    var_0 thread scripts\mp\events::supershutdown(self.triggerportableradarping);
    var_0 notify("destroyed_equipment");
  }

  if(isDefined(var_0) && isplayer(var_0) && var_0 != self.triggerportableradarping) {
    var_0 scripts\mp\missions::func_D991("ch_killjoy_six_ability");
  }

  thread func_11274();
}

func_1127B(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return int(ceil(self.maxhealth / 2));
  }

  return var_2;
}

supertrophy_handlesuperdamage(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = getweaponbasename(var_0);
  if(isDefined(var_4)) {
    var_0 = var_4;
  }

  switch (var_0) {
    case "micro_turret_gun_mp":
      var_3 = 4;
      break;

    case "iw7_penetrationrail_mp":
      var_3 = 2.3;
      break;

    case "iw7_atomizer_mp":
      var_3 = 1.5;
      break;
  }

  return int(ceil(var_3 * var_2));
}

func_1129D() {
  self endon("disconnect");
  self endon("superTrophy_createTrophy");
  self endon("superTrophy_end");
  for(;;) {
    self waittill("equip_deploy_succeeded", var_0, var_1, var_2, var_3);
    if(var_0 == "deploy_supertrophy_mp") {
      thread func_11271(var_1, var_2, var_3);
      break;
    }
  }
}

func_1129B() {
  self endon("disconnect");
  self endon("superTrophy_createTrophy");
  self endon("superTrophy_end");
  for(;;) {
    self waittill("equip_deploy_failed", var_0, var_1, var_2, var_3);
    if(var_0 == "deploy_supertrophy_mp") {
      self setweaponammoclip("deploy_supertrophy_mp", 100);
      break;
    }
  }
}

func_1129C() {
  self endon("disconnect");
  self endon("superTrophy_createTrophy");
  self endon("superTrophy_end");
  level waittill("game_ended");
  scripts\mp\supers::func_DE3B(9999000);
}

watcharbitraryup() {
  self endon("disconnect");
  self endon("superTrophy_createTrophy");
  self endon("superTrophy_end");
  scripts\engine\utility::waitframe();
  while(!scripts\mp\utility::isinarbitraryup()) {
    scripts\engine\utility::waitframe();
  }

  scripts\mp\supers::superdisabledinarbitraryupmessage();
  scripts\mp\supers::func_DE3B(9999000);
}

func_11272() {
  self.var_11277 = 1;
  scripts\engine\utility::allow_usability(0);
  scripts\mp\powers::func_D729();
  scripts\mp\utility::func_1C47(0);
}

func_11273(var_0) {
  if(!scripts\mp\utility::istrue(var_0)) {
    if(scripts\mp\utility::istrue(self.var_11277)) {
      scripts\engine\utility::allow_usability(1);
      scripts\mp\powers::func_D72F();
      scripts\mp\utility::func_1C47(1);
    }
  }

  self.var_11277 = undefined;
}

func_11271(var_0, var_1, var_2) {
  if(isDefined(self.supertrophy)) {
    self.supertrophy thread func_11274();
  }

  self notify("superTrophy_createTrophy");
  if(!isDefined(self.supertrophies)) {
    self.supertrophies = [];
  }

  if(self.supertrophies.size >= supertrophy_getmaxnum()) {
    self.supertrophies[0] thread func_11274();
  }

  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setotherent(self);
  var_3 setModel("super_trophy_mp_wm");
  var_3 give_player_tickets(1);
  var_3 func_8549();
  var_3 func_8594();
  var_3.triggerportableradarping = self;
  var_3.team = var_3.triggerportableradarping.team;
  var_3.super = "super_supertrophy";
  var_3.weapon_name = "super_trophy_mp";
  var_3.planted = 1;
  var_3.markeduioff = [];
  var_3.markeduion = [];
  var_3.var_1E2D = 10;
  supertrophy_addtoarrays(var_3, self);
  var_3 thread func_1126D();
  var_3 thread func_1126E();
  var_3.killcament = func_1126F(var_3);
  var_3.var_69DA = supertrophy_createexplosion(var_3);
  var_4 = scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  var_5 = scripts\engine\utility::ter_op(var_4, 475, 399);
  var_6 = scripts\engine\utility::ter_op(var_4, "hitequip", "");
  var_3 thread scripts\mp\damage::monitordamage(var_5, var_6, ::func_11279, ::func_11278, 0);
  if(isDefined(var_2)) {
    var_3 scripts\mp\weapons::explosivehandlemovers(var_2);
  }

  var_3 thread func_11299();
  self.var_11293 = undefined;
  scripts\mp\supers::func_DE3B(9999000);
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_trophy", undefined, 0.75);
  scripts\mp\utility::printgameaction("supertrophy placed", self);
}

func_1126F(var_0) {
  var_1 = spawn("script_model", var_0.origin + anglestoup(var_0.angles) * 65);
  var_1.angles = var_0.angles;
  var_1 setModel("tag_origin");
  var_1 setscriptmoverkillcam("explosive");
  var_1 linkto(var_0);
  var_1 thread supertrophy_cleanuponparentdeath(var_0, 5);
  return var_1;
}

supertrophy_createexplosion(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.killcament = var_0.killcament;
  var_1.triggerportableradarping = var_0.triggerportableradarping;
  var_1.team = var_0.team;
  var_1.super = var_0.super;
  var_1.weapon_name = var_0.weapon_name;
  var_1 setotherent(var_1.triggerportableradarping);
  var_1 setentityowner(var_1.triggerportableradarping);
  var_1 setModel("super_trophy_mp_explode");
  var_1.timebypart = [];
  for(var_2 = 0; var_2 < 4; var_2++) {
    var_1.timebypart[var_2] = 0;
  }

  var_1 thread supertrophy_cleanuponparentdeath(var_0, 0.1);
  return var_1;
}

supertrophy_explode(var_0, var_1) {
  foreach(var_4, var_3 in self.timebypart) {
    if(gettime() - var_3 / 1000 > 0.1) {
      self dontinterpolate();
      self.origin = var_0;
      self.angles = var_1;
      self setscriptablepartstate("explode" + var_4 + 1, "active", 0);
      self.timebypart[var_4] = gettime();
      return;
    }
  }
}

func_1129F() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  if(!isDefined(level.grenades)) {
    level.grenades = [];
  }

  if(!isDefined(level.missiles)) {
    level.missiles = [];
  }

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  var_0 = scripts\mp\trophy_system::func_12804();
  for(;;) {
    var_1 = [];
    var_1[0] = level.grenades;
    var_1[1] = level.missiles;
    var_1[2] = level.mines;
    var_2 = scripts\engine\utility::array_combine_multiple(var_1);
    var_3 = func_1128F();
    foreach(var_5 in var_2) {
      if(!isDefined(var_5)) {
        continue;
      }

      if(scripts\mp\utility::istrue(var_5.exploding)) {
        continue;
      }

      if(supertrophy_checkignorelist(var_5)) {
        continue;
      }

      var_6 = var_5.triggerportableradarping;
      if(!isDefined(var_6) && isDefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "grenade") {
        var_6 = getmissileowner(var_5);
      }

      if(isDefined(var_6) && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_6))) {
        continue;
      }

      if(distancesquared(var_5.origin, self.origin) > scripts\mp\trophy_system::trophy_modifiedprotectiondistsqr(var_5, 65536)) {
        continue;
      }

      var_7 = physics_raycast(var_3, var_5.origin, var_0, [self, var_5], 0, "physicsquery_closest");
      if(isDefined(var_7) && var_7.size > 0) {
        continue;
      }

      if(isDefined(self.objstruct)) {
        self.objstruct thread supertrophy_setobjectivefiring();
      }

      thread func_1128E(var_5);
      self.var_1E2D--;
      if(self.var_1E2D <= 0) {
        thread func_11274();
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_1128E(var_0) {
  level thread scripts\mp\battlechatter_mp::saytoself(self.triggerportableradarping, "plr_perk_trophy_block", undefined, 0.75);
  self.triggerportableradarping scripts\mp\killstreaks\_killstreaks::givescorefortrophyblocks();
  self.triggerportableradarping thread scripts\mp\events::superkill("super_supertrophy");
  self.triggerportableradarping scripts\mp\supers::combatrecordsuperkill("super_supertrophy");
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  scripts\mp\trophy_system::func_12821(var_0);
  scripts\mp\trophy_system::func_12817(var_0, "super_trophy_mp", self.triggerportableradarping);
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  if(scripts\mp\weapons::isplantedequipment(var_0)) {
    var_0 scripts\mp\weapons::deleteexplosive();
  } else if(var_0 scripts\mp\domeshield::isdomeshield()) {
    var_0 thread scripts\mp\domeshield::domeshield_delete();
  } else {
    var_0 delete();
  }

  var_3 = supertrophy_getbesttag(var_1);
  var_4 = supertrophy_getpartbytag(var_3);
  self setscriptablepartstate(var_4, "active", 0);
  self.var_69DA thread supertrophy_explode(var_1, var_2);
}

func_1129E() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_missileclip"]);
  for(;;) {
    var_1 = scripts\mp\utility::clearscrambler(self.origin, 256, undefined);
    foreach(var_3 in self.markeduioff) {
      if(!func_1127E(var_3)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_1, var_3)) {
        continue;
      }

      func_11292(var_3);
    }

    var_5 = func_1128F();
    foreach(var_7 in var_1) {
      if(!func_1127E(var_7)) {
        continue;
      }

      var_8 = func_11295(var_7);
      var_9 = func_11288(var_7, var_5, var_0);
      if(!var_8 && var_9) {
        thread func_11284(var_7);
        continue;
      }

      if(var_8 && !var_9) {
        func_11292(var_7);
      }
    }

    var_1 = scripts\mp\weapons::getempdamageents(self.origin, 256);
    foreach(var_3 in self.markeduioff) {
      if(func_1127E(var_3)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_1, var_3)) {
        continue;
      }

      func_11292(var_3);
    }

    foreach(var_7 in var_1) {
      if(func_1127E(var_7)) {
        continue;
      }

      var_8 = func_11295(var_7);
      var_9 = func_11287(var_7);
      if(!var_8 && var_9) {
        thread func_11282(var_7);
        continue;
      }

      if(var_8 && !var_9) {
        func_11292(var_7);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_11284(var_0) {
  func_11269(var_0);
  var_1 = var_0 getentitynumber();
  var_2 = spawnStruct();
  var_2.empd = 0;
  func_11285(var_0, var_2);
  if(isDefined(self)) {
    func_11292(var_0, var_1);
  }

  if(isDefined(var_0)) {
    if(isDefined(self) && isDefined(self.triggerportableradarping)) {
      scripts\mp\gamescore::untrackdebuffassist(self.triggerportableradarping, var_0, "super_trophy_mp");
    }

    if(var_2.empd) {
      var_0 scripts\mp\killstreaks\_emp_common::func_E0F3();
    }
  }
}

func_11285(var_0, var_1) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_2 = gettime();
  while(func_11295(var_0)) {
    if(!var_1.empd) {
      if(!var_0 scripts\mp\utility::_hasperk("specialty_empimmune")) {
        var_0 scripts\mp\killstreaks\_emp_common::func_20C3();
        scripts\mp\gamescore::func_11ACE(self.triggerportableradarping, var_0, "super_trophy_mp");
        var_1.empd = 1;
      }
    } else if(var_0 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      var_0 scripts\mp\killstreaks\_emp_common::func_E0F3();
      scripts\mp\gamescore::untrackdebuffassist(self.triggerportableradarping, var_0, "super_trophy_mp");
      var_1.empd = 0;
    }

    if(gettime() >= var_2) {
      if(var_0 scripts\mp\utility::_hasperk("specialty_empimmune")) {
        self.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
      }

      var_3 = scripts\mp\perks\_perkfunctions::applystunresistence(self.triggerportableradarping, var_0, 0.7);
      var_0 dodamage(1, self.origin, self.triggerportableradarping, self, "MOD_EXPLOSIVE", "super_trophy_mp");
      var_0 shellshock("super_trophy_mp", var_3);
      thread supertrophy_persempplayereffectsstun(var_0, var_3);
      var_2 = gettime() + 1000;
    }

    scripts\engine\utility::waitframe();
  }
}

supertrophy_persempplayereffectsstun(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 scripts\mp\weapons::func_F7FC();
  wait(var_1);
  var_0 scripts\mp\weapons::func_F800();
}

func_11282(var_0) {
  func_11269(var_0);
  var_1 = var_0 getentitynumber();
  func_11283(var_0);
  if(isDefined(self)) {
    func_11292(var_0, var_1);
  }
}

func_11283(var_0) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_1 = gettime();
  while(func_11295(var_0)) {
    if(gettime() >= var_1) {
      var_0 notify("emp_damage", self.triggerportableradarping, 2.25, self.origin, "super_trophy_mp", "MOD_EXPLOSIVE");
      var_1 = gettime() + 1000;
    }

    scripts\engine\utility::waitframe();
  }
}

func_11270() {
  var_0 = spawnStruct();
  var_0.triggerportableradarping = self.triggerportableradarping;
  var_0.var_12802 = self;
  var_0.id = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_0.id == -1) {
    return undefined;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_0.id, "active", self.origin, "icon_minimap_super_trophy_friendly");
  scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_0.id, self);
  var_0 thread supertrophy_monitorobjective();
  return var_0;
}

func_11275() {
  self notify("returnMinimapID");
  scripts\mp\objidpoolmanager::returnminimapid(self.id);
}

supertrophy_monitorobjective() {
  self.var_12802 endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("returnMinimapID");
  self notify("superTrophy_monitorObjective");
  self endon("superTrophy_monitorObjective");
  while(isDefined(self.triggerportableradarping) && isDefined(self.var_12802)) {
    if(scripts\mp\utility::istrue(self.firingstate)) {
      scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(self.id);
      if(self.firingstate == 1) {
        scripts\mp\objidpoolmanager::minimap_objective_icon(self.id, "icon_minimap_super_trophy_friendly_firing");
      }

      if(self.firingstate == 2) {
        scripts\mp\objidpoolmanager::minimap_objective_icon(self.id, "icon_minimap_super_trophy_friendly");
      }

      continue;
    }

    scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(self.id);
    scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.id, self.triggerportableradarping getentitynumber());
    scripts\mp\objidpoolmanager::minimap_objective_icon(self.id, "icon_minimap_super_trophy_friendly");
    foreach(var_1 in level.players) {
      if(var_1 scripts\mp\utility::_hasperk("specialty_engineer")) {
        scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.id, var_1 getentitynumber());
        continue;
      }

      if(level.teambased && var_1.team == self.triggerportableradarping.team) {
        scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.id, var_1 getentitynumber());
      }
    }

    scripts\engine\utility::waitframe();
  }
}

supertrophy_setobjectivefiring() {
  self notify("superTrophy_setObjectiveFiring");
  self endon("superTrophy_setObjectiveFiring");
  self.firingstate = 1;
  thread supertrophy_monitorobjective();
  wait(0.5);
  self.firingstate = 2;
  wait(0.25);
  self.firingstate = undefined;
}

func_11288(var_0, var_1, var_2) {
  if(!scripts\mp\utility::isreallyalive(var_0)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_0))) {
    return 0;
  }

  var_3 = physics_raycast(var_1, var_0.origin, var_2, [self, var_0], 0, "physicsquery_closest");
  if(isDefined(var_3) && var_3.size > 0) {
    var_3 = physics_raycast(var_1, var_0 getEye(), var_2, [self, var_0], 0, "physicsquery_closest");
    if(isDefined(var_3) && var_3.size > 0) {
      return 0;
    }
  }

  return 1;
}

func_11287(var_0) {
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_0.triggerportableradarping))) {
    return 0;
  }

  return 1;
}

func_11280(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) || var_2 != "super_trophy_mp") {
    return var_3;
  }

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return var_3;
  }

  if(var_0 != var_1) {
    return var_3;
  }

  return 0;
}

func_11286(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 1) {
    return 1;
  }

  return 0;
}

func_11269(var_0) {
  var_1 = var_0 getentitynumber();
  self.markeduioff[var_1] = var_0;
}

func_11292(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0 getentitynumber();
  }

  self.markeduioff[var_1] = undefined;
}

func_11295(var_0) {
  var_1 = var_0 getentitynumber();
  return isDefined(self.markeduioff[var_1]);
}

supertrophy_checkignorelist(var_0) {
  return !supertrophy_ignorelistoverrides(var_0) && scripts\mp\trophy_system::trophy_checkignorelist(var_0);
}

supertrophy_ignorelistoverrides(var_0) {
  if(isDefined(var_0.weapon_name)) {
    switch (var_0.weapon_name) {
      case "jackal_cannon_mp":
      case "shockproj_mp":
      case "switch_blade_child_mp":
      case "thorproj_tracking_mp":
      case "thorproj_zoomed_mp":
      case "drone_hive_projectile_mp":
        return 1;

      case "trophy_mp":
      case "domeshield_mp":
        if(scripts\mp\weapons::isplantedequipment(var_0)) {
          return 1;
        }

        break;
    }
  }

  return 0;
}

func_1128F() {
  return self.origin + anglestoup(self.angles) * 35;
}

func_1127E(var_0) {
  if(!isplayer(var_0) && !isagent(var_0)) {
    return 0;
  }

  if(scripts\mp\utility::func_9F22(var_0)) {
    return 0;
  }

  if(scripts\mp\utility::func_9F72(var_0)) {
    return 0;
  }

  return 1;
}

supertrophy_getbesttag(var_0) {
  var_1 = level.supertrophy.var_1141B;
  var_2 = undefined;
  var_3 = undefined;
  foreach(var_0A, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = self gettagangles(var_5);
    var_8 = anglesToForward(var_7);
    var_9 = vectordot(vectornormalize(var_0 - var_6), var_8);
    if(var_0A == 0 || var_9 > var_2) {
      var_2 = var_9;
      var_3 = var_5;
    }
  }

  return var_3;
}

supertrophy_getpartbytag(var_0) {
  var_1 = level.supertrophy.var_1141B;
  foreach(var_4, var_3 in var_1) {
    if(var_3 == var_0) {
      return "protect" + var_4 + 1;
    }
  }

  return undefined;
}

supertrophy_getmaxnum() {
  var_0 = 1;
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_0++;
  }

  return var_0;
}

supertrophy_onruggedequipmentunset() {
  self endon("disconnect");
  if(!isDefined(self.supertrophies) || self.supertrophies.size <= 0) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    self waittill("giveLoadout");
    if(!isDefined(self.supertrophies) || self.supertrophies.size <= 0) {
      return;
    }
  }

  var_0 = supertrophy_getmaxnum();
  var_1 = max(0, self.supertrophies.size - var_0);
  for(var_2 = 0; var_2 < var_1; var_2++) {
    self.supertrophies[0] thread func_11274();
  }
}

supertrophy_addtoarrays(var_0, var_1) {
  var_1.supertrophies[var_1.supertrophies.size] = var_0;
  level.supertrophy.trophies[var_0 getentitynumber()] = var_0;
}

supertrophy_removefromarrays(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.supertrophies)) {
    var_1.supertrophies = scripts\engine\utility::array_remove(var_1.supertrophies, var_0);
  }

  level.supertrophy.trophies[var_0 getentitynumber()] = undefined;
}

func_1126D() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  thread func_11274();
}

func_1126E() {
  self endon("death");
  level scripts\engine\utility::waittill_any_3("game_ended", "bro_shot_start");
  thread func_11274();
}

supertrophy_cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait(var_1);
  self delete();
}