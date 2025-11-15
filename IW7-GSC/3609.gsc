/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3609.gsc
************************/

func_1127D() {
  var_00 = spawnStruct();
  var_00.trophies = [];
  var_00.var_1141B = [];
  var_00.var_1141B[0] = "fx_01_jnt";
  var_00.var_1141B[1] = "fx_02_jnt";
  var_00.var_1141B[2] = "fx_03_jnt";
  var_00.var_1141B[3] = "fx_04_jnt";
  level.supertrophy = var_00;
}

func_11296(param_00) {
  var_01 = self.supertrophies;
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      var_03 thread func_11274();
    }

    self.supertrophies = undefined;
  }

  if(isDefined(self.var_11293)) {
    self.var_11293 = undefined;
    func_11276(param_00);
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

func_11276(param_00) {
  self notify("superTrophy_end");
  if(!scripts\mp\utility::istrue(param_00)) {
    scripts\mp\utility::func_11DB();
  }

  self setscriptablepartstate("killstreak", "neutral", 0);
  func_11273(param_00);
  var_01 = self.var_11293;
  self.var_11293 = undefined;
  return scripts\mp\utility::istrue(var_01);
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
  self _meth_854A();
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

func_11278(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, param_00)) {
    return 0;
  }

  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  var_05 = func_1127B(param_01, param_02, var_05);
  var_05 = supertrophy_handlesuperdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\supers::modifysuperequipmentdamage(param_00, param_01, param_02, var_05, param_04);
  return var_05;
}

func_11279(param_00, param_01, param_02, param_03, param_04) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
    param_00 thread scripts\mp\events::supershutdown(self.triggerportableradarping);
    param_00 notify("destroyed_equipment");
  }

  if(isDefined(param_00) && isplayer(param_00) && param_00 != self.triggerportableradarping) {
    param_00 scripts\mp\missions::func_D991("ch_killjoy_six_ability");
  }

  thread func_11274();
}

func_1127B(param_00, param_01, param_02) {
  if(param_01 == "MOD_MELEE") {
    return int(ceil(self.maxhealth / 2));
  }

  return param_02;
}

supertrophy_handlesuperdamage(param_00, param_01, param_02) {
  var_03 = 1;
  var_04 = getweaponbasename(param_00);
  if(isDefined(var_04)) {
    param_00 = var_04;
  }

  switch (param_00) {
    case "micro_turret_gun_mp":
      var_03 = 4;
      break;

    case "iw7_penetrationrail_mp":
      var_03 = 2.3;
      break;

    case "iw7_atomizer_mp":
      var_03 = 1.5;
      break;
  }

  return int(ceil(var_03 * param_02));
}

func_1129D() {
  self endon("disconnect");
  self endon("superTrophy_createTrophy");
  self endon("superTrophy_end");
  for(;;) {
    self waittill("equip_deploy_succeeded", var_00, var_01, var_02, var_03);
    if(var_00 == "deploy_supertrophy_mp") {
      thread func_11271(var_01, var_02, var_03);
      break;
    }
  }
}

