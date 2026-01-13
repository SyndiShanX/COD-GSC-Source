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
  var_0 = scripts\mp\trophy_system::func_12804();
  for(;;) {
    var_1 = func_D444();
    var_2 = [];
    var_2[0] = level.grenades;
    var_2[1] = level.missiles;
    var_2[2] = level.mines;
    var_3 = scripts\engine\utility::array_combine_multiple(var_2);
    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }

      if(scripts\mp\utility::istrue(var_5.exploding)) {
        continue;
      }

      if(playertrophy_checkignorelist(var_5)) {
        continue;
      }

      var_6 = var_5.triggerportableradarping;
      if(!isDefined(var_6) && isDefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "grenade") {
        var_6 = getmissileowner(var_5);
      }

      if(isDefined(var_6) && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self, var_5.triggerportableradarping))) {
        continue;
      }

      if(distancesquared(var_5.origin, var_1) > scripts\mp\trophy_system::trophy_modifiedprotectiondistsqr(var_5, 65536)) {
        continue;
      }

      var_7 = physics_raycast(var_1, var_5.origin, var_0, [self, var_5], 0, "physicsquery_closest");
      if(isDefined(var_7) && var_7.size > 0) {
        continue;
      }

      thread func_D445(var_5);
      thread func_D441();
    }

    scripts\engine\utility::waitframe();
  }
}

func_D445(var_0) {
  scripts\mp\missions::func_D991("ch_trait_personal_trophy");
  scripts\mp\killstreaks\_killstreaks::givescorefortrophyblocks();
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  scripts\mp\trophy_system::func_12821(var_0);
  scripts\mp\trophy_system::func_12817(var_0, "player_trophy_system_mp", self);
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  if(scripts\mp\weapons::isplantedequipment(var_0)) {
    var_0 scripts\mp\weapons::deleteexplosive();
  } else if(var_0 scripts\mp\domeshield::isdomeshield()) {
    var_0 thread scripts\mp\domeshield::domeshield_delete();
  } else {
    var_0 delete();
  }

  radiusdamage(var_1, 128, 70, 10, self, "MOD_EXPLOSIVE", "player_trophy_system_mp");
  thread playertrophy_protectionfx(var_1, var_2);
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
  var_0 = scripts\mp\utility::isinarbitraryup();
  var_1 = scripts\engine\utility::ter_op(var_0, self gettagorigin("tag_shield_back", 1, 1), self gettagorigin("tag_shield_back"));
  var_2 = scripts\engine\utility::ter_op(var_0, self getworldupreferenceangles(), self.angles);
  return var_1 + anglestoup(var_2) * 20;
}

playertrophy_checkignorelist(var_0) {
  var_1 = scripts\mp\trophy_system::trophy_checkignorelist(var_0);
  if(isDefined(var_0.weapon_name) && issubstr(var_0.weapon_name, "iw7_tacburst") || issubstr(var_0.weapon_name, "power_smoke_drone_mp")) {
    var_1 = 1;
  }

  if(!var_1 && isDefined(var_0.weapon_name)) {
    var_2 = scripts\mp\utility::getequipmenttype(var_0.weapon_name);
    if(isDefined(var_2) && var_2 != "lethal") {
      var_1 = 1;
    }
  }

  if(!var_1 && scripts\mp\weapons::isplantedequipment(var_0)) {
    var_1 = 1;
  }

  return var_1;
}

playertrophy_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || var_2 != "player_trophy_system_mp") {
    return var_4;
  }

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return var_4;
  }

  return scripts\engine\utility::ter_op(var_0 == var_1, 0, var_4);
}

playertrophy_protectionfx(var_0, var_1) {
  self playSound("trophy_detect_projectile");
  playFX(scripts\engine\utility::getfx("pts_detonate"), var_0, anglesToForward(var_1), anglestoup(var_1));
  playsoundatpos(var_0, "trophy_fire");
}