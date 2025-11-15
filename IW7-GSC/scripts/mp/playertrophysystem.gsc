/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\playertrophysystem.gsc
*********************************************/

func_D446() {
  self endon("death");
  self endon("disconnect");
  self endon("player_trophy_unset");
  if(!isDefined(level._effect["pts_detonate"])) {
    level._effect["pts_detonate"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp.vfx");
  }

  if(!isDefined(level._effect["pts_drone_drop"])) {
    level._effect["pts_drone_drop"] = loadfx("vfx\iw7\_requests\mp\vfx_pts_drone_drop.vfx");
  }

  for(;;) {
    func_D447();
    wait(40);
  }
}

func_D448() {
  self notify("player_trophy_unset");
  func_D441();
}

func_D447() {
  self endon("player_trophy_end");
  self notify("player_trophy_start");
  self endon("player_trophy_start");
  self setclientomnvar("ui_dodge_charges", 5);
  if(self.loadoutarchetype == "archetype_engineer") {
    self setscriptablepartstate("pts_drone", "active");
  }

  thread playertrophy_watchemp();
  thread playertrophy_watchownerdeath();
  func_D449();
}

func_D441() {
  self notify("player_trophy_end");
  self setclientomnvar("ui_dodge_charges", 0);
  if(self.loadoutarchetype == "archetype_engineer") {
    self setscriptablepartstate("pts_drone", "off");
  }
}

func_D449() {
  var_00 = scripts\mp\trophy_system::func_12804();
  for(;;) {
    var_01 = func_D444();
    var_02 = [];
    var_02[0] = level.grenades;
    var_02[1] = level.missiles;
    var_02[2] = level.mines;
    var_03 = scripts\engine\utility::array_combine_multiple(var_02);
    foreach(var_05 in var_03) {
      if(!isDefined(var_05)) {
        continue;
      }

      if(scripts\mp\utility::istrue(var_05.exploding)) {
        continue;
      }

      if(playertrophy_checkignorelist(var_05)) {
        continue;
      }

      var_06 = var_05.triggerportableradarping;
      if(!isDefined(var_06) && isDefined(var_05.weapon_name) && weaponclass(var_05.weapon_name) == "grenade") {
        var_06 = getmissileowner(var_05);
      }

      if(isDefined(var_06) && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self, var_05.triggerportableradarping))) {
        continue;
      }

      if(distancesquared(var_05.origin, var_01) > scripts\mp\trophy_system::trophy_modifiedprotectiondistsqr(var_05, 65536)) {
        continue;
      }

      var_07 = physics_raycast(var_01, var_05.origin, var_00, [self, var_05], 0, "physicsquery_closest");
      if(isDefined(var_07) && var_07.size > 0) {
        continue;
      }

      thread func_D445(var_05);
      thread func_D441();
    }

    scripts\engine\utility::waitframe();
  }
}

func_D445(param_00) {
  scripts\mp\missions::func_D991("ch_trait_personal_trophy");
  scripts\mp\killstreaks\_killstreaks::givescorefortrophyblocks();
  param_00 setCanDamage(0);
  param_00.exploding = 1;
  param_00 stopsounds();
  scripts\mp\trophy_system::func_12821(param_00);
  scripts\mp\trophy_system::func_12817(param_00, "player_trophy_system_mp", self);
  var_01 = param_00.origin;
  var_02 = param_00.angles;
  if(scripts\mp\weapons::isplantedequipment(param_00)) {
    param_00 scripts\mp\weapons::deleteexplosive();
  } else if(param_00 scripts\mp\domeshield::isdomeshield()) {
    param_00 thread scripts\mp\domeshield::domeshield_delete();
  } else {
    param_00 delete();
  }

  radiusdamage(var_01, 128, 70, 10, self, "MOD_EXPLOSIVE", "player_trophy_system_mp");
  thread playertrophy_protectionfx(var_01, var_02);
}

playertrophy_watchemp() {
  self endon("death");
  self endon("disconnect");
  self endon("player_trophy_end");
  while(!scripts\mp\killstreaks\_emp_common::isemped()) {
    scripts\engine\utility::waitframe();
  }

  thread func_D441();
}

playertrophy_watchownerdeath() {
  self endon("player_trophy_end");
  self waittill("death");
  playFX(scripts\engine\utility::getfx("pts_drone_drop"), self gettagorigin("tag_shield_back"));
  thread func_D441();
}

func_D444() {
  var_00 = scripts\mp\utility::isinarbitraryup();
  var_01 = scripts\engine\utility::ter_op(var_00, self gettagorigin("tag_shield_back", 1, 1), self gettagorigin("tag_shield_back"));
  var_02 = scripts\engine\utility::ter_op(var_00, self getworldupreferenceangles(), self.angles);
  return var_01 + anglestoup(var_02) * 20;
}

playertrophy_checkignorelist(param_00) {
  var_01 = scripts\mp\trophy_system::trophy_checkignorelist(param_00);
  if(isDefined(param_00.weapon_name) && issubstr(param_00.weapon_name, "iw7_tacburst") || issubstr(param_00.weapon_name, "power_smoke_drone_mp")) {
    var_01 = 1;
  }

  if(!var_01 && isDefined(param_00.weapon_name)) {
    var_02 = scripts\mp\utility::getequipmenttype(param_00.weapon_name);
    if(isDefined(var_02) && var_02 != "lethal") {
      var_01 = 1;
    }
  }

  if(!var_01 && scripts\mp\weapons::isplantedequipment(param_00)) {
    var_01 = 1;
  }

  return var_01;
}

playertrophy_modifieddamage(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_02) || param_02 != "player_trophy_system_mp") {
    return param_04;
  }

  if(!isDefined(param_00) || !isDefined(param_01)) {
    return param_04;
  }

  return scripts\engine\utility::ter_op(param_00 == param_01, 0, param_04);
}

playertrophy_protectionfx(param_00, param_01) {
  self playSound("trophy_detect_projectile");
  playFX(scripts\engine\utility::getfx("pts_detonate"), param_00, anglesToForward(param_01), anglestoup(param_01));
  playsoundatpos(param_00, "trophy_fire");
}