func_1129B() {
  self endon("disconnect");
  self endon("superTrophy_createTrophy");
  self endon("superTrophy_end");
  for(;;) {
    self waittill("equip_deploy_failed", var_00, var_01, var_02, var_03);
    if(var_00 == "deploy_supertrophy_mp") {
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

func_11273(param_00) {
  if(!scripts\mp\utility::istrue(param_00)) {
    if(scripts\mp\utility::istrue(self.var_11277)) {
      scripts\engine\utility::allow_usability(1);
      scripts\mp\powers::func_D72F();
      scripts\mp\utility::func_1C47(1);
    }
  }

  self.var_11277 = undefined;
}

func_11271(param_00, param_01, param_02) {
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

  var_03 = spawn("script_model", param_00);
  var_03.angles = param_01;
  var_03 setotherent(self);
  var_03 setModel("super_trophy_mp_wm");
  var_03 give_player_tickets(1);
  var_03 _meth_8549();
  var_03 _meth_8594();
  var_03.triggerportableradarping = self;
  var_03.team = var_03.triggerportableradarping.team;
  var_03.super = "super_supertrophy";
  var_03.weapon_name = "super_trophy_mp";
  var_03.planted = 1;
  var_03.markeduioff = [];
  var_03.markeduion = [];
  var_03.var_1E2D = 10;
  supertrophy_addtoarrays(var_03, self);
  var_03 thread func_1126D();
  var_03 thread func_1126E();
  var_03.killcament = func_1126F(var_03);
  var_03.var_69DA = supertrophy_createexplosion(var_03);
  var_04 = scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  var_05 = scripts\engine\utility::ter_op(var_04, 475, 399);
  var_06 = scripts\engine\utility::ter_op(var_04, "hitequip", "");
  var_03 thread scripts\mp\damage::monitordamage(var_05, var_06, ::func_11279, ::func_11278, 0);
  if(isDefined(param_02)) {
    var_03 scripts\mp\weapons::explosivehandlemovers(param_02);
  }

  var_03 thread func_11299();
  self.var_11293 = undefined;
  scripts\mp\supers::func_DE3B(9999000);
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_trophy", undefined, 0.75);
  scripts\mp\utility::printgameaction("supertrophy placed", self);
}

func_1126F(param_00) {
  var_01 = spawn("script_model", param_00.origin + anglestoup(param_00.angles) * 65);
  var_01.angles = param_00.angles;
  var_01 setModel("tag_origin");
  var_01 setscriptmoverkillcam("explosive");
  var_01 linkto(param_00);
  var_01 thread supertrophy_cleanuponparentdeath(param_00, 5);
  return var_01;
}

supertrophy_createexplosion(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01.killcament = param_00.killcament;
  var_01.triggerportableradarping = param_00.triggerportableradarping;
  var_01.team = param_00.team;
  var_01.super = param_00.super;
  var_01.weapon_name = param_00.weapon_name;
  var_01 setotherent(var_01.triggerportableradarping);
  var_01 setentityowner(var_01.triggerportableradarping);
  var_01 setModel("super_trophy_mp_explode");
  var_01.timebypart = [];
  for(var_02 = 0; var_02 < 4; var_02++) {
    var_01.timebypart[var_02] = 0;
  }

  var_01 thread supertrophy_cleanuponparentdeath(param_00, 0.1);
  return var_01;
}

supertrophy_explode(param_00, param_01) {
  foreach(var_04, var_03 in self.timebypart) {
    if(gettime() - var_03 / 1000 > 0.1) {
      self dontinterpolate();
      self.origin = param_00;
      self.angles = param_01;
      self setscriptablepartstate("explode" + var_04 + 1, "active", 0);
      self.timebypart[var_04] = gettime();
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

  var_00 = scripts\mp\trophy_system::func_12804();
  for(;;) {
    var_01 = [];
    var_01[0] = level.grenades;
    var_01[1] = level.missiles;
    var_01[2] = level.mines;
    var_02 = scripts\engine\utility::array_combine_multiple(var_01);
    var_03 = func_1128F();
    foreach(var_05 in var_02) {
      if(!isDefined(var_05)) {
        continue;
      }

      if(scripts\mp\utility::istrue(var_05.exploding)) {
        continue;
      }

      if(supertrophy_checkignorelist(var_05)) {
        continue;
      }

      var_06 = var_05.triggerportableradarping;
      if(!isDefined(var_06) && isDefined(var_05.weapon_name) && weaponclass(var_05.weapon_name) == "grenade") {
        var_06 = getmissileowner(var_05);
      }

      if(isDefined(var_06) && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_06))) {
        continue;
      }

      if(distancesquared(var_05.origin, self.origin) > scripts\mp\trophy_system::trophy_modifiedprotectiondistsqr(var_05, 65536)) {
        continue;
      }

      var_07 = physics_raycast(var_03, var_05.origin, var_00, [self, var_05], 0, "physicsquery_closest");
      if(isDefined(var_07) && var_07.size > 0) {
        continue;
      }

      if(isDefined(self.objstruct)) {
        self.objstruct thread supertrophy_setobjectivefiring();
      }

      thread func_1128E(var_05);
      self.var_1E2D--;
      if(self.var_1E2D <= 0) {
        thread func_11274();
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_1128E(param_00) {
  level thread scripts\mp\battlechatter_mp::saytoself(self.triggerportableradarping, "plr_perk_trophy_block", undefined, 0.75);
  self.triggerportableradarping scripts\mp\killstreaks\_killstreaks::givescorefortrophyblocks();
  self.triggerportableradarping thread scripts\mp\events::superkill("super_supertrophy");
  self.triggerportableradarping scripts\mp\supers::combatrecordsuperkill("super_supertrophy");
  param_00 setCanDamage(0);
  param_00.exploding = 1;
  param_00 stopsounds();
  scripts\mp\trophy_system::func_12821(param_00);
  scripts\mp\trophy_system::func_12817(param_00, "super_trophy_mp", self.triggerportableradarping);
  var_01 = param_00.origin;
  var_02 = param_00.angles;
  if(scripts\mp\weapons::isplantedequipment(param_00)) {
    param_00 scripts\mp\weapons::deleteexplosive();
  } else if(param_00 scripts\mp\domeshield::isdomeshield()) {
    param_00 thread scripts\mp\domeshield::domeshield_delete();
  } else {
    param_00 delete();
  }

  var_03 = supertrophy_getbesttag(var_01);
  var_04 = supertrophy_getpartbytag(var_03);
  self setscriptablepartstate(var_04, "active", 0);
  self.var_69DA thread supertrophy_explode(var_01, var_02);
}

func_1129E() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_00 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_missileclip"]);
  for(;;) {
    var_01 = scripts\mp\utility::clearscrambler(self.origin, 256, undefined);
    foreach(var_03 in self.markeduioff) {
      if(!func_1127E(var_03)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_01, var_03)) {
        continue;
      }

      func_11292(var_03);
    }

    var_05 = func_1128F();
    foreach(var_07 in var_01) {
      if(!func_1127E(var_07)) {
        continue;
      }

      var_08 = func_11295(var_07);
      var_09 = func_11288(var_07, var_05, var_00);
      if(!var_08 && var_09) {
        thread func_11284(var_07);
        continue;
      }

      if(var_08 && !var_09) {
        func_11292(var_07);
      }
    }

    var_01 = scripts\mp\weapons::getempdamageents(self.origin, 256);
    foreach(var_03 in self.markeduioff) {
      if(func_1127E(var_03)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_01, var_03)) {
        continue;
      }

      func_11292(var_03);
    }

    foreach(var_07 in var_01) {
      if(func_1127E(var_07)) {
        continue;
      }

      var_08 = func_11295(var_07);
      var_09 = func_11287(var_07);
      if(!var_08 && var_09) {
        thread func_11282(var_07);
        continue;
      }

      if(var_08 && !var_09) {
        func_11292(var_07);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_11284(param_00) {
  func_11269(param_00);
  var_01 = param_00 getentitynumber();
  var_02 = spawnStruct();
  var_02.empd = 0;
  func_11285(param_00, var_02);
  if(isDefined(self)) {
    func_11292(param_00, var_01);
  }

  if(isDefined(param_00)) {
    if(isDefined(self) && isDefined(self.triggerportableradarping)) {
      scripts\mp\gamescore::untrackdebuffassist(self.triggerportableradarping, param_00, "super_trophy_mp");
    }

    if(var_02.empd) {
      param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
    }
  }
}

func_11285(param_00, param_01) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  param_00 endon("death");
  param_00 endon("disconnect");
  level endon("game_ended");
  var_02 = gettime();
  while(func_11295(param_00)) {
    if(!param_01.empd) {
      if(!param_00 scripts\mp\utility::_hasperk("specialty_empimmune")) {
        param_00 scripts\mp\killstreaks\_emp_common::func_20C3();
        scripts\mp\gamescore::func_11ACE(self.triggerportableradarping, param_00, "super_trophy_mp");
        param_01.empd = 1;
      }
    } else if(param_00 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
      scripts\mp\gamescore::untrackdebuffassist(self.triggerportableradarping, param_00, "super_trophy_mp");
      param_01.empd = 0;
    }

    if(gettime() >= var_02) {
      if(param_00 scripts\mp\utility::_hasperk("specialty_empimmune")) {
        self.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
      }

      var_03 = scripts\mp\perks\_perkfunctions::applystunresistence(self.triggerportableradarping, param_00, 0.7);
      param_00 dodamage(1, self.origin, self.triggerportableradarping, self, "MOD_EXPLOSIVE", "super_trophy_mp");
      param_00 shellshock("super_trophy_mp", var_03);
      thread supertrophy_persempplayereffectsstun(param_00, var_03);
      var_02 = gettime() + 1000;
    }

    scripts\engine\utility::waitframe();
  }
}

supertrophy_persempplayereffectsstun(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 scripts\mp\weapons::func_F7FC();
  wait(param_01);
  param_00 scripts\mp\weapons::func_F800();
}

func_11282(param_00) {
  func_11269(param_00);
  var_01 = param_00 getentitynumber();
  func_11283(param_00);
  if(isDefined(self)) {
    func_11292(param_00, var_01);
  }
}

func_11283(param_00) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  param_00 endon("death");
  level endon("game_ended");
  var_01 = gettime();
  while(func_11295(param_00)) {
    if(gettime() >= var_01) {
      param_00 notify("emp_damage", self.triggerportableradarping, 2.25, self.origin, "super_trophy_mp", "MOD_EXPLOSIVE");
      var_01 = gettime() + 1000;
    }

    scripts\engine\utility::waitframe();
  }
}

func_11270() {
  var_00 = spawnStruct();
  var_00.triggerportableradarping = self.triggerportableradarping;
  var_00.var_12802 = self;
  var_00.id = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_00.id == -1) {
    return undefined;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_00.id, "active", self.origin, "icon_minimap_super_trophy_friendly");
  scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_00.id, self);
  var_00 thread supertrophy_monitorobjective();
  return var_00;
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
    foreach(var_01 in level.players) {
      if(var_01 scripts\mp\utility::_hasperk("specialty_engineer")) {
        scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.id, var_01 getentitynumber());
        continue;
      }

      if(level.teambased && var_01.team == self.triggerportableradarping.team) {
        scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.id, var_01 getentitynumber());
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

func_11288(param_00, param_01, param_02) {
  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
    return 0;
  }

  var_03 = physics_raycast(param_01, param_00.origin, param_02, [self, param_00], 0, "physicsquery_closest");
  if(isDefined(var_03) && var_03.size > 0) {
    var_03 = physics_raycast(param_01, param_00 getEye(), param_02, [self, param_00], 0, "physicsquery_closest");
    if(isDefined(var_03) && var_03.size > 0) {
      return 0;
    }
  }

  return 1;
}

func_11287(param_00) {
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00.triggerportableradarping))) {
    return 0;
  }

  return 1;
}

func_11280(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02) || param_02 != "super_trophy_mp") {
    return param_03;
  }

  if(!isDefined(param_00) || !isDefined(param_01)) {
    return param_03;
  }

  if(param_00 != param_01) {
    return param_03;
  }

  return 0;
}

func_11286(param_00, param_01, param_02, param_03, param_04) {
  if(param_04 == 1) {
    return 1;
  }

  return 0;
}

func_11269(param_00) {
  var_01 = param_00 getentitynumber();
  self.markeduioff[var_01] = param_00;
}

func_11292(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = param_00 getentitynumber();
  }

  self.markeduioff[param_01] = undefined;
}

func_11295(param_00) {
  var_01 = param_00 getentitynumber();
  return isDefined(self.markeduioff[var_01]);
}

supertrophy_checkignorelist(param_00) {
  return !supertrophy_ignorelistoverrides(param_00) && scripts\mp\trophy_system::trophy_checkignorelist(param_00);
}

supertrophy_ignorelistoverrides(param_00) {
  if(isDefined(param_00.weapon_name)) {
    switch (param_00.weapon_name) {
      case "jackal_cannon_mp":
      case "shockproj_mp":
      case "switch_blade_child_mp":
      case "thorproj_tracking_mp":
      case "thorproj_zoomed_mp":
      case "drone_hive_projectile_mp":
        return 1;

      case "trophy_mp":
      case "domeshield_mp":
        if(scripts\mp\weapons::isplantedequipment(param_00)) {
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

func_1127E(param_00) {
  if(!isplayer(param_00) && !isagent(param_00)) {
    return 0;
  }

  if(scripts\mp\utility::func_9F22(param_00)) {
    return 0;
  }

  if(scripts\mp\utility::func_9F72(param_00)) {
    return 0;
  }

  return 1;
}

supertrophy_getbesttag(param_00) {
  var_01 = level.supertrophy.var_1141B;
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_0A, var_05 in var_01) {
    var_06 = self gettagorigin(var_05);
    var_07 = self gettagangles(var_05);
    var_08 = anglesToForward(var_07);
    var_09 = vectordot(vectornormalize(param_00 - var_06), var_08);
    if(var_0A == 0 || var_09 > var_02) {
      var_02 = var_09;
      var_03 = var_05;
    }
  }

  return var_03;
}

supertrophy_getpartbytag(param_00) {
  var_01 = level.supertrophy.var_1141B;
  foreach(var_04, var_03 in var_01) {
    if(var_03 == param_00) {
      return "protect" + var_04 + 1;
    }
  }

  return undefined;
}

supertrophy_getmaxnum() {
  var_00 = 1;
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_00++;
  }

  return var_00;
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

  var_00 = supertrophy_getmaxnum();
  var_01 = max(0, self.supertrophies.size - var_00);
  for(var_02 = 0; var_02 < var_01; var_02++) {
    self.supertrophies[0] thread func_11274();
  }
}

supertrophy_addtoarrays(param_00, param_01) {
  param_01.supertrophies[param_01.supertrophies.size] = param_00;
  level.supertrophy.trophies[param_00 getentitynumber()] = param_00;
}

supertrophy_removefromarrays(param_00, param_01) {
  if(isDefined(param_01) && isDefined(param_01.supertrophies)) {
    param_01.supertrophies = scripts\engine\utility::array_remove(param_01.supertrophies, param_00);
  }

  level.supertrophy.trophies[param_00 getentitynumber()] = undefined;
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

supertrophy_cleanuponparentdeath(param_00, param_01) {
  self endon("death");
  param_00 waittill("death");
  wait(param_01);
  self delete();
}