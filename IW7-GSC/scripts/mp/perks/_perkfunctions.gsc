/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\perks\_perkfunctions.gsc
***********************************************/

setoverridearchetype() {}

unsetoverridearchetype() {}

setempimmune() {}

unsetempimmune() {}

setautospot() {
  if(!isplayer(self)) {
    return;
  }

  autospotadswatcher();
  autospotdeathwatcher();
}

autospotdeathwatcher() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  self getomnvarvalue();
}

unsetautospot() {
  if(!isplayer(self)) {
    return;
  }

  self notify("endAutoSpotAdsWatcher");
  self getomnvarvalue();
}

autospotadswatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    wait(0.05);
    if(self isusingturret()) {
      self getomnvarvalue();
      continue;
    }

    var_01 = self getweaponrankinfominxp();
    if(var_01 < 1 && var_00) {
      var_00 = 0;
      self getomnvarvalue();
    }

    if(var_01 < 1 && !var_00) {
      continue;
    }

    if(var_01 == 1 && !var_00) {
      var_00 = 1;
      self getoneshoteffectdelaydefault();
    }
  }
}

setregenfaster() {
  self.trait = "specialty_regenfaster";
}

unsetregenfaster() {
  self.trait = undefined;
}

timeoutregenfaster() {
  self.hasregenfaster = undefined;
  scripts\mp\utility::removeperk("specialty_regenfaster");
  self setclientdvar("ui_regen_faster_end_milliseconds", 0);
  self notify("timeOutRegenFaster");
}

sethardshell() {
  self.shellshockreduction = 0.25;
}

unsethardshell() {
  self.shellshockreduction = 0;
}

setsharpfocus() {
  thread monitorsharpfocus();
}

monitorsharpfocus() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_monitorSharpFocus");
  for(;;) {
    updatesharpfocus();
    self waittill("weapon_change");
  }
}

updatesharpfocus() {
  var_00 = self getcurrentweapon();
  var_01 = undefined;
  if(level.tactical) {
    if(weaponclass(var_00) == "sniper") {
      var_01 = 0.85;
    } else {
      var_01 = 0.5;
    }
  } else if(weaponclass(var_00) == "sniper") {
    var_01 = 0.85;
  } else {
    var_01 = 0.25;
  }

  scripts\mp\weapons::updateviewkickscale(var_01);
}

unsetsharpfocus() {
  self notify("stop_monitorSharpFocus");
  scripts\mp\weapons::updateviewkickscale(1);
}

setviewkickoverride() {
  self.overrideviewkickscale = 0.2;
  self.overrideviewkickscalesniper = 0.425;
  scripts\mp\weapons::updateviewkickscale();
}

unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.overrideviewkickscalesniper = undefined;
  scripts\mp\weapons::updateviewkickscale();
}

setaffinityspeedboost() {
  self.weaponaffinityspeedboost = 0.08;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetaffinityspeedboost() {
  self.weaponaffinityspeedboost = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

setaffinityextralauncher() {
  self.weaponaffinityextralauncher = 1;
  var_00 = scripts\mp\class::buildweaponname(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid);
  var_01 = scripts\mp\class::buildweaponname(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.var_AEA5);
  if(scripts\mp\utility::getweapongroup(var_00) == "weapon_projectile") {
    self setweaponammoclip(var_00, weaponclipsize(var_00));
  }

  if(scripts\mp\utility::getweapongroup(var_01) == "weapon_projectile") {
    self setweaponammoclip(var_01, weaponclipsize(var_01));
  }
}

unsetaffinityextralauncher() {
  self.weaponaffinityextralauncher = undefined;
}

setdoubleload() {
  self endon("death");
  self endon("disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");
  for(;;) {
    self waittill("reload");
    var_00 = self getweaponslist("primary");
    foreach(var_02 in var_00) {
      var_03 = self getweaponammoclip(var_02);
      var_04 = weaponclipsize(var_02);
      var_05 = var_04 - var_03;
      var_06 = self getweaponammostock(var_02);
      if(var_03 != var_04 && var_06 > 0) {
        if(var_03 + var_06 >= var_04) {
          self setweaponammoclip(var_02, var_04);
          self setweaponammostock(var_02, var_06 - var_05);
          continue;
        }

        self setweaponammoclip(var_02, var_03 + var_06);
        if(var_06 - var_05 > 0) {
          self setweaponammostock(var_02, var_06 - var_05);
          continue;
        }

        self setweaponammostock(var_02, 0);
      }
    }
  }
}

unsetdoubleload() {
  self notify("endDoubleLoad");
}

setmarksman(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 10;
  } else {
    param_00 = int(param_00) * 2;
  }

  scripts\mp\utility::setrecoilscale(param_00);
  self.recoilscale = param_00;
}

unsetmarksman() {
  scripts\mp\utility::setrecoilscale(0);
  self.recoilscale = 0;
}

setfastcrouch() {
  thread watchfastcrouch();
}

watchfastcrouch() {
  self endon("death");
  self endon("disconnect");
  self endon("fastcrouch_unset");
  for(;;) {
    var_00 = self getstance() == "crouch" && !self issprintsliding();
    if(!isDefined(self.fastcrouchspeedmod)) {
      if(var_00) {
        self.fastcrouchspeedmod = 0.3;
        scripts\mp\weapons::updatemovespeedscale();
      }
    } else if(!var_00) {
      self.fastcrouchspeedmod = undefined;
      scripts\mp\weapons::updatemovespeedscale();
    }

    scripts\engine\utility::waitframe();
  }
}

unsetfastcrouch() {
  self notify("fastcrouch_unset");
  if(isDefined(self.fastcrouchspeedmod)) {
    self.fastcrouchspeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

setrshieldradar() {
  self endon("unsetRShieldRadar");
  wait(0.75);
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

setrshieldradar_cleanup() {
  self endon("unsetRShieldRadar");
  scripts\engine\utility::waittill_any_3("disconnect", "death");
  if(isDefined(self)) {
    func_12D1D();
  }
}

func_12D1D() {
  self getplayermodelname();
  self notify("unsetRShieldRadar");
}

setrshieldscrambler() {
  self makescrambler();
  thread setrshieldscrambler_cleanup();
}

setrshieldscrambler_cleanup() {
  self endon("unsetRShieldScrambler");
  scripts\engine\utility::waittill_any_3("disconnect", "death");
  if(isDefined(self)) {
    unsetrshieldscrambler();
  }
}

unsetrshieldscrambler() {
  self clearscrambler();
  self notify("unsetRShieldScrambler");
}

setstunresistance(param_00) {
  scripts\mp\utility::giveperk("specialty_hard_shell");
  if(!isDefined(param_00)) {
    param_00 = 10;
  }

  param_00 = int(param_00);
  if(param_00 == 10) {
    self.stunscalar = 0;
    return;
  }

  self.stunscalar = param_00 / 10;
}

unsetstunresistance() {
  self.stunscalar = 1;
}

applystunresistence(param_00, param_01, param_02) {
  if(param_01 scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
    if(isDefined(param_01.stunscalar) && isDefined(param_02)) {
      param_02 = param_02 * param_01.stunscalar;
    }

    var_03 = scripts\engine\utility::ter_op(isDefined(param_00.triggerportableradarping), param_00.triggerportableradarping, param_00);
    var_04 = scripts\engine\utility::ter_op(isDefined(param_01.triggerportableradarping), param_01.triggerportableradarping, param_01);
    if(isplayer(var_03) && var_03 != param_01) {
      param_00 scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }

    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_03, var_04))) {
      param_01 scripts\mp\missions::resistedstun(var_03);
    }
  }

  return param_02;
}

setweaponlaser() {
  if(isagent(self)) {
    return;
  }

  self endon("unsetWeaponLaser");
  wait(0.5);
  thread setweaponlaser_internal();
}

unsetweaponlaser() {
  self notify("unsetWeaponLaser");
  if(isDefined(self.perkweaponlaseron) && self.perkweaponlaseron) {
    scripts\mp\utility::disableweaponlaser();
  }

  self.perkweaponlaseron = undefined;
  self.perkweaponlaseroffforswitchstart = undefined;
}

setweaponlaser_waitforlaserweapon(param_00) {
  for(;;) {
    param_00 = getweaponbasename(param_00);
    if(isDefined(param_00) && param_00 == "iw6_kac_mp" || param_00 == "iw6_arx160_mp") {
      break;
    }

    self waittill("weapon_change", param_00);
  }
}

setweaponlaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var_00 = self getcurrentweapon();
  for(;;) {
    setweaponlaser_waitforlaserweapon(var_00);
    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      scripts\mp\utility::enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change", var_00);
    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      scripts\mp\utility::disableweaponlaser();
    }
  }
}

setweaponlaser_monitorweaponswitchstart(param_00) {
  self endon("weapon_change");
  for(;;) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(param_00);
  }
}

setweaponlaser_onweaponswitchstart(param_00) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");
  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    scripts\mp\utility::disableweaponlaser();
  }

  wait(param_00);
  self.perkweaponlaseroffforswitchstart = undefined;
  if(self.perkweaponlaseron == 0 && self getweaponrankinfominxp() <= 0.6) {
    self.perkweaponlaseron = 1;
    scripts\mp\utility::enableweaponlaser();
  }
}

setweaponlaser_monitorads() {
  self endon("weapon_change");
  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self getweaponrankinfominxp() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          scripts\mp\utility::disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        scripts\mp\utility::enableweaponlaser();
      }
    }

    scripts\engine\utility::waitframe();
  }
}

setsteadyaimpro() {
  self setaimspreadmovementscale(0.5);
}

unsetsteadyaimpro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1);
}

blastshieldusetracker(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("end_perkUseTracker");
  level endon("game_ended");
  for(;;) {
    self waittill("empty_offhand");
    if(!scripts\engine\utility::isoffhandweaponsallowed()) {
      continue;
    }

    self[[param_01]](scripts\mp\utility::_hasperk("specialty_blastshield"));
  }
}

perkusedeathtracker() {
  self endon("disconnect");
  self waittill("death");
  self._useperkenabled = undefined;
}

setendgame() {
  if(isDefined(self.endgame)) {
    return;
  }

  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth") * 4;
  self.health = self.maxhealth;
  self.endgame = 1;
  self.attackertable[0] = "";
  self visionsetnakedforplayer("end_game", 5);
  thread endgamedeath(7);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

unsetendgame() {
  self notify("stopEndGame");
  self.endgame = undefined;
  scripts\mp\utility::restorebasevisionset(1);
  if(!isDefined(self.endgametimer)) {
    return;
  }

  self.endgametimer scripts\mp\hud_util::destroyelem();
  self.endgameicon scripts\mp\hud_util::destroyelem();
}

endgamedeath(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait(param_00 + 1);
  scripts\mp\utility::_suicide();
}

setsaboteur() {
  self.objectivescaler = 1.2;
}

unsetsaboteur() {
  self.objectivescaler = 1;
}

setcombatspeed() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetCombatSpeed");
  self.incombatspeed = 0;
  unsetcombatspeedscalar();
  for(;;) {
    self waittill("damage", var_00, var_01);
    if(!isDefined(var_01.team)) {
      continue;
    }

    if(level.teambased && var_01.team == self.team) {
      continue;
    }

    if(self.incombatspeed) {
      continue;
    }

    setcombatspeedscalar();
    self.incombatspeed = 1;
    thread func_636C();
  }
}

func_636C() {
  self notify("endOfSpeedWatcher");
  self endon("endOfSpeedWatcher");
  self endon("death");
  self endon("disconnect");
  self waittill("healed");
  unsetcombatspeedscalar();
  self.incombatspeed = 0;
}

setcombatspeedscalar() {
  if(isDefined(self.isjuggernaut) && self.isjuggernaut) {
    return;
  }

  if(self.weaponspeed <= 0.8) {
    self.combatspeedscalar = 1.4;
  } else if(self.weaponspeed <= 0.9) {
    self.combatspeedscalar = 1.3;
  } else {
    self.combatspeedscalar = 1.2;
  }

  scripts\mp\weapons::updatemovespeedscale();
}

unsetcombatspeedscalar() {
  self.combatspeedscalar = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetcombatspeed() {
  unsetcombatspeedscalar();
  self notify("unsetCombatSpeed");
}

setlightweight() {
  if(!isDefined(self.cranked)) {
    self.movespeedscaler = scripts\mp\utility::lightweightscalar();
    scripts\mp\weapons::updatemovespeedscale();
  }
}

unsetlightweight() {
  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

setblackbox() {
  self.killstreakscaler = 1.5;
}

unsetblackbox() {
  self.killstreakscaler = 1;
}

setsteelnerves() {
  scripts\mp\utility::giveperk("specialty_bulletaccuracy");
  scripts\mp\utility::giveperk("specialty_holdbreath");
}

unsetsteelnerves() {
  scripts\mp\utility::removeperk("specialty_bulletaccuracy");
  scripts\mp\utility::removeperk("specialty_holdbreath");
}

setdelaymine() {}

unsetdelaymine() {}

setlocaljammer() {
  if(!scripts\mp\killstreaks\_emp_common::isemped()) {
    self makescrambler();
  }
}

unsetlocaljammer() {
  self clearscrambler();
}

setthermal() {
  self thermalvisionon();
}

unsetthermal() {
  self thermalvisionoff();
}

setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

unsetonemanarmy() {
  self notify("stop_oneManArmyTracker");
}

onemanarmyweaponchangetracker() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");
  for(;;) {
    self waittill("weapon_change", var_00);
    if(var_00 != "onemanarmy_mp") {
      continue;
    }

    thread selectonemanarmyclass();
  }
}

isonemanarmymenu(param_00) {
  if(param_00 == game["menu_onemanarmy"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && param_00 == game["menu_onemanarmy_defaults_splitscreen"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && param_00 == game["menu_onemanarmy_custom_splitscreen"]) {
    return 1;
  }

  return 0;
}

selectonemanarmyclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_usability(0);
  thread closeomamenuondeath();
  self waittill("menuresponse", var_00, var_01);
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);
  if(var_01 == "back" || !isonemanarmymenu(var_00) || scripts\mp\utility::isusingremote()) {
    if(self getcurrentweapon() == "onemanarmy_mp") {
      scripts\engine\utility::allow_weapon_switch(0);
      scripts\engine\utility::allow_offhand_weapons(0);
      scripts\engine\utility::allow_usability(0);
      scripts\mp\utility::_switchtoweapon(scripts\engine\utility::getlastweapon());
      self waittill("weapon_change");
      scripts\engine\utility::allow_weapon_switch(1);
      scripts\engine\utility::allow_offhand_weapons(1);
      scripts\engine\utility::allow_usability(1);
    }

    return;
  }

  thread giveonemanarmyclass(var_01);
}

closeomamenuondeath() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);
}

giveonemanarmyclass(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(scripts\mp\utility::_hasperk("specialty_omaquickchange")) {
    var_01 = 3;
    scripts\mp\utility::playplayerandnpcsounds(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    var_01 = 6;
    scripts\mp\utility::playplayerandnpcsounds(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
  }

  thread omausebar(var_01);
  scripts\engine\utility::allow_weapon(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_usability(0);
  wait(var_01);
  scripts\engine\utility::allow_weapon(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);
  self.var_C47E = 1;
  scripts\mp\class::giveloadout(self.pers["team"], param_00);
  if(isDefined(self.carryflag)) {
    self attach(self.carryflag, "J_spine4", 1);
  }

  self notify("changed_kit");
  level notify("changed_kit");
}

omausebar(param_00) {
  self endon("disconnect");
  var_01 = scripts\mp\hud_util::createprimaryprogressbar();
  var_02 = scripts\mp\hud_util::createprimaryprogressbartext();
  var_02 settext(&"MPUI_CHANGING_KIT");
  var_01 scripts\mp\hud_util::updatebar(0, 1 / param_00);
  var_03 = 0;
  while(var_03 < param_00 && isalive(self) && !level.gameended) {
    wait(0.05);
    var_03 = var_03 + 0.05;
  }

  var_01 scripts\mp\hud_util::destroyelem();
  var_02 scripts\mp\hud_util::destroyelem();
}

setafterburner() {
  self.trait = "specialty_afterburner";
  self goalflag(0, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 600, 650));
  self goal_type(0, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 900, 900));
}

unsetafterburner() {
  self.trait = undefined;
  self goalflag(0, 400);
  self goal_type(0, 900);
}

setblastshield() {
  self setweaponhudiconoverride("primaryoffhand", "icon_perks_blast_shield");
}

unsetblastshield() {
  self setweaponhudiconoverride("primaryoffhand", "none");
}

setfreefall() {}

unsetfreefall() {}

settacticalinsertion() {
  var_00 = "secondary";
  var_01 = scripts\mp\powers::getcurrentequipment(var_00);
  if(isDefined(var_01)) {
    scripts\mp\powers::removepower(var_01);
  }

  scripts\mp\powers::givepower("power_tacInsert", var_00, 0);
  thread func_BA34();
}

unsettacticalinsertion() {
  self notify("end_monitorTIUse");
}

func_41D2() {
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  if(isDefined(self.setspawnpoint)) {
    deleteti(self.setspawnpoint);
  }
}

func_12F47() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");
  while(scripts\mp\utility::isreallyalive(self)) {
    if(func_9FE9()) {
      self.var_11947 = self.origin;
    }

    wait(0.05);
  }
}

func_9FE9() {
  if(canspawn(self.origin) && self isonground() && !scripts\mp\utility::func_11A44()) {
    return 1;
  }

  return 0;
}

func_11899(param_00) {
  if(scripts\mp\utility::isreallyalive(param_00.triggerportableradarping)) {
    param_00.triggerportableradarping deleteti(self);
  }
}

func_BA34() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");
  thread func_12F47();
  thread func_41D2();
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 != "flare_mp") {
      continue;
    }

    if(isDefined(self.setspawnpoint)) {
      deleteti(self.setspawnpoint);
    }

    if(!isDefined(self.var_11947)) {
      continue;
    }

    if(scripts\mp\utility::touchingbadtrigger()) {
      continue;
    }

    var_02 = self.var_11947 + (0, 0, 16);
    var_03 = self.var_11947 - (0, 0, 2048);
    var_04 = playerphysicstrace(var_02, var_03) + (0, 0, 1);
    var_05 = [];
    var_05[0] = self;
    var_06 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
    var_07 = scripts\common\trace::ray_trace(var_02, var_03, var_05, var_06, 0);
    var_08 = spawn("script_model", var_04);
    var_08.angles = self.angles;
    var_08.team = self.team;
    var_08.triggerportableradarping = self;
    var_08.enemytrigger = spawn("script_origin", var_04);
    var_08 thread _meth_83EC(self);
    var_08.playerspawnpos = self.var_11947;
    var_08 setotherent(self);
    var_08 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
    var_08 scripts\mp\weapons::explosivehandlemovers(var_07["entity"]);
    scripts\mp\weapons::ontacticalequipmentplanted(var_08);
    self.setspawnpoint = var_08;
  }
}

_meth_83EC(param_00) {
  self setModel(level.var_108D3["enemy"]);
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 20));
  } else {
    scripts\mp\entityheadicons::setplayerheadicon(param_00, (0, 0, 20));
  }

  thread _meth_83E8(param_00);
  thread _meth_83E9(param_00);
  thread _meth_83EE(param_00);
  thread _meth_83EF(param_00);
  var_01 = spawn("script_model", self.origin);
  var_01.angles = self.angles;
  var_01 setModel(level.var_108D3["friendly"]);
  var_01 setcontents(0);
  var_01 linkto(self);
  var_01 playLoopSound("tactical_insert_lp");
  thread _meth_83ED(self, var_01, param_00);
  self waittill("death");
  var_01 stoploopsound();
  var_01 delete();
}

_meth_83ED(param_00, param_01, param_02) {
  param_00 endon("death");
  wait(0.05);
  var_03 = [];
  var_03["enemy"] = param_00;
  var_03["friendly"] = param_01;
  for(;;) {
    foreach(var_05 in var_03) {
      var_05 hide();
    }

    foreach(var_08 in level.players) {
      var_09 = "friendly";
      if(param_02 scripts\mp\utility::isenemy(var_08)) {
        var_09 = "enemy";
      }

      var_05 = var_03[var_09];
      var_05 show();
      scripts\engine\utility::waitframe();
      playfxontagforclients(level.var_108D2[var_09], var_05, "tag_fx", var_08);
    }

    level waittill("joined_team");
    foreach(var_09, var_05 in var_03) {
      stopFXOnTag(level.var_108D2[var_09], var_05, "tag_fx");
    }

    scripts\engine\utility::waitframe();
  }
}

deleteondeath(param_00) {
  self waittill("death");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

_meth_83E8(param_00) {
  scripts\mp\damage::monitordamage(100, "tactical_insertion", ::_meth_83EB, ::_meth_83EA, 1);
}

_meth_83EB(param_00, param_01, param_02, param_03, param_04) {
  return scripts\mp\damage::handlemeleedamage(param_01, param_02);
}

_meth_83EA(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 notify("destroyed_insertion", self.triggerportableradarping);
    param_00 notify("destroyed_equipment");
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }

  param_00 thread deleteti(self);
}

_meth_83EE(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_PATCH_PICKUP_TI");
  thread func_12E8B(param_00);
  for(;;) {
    self waittill("trigger", var_01);
    var_01 playSound("tactical_insert_flare_pu");
    if(!var_01 scripts\mp\utility::isjuggernaut()) {
      var_01 thread settacticalinsertion();
    }

    var_01 thread deleteti(self);
  }
}

func_12E8B(param_00) {
  self endon("death");
  for(;;) {
    scripts\mp\utility::setselfusable(param_00);
    level scripts\engine\utility::waittill_either("joined_team", "player_spawned");
  }
}

_meth_83EF(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  thread deleteti(self);
}

deleteti(param_00) {
  if(isDefined(param_00.enemytrigger)) {
    param_00.enemytrigger delete();
  }

  var_01 = param_00.origin;
  var_02 = param_00.angles;
  var_03 = param_00 getlinkedparent();
  param_00 delete();
  var_04 = spawn("script_model", var_01);
  var_04.angles = var_02;
  var_04 setModel(level.var_108D3["friendly"]);
  var_04 setcontents(0);
  if(isDefined(var_03)) {
    var_04 linkto(var_03);
  }

  thread func_5F2B(var_04);
}

func_5F2B(param_00) {
  wait(1);
  stopFXOnTag(level.var_108D2["friendly"], param_00, "tag_fx");
  stopFXOnTag(level.var_108D2["enemy"], param_00, "tag_fx");
  param_00 delete();
}

_meth_83E9(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  self.enemytrigger setcursorhint("HINT_NOICON");
  self.enemytrigger sethintstring(&"MP_PATCH_DESTROY_TI");
  self.enemytrigger scripts\mp\utility::makeenemyusable(param_00);
  for(;;) {
    self.enemytrigger waittill("trigger", var_01);
    var_01 notify("destroyed_insertion", param_00);
    var_01 notify("destroyed_equipment");
    if(isDefined(param_00) && var_01 != param_00) {
      param_00 thread scripts\mp\utility::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
    }

    var_01 thread deleteti(self);
  }
}

setpainted(param_00) {
  if(isplayer(self)) {
    var_01 = 0.5;
    if(!scripts\mp\utility::_hasperk("specialty_engineer") && !scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
      self.painted = 1;
      var_02 = scripts\mp\utility::outlineenableforplayer(self, "orange", param_00, 0, 0, "perk");
      thread watchpainted(var_02, var_01);
      thread watchpaintedagain(var_02);
    }
  }
}

watchpainted(param_00, param_01) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(param_01, "death");
  self.painted = 0;
  scripts\mp\utility::outlinedisable(param_00, self);
  self notify("painted_end");
}

watchpaintedagain(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("painted_again", "painted_end");
  scripts\mp\utility::outlinedisable(param_00, self);
}

ispainted() {
  return isDefined(self.painted) && self.painted;
}

setassists() {}

unsetassists() {}

setrefillgrenades() {
  if(isDefined(self.primarygrenade)) {
    self givemaxammo(self.primarygrenade);
  }

  if(isDefined(self.secondarygrenade)) {
    self givemaxammo(self.secondarygrenade);
  }
}

unsetrefillgrenades() {}

setrefillammo() {
  if(isDefined(self.primaryweapon)) {
    self givemaxammo(self.primaryweapon);
  }

  if(isDefined(self.secondaryweapon)) {
    self givemaxammo(self.secondaryweapon);
  }
}

unsetrefillammo() {}

func_F737() {
  thread func_F738();
}

func_F738() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("unsetGunsmith");
  self waittill("giveLoadout");
  if(self.loadoutprimaryattachments.size == 0 && self.loadoutsecondaryattachments.size == 0) {
    return;
  }

  for(;;) {
    self waittill("weapon_change", var_00);
    if(var_00 == "none") {
      continue;
    }

    if(scripts\mp\utility::iskillstreakweapon(var_00)) {
      continue;
    }

    if(!scripts\mp\utility::isstrstart(var_00, "iw6_") && !scripts\mp\utility::isstrstart(var_00, "iw7_")) {
      continue;
    }

    var_01 = undefined;
    if(scripts\mp\utility::getweapongroup(var_00) == "weapon_pistol") {
      if(self.loadoutsecondaryattachments.size > 0) {
        var_01 = self.loadoutsecondaryattachments;
      }
    } else if(self.loadoutprimaryattachments.size > 0) {
      var_01 = self.loadoutprimaryattachments;
    }

    if(!isDefined(var_01)) {
      continue;
    }

    var_02 = 0;
    var_03 = scripts\mp\utility::getweaponattachmentsbasenames(var_00);
    if(var_03.size == 0) {
      var_02 = 1;
    } else {
      foreach(var_05 in var_01) {
        if(!scripts\engine\utility::array_contains(var_03, var_05)) {
          var_02 = 1;
          break;
        }
      }
    }

    if(!var_02) {
      continue;
    }

    var_07 = [];
    var_08 = scripts\mp\utility::getweaponattachmentarrayfromstats(var_00);
    foreach(var_05 in var_01) {
      if(scripts\engine\utility::array_contains(var_08, var_05)) {
        var_07[var_07.size] = var_05;
      }
    }

    var_01 = var_07;
    var_0B = [];
    foreach(var_0D in var_03) {
      var_0E = 1;
      foreach(var_10 in var_01) {
        if(!scripts\mp\utility::attachmentscompatible(var_10, var_0D)) {
          var_0E = 0;
          break;
        }
      }

      if(var_0E) {
        var_0B[var_0B.size] = var_0D;
      }
    }

    var_03 = var_0B;
    var_13 = var_01.size + var_03.size;
    if(var_13 > 4) {
      var_03 = scripts\engine\utility::array_randomize(var_03);
    }

    for(var_14 = 0; var_01.size < 4 && var_14 < var_03.size; var_14++) {
      var_01[var_01.size] = var_03[var_14];
    }

    var_15 = getweaponbasename(var_00);
    var_16 = var_15;
    foreach(var_14, var_05 in var_01) {
      var_18 = scripts\mp\utility::attachmentmap_tounique(var_05, var_00);
      var_01[var_14] = var_18;
    }

    var_01 = scripts\engine\utility::alphabetize(var_01);
    foreach(var_05 in var_01) {
      var_16 = var_16 + "_" + var_05;
    }

    if(var_16 != var_15) {
      var_1B = self getweaponammoclip(var_00);
      var_1C = self getweaponammostock(var_00);
      scripts\mp\utility::_takeweapon(var_00);
      self giveweapon(var_16);
      self setweaponammoclip(var_16, var_1B);
      self setweaponammostock(var_16, var_1C);
      scripts\mp\utility::_switchtoweapon(var_16);
    }
  }
}

func_12CCB() {
  self notify("unsetGunsmith");
}

func_F71F() {
  self setclientomnvar("ui_gambler_show", -1);
  func_F720();
}

func_F720() {}

func_765A() {
  if(!isai(self)) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", self.class_num, "abilitiesPicked", scripts\mp\utility::func_7D91(6, 0));
  } else {
    var_00 = [];
    if(isDefined(self.pers["loadoutPerks"])) {
      var_00 = scripts\engine\utility::array_combine(var_00, self.pers["loadoutPerks"]);
    }

    foreach(var_02 in var_00) {
      if(scripts\mp\utility::getbaseperkname(var_02) == "specialty_gambler") {
        return 1;
      }
    }
  }

  return 0;
}

givefriendlyperks(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("unsetGambler");
  level endon("game_ended");
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    scripts\mp\utility::gameflagwait("prematch_done");
  } else if(scripts\mp\utility::gameflag("prematch_done") && self.streaktype != "specialist") {
    self waittill("giveLoadout");
  }

  if(!isDefined(self.var_1519)) {
    self.var_1519 = 0;
  }

  if(!self.var_1519) {
    var_01 = getrandom_spammodel(param_00);
    self.var_7658 = var_01;
  } else {
    var_01 = self.var_7658;
  }

  scripts\mp\utility::giveperk(var_01.id);
  if(var_01.id == "specialty_hardline") {
    scripts\mp\killstreaks\_killstreaks::func_F866();
  }

  if(func_1012B()) {
    self playlocalsound("mp_suitcase_pickup");
    self setclientomnvar("ui_gambler_show", var_01.var_E76D);
    thread func_7659();
  }

  if(level.gametype != "infect") {
    self.var_1519 = 1;
  }
}

func_1012B() {
  var_00 = 1;
  if(!level.ingraceperiod && self.var_1519) {
    var_00 = 0;
  }

  if(!scripts\mp\utility::allowclasschoice() && level.gametype != "infect") {
    var_00 = 0;
  }

  return var_00;
}

func_7659() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetGambler");
  level endon("game_ended");
  self waittill("luinotifyserver", var_00, var_01);
  if(var_00 == "gambler_anim_complete") {
    self setclientomnvar("ui_gambler_show", -1);
  }
}

getrandom_spammodel(param_00) {
  var_01 = [];
  var_01 = thread sortbyweight(param_00);
  var_01 = thread setbucketval(var_01);
  var_02 = randomint(level.var_151A["sum"]);
  var_03 = undefined;
  foreach(var_05 in var_01) {
    if(!var_05.weight || var_05.id == "specialty_gambler") {
      continue;
    }

    if(var_05.weight > var_02) {
      var_03 = var_05;
      break;
    }
  }

  return var_03;
}

sortbyweight(param_00) {
  var_01 = [];
  var_02 = [];
  for(var_03 = 1; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03].weight;
    var_01 = param_00[var_03];
    for(var_05 = var_03 - 1; var_05 >= 0 && is_weight_a_less_than_b(param_00[var_05].weight, var_04); var_05--) {
      var_02 = param_00[var_05];
      param_00[var_05] = var_01;
      param_00[var_05 + 1] = var_02;
    }
  }

  return param_00;
}

is_weight_a_less_than_b(param_00, param_01) {
  return param_00 < param_01;
}

setbucketval(param_00) {
  level.var_151A["sum"] = 0;
  foreach(var_02 in param_00) {
    if(!var_02.weight) {
      continue;
    }

    level.var_151A["sum"] = level.var_151A["sum"] + var_02.weight;
    var_02.weight = level.var_151A["sum"];
  }

  return param_00;
}

func_12CC5() {
  self notify("unsetGambler");
}

setcomexp() {}

unsetcomexp() {}

settagger() {
  thread settaggerinternal();
}

settaggerinternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetTagger");
  level endon("game_ended");
  for(;;) {
    self waittill("eyesOn");
    var_00 = self _meth_8156();
    foreach(var_02 in var_00) {
      if(level.teambased && var_02.team == self.team) {
        continue;
      }

      if(isalive(var_02) && var_02.sessionstate == "playing") {
        if(!isDefined(var_02.perkoutlined)) {
          var_02.perkoutlined = 0;
        }

        if(!var_02.perkoutlined) {
          var_02.perkoutlined = 1;
        }

        var_02 thread outlinewatcher(self);
      }
    }
  }
}

outlinewatcher(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("eyesOff");
  level endon("game_ended");
  for(;;) {
    var_01 = 1;
    var_02 = param_00 _meth_8156();
    foreach(var_04 in var_02) {
      if(var_04 == self) {
        var_01 = 0;
        break;
      }
    }

    if(var_01) {
      self.perkoutlined = 0;
      self notify("eyesOff");
    }

    wait(0.5);
  }
}

unsettagger() {
  self notify("unsetTagger");
}

setpitcher() {
  thread setpitcherinternal();
}

setpitcherinternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");
  scripts\mp\utility::giveperk("specialty_throwback");
  self setgrenadecookscale(1.5);
  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("grenade_pullback", var_00);
    if(var_00 == "airdrop_marker_mp" || var_00 == "killstreak_uplink_mp" || var_00 == "deployable_vest_marker_mp" || var_00 == "deployable_weapon_crate_marker_mp" || var_00 == "airdrop_juggernaut_mp") {
      self setgrenadethrowscale(1);
    }

    self waittill("grenade_fire", var_01, var_02);
  }
}

func_12D0C() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  scripts\mp\utility::removeperk("specialty_throwback");
  self notify("unsetPitcher");
}

setboom() {
  self.trait = "specialty_boom";
}

setboominternal(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("disconnect");
  scripts\engine\utility::waitframe();
  triggerportableradarping(self.origin, param_00, 800, 1500);
  param_00 boomtrackplayers(self.origin, self);
}

boomtrackplayers(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(param_01 == var_03) {
      continue;
    }

    if(scripts\mp\utility::isenemy(var_03) && isalive(var_03) && !var_03 scripts\mp\utility::_hasperk("specialty_gpsjammer") && distancesquared(param_00, var_03.origin) <= 490000) {
      scripts\mp\missions::func_D991("ch_trait_ping");
    }
  }
}

boomtrackplayerdeath(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("removearchetype");
  var_02 = scripts\engine\utility::waittill_any_timeout_1(7, "death");
  if(var_02 == "timeout" && isDefined(self.markedbyboomperk[param_01])) {
    self.markedbyboomperk[param_01] = undefined;
    return;
  }

  self waittill("spawned_player");
  self.markedbyboomperk = undefined;
}

unsetboom() {
  self.trait = undefined;
  self notify("unsetBoom");
}

customjuiced(param_00) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.1;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility::giveperk("specialty_fastreload");
  scripts\mp\utility::giveperk("specialty_quickdraw");
  scripts\mp\utility::giveperk("specialty_stalker");
  scripts\mp\utility::giveperk("specialty_fastoffhand");
  scripts\mp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility::giveperk("specialty_quickswap");
  thread unsetcustomjuicedondeath();
  thread unsetcustomjuicedonride();
  thread unsetcustomjuicedonmatchend();
  var_01 = param_00 * 1000 + gettime();
  if(!isai(self)) {
    self setclientomnvar("ui_juiced_end_milliseconds", var_01);
  }

  wait(param_00);
  unsetcustomjuiced();
}

unsetcustomjuiced(param_00) {
  if(!isDefined(param_00)) {
    if(scripts\mp\utility::isjuggernaut()) {
      if(isDefined(self.var_A4AA)) {
        self.movespeedscaler = self.var_A4AA;
      } else {
        self.movespeedscaler = 0.7;
      }
    } else {
      self.movespeedscaler = 1;
      if(scripts\mp\utility::_hasperk("specialty_lightweight")) {
        self.movespeedscaler = scripts\mp\utility::lightweightscalar();
      }
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility::removeperk("specialty_fastreload");
  scripts\mp\utility::removeperk("specialty_quickdraw");
  scripts\mp\utility::removeperk("specialty_stalker");
  scripts\mp\utility::removeperk("specialty_fastoffhand");
  scripts\mp\utility::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility::removeperk("specialty_quickswap");
  self.isjuiced = undefined;
  if(!isai(self)) {
    self setclientomnvar("ui_juiced_end_milliseconds", 0);
  }

  self notify("unset_custom_juiced");
}

unsetcustomjuicedonride() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  for(;;) {
    wait(0.05);
    if(scripts\mp\utility::isusingremote()) {
      thread unsetcustomjuiced();
      break;
    }
  }
}

unsetcustomjuicedondeath() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  scripts\engine\utility::waittill_any_3("death", "faux_spawn");
  thread unsetcustomjuiced(1);
}

unsetcustomjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  thread unsetcustomjuiced();
}

settriggerhappy() {}

settriggerhappyinternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");
  var_00 = self.lastdroppableweaponobj;
  var_01 = self getweaponammostock(var_00);
  var_02 = self getweaponammoclip(var_00);
  self givestartammo(var_00);
  var_03 = self getweaponammoclip(var_00);
  var_04 = var_03 - var_02;
  var_05 = var_01 - var_04;
  if(var_04 > var_01) {
    self setweaponammoclip(var_00, var_02 + var_01);
    var_05 = 0;
  }

  self setweaponammostock(var_00, var_05);
  self playlocalsound("ammo_crate_use");
  self setclientomnvar("ui_trigger_happy", 1);
  wait(0.2);
  self setclientomnvar("ui_trigger_happy", 0);
}

unsettriggerhappy() {
  self setclientomnvar("ui_trigger_happy", 0);
  self notify("unsetTriggerHappy");
}

setincog() {}

unsetincog() {}

setblindeye() {}

unsetblindeye() {}

setquickswap() {}

unsetquickswap() {}

setextraammo() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_extraammo");
  level endon("game_ended");
  if(self.gettingloadout) {
    self waittill("giveLoadout");
  }

  var_00 = scripts\mp\utility::getvalidextraammoweapons();
  foreach(var_02 in var_00) {
    if(isDefined(var_02) && var_02 != "none") {
      self givemaxammo(var_02);
    }
  }
}

unsetextraammo() {
  self notify("unset_extraammo");
}

setextraequipment() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_extraequipment");
  level endon("game_ended");
  if(self.gettingloadout) {
    self waittill("giveLoadout");
  }

  var_00 = self.loadoutperkoffhand;
  if(isDefined(var_00) && var_00 != "specialty_null") {
    if(var_00 != "specialty_tacticalinsertion" && var_00 != "smoke_grenade_mp" && var_00 != "player_trophy_system_mp" && var_00 != "shoulder_cannon_mp") {
      self setweaponammoclip(var_00, 2);
    }
  }
}

unsetextraequipment() {
  self notify("unset_extraequipment");
}

setextradeadly() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_extradeadly");
  level endon("game_ended");
}

unsetextradeadly() {
  self notify("unset_extradeadly");
}

func_10D79(param_00) {
  if(isDefined(param_00) && param_00 != self) {
    var_01 = self getweaponslistoffhands();
    var_02 = 1;
    var_03 = 0;
    foreach(var_05 in var_01) {
      if(var_05 != "throwingknife_mp") {
        var_03 = self getweaponammoclip(var_05);
        var_02 = var_02 + var_03;
      }
    }

    var_07 = 1;
    var_08 = spawn("script_origin", self.origin);
    var_08.triggerportableradarping = param_00;
    if(!isDefined(var_08.team)) {
      var_08.team = param_00.team;
    }

    var_08.clusterticks = var_02;
    var_08 thread scripts\mp\weapons::func_42D8(var_07);
    var_08 notify("explode", var_08.origin);
    var_08 delete();
  }
}

setbattleslide() {
  scripts\mp\archetypes\archcommon::_allowbattleslide(1);
  scripts\mp\equipment\battle_slide::func_28F2();
}

unsetbattleslide() {
  scripts\mp\archetypes\archcommon::_allowbattleslide(0);
  scripts\mp\equipment\battle_slide::func_28F6();
}

setoverkill() {}

unsetoverkill() {}

setactivereload() {
  scripts\mp\perks\perk_activereload::func_1664();
}

unsetactivereload() {
  scripts\mp\perks\perk_activereload::func_1667();
}

setlifepack() {
  if(!isDefined(level._effect["life_pack_pickup"])) {
    level._effect["life_pack_pickup"] = loadfx("vfx\iw7\_requests\mp\vfx_health_pickup");
  }

  thread watchlifepackkills();
}

watchlifepackkills() {
  self endon("death");
  self endon("disconnect");
  self notify("unset_lifepack");
  self endon("unset_lifepack");
  for(;;) {
    self waittill("got_a_kill", var_00, var_01, var_02);
    var_03 = self.origin;
    var_04 = 20;
    var_05 = 20;
    var_06 = spawn("script_model", self.origin + (0, 0, 10));
    var_06 setModel("weapon_life_pack");
    var_06.triggerportableradarping = self;
    var_06.team = self.team;
    var_06 hidefromplayer(self);
    var_07 = spawn("trigger_radius", self.origin, 0, var_04, var_05);
    var_07 thread watchlifepackuse(var_06);
    var_07 thread watchlifepackdeath(var_06);
    var_06 thread hoverlifepack();
    var_06 rotateyaw(1000, 30, 0.2, 0.2);
    var_06 thread watchlifepacklifetime(10, var_07);
    var_06 thread watchlifepackowner();
    foreach(var_09 in level.players) {
      var_06 setlifepackvisualforplayer(var_09);
    }
  }
}

activatelifepackboost(param_00, param_01, param_02) {
  self.lifeboostactive = 1;
  if(isDefined(param_01) && param_01 > 0) {
    thread watchlifepackboostlifetime(param_01);
  }

  if(isDefined(param_02) && param_02) {
    thread watchlifepackuserdeath();
  }

  scripts\mp\utility::giveperk("specialty_regenfaster");
  self setclientomnvar("ui_life_link", 1);
  self notify("enabled_life_pack_boost");
  self.lifepackowner = param_00;
  scripts\mp\gamescore::trackbuffassist(param_00, self, "medic_lifepack");
}

watchlifepackboostlifetime(param_00) {
  self endon("death");
  self endon("disconnect");
  wait(param_00);
  if(isDefined(self.lifeboostactive)) {
    disablelifepackboost();
  }
}

disablelifepackboost() {
  if(isDefined(self) && isDefined(self.lifeboostactive)) {
    self.lifeboostactive = undefined;
    self setclientomnvar("ui_life_link", 0);
    self notify("disabled_life_pack_boost");
    scripts\mp\utility::removeperk("specialty_regenfaster");
    scripts\mp\gamescore::untrackbuffassist(self.lifepackowner, self, "medic_lifepack");
    self.lifepackowner = undefined;
  }
}

setlifepackvisualforplayer(param_00) {
  if(level.teambased && param_00.team == self.team && param_00 != self.triggerportableradarping) {
    setlifepackoutlinestate(param_00);
    self showtoplayer(param_00);
    thread watchlifepackoutlinestate(param_00);
    return;
  }

  self hidefromplayer(param_00);
}

setlifepackoutlinestate(param_00) {
  if(isDefined(param_00.lifeboostactive)) {
    if(isDefined(param_00.lifepackoutlines) && param_00.lifepackoutlines.size > 0) {
      foreach(var_02 in param_00.lifepackoutlines) {
        if(self == var_02.pack) {
          scripts\mp\utility::outlinedisable(var_02.id, var_02.pack);
          param_00.lifepackoutlines = scripts\engine\utility::array_remove(param_00.lifepackoutlines, var_02);
          var_02 = undefined;
        }
      }

      return;
    }

    return;
  }

  if(!isDefined(var_03.lifepackoutlines)) {
    var_03.lifepackoutlines = [];
  }

  var_04 = spawnStruct();
  var_04.id = scripts\mp\utility::outlineenableforplayer(self, "cyan", var_03, 1, 0, "equipment");
  var_04.pack = self;
  var_03.lifepackoutlines = scripts\engine\utility::array_add_safe(var_03.lifepackoutlines, var_04);
}

watchlifepackoutlinestate(param_00) {
  self endon("death");
  for(;;) {
    param_00 scripts\engine\utility::waittill_any_3("enabled_life_pack_boost", "disabled_life_pack_boost");
    setlifepackoutlinestate(param_00);
  }
}

hoverlifepack() {
  self endon("death");
  self endon("phase_resource_pickup");
  var_00 = self.origin;
  for(;;) {
    self moveto(var_00 + (0, 0, 15), 1, 0.2, 0.2);
    wait(1);
    self moveto(var_00, 1, 0.2, 0.2);
    wait(1);
  }
}

watchlifepackuse(param_00) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_01);
    if(!isplayer(var_01)) {
      continue;
    }

    if(var_01.team != param_00.team) {
      continue;
    }

    if(isDefined(var_01.lifeboostactive)) {
      continue;
    }

    if(var_01 == param_00.triggerportableradarping) {
      continue;
    }

    var_01 activatelifepackboost(param_00.triggerportableradarping, 5, 1);
    var_01 playlocalsound("scavenger_pack_pickup");
    var_02 = spawnfx(scripts\engine\utility::getfx("life_pack_pickup"), self.origin);
    triggerfx(var_02);
    var_02 thread scripts\mp\utility::delayentdelete(2);
    foreach(var_04 in level.players) {
      if(var_04.team == var_01.team) {
        continue;
      }

      var_02 hidefromplayer(var_04);
    }

    param_00 delete();
  }
}

watchlifepackdeath(param_00) {
  self endon("death");
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

watchlifepacklifetime(param_00, param_01) {
  self endon("death");
  wait(param_00);
  param_01 delete();
  self delete();
}

watchlifepackowner() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}

watchlifepackuserdeath() {
  self endon("disconnect");
  self waittill("death");
  disablelifepackboost();
}

unsetlifepack() {
  disablelifepackboost();
  self notify("unset_lifepack");
}

settoughenup() {
  if(!isDefined(level._effect["toughen_up_screen"])) {
    level._effect["toughen_up_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_toughen_up_scrn");
  }

  thread watchtoughenup();
}

watchtoughenup() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetToughenUp");
  level endon("game_ended");
  var_00 = 0;
  var_01 = 15;
  var_02 = 7.5;
  var_03 = 4;
  var_04 = 5;
  var_05 = 2;
  var_06 = [];
  var_06 = scripts\engine\utility::array_add_safe(var_06, (35, 0, 10));
  var_06 = scripts\engine\utility::array_add_safe(var_06, (0, 35, 10));
  var_06 = scripts\engine\utility::array_add_safe(var_06, (-35, 0, 10));
  var_06 = scripts\engine\utility::array_add_safe(var_06, (0, -35, 10));
  self waittill("spawned_player");
  for(;;) {
    self waittill("got_a_kill", var_07, var_08, var_09);
    if(!isDefined(self.toughenedup)) {
      self.toughenedup = 1;
      var_0A = spawnfxforclient(scripts\engine\utility::getfx("toughen_up_screen"), self getEye(), self);
      triggerfx(var_0A);
      thread attachtoughenuparmor("j_forehead", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_ri", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_spineupper", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_shield_back", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_ri", level.bulletstormshield["section"].friendlymodel);
      if(var_05 == 1) {
        scripts\mp\utility::func_F741(var_01);
        thread watchtoughenuplifetime(var_04);
      } else {
        scripts\mp\lightarmor::setlightarmorvalue(self, 100);
        thread watchtoughenuplightarmorend();
      }

      var_0A thread watchtoughenupplayerend(self);
      continue;
    }

    if(var_05 == 1) {
      self notify("toughen_up_reset");
      thread watchtoughenuplifetime(var_04);
    }
  }
}

attachtoughenuparmor(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self gettagorigin(param_00);
  var_06 = spawn("script_model", var_05);
  var_06 setModel(param_01);
  var_07 = (0, 0, 0);
  var_08 = (0, 0, 0);
  if(isDefined(param_02)) {
    var_07 = param_02;
  }

  if(isDefined(param_03)) {
    var_08 = param_03;
  }

  var_06.angles = self.angles;
  var_06 linkto(self, param_00, var_07, var_08);
  var_06 thread watchtoughenupplayerend(self);
  var_06 thread watchtoughenupgameend();
  return var_06;
}

settoughenupmodel(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", self.origin + (0, 0, 50));
  var_04.team = self.triggerportableradarping.team;
  if(param_03 == "friendly") {
    var_04 setModel(level.bulletstormshield["section"].friendlymodel);
  } else {
    var_04 setModel(level.bulletstormshield["section"].enemymodel);
  }

  var_04 linkto(self, "tag_origin", param_01, (0, 90 * param_02 + 1, 0));
  var_04 hide();
  var_04 thread watchtoughenupplayerend(self.triggerportableradarping);
  var_04 thread watchtoughenupgameend();
  var_04 thread settoughenupvisiblestate(param_03, self.triggerportableradarping);
}

watchtoughenuplightarmorend() {
  self endon("disconnect");
  self waittill("remove_light_armor");
}

watchtoughenupplayerend(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect", "toughen_up_end");
  param_00.toughenedup = undefined;
  if(param_00 scripts\mp\lightarmor::haslightarmor(param_00)) {
    param_00 unsetlightarmor();
  }

  if(isDefined(self)) {
    self delete();
  }
}

watchtoughenupgameend() {
  self endon("death");
  level waittill("game_ended");
  if(isDefined(self)) {
    self delete();
  }
}

watchtoughenuplifetime(param_00) {
  self endon("death");
  self endon("toughen_up_reset");
  while(param_00 > 0) {
    param_00 = param_00 - 1;
    wait(1);
  }

  self notify("toughen_up_end");
}

settoughenupvisiblestate(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == param_01) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_03)) {
      if(canshowtoughenupshield(var_03, param_00)) {
        self showtoplayer(var_03);
      }
    }

    thread watchtoughenupplayerbegin(var_03, param_00);
    thread watchtoughenupplayer(var_03, param_00);
  }
}

watchtoughenupplayerbegin(param_00, param_01) {
  param_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    param_00 waittill("spawned_player");
    self hidefromplayer(param_00);
    if(canshowtoughenupshield(param_00, param_01)) {
      self showtoplayer(param_00);
    }

    thread watchtoughenupplayer(param_00, param_01);
  }
}

canshowtoughenupshield(param_00, param_01) {
  var_02 = 0;
  if((param_01 == "friendly" && param_00.team == self.team) || param_01 == "enemy" && param_00.team != self.team) {
    var_02 = 1;
  }

  return var_02;
}

watchtoughenupplayer(param_00, param_01) {}

unsettoughenup() {
  scripts\mp\utility::clearhealthshield();
  unsetlightarmor();
  self notify("unsetToughenUp");
}

setscoutping() {
  thread scripts\mp\archetypes\archscout::func_13B32();
  thread updatescoutping();
}

updatescoutping() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetScoutPing");
  var_00 = 50;
  var_01 = 1200;
  for(;;) {
    var_02 = var_00;
    var_03 = var_01;
    if(isDefined(self.scoutpingradius)) {
      var_02 = self.scoutpingradius;
    }

    if(isDefined(self.scoutsweeptime)) {
      var_03 = self.scoutsweeptime;
    }

    var_02 = int(var_02);
    var_03 = int(var_03);
    if(var_02 != var_00) {
      triggerportableradarpingteam(self.origin, self.team, var_02, var_03);
    }

    wait(var_01 / 1200);
  }
}

updatescoutpingvalues(param_00) {
  var_01 = 0;
  var_02 = 150;
  var_03 = 3000;
  if(isDefined(self.scoutpingmod)) {
    var_01 = self.scoutpingmod;
  }

  if(isDefined(self.scoutpingpreviousstage)) {
    if(param_00 > self.scoutpingpreviousstage) {
      var_04 = param_00 - self.scoutpingpreviousstage;
      var_01 = var_01 + var_04 / 10;
    } else if(param_00 < self.scoutpingpreviousstage) {
      var_04 = self.scoutpingpreviousstage - param_00;
      var_01 = var_01 - var_04 / 10;
    }
  }

  if(isDefined(self.scoutpingmod)) {
    if(var_01 > self.scoutpingmod || var_01 < self.scoutpingmod) {
      var_02 = var_02 + var_02 * var_01 * 1.5;
      var_03 = var_03 - var_03 * var_01 / 1.5;
      self.scoutpingradius = var_02;
      self.scoutsweeptime = var_03;
    }
  }

  if(param_00 == 0) {
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
  }

  self.scoutpingmod = var_01;
  self.scoutpingpreviousstage = param_00;
}

unsetscoutping() {
  self.scoutpingradius = undefined;
  self.scoutsweeptime = undefined;
  self.scoutpingmod = undefined;
  self.scoutpingpreviousstage = undefined;
  self notify("unsetScoutPing");
  thread scripts\mp\archetypes\archscout::func_3886();
}

setphasespeed() {
  thread func_139D8();
}

unsetcritchance() {}

func_3E41() {
  self endon("disconnect");
  self waittill("spawned_player");
  thread func_139D8();
}

func_139D8() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  for(;;) {
    self waittill("got_a_kill", var_00, var_01, var_02);
    var_03 = var_00 _meth_8113();
    var_04 = "primary";
    var_05 = "none";
    var_06 = getarraykeys(var_00.powers);
    foreach(var_08 in var_06) {
      if(var_00.powers[var_08].slot == var_04) {
        var_05 = var_08;
      }
    }

    if(var_05 == "none") {
      continue;
    }

    var_0A = 20;
    var_0B = 20;
    var_0C = spawn("script_model", var_03.origin + (0, 0, 10));
    var_0C.triggerportableradarping = self;
    var_0C.team = self.team;
    var_0D = spawn("trigger_radius", var_03.origin, 0, var_0A, var_0B);
    var_0D thread func_139D9(var_0C);
    var_0C thread func_139DA(30, var_0D);
    var_0C thread func_139DB();
    var_0C func_B29E(var_05);
  }
}

updatetriggerposition() {
  self endon("death");
  for(;;) {
    if(isDefined(self)) {
      self.origin = self.origin;
      if(isDefined(self.bombsquadmodel)) {
        self.bombsquadmodel.origin = self.origin;
      }
    } else {
      return;
    }

    wait(0.05);
  }
}

func_4650(param_00, param_01, param_02) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  switch (param_02) {
    case "power_c4":
      self.trigger sethintstring(&"MP_PICKUP_C4");
      break;

    case "power_biospike":
      self.trigger sethintstring(&"MP_PICKUP_BIOSPIKE");
      break;

    case "power_bouncingBetty":
      self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
      break;

    case "power_semtex":
      self.trigger sethintstring(&"MP_PICKUP_SEMTEX");
      break;

    case "power_smokeGrenade":
      self.trigger sethintstring(&"MP_PICKUP_SMOKE_GRENADE");
      break;

    case "power_domeshield":
      self.trigger sethintstring(&"MP_PICKUP_DOME_SHIELD");
      break;

    case "power_shardBall":
      self.trigger sethintstring(&"MP_PICKUP_SHARD_BALL");
      break;

    case "power_splashGrenade":
      self.trigger sethintstring(&"MP_PICKUP_SPLASH_GRENADE");
      break;

    case "power_clusterGrenade":
      self.trigger sethintstring(&"MP_PICKUP_CLUSTER_GRENADE");
      break;

    case "power_smokeWall":
      self.trigger sethintstring(&"MP_PICKUP_SMOKE_WALL");
      break;

    case "power_empGrenade":
      self.trigger sethintstring(&"MP_PICKUP_EMP_GRENADE");
      break;

    case "power_blackholeGrenade":
      self.trigger sethintstring(&"MP_PICKUP_BLACKHOLE_GRENADE");
      break;

    case "power_blinkKnife":
      self.trigger sethintstring(&"MP_PICKUP_TELEPORT_KNIFE");
      break;

    case "power_throwingReap":
      self.trigger sethintstring(&"MP_PICKUP_THROWING_REAP");
      break;

    case "power_thermobaric":
      self.trigger sethintstring(&"MP_PICKUP_THERMOBARIC");
      break;

    case "power_playerTrophySystem":
      self.trigger sethintstring(&"MP_PICKUP_PLAYER_TROPHY");
      break;

    case "power_discMarker":
      self.trigger sethintstring(&"MP_PICKUP_DISC_MARKER");
      break;

    case "power_caseBomb":
      self.trigger sethintstring(&"MP_PICKUP_CASE_BOMB");
      break;

    case "power_transponder":
      self.trigger sethintstring(&"MP_PICKUP_TRANSPONDER");
      break;

    case "power_gasGrenade":
      self.trigger sethintstring(&"MP_PICKUP_GAS_GRENADE");
      break;

    case "power_blackoutGrenade":
      self.trigger sethintstring(&"MP_PICKUP_BLACKOUT_GRENADE");
      break;

    case "power_copycatGrenade":
      self.trigger sethintstring(&"MP_PICKUP_COPYCAT_GRENADE");
      break;

    case "power_arcGrenade":
      self.trigger sethintstring(&"MP_PICKUP_ARC_MINE");
      break;
  }

  self.trigger makeusable();
  foreach(var_04 in level.players) {
    if(var_04 == param_00) {
      self.trigger enableplayeruse(var_04);
      continue;
    }

    self.trigger disableplayeruse(var_04);
  }

  self.trigger thread scripts\mp\utility::notusableforjoiningplayers(param_00);
  if(isDefined(param_01) && param_01) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", param_00);
    param_00 playlocalsound("scavenger_pack_pickup");
    var_06 = param_02;
    var_07 = "primary";
    param_00 notify("start_copycat");
    param_00 notify("corpse_steal");
    var_08 = "none";
    var_09 = getarraykeys(param_00.powers);
    foreach(var_0B in var_09) {
      if(param_00.powers[var_0B].slot == var_07) {
        var_08 = var_0B;
      }
    }

    param_00 scripts\mp\powers::removepower(var_08);
    param_00 scripts\mp\powers::givepower(var_06, var_07, 1);
    param_00 thread scripts\mp\weapons::func_139D7(var_06, var_07);
    self.trigger delete();
    self delete();
    self notify("death");
  }
}

func_B29E(param_00) {
  if(scripts\mp\utility::isreallyalive(self.triggerportableradarping)) {
    self setotherent(self.triggerportableradarping);
    self.trigger = spawn("script_origin", self.origin, 0, 1, 1);
    self.trigger.triggerportableradarping = self;
    thread func_4650(self.triggerportableradarping, 1, param_00);
  }
}

func_139D9(param_00) {
  self endon("death");
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_139DA(param_00, param_01) {
  self endon("death");
  wait(param_00);
  self.trigger delete();
  param_01 delete();
  self delete();
}

func_139DB() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}

setphasespeed() {
  thread watchphasespeedshift();
  thread watchphasespeedendshift();
}

watchphasespeedshift() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("phase_shift_start");
    self.phasespeedmod = 0.2;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

watchphasespeedendshift() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("phase_shift_completed");
    self.phasespeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

unsetphasespeed() {
  self.phasespeedmod = undefined;
}

setdodge() {
  self.trait = "specialty_dodge";
  self allowdodge(1);
  if(scripts\mp\utility::isanymlgmatch()) {
    self _meth_8454(6);
  } else {
    self _meth_8454(3);
  }

  scripts\mp\perks\perk_dodgedefense::func_139F9();
}

unsetdodge() {
  self.trait = undefined;
  self allowdodge(0);
}

setextradodge() {
  self energy_setmax(1, 100);
  self goal_radius(1, 100);
}

unsetextradodge() {
  self energy_setmax(1, 50);
  self goal_radius(1, 50);
}

setsixthsense() {
  self.trait = "specialty_sixth_sense";
  updatesixthsensevfx(0, 0);
  thread func_10225();
}

unsetsixthsense() {
  self.trait = undefined;
  self.var_10224 = undefined;
  self notify("removeSixthSense");
  updatesixthsensevfx(0, 0);
}

func_F6E9() {}

func_12CAD() {}

func_10225() {
  self endon("death");
  self endon("disconnect");
  self endon("removeSixthSense");
  self endon("round_switch");
  thread watchdeathsixthsense();
  for(;;) {
    var_00 = 0;
    var_01 = level.players;
    var_02 = 0;
    var_03 = scripts\mp\utility::_hasperk("specialty_enhanced_sixth_sense");
    if(!scripts\mp\killstreaks\_emp_common::isemped()) {
      foreach(var_05 in var_01) {
        if(!isDefined(var_05) || !scripts\mp\utility::isreallyalive(var_05)) {
          continue;
        }

        if(var_05.team == self.team) {
          continue;
        }

        if(var_05 scripts\mp\utility::_hasperk("specialty_coldblooded")) {
          continue;
        }

        if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_05)) {
          continue;
        }

        var_06 = self.origin - var_05.origin;
        var_07 = anglesToForward(var_05 getplayerangles());
        var_08 = vectordot(var_06, var_07);
        if(var_08 <= 0) {
          continue;
        }

        var_09 = vectornormalize(var_06);
        var_0A = vectornormalize(var_07);
        var_08 = vectordot(var_09, var_0A);
        if(var_08 < 0.9659258) {
          continue;
        }

        var_00++;
        var_0B = var_05 getEye();
        var_0C = self getEye();
        if(bullettracepassed(var_0B, var_0C, 0, self)) {
          thread watchperceptionchallengedeath();
          thread watchperceptionchallengeprogress();
          var_02 = var_02 | getsixthsensedirection(var_05);
          thread markassixthsensesource(var_05);
          continue;
        }

        if(var_00 >= 3) {
          scripts\engine\utility::waitframe();
          var_00 = 0;
        }
      }
    }

    if(var_02 > 4) {
      var_02 = 255;
    } else {
      var_02 = 0;
    }

    updatesixthsensevfx(var_02, var_03);
    scripts\engine\utility::waitframe();
  }
}

watchperceptionchallengedeath() {
  self endon("disconnect");
  if(scripts\mp\utility::istrue(self.startperceptionchallengewatch)) {
    return;
  }

  scripts\engine\utility::waittill_any_3("removesixthsense", "death", "perceptionChallengeCheckDone");
  self.startperceptionchallengewatch = 0;
}

watchperceptionchallengeprogress() {
  self endon("disconnect");
  self endon("removesixthsense");
  self endon("death");
  if(scripts\mp\utility::istrue(self.startperceptionchallengewatch)) {
    return;
  }

  self.startperceptionchallengewatch = 1;
  wait(10);
  scripts\mp\missions::func_D991("ch_trait_perception");
  self notify("perceptionChallengeCheckDone");
}

watchdeathsixthsense() {
  self endon("disconnect");
  self endon("removesixthsense");
  self waittill("death");
  self setclientomnvar("ui_edge_glow", 0);
}

updatesixthsensevfx(param_00, param_01) {
  var_02 = 0;
  if(isDefined(self.var_10224)) {
    var_02 = self.var_10224;
  }

  if(isDefined(param_01) && param_01) {
    if(var_02 != param_00) {
      self.var_10224 = param_00;
    }
  }

  self setclientomnvar("ui_edge_glow", param_00);
}

getsixthsensedirection(param_00) {
  var_01 = anglesToForward(self getplayerangles());
  var_02 = (var_01[0], var_01[1], var_01[2]);
  var_02 = vectornormalize(var_02);
  var_03 = param_00.origin - self.origin;
  var_04 = (var_03[0], var_03[1], var_03[2]);
  var_04 = vectornormalize(var_04);
  var_05 = vectordot(var_02, var_04);
  if(var_05 >= 0.9238795) {
    return 2;
  }

  if(var_05 >= 0.3826834) {
    return scripts\engine\utility::ter_op(scripts\mp\utility::isleft2d(self.origin, var_02, param_00.origin), 4, 1);
  }

  if(var_05 >= -0.3826834) {
    return scripts\engine\utility::ter_op(scripts\mp\utility::isleft2d(self.origin, var_02, param_00.origin), 128, 64);
  }

  if(var_05 >= -0.9238795) {
    return scripts\engine\utility::ter_op(scripts\mp\utility::isleft2d(self.origin, var_02, param_00.origin), 32, 8);
  }

  return 16;
}

markassixthsensesource(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 = param_00 getentitynumber();
  if(!isDefined(self.sixthsensesource)) {
    self.sixthsensesource = [];
  } else if(isDefined(self.sixthsensesource[var_01])) {
    self notify("markAsSixthSenseSource");
    self endon("markAsSixthSenseSource");
  }

  self.sixthsensesource[var_01] = 1;
  param_00 scripts\engine\utility::waittill_any_timeout_1(10, "death");
  self.sixthsensesource[var_01] = 0;
}

setcamoelite() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  for(;;) {
    var_00 = 0;
    var_01 = level.players;
    var_02 = 0;
    if(!scripts\mp\killstreaks\_emp_common::isemped()) {
      foreach(var_04 in var_01) {
        if(!isDefined(var_04) || !scripts\mp\utility::isreallyalive(var_04)) {
          continue;
        }

        if(var_04.team == self.team) {
          continue;
        }

        if(var_04 scripts\mp\utility::_hasperk("specialty_empimmune")) {
          continue;
        }

        if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_04)) {
          continue;
        }

        var_05 = self.origin - var_04.origin;
        var_06 = anglesToForward(var_04 getplayerangles());
        var_07 = vectordot(var_05, var_06);
        if(var_07 <= 0) {
          continue;
        }

        var_08 = vectornormalize(var_05);
        var_09 = vectornormalize(var_06);
        var_07 = vectordot(var_08, var_09);
        if(var_07 < 0.9659258) {
          continue;
        }

        var_00++;
        var_0A = var_04 getEye();
        var_0B = self getEye();
        if(bullettracepassed(var_0A, var_0B, 0, self)) {
          var_02 = 1;
          break;
        }

        if(var_00 >= 3) {
          scripts\engine\utility::waitframe();
          var_00 = 0;
        }
      }

      scripts\engine\utility::waitframe();
    }

    updatecamoeliteoverlay(var_02);
    scripts\engine\utility::waitframe();
  }
}

updatecamoeliteoverlay(param_00) {}

unsetcamoelite() {}

func_F704() {
  scripts\mp\utility::giveperk("specialty_pistoldeath");
}

func_12CBD() {
  scripts\mp\utility::removeperk("specialty_pistoldeath");
}

setcarepackage() {
  thread scripts\mp\killstreaks\_killstreaks::givekillstreak("airdrop_assault", 0, 0, self);
}

unsetcarepackage() {}

setuav() {
  thread scripts\mp\killstreaks\_killstreaks::givekillstreak("uav", 0, 0, self);
}

unsetuav() {}

func_F864() {
  scripts\mp\utility::giveperk("specialty_bulletdamage");
  thread func_13B63();
}

func_13B63() {
  self notify("watchStoppingPowerKill");
  self endon("watchStoppingPowerKill");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("killed_enemy");
  func_12D3A();
}

func_12D3A() {
  scripts\mp\utility::removeperk("specialty_bulletdamage");
  self notify("watchStoppingPowerKill");
}

func_F678() {
  scripts\mp\utility::giveperk("specialty_pistoldeath");
}

func_12C8A() {
  if(scripts\mp\utility::_hasperk("specialty_pistoldeath")) {
    scripts\mp\utility::removeperk("specialty_pistoldeath");
  }
}

setjuiced(param_00) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.25;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility::giveperk("specialty_fastreload");
  scripts\mp\utility::giveperk("specialty_quickdraw");
  scripts\mp\utility::giveperk("specialty_stalker");
  scripts\mp\utility::giveperk("specialty_fastoffhand");
  scripts\mp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility::giveperk("specialty_quickswap");
  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  thread unsetjuicedonmatchend();
  if(!isDefined(param_00)) {
    param_00 = 10;
  }

  var_01 = param_00 * 1000 + gettime();
  if(!isai(self)) {
    self setclientomnvar("ui_juiced_end_milliseconds", var_01);
  }

  wait(param_00);
  unsetjuiced();
}

unsetjuiced(param_00) {
  if(!isDefined(param_00)) {
    if(scripts\mp\utility::isjuggernaut()) {
      if(isDefined(self.var_A4AA)) {
        self.movespeedscaler = self.var_A4AA;
      } else {
        self.movespeedscaler = 0.7;
      }
    } else {
      self.movespeedscaler = 1;
      if(scripts\mp\utility::_hasperk("specialty_lightweight")) {
        self.movespeedscaler = scripts\mp\utility::lightweightscalar();
      }
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility::removeperk("specialty_fastreload");
  scripts\mp\utility::removeperk("specialty_quickdraw");
  scripts\mp\utility::removeperk("specialty_stalker");
  scripts\mp\utility::removeperk("specialty_fastoffhand");
  scripts\mp\utility::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility::removeperk("specialty_quickswap");
  self.isjuiced = undefined;
  if(!isai(self)) {
    self setclientomnvar("ui_juiced_end_milliseconds", 0);
  }

  self notify("unset_juiced");
}

unsetjuicedonride() {
  self endon("disconnect");
  self endon("unset_juiced");
  for(;;) {
    wait(0.05);
    if(scripts\mp\utility::isusingremote()) {
      thread unsetjuiced();
      break;
    }
  }
}

unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  scripts\engine\utility::waittill_any_3("death", "faux_spawn");
  thread unsetjuiced(1);
}

unsetjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_juiced");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  thread unsetjuiced();
}

hasjuiced() {
  return isDefined(self.isjuiced);
}

setcombathigh() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_combathigh");
  level endon("end_game");
  self.damageblockedtotal = 0;
  if(level.splitscreen) {
    var_00 = 56;
    var_01 = 21;
  } else {
    var_00 = 112;
    var_01 = 32;
  }

  if(isDefined(self.juicedtimer)) {
    self.juicedtimer destroy();
  }

  if(isDefined(self.juicedicon)) {
    self.juicedicon destroy();
  }

  self.combathighoverlay = newclienthudelem(self);
  self.combathighoverlay.x = 0;
  self.combathighoverlay.y = 0;
  self.combathighoverlay.alignx = "left";
  self.combathighoverlay.aligny = "top";
  self.combathighoverlay.horzalign = "fullscreen";
  self.combathighoverlay.vertalign = "fullscreen";
  self.combathighoverlay setshader("combathigh_overlay", 640, 480);
  self.combathighoverlay.sort = -10;
  self.combathighoverlay.archived = 1;
  self.combathightimer = scripts\mp\hud_util::createtimer("hudsmall", 1);
  self.combathightimer scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_00);
  self.combathightimer settimer(10);
  self.combathightimer.color = (0.8, 0.8, 0);
  self.combathightimer.archived = 0;
  self.combathightimer.foreground = 1;
  self.combathighicon = scripts\mp\hud_util::createicon("specialty_painkiller", var_01, var_01);
  self.combathighicon.alpha = 0;
  self.combathighicon scripts\mp\hud_util::setparent(self.combathightimer);
  self.combathighicon scripts\mp\hud_util::setpoint("BOTTOM", "TOP");
  self.combathighicon.archived = 1;
  self.combathighicon.sort = 1;
  self.combathighicon.foreground = 1;
  self.combathighoverlay.alpha = 0;
  self.combathighoverlay fadeovertime(1);
  self.combathighicon fadeovertime(1);
  self.combathighoverlay.alpha = 1;
  self.combathighicon.alpha = 0.85;
  thread unsetcombathighondeath();
  thread unsetcombathighonride();
  wait(8);
  self.combathighicon fadeovertime(2);
  self.combathighicon.alpha = 0;
  self.combathighoverlay fadeovertime(2);
  self.combathighoverlay.alpha = 0;
  self.combathightimer fadeovertime(2);
  self.combathightimer.alpha = 0;
  wait(2);
  self.damageblockedtotal = undefined;
  scripts\mp\utility::removeperk("specialty_combathigh");
}

unsetcombathighondeath() {
  self endon("disconnect");
  self endon("unset_combathigh");
  self waittill("death");
  thread scripts\mp\utility::removeperk("specialty_combathigh");
}

unsetcombathighonride() {
  self endon("disconnect");
  self endon("unset_combathigh");
  for(;;) {
    wait(0.05);
    if(scripts\mp\utility::isusingremote()) {
      thread scripts\mp\utility::removeperk("specialty_combathigh");
      break;
    }
  }
}

unsetcombathigh() {
  self notify("unset_combathigh");
  self.combathighoverlay destroy();
  self.combathighicon destroy();
  self.combathightimer destroy();
}

setlightarmor() {
  scripts\mp\lightarmor::setlightarmorvalue(self, 150);
}

unsetlightarmor() {
  scripts\mp\lightarmor::lightarmor_unset();
}

setrevenge() {
  self notify("stopRevenge");
  wait(0.05);
  if(!isDefined(self.lastkilledby)) {
    return;
  }

  if(level.teambased && self.team == self.lastkilledby.team) {
    return;
  }

  var_00 = spawnStruct();
  var_00.showto = self;
  var_00.icon = "compassping_revenge";
  var_00.offset = (0, 0, 64);
  var_00.width = 10;
  var_00.height = 10;
  var_00.archived = 0;
  var_00.delay = 1.5;
  var_00.constantsize = 0;
  var_00.pintoscreenedge = 1;
  var_00.fadeoutpinnedicon = 0;
  var_00.is3d = 0;
  self.revengeparams = var_00;
  self.lastkilledby scripts\mp\entityheadicons::setheadicon(var_00.showto, var_00.icon, var_00.offset, var_00.width, var_00.height, var_00.archived, var_00.delay, var_00.constantsize, var_00.pintoscreenedge, var_00.fadeoutpinnedicon, var_00.is3d);
  thread watchrevengedeath();
  thread watchrevengekill();
  thread watchrevengedisconnected();
  thread watchrevengevictimdisconnected();
  thread watchstoprevenge();
}

watchrevengedeath() {
  self endon("stopRevenge");
  self endon("disconnect");
  var_00 = self.lastkilledby;
  for(;;) {
    var_00 waittill("spawned_player");
    var_00 scripts\mp\entityheadicons::setheadicon(self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, self.revengeparams.width, self.revengeparams.height, self.revengeparams.archived, self.revengeparams.delay, self.revengeparams.constantsize, self.revengeparams.pintoscreenedge, self.revengeparams.fadeoutpinnedicon, self.revengeparams.is3d);
  }
}

watchrevengekill() {
  self endon("stopRevenge");
  self waittill("killed_enemy");
  self notify("stopRevenge");
}

watchrevengedisconnected() {
  self endon("stopRevenge");
  self.lastkilledby waittill("disconnect");
  self notify("stopRevenge");
}

watchstoprevenge() {
  var_00 = self.lastkilledby;
  self waittill("stopRevenge");
  if(!isDefined(var_00)) {
    return;
  }

  foreach(var_02 in var_00.entityheadicons) {
    if(!isDefined(var_02)) {
      continue;
    }

    var_02 destroy();
  }
}

watchrevengevictimdisconnected() {
  var_00 = self.objidfriendly;
  var_01 = self.lastkilledby;
  var_01 endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");
  self waittill("disconnect");
  if(!isDefined(var_01)) {
    return;
  }

  foreach(var_03 in var_01.entityheadicons) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_03 destroy();
  }
}

unsetrevenge() {
  self notify("stopRevenge");
}

setphaseslide() {
  self.canphaseslide = 1;
  thread scripts\mp\archetypes\archassassin::func_CAAF();
}

unsetphaseslide() {
  self.canphaseslide = 0;
}

setteleslide() {
  self.canteleslide = 1;
  thread scripts\mp\archetypes\archassassin::func_1166B();
}

unsetteleslide() {
  self.canteleslide = 0;
}

setphaseslashrephase() {
  self.hasrephase = 1;
  thread scripts\mp\archetypes\archassassin::func_E88E();
}

unsetphaseslashrephase() {
  self.hasrephase = 0;
}

func_F7E0() {
  scripts\mp\equipment\ground_pound::func_8659("phase");
}

func_12D05() {
  scripts\mp\equipment\ground_pound::func_865A();
}

func_F62F() {
  self.var_8BC2 = 1;
}

func_12C68() {
  self.var_8BC2 = 0;
}

func_F630() {
  self.var_8BC3 = 1;
  self notify("force_regeneration");
}

func_12C69() {
  self.var_8BC3 = 1;
}

func_F6F1() {
  scripts\mp\archetypes\archscout::func_F6F2();
}

func_12CB1() {}

func_F64E() {
  scripts\mp\archetypes\archheavy::func_261D();
}

func_12C74() {}

func_F64D() {
  scripts\mp\archetypes\archassault::auraquickswap_run();
}

func_12C73() {}

func_F64F() {
  scripts\mp\archetypes\archscout::func_2620();
}

func_12C75() {}

func_F790() {
  self.var_11B2E = "specialty_mark_targets";
  scripts\mp\perks\_perk_mark_targets::marktarget_init();
}

func_12CED() {
  self.trait = undefined;
}

func_F65A() {
  scripts\mp\archetypes\archengineer::func_F6E6("battery");
}

func_12C7A() {}

func_F67A() {}

func_12C8B() {}

setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("force_regen");
}

unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("force_regen");
}

setscorestreakpack() {
  scripts\mp\archetypes\archengineer::func_F6E6("scorestreak");
}

unsetscorestreakpack() {}

setsuperpack() {
  self.trait = "specialty_superpack";
  scripts\mp\archetypes\archengineer::func_F6E6("super");
}

unsetsuperpack() {
  self.trait = undefined;
}

setspawncloak() {}

unsetspawncloak() {}

setdodgedefense() {
  scripts\mp\utility::adddamagemodifier("dodgeDefense", 0.5, 0, ::dodgedefenseignorefunc);
}

unsetdodgedefense() {
  scripts\mp\utility::removedamagemodifier("dodgeDefense", 0);
}

dodgedefenseignorefunc(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_02.dodging) && param_02.dodging && param_02 scripts\mp\utility::_hasperk("specialty_dodge_defense")) {
    return 1;
  }

  return 0;
}

setdodgewave() {}

unsetdodgewave() {}

setgroundpound() {
  self.trait = "specialty_ground_pound";
  scripts\mp\equipment\ground_pound::func_8659();
}

unsetgroundpound() {
  self.trait = undefined;
  scripts\mp\equipment\ground_pound::func_865A();
}

setmeleekill() {
  self giveweapon("iw7_fistsperk_mp");
  self assignweaponmeleeslot("iw7_fistsperk_mp");
  if(self hasweapon("iw7_fists_mp")) {
    var_00 = self getcurrentweapon();
    scripts\mp\utility::_takeweapon("iw7_fists_mp");
    self giveweapon("iw7_fistslethal_mp");
    if(var_00 == "iw7_fists_mp") {
      scripts\mp\utility::_switchtoweapon("iw7_fistslethal_mp");
      if(isDefined(self.gettingloadout) && self.gettingloadout && isDefined(self.spawnweaponobj) && self.spawnweaponobj == "iw7_fists_mp") {
        self setspawnweapon("iw7_fistslethal_mp");
        self.spawnweaponobj = "iw7_fistslethal_mp";
        return;
      }
    }
  }
}

unsetmeleekill() {
  scripts\mp\utility::_takeweapon("iw7_fistsperk_mp");
  if(self hasweapon("iw7_fistslethal_mp")) {
    var_00 = self getcurrentweapon();
    scripts\mp\utility::_takeweapon("iw7_fistslethal_mp");
    self giveweapon("iw7_fists_mp");
    if(var_00 == "iw7_fistslethal_mp") {
      scripts\mp\utility::_switchtoweapon("iw7_fists_mp");
    }
  }
}

setpowercell() {}

unsetpowercell() {}

sethardline() {
  self endon("death");
  self endon("disconnect");
  self endon("perk_end_hardline");
  self.hardlineactive["kills"] = 0;
  self.hardlineactive["assists"] = 0;
  thread watchhardlineassists();
  while(self.hardlineactive["kills"] < 8) {
    self waittill("got_a_kill", var_00, var_01, var_02);
    if(isDefined(var_01) && !scripts\mp\utility::iskillstreakweapon(var_01)) {
      self.hardlineactive["kills"] = self.hardlineactive["kills"] + 1;
    }
  }

  self.hardlineactive = undefined;
}

watchhardlineassists() {
  self endon("death");
  self endon("disconnect");
  self endon("perk_end_hardline");
  for(;;) {
    self waittill("assist_hardline");
    if(self.hardlineactive["assists"] == 1) {
      self.hardlineactive["kills"] = self.hardlineactive["kills"] + 1;
      self.hardlineactive["assists"] = 0;
      continue;
    }

    self.hardlineactive["assists"] = self.hardlineactive["assists"] + 1;
  }
}

unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

func_F74A() {
  for(;;) {
    foreach(var_01 in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_01)) {
        continue;
      }

      if(var_01.team == self.team) {
        continue;
      }

      if(var_01 scripts\mp\utility::_hasperk("specialty_coldblooded")) {
        continue;
      }

      if(var_01 scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
        continue;
      }

      if(length2d(var_01 getvelocity()) < 150 && !isDefined(var_01.campfire_temp_dialog) && distance2d(self.origin, var_01.origin) < 1024) {
        thread func_49EE(var_01);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_49EE(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  if(!isDefined(self) || !scripts\mp\utility::isreallyalive(self)) {
    return;
  }

  param_00.campfire_temp_dialog = 1;
  var_01 = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_01 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_01, "active", param_00.origin, "cb_compassping_sniper_enemy", self);
    scripts\mp\objidpoolmanager::minimap_objective_team(var_01, self.team);
    param_00 thread watchfordeath(var_01);
  }

  while(length2d(param_00 getvelocity()) < 150) {
    wait(2);
  }

  scripts\mp\objidpoolmanager::returnminimapid(var_01);
  param_00.campfire_temp_dialog = undefined;
}

watchfordeath(param_00) {
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  scripts\mp\objidpoolmanager::returnminimapid(param_00);
  self.campfire_temp_dialog = undefined;
}

func_12CD3() {}

func_F7CD() {}

unsetoverclock() {}

func_F894() {
  thread func_E8A9();
  thread func_E8AA();
}

func_12D4E() {}

func_F7DE() {
  self.trait = "specialty_personal_trophy";
  thread scripts\mp\playertrophy_system::func_D446();
}

func_12D04() {
  self.trait = undefined;
  thread scripts\mp\playertrophy_system::func_D448();
}

func_F6CA() {
  thread scripts\mp\archetypes\archheavy::func_56E7();
}

func_12CA3() {}

setequipmentping() {
  self.trait = "specialty_equipment_ping";
}

unsetequipmentping() {
  self.trait = undefined;
}

setruggedeqp() {
  self.trait = "specialty_rugged_eqp";
}

unsetruggedeqp() {
  self.trait = undefined;
  thread scripts\mp\supers\super_supertrophy::supertrophy_onruggedequipmentunset();
  thread scripts\mp\equipment\micro_turret::microturret_onruggedequipmentunset();
}

feedbackruggedeqp(param_00, param_01) {}

setmanatarms() {
  self.trait = "specialty_man_at_arms";
}

unsetmanatarms() {
  self.trait = undefined;
}

func_F7CB() {
  self endon("disconnect");
  self endon("unsetOutlineKillstreaks");
  self.engstructks = engineer_createengstruct();
  var_00 = self.engstructks;
  thread engineer_watchownerdisconnect(var_00, "unsetOutlineKillstreaks");
  for(;;) {
    var_01 = level.var_1655;
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03.model)) {
          if(engineer_shouldoutlineent(var_03, var_00)) {
            engineer_addoutlinedent(var_03, var_00);
          }
        }
      }
    }

    wait(0.1);
  }
}

func_12CFC() {
  self notify("unsetOutlineKillstreaks");
  if(isDefined(self.engstructks)) {
    thread engineer_clearoutlinedents(self.engstructks);
  }

  self.engstructks = undefined;
}

setengineer() {
  self endon("disconnect");
  self endon("unsetEngineer");
  self.engstructeqp = engineer_createengstruct();
  var_00 = self.engstructeqp;
  thread engineer_watchownerdisconnect(var_00, "unsetEngineer");
  for(;;) {
    var_01 = func_7D96();
    foreach(var_03 in var_01) {
      if(engineer_shouldoutlineent(var_03, var_00)) {
        engineer_addoutlinedent(var_03, var_00);
      }
    }

    wait(0.1);
  }
}

unsetengineer() {
  self notify("unsetEngineer");
  if(isDefined(self.engstructeqp)) {
    thread engineer_clearoutlinedents(self.engstructeqp);
  }

  self.engstructeqp = undefined;
}

engineer_createengstruct() {
  var_00 = spawnStruct();
  var_00.triggerportableradarping = self;
  var_00.var_C78E = [];
  var_00.outlinedids = [];
  return var_00;
}

engineer_addoutlinedent(param_00, param_01) {
  var_02 = param_00 getentitynumber();
  var_03 = param_01.outlinedids[var_02];
  if(isDefined(var_03)) {
    thread engineer_removeoutlinedent(var_02, param_01);
  }

  var_03 = scripts\mp\utility::outlineenableforplayer(param_00, "red", param_01.triggerportableradarping, 0, 1, "level_script");
  param_01.var_C78E[var_02] = param_00;
  param_01.outlinedids[var_02] = var_03;
  thread engineer_removeoutlinedentondeath(var_02, param_01);
}

engineer_removeoutlinedent(param_00, param_01) {
  param_01 notify("engineer_removeOutlinedEnt_" + param_00);
  var_02 = param_01.var_C78E[param_00];
  var_03 = param_01.outlinedids[param_00];
  scripts\mp\utility::outlinedisable(var_03, var_02);
  param_01.var_C78E[param_00] = undefined;
  param_01.outlinedids[param_00] = undefined;
}

engineer_removeoutlinedentondeath(param_00, param_01) {
  param_01 endon("engineer_clearOutlinedEnts");
  param_01 endon("engineer_removeOutlinedEnt_" + param_00);
  var_02 = param_01.var_C78E[param_00];
  var_02 waittill("death");
  thread engineer_removeoutlinedent(param_00, param_01);
}

engineer_clearoutlinedents(param_00) {
  param_00 notify("engineer_clearOutlinedEnts");
  foreach(var_03, var_02 in param_00.outlinedids) {
    scripts\mp\utility::outlinedisable(var_02, param_00.var_C78E[var_03]);
  }
}

engineer_shouldoutlineent(param_00, param_01) {
  var_02 = param_00 getentitynumber();
  if(isDefined(param_01.outlinedids[var_02])) {
    return 0;
  }

  var_03 = param_00.triggerportableradarping;
  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_03, param_01.triggerportableradarping))) {
    return 0;
  }

  return 1;
}

engineer_watchownerdisconnect(param_00, param_01) {
  if(isDefined(param_01)) {
    param_00.triggerportableradarping endon(param_01);
  }

  param_00 endon("engineer_clearOutlinedEnts");
  param_00.triggerportableradarping waittill("disconnect");
  thread engineer_clearoutlinedents(param_00);
}

func_7D96() {
  return scripts\engine\utility::array_remove_duplicates(scripts\engine\utility::array_combine_multiple([level.mines, level.microturrets, level.var_69D6, level.supertrophy.trophies, level.var_590F, level.var_2ABD, level.spidergrenade.activeagents, level.spidergrenade.proxies]));
}

setcloak() {}

unsetcloak() {}

setwalllock() {
  self.trait = "specialty_wall_lock";
  thread scripts\mp\archetypes\archsniper::func_E8AC();
}

unsetwalllock() {
  self.trait = undefined;
}

setrush() {
  self.trait = "specialty_rush";
  thread scripts\mp\archetypes\archscout::func_B947();
}

unsetrush() {
  self notify("removeCombatHigh");
  self.speedonkillmod = undefined;
  self.trait = undefined;
}

sethover() {
  thread runhover();
}

unsethover() {}

setmomentum() {
  self.trait = "specialty_momentum";
  thread func_E863();
}

func_E863() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");
  for(;;) {
    if(self issprinting()) {
      _meth_848B();
      self.movespeedscaler = 1;
      scripts\mp\weapons::updatemovespeedscale();
    }

    wait(0.1);
  }
}

_meth_848B() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread func_B944();
  thread func_B943();
  var_00 = 0;
  while(var_00 < 0.06) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    scripts\mp\weapons::updatemovespeedscale();
    wait(0.2083333);
    var_00 = var_00 + 0.01;
  }

  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
}

func_B944() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");
  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait(0.4);
      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_B943() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

unsetmomentum() {
  self notify("momentum_unset");
  self.trait = undefined;
}

setscavengereqp() {
  self.trait = "specialty_scavenger_eqp";
  scripts\mp\archetypes\archengineer::func_F6E6("equipment");
}

unsetscavengereqp() {
  self.trait = undefined;
}

setspawnview() {
  thread scripts\mp\archetypes\archassassin::func_1091C();
}

unsetspawnview() {
  foreach(var_01 in level.players) {
    var_01 notify("end_spawnview");
  }
}

setheadgear() {
  thread scripts\mp\equipment\headgear::func_E855();
}

unsetheadgear() {}

setftlslide() {
  self.trait = "specialty_ftlslide";
  if(scripts\mp\utility::isanymlgmatch() && level.tactical) {
    self setsuit("assassin_mlgslide_mp_tactical");
    return;
  }

  if(scripts\mp\utility::isanymlgmatch()) {
    self setsuit("assassin_mlgslide_mp");
    return;
  }

  if(level.tactical) {
    self setsuit("assassin_slide_mp_tactical");
    return;
  }

  self setsuit("assassin_slide_mp");
}

unsetftlslide() {
  self.trait = undefined;
}

func_F753() {
  thread scripts\mp\archetypes\archsniper::func_E7FE();
}

func_12CD6() {}

setghost() {
  thread updategpsjammer();
}

unsetghost() {
  thread removegpsjammer();
}

setsupportkillstreaks() {
  self endon("disconnect");
  self.trait = "specialty_support_killstreaks";
  self waittill("equipKillstreaksFinished");
  if(!isDefined(self.pers["killstreaks"][1])) {
    foreach(var_01 in self.pers["killstreaks"]) {
      var_01.earned = 0;
    }
  }
}

unsetsupportkillstreaks() {
  self notify("end_support_killstreaks");
  self.trait = undefined;
}

func_F7D2() {
  self.overrideweaponspeed_speedscale = 0.98;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = undefined;
}

func_F657() {
  self setclientomnvar("ui_uplink_carrier_hud", 1);
  if(level.armormod == 0) {
    self setclientomnvar("ui_uplink_carrier_armor_max", 100);
  } else {
    self setclientomnvar("ui_uplink_carrier_armor_max", level.carrierarmor);
  }

  if(level.possessionresetcondition != 0) {
    self setclientomnvar("ui_uplink_timer_hud", 1);
  }
}

func_12C77() {
  self notify("unsetBallCarrier");
  self setclientomnvar("ui_uplink_carrier_hud", 0);
  self setclientomnvar("ui_uplink_carrier_armor", -1);
  if(level.possessionresetcondition != 0) {
    self setclientomnvar("ui_uplink_timer_hud", 0);
  }
}

setcloakaerial() {
  self.trait = "specialty_cloak_aerial";
}

unsetcloakaerial() {
  self.trait = undefined;
}

setspawnradar() {
  self.trait = "specialty_spawn_radar";
  self.hasspawnradar = 1;
}

unsetspawnradar() {
  self.trait = undefined;
  self.hasspawnradar = 1;
}

setimprovedmelee() {}

unsetimprovedmelee() {}

setthief() {}

unsetthief() {}

setadsawareness() {
  self.trait = "specialty_ads_awareness";
  thread runadsawareness();
  self setscriptablepartstate("heightened_senses", "default");
}

runadsawareness() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetADSAwareness");
  self.awarenessradius = 256;
  self.awarenessqueryrate = 2;
  thread awarenessmonitorstance();
  for(;;) {
    wait(self.awarenessqueryrate);
    foreach(var_01 in level.players) {
      if(var_01.team == self.team) {
        continue;
      }

      if(var_01 scripts\mp\utility::_hasperk("specialty_coldblooded")) {
        continue;
      }

      if(var_01 isonground() && !var_01 issprinting() && !var_01 iswallrunning() && !var_01 issprintsliding()) {
        continue;
      }

      if(distance2d(var_01.origin, self.origin) < self.awarenessradius) {
        thread playincomingwarning(var_01);
      }
    }
  }
}

playincomingwarning(param_00) {
  self setscriptablepartstate("heightened_senses", "scrn_pulse");
  self playrumbleonentity("damage_heavy");
  param_00 playsoundtoplayer("ghost_senses_ping", self);
  wait(0.2);
  if(isDefined(self)) {
    self setscriptablepartstate("heightened_senses", "default");
    if(scripts\mp\utility::isreallyalive(self)) {
      self playrumbleonentity("damage_heavy");
      if(isDefined(param_00) && scripts\mp\utility::isreallyalive(param_00)) {
        param_00 playsoundtoplayer("ghost_senses_ping", self);
        return;
      }
    }
  }
}

awarenessmonitorstance() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    var_00 = self getstance();
    var_01 = self getvelocity();
    switch (var_00) {
      case "stand":
        self.awarenessradius = 400;
        self.awarenessqueryrate = 2;
        break;

      case "crouch":
        self.awarenessradius = 650;
        self.awarenessqueryrate = 1;
        break;

      case "prone":
        self.awarenessradius = 700;
        self.awarenessqueryrate = 0.5;
        break;
    }

    wait(0.01);
  }
}

awarenessaudiopulse() {
  self endon("death");
  self endon("disconnect");
  self endon("stop_awareness");
  for(;;) {
    playsoundatpos(self.origin + (0, 0, 5), "ghost_senses_ping");
    wait(2);
  }
}

unsetadsawareness() {
  self notify("unsetADSAwareness");
  self.trait = undefined;
  self setscriptablepartstate("heightened_senses", "default");
}

setrearguard() {
  self.trait = "specialty_rearguard";
  scripts\mp\perks\_perk_rearguard_shield::func_E814();
}

unsetrearguard() {
  self.trait = undefined;
  self.hasrearguardshield = undefined;
}

setbulletoutline() {
  self.bulletoutline = spawnStruct();
  self.bulletoutline.player = self;
  self.bulletoutline.enemies = [];
  self.bulletoutline.enemyids = [];
  self.bulletoutline.enemyendtimes = [];
  self.bulletoutline thread watchbulletoutline();
  self.bulletoutline thread watchbulletoutlinecleanup();
}

unsetbulletoutline() {
  self notify("unsetBulletOutline");
  self.bulletoutline = undefined;
}

watchbulletoutline() {
  self.player endon("death");
  self.player endon("disconnect");
  self.player endon("unsetBulletOutline");
  while(isDefined(self.player)) {
    var_00 = gettime();
    foreach(var_03, var_02 in self.enemies) {
      if(!isDefined(var_02)) {
        bulletoutlineremoveenemy(undefined, var_03);
        continue;
      }

      if(var_02 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
        bulletoutlineremoveenemy(var_02, var_03);
        continue;
      }

      if(var_00 >= self.enemyendtimes[var_03]) {
        bulletoutlineremoveenemy(var_02, var_03);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

watchbulletoutlinecleanup() {
  self.player scripts\engine\utility::waittill_any_3("disconnect", "unsetBulletOutline");
  foreach(var_02, var_01 in self.enemies) {
    if(isDefined(var_01)) {
      bulletoutlineremoveenemy(var_01, var_02);
    }
  }
}

bulletoutlineaddenemy(param_00, param_01, param_02) {
  var_03 = param_00 getentitynumber();
  var_04 = gettime() + param_01 * 1000;
  self.enemies[var_03] = param_00;
  if(!isDefined(self.enemyids[var_03])) {
    self.enemyids[var_03] = scripts\mp\utility::outlineenableforplayer(param_00, "red", self.player, 1, 0, "perk");
  }

  if(!isDefined(self.enemyendtimes[var_03]) || !isDefined(param_02) || param_02) {
    self.enemyendtimes[var_03] = var_04;
  }
}

bulletoutlineremoveenemy(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = param_00 getentitynumber();
  }

  self.enemies[param_01] = undefined;
  self.enemyendtimes[param_01] = undefined;
  if(isDefined(param_00)) {
    scripts\mp\utility::outlinedisable(self.enemyids[param_01], param_00);
  }

  self.enemyids[param_01] = undefined;
}

bulletoutlinecheck(param_00, param_01, param_02, param_03) {
  if(!param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_EXPLOSIVE_BULLET") {
    return;
  }

  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  if(!isplayer(param_00) || scripts\mp\utility::func_9F22(param_00) || !isplayer(param_01) || scripts\mp\utility::func_9F22(param_01)) {
    return;
  }

  var_04 = param_00;
  if(isDefined(param_00.triggerportableradarping)) {
    var_04 = param_00.triggerportableradarping;
  }

  var_05 = param_01;
  if(isDefined(param_01.triggerportableradarping)) {
    var_05 = param_01.triggerportableradarping;
  }

  if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_04, var_05))) {
    return;
  }

  if(isplayer(param_00) && isplayer(param_01) && scripts\mp\utility::func_C7A0(param_00 getEye(), param_01 getEye())) {
    return;
  }

  if(isDefined(param_00.bulletoutline) && !param_01 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
    param_00.bulletoutline bulletoutlineaddenemy(param_01, 1);
  }

  if(isDefined(param_01.bulletoutline) && !param_00 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
    param_01.bulletoutline bulletoutlineaddenemy(param_00, 2, 0);
  }
}

func_E8A9() {
  self endon("death");
  self endon("disconnect");
  var_00 = scripts\mp\utility::getuniqueid();
  for(;;) {
    foreach(var_02 in level.players) {
      if(!isDefined(var_02) || !scripts\mp\utility::isreallyalive(var_02)) {
        continue;
      }

      if(var_02.team == self.team || var_02 == self) {
        continue;
      }

      if(var_02 scripts\mp\utility::_hasperk("specialty_empimmune")) {
        continue;
      }

      if(var_02 scripts\mp\equipment\cloak::func_9FC1()) {
        thread markempsignatures(var_02, var_00);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_E8AA() {
  self endon("death");
  self endon("disconnect");
  self endon("track_killstreak_end");
  for(;;) {
    if(scripts\mp\utility::isusingremote()) {
      scripts\engine\utility::waitframe();
      scripts\mp\utility::removeperk("specialty_tracker");
      while(scripts\mp\utility::isusingremote()) {
        scripts\engine\utility::waitframe();
      }

      scripts\mp\utility::giveperk("specialty_tracker");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

markempsignatures(param_00, param_01) {
  if(!isDefined(param_00.empmarked)) {
    param_00.empmarked = [];
  }

  if(isDefined(param_00.empmarked[param_01]) && param_00.empmarked[param_01] == "active") {
    return;
  }

  param_00.empmarked[param_01] = "active";
  thread empvfx(param_00, param_01);
  param_00 scripts\engine\utility::waittill_any_3("death", "cloak_end");
  param_00.empmarked[param_01] = undefined;
}

empvfx(param_00, param_01) {
  var_02 = ["j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le"];
  while(param_00 scripts\mp\equipment\cloak::func_9FC1()) {
    playfxontagforclients(scripts\engine\utility::getfx("tracker_cloak_tag"), param_00, var_02[randomint(var_02.size - 1)], self);
    wait(0.25);
  }

  param_00.empmarked[param_01] = undefined;
}

updategpsjammer() {
  self endon("remove_gpsjammer");
  self endon("death");
  self endon("disconnect");
  if(isai(self)) {
    while(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0) {
      scripts\engine\utility::waitframe();
    }
  }

  if(level.minspeedsq == 0) {
    return;
  }

  if(level.timeperiod < 0.05) {
    return;
  }

  var_00 = 1;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = self.origin;
  var_07 = 0;
  if(1) {
    var_07 = 1;
    self setplayerghost(1);
    thread ghostadvanceduavwatcher();
    return;
  }

  thread ghostadvanceduavwatcher();
  for(;;) {
    var_07 = 0;
    if(scripts\mp\utility::isusingremote() || scripts\engine\utility::istrue(self.isplanting) || scripts\engine\utility::istrue(self.isdefusing) || self ismantling()) {
      var_07 = 1;
    } else {
      if(var_05 > 1) {
        var_05 = 0;
        if(distancesquared(var_06, self.origin) < level.var_B75E) {
          var_02 = 1;
        } else {
          var_02 = 0;
        }

        var_06 = self.origin;
      }

      var_08 = self getvelocity();
      var_09 = lengthsquared(var_08);
      if(var_09 > level.minspeedsq && var_02 == 0) {
        var_07 = 1;
      }
    }

    if(var_07 == 1) {
      var_03 = 0;
      if(var_00 == 0) {
        var_01 = 0;
        var_00 = 1;
        self setplayerghost(1);
      }
    } else {
      var_03++;
      if(var_00 == 1 && var_03 >= level._meth_848A) {
        var_01 = 1;
        var_00 = 0;
        self setplayerghost(0);
      }
    }

    if(var_01 == 1) {
      level notify("radar_status_change");
    }

    var_05 = var_05 + level.timeperiod;
    wait(level.timeperiod);
  }
}

ghostadvanceduavwatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_gpsjammer");
  for(;;) {
    if(level.teambased) {
      if(isDefined(level.activeadvanceduavs) && scripts\mp\utility::istrue(level.activeadvanceduavs[scripts\mp\utility::getotherteam(self.team)])) {
        self setplayerghost(0);
        while(scripts\mp\utility::istrue(level.activeadvanceduavs[scripts\mp\utility::getotherteam(self.team)])) {
          scripts\engine\utility::waitframe();
        }

        self setplayerghost(1);
      }
    } else {
      foreach(var_01 in level.players) {
        if(var_01 == self) {
          continue;
        }

        if(scripts\mp\utility::istrue(level.activeadvanceduavs[var_01.guid]) && level.activeadvanceduavs[var_01.guid] > 0) {
          self setplayerghost(0);
          while(scripts\mp\utility::istrue(level.activeadvanceduavs[var_01.guid]) && level.activeadvanceduavs[var_01.guid] > 0) {
            level waittill("uav_update");
          }

          self setplayerghost(1);
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

removegpsjammer() {
  self notify("remove_gpsjammer");
  self setplayerghost(0);
}

setgroundpoundshield() {
  level._effect["groundPoundShield_impact"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  thread scripts\mp\equipment\ground_pound::func_8655(6, 8, ::groundpoundshield_onimpact, "groundPoundShield_unset");
}

unsetgroundpoundshield() {
  self notify("groundPoundShield_unset");
}

groundpoundshield_onimpact(param_00) {
  thread groundpoundshield_raiseondelay();
}

groundpoundshield_raiseondelay() {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundLand");
  wait(0.25);
  groundpoundshield_raise();
}

groundpoundshield_raise() {
  if(isDefined(self.groundpoundshield)) {
    thread groundpoundshield_lower(self.groundpoundshield);
  }

  var_00 = self.origin + anglesToForward(self.angles) * 5;
  var_01 = self.angles + (0, 90, 0);
  var_02 = spawn("script_model", var_00);
  var_02.angles = var_01;
  var_02 setModel("weapon_shinguard_col_wm");
  var_03 = spawn("script_model", var_00);
  var_03.angles = var_01;
  var_03 setModel("weapon_shinguard_fr_wm");
  var_03.outlineid = scripts\mp\utility::func_C793(var_03, "cyan", 0, 0, "equipment");
  var_04 = spawn("script_model", var_00);
  var_04.angles = var_01;
  var_04 setModel("weapon_shinguard_en_wm");
  var_04.outlineid = scripts\mp\utility::func_C793(var_04, "orange", 0, 0, "equipment");
  var_02.visfr = var_03;
  var_02.visen = var_04;
  var_02.triggerportableradarping = self;
  var_02 setCanDamage(1);
  var_02 _meth_847F(1);
  var_02.health = 9999;
  var_02.shieldhealth = 210;
  self.groundpoundshield = var_02;
  var_05 = level.characters;
  foreach(var_07 in var_05) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(level.teambased && var_07.team == self.team) {
      var_04 hidefromplayer(var_07);
      continue;
    }

    var_03 hidefromplayer(var_07);
  }

  thread groundpoundshield_monitorjoinedteam(var_02);
  thread groundpoundshield_loweronleavearea(var_02);
  thread groundpoundshield_lowerontime(var_02, 3.25);
  thread groundpoundshield_loweronjump(var_02);
  thread groundpoundshield_deleteondisconnect(var_02);
  thread groundpoundshield_monitorhealth(var_02);
  thread groundpound_raisefx();
  return var_02;
}

groundpoundshield_lower(param_00) {
  self notify("groundPoundShield_end");
  if(!isDefined(param_00)) {
    return;
  }

  thread groundpoundshield_lowerfx();
  thread groundpoundshield_deleteshield(param_00);
}

groundpoundshield_break(param_00) {
  self notify("groundPoundShield_end");
  if(!isDefined(param_00)) {
    return;
  }

  thread func_865E();
  thread groundpoundshield_deleteshield(param_00);
}

groundpoundshield_monitorhealth(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isDefined(var_02)) {
      if(var_02 == self || var_02.team != self.team) {
        param_00.shieldhealth = param_00.shieldhealth - var_01;
      }
    }

    param_00.health = 9999;
    thread groundpoundshield_damagedfx(var_02, var_04, var_03);
    if(param_00.shieldhealth <= 0) {
      thread groundpoundshield_break(param_00);
      return;
    } else if(param_00.shieldhealth <= 105) {
      if(param_00.visfr.model != "weapon_shinguard_dam_wm") {
        param_00.visfr setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility::func_C7AA(param_00.visfr);
      }

      if(param_00.visen.model != "weapon_shinguard_dam_wm") {
        param_00.visen setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility::func_C7AA(param_00.visen);
      }
    }
  }
}

groundpoundshield_loweronjump(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  var_01 = self isjumping();
  var_02 = undefined;
  for(;;) {
    var_02 = var_01;
    var_01 = self isjumping();
    if(!var_02 && var_01) {
      thread groundpoundshield_lower(param_00);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

groundpoundshield_lowerontime(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  wait(param_01);
  thread groundpoundshield_lower(param_00);
}

groundpoundshield_loweronleavearea(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  while(isDefined(param_00)) {
    if(lengthsquared(param_00.origin - self.origin) > 11664) {
      thread groundpoundshield_lower(param_00);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

groundpoundshield_deleteondisconnect(param_00) {
  self endon("groundPoundShield_deleteShield");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "groundPound_unset");
  thread groundpoundshield_deleteshield(param_00);
}

groundpoundshield_monitorjoinedteam(param_00) {
  self endon("groundPoundShield_deleteShield");
  var_01 = self.team;
  for(;;) {
    level waittill("joined_team", var_02);
    if(level.teambased && var_02.team == var_01) {
      param_00.visfr showtoplayer(var_02);
      param_00.visen hidefromplayer(var_02);
      continue;
    }

    param_00.visfr hidefromplayer(var_02);
    param_00.visen showtoplayer(var_02);
  }
}

groundpoundshield_deleteshield(param_00) {
  self notify("groundPoundShield_deleteShield");
  scripts\mp\utility::outlinedisable(param_00.visfr.outlineid, param_00.visfr);
  scripts\mp\utility::outlinedisable(param_00.visen.outlineid, param_00.visen);
  param_00.visfr delete();
  param_00.visen delete();
  param_00 delete();
}

groundpound_raisefx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  self playlocalsound("heavy_shield_up");
  self playsoundtoteam("heavy_shield_up_npc", "axis", self);
  self playsoundtoteam("heavy_shield_up_npc", "allies", self);
}

groundpoundshield_lowerfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  self playlocalsound("heavy_shield_down");
  self playsoundtoteam("heavy_shield_down_npc", "axis", self);
  self playsoundtoteam("heavy_shield_down_npc", "allies", self);
}

groundpoundshield_damagedfx(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  playFX(scripts\engine\utility::getfx("groundPoundShield_impact"), param_01, -1 * param_02);
  playsoundatpos(param_01, "ds_shield_impact");
  param_00 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
}

func_865E() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

setgroundpoundshock() {
  level._effect["groundPoundShock_impact_sm"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["groundPoundShock_impact_lrg"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  thread scripts\mp\equipment\ground_pound::func_8655(7, 8, ::groundpoundshock_onimpact, "groundPoundShock_unset");
}

unsetgroundpoundshock() {
  self notify("groundPoundShock_unset");
}

groundpoundshock_onimpact(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShock_unset");
  var_01 = undefined;
  var_02 = undefined;
  switch (param_00) {
    case "groundPoundLandTier0":
      var_02 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_01 = 144;
      break;

    case "groundPoundLandTier1":
      var_02 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_01 = 180;
      break;

    case "groundPoundLandTier2":
      var_02 = scripts\engine\utility::getfx("groundPoundShock_impact_lrg");
      var_01 = 216;
      break;
  }

  thread groundpoundshock_onimpactfx(var_01, var_02);
  var_03 = undefined;
  if(level.teambased) {
    var_03 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
  } else {
    var_03 = level.characters;
  }

  var_04 = var_01 * var_01;
  var_05 = scripts\common\trace::create_contents(0, 1, 0, 0, 1, 0, 0);
  foreach(var_07 in var_03) {
    if(!isDefined(var_07) || var_07 == self || !var_07 scripts\mp\killstreaks\_emp_common::func_FFC5()) {
      continue;
    }

    if(lengthsquared(var_07 getEye() - self getEye()) > var_04) {
      continue;
    }

    var_08 = physics_raycast(self getEye(), var_07 getEye(), var_05, undefined, 0, "physicsquery_closest");
    if(isDefined(var_08) && var_08.size > 0) {
      continue;
    }

    thread groundpoundshock_empplayer(var_07);
  }

  var_0A = scripts\mp\weapons::getempdamageents(self.origin, var_01, 0, undefined);
  foreach(var_0C in var_0A) {
    if(isDefined(var_0C.triggerportableradarping) && !scripts\mp\weapons::friendlyfirecheck(self, var_0C.triggerportableradarping)) {
      continue;
    }

    var_0C notify("emp_damage", self, 3);
  }
}

groundpoundshock_empplayer(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 scripts\mp\killstreaks\_emp_common::func_20C3();
  scripts\mp\gamescore::func_11ACE(self, param_00, "groundpound_mp");
  param_00 shellshock("concussion_grenade_mp", 3);
  wait(3);
  param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
  if(isDefined(self)) {
    scripts\mp\gamescore::untrackdebuffassist(self, param_00, "groundpound_mp");
  }
}

groundpoundshock_onimpactfx(param_00, param_01) {
  playFX(param_01, self.origin + (0, 0, 20), (0, 0, 1));
}

setgroundpoundboost() {
  thread scripts\mp\equipment\ground_pound::func_8655(8, 8, ::groundpoundboost_onimpact, "groundPoundBoost_unset");
}

unsetgroundpoundboost() {
  self notify("groundPoundBoost_unset");
}

groundpoundboost_onimpact(param_00) {
  scripts\engine\utility::set_doublejumpenergy(self energy_getmax(0));
}

setbattleslideshield() {
  level._effect["battleSlideShield_damage"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  thread battleslideshield_monitor();
}

unsetbattleslideshield() {
  self notify("battleSlideShield_unset");
}

battleslideshield_monitor() {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self notify("battleSlideShield_monitor");
  self endon("battleSlideShield_monitor");
  for(;;) {
    self waittill("sprint_slide_begin");
    thread battleslideshield_raise();
  }
}

battleslideshield_monitorhealth(param_00) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  while(isDefined(param_00)) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    thread battleslideshield_damagedfx(param_00, var_02, var_04, var_03);
    if(param_00.health <= 0) {
      thread battleslideshield_break(param_00);
      param_00 delete();
      continue;
    }

    if(param_00.health <= 125) {
      if(param_00.model != "weapon_shinguard_dam_wm") {
        param_00 setModel("weapon_shinguard_dam_wm");
      }

      continue;
    }

    if(param_00.model != "weapon_shinguard_wm") {
      param_00 setModel("weapon_shinguard_wm");
    }
  }
}

battleslideshield_raise() {
  if(isDefined(self.battleslideshield)) {
    thread battleslideshield_lower(self.battleslideshield);
  }

  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 setModel("weapon_shinguard_wm");
  var_00 setCanDamage(1);
  var_00.health = 250;
  var_00 linkto(self, "tag_origin", (30, 0, 0), (0, 90, 0));
  var_00 show();
  self.battleslideshield = var_00;
  thread battleslideshield_killonjumpfall(var_00);
  thread battleslideshield_killonsprint(var_00);
  thread battleslideshield_killontime(var_00);
  thread battleslideshield_unlinkonstop(var_00);
  thread battleslideshield_monitorhealth(var_00);
  thread battleslideshield_killondeathdisconnectunset(var_00);
  thread battleslideshield_raisefx(var_00);
  return var_00;
}

battleslideshield_lower(param_00) {
  self notify("battleSlideShield_end");
  if(!isDefined(param_00)) {
    return;
  }

  thread battleslideshield_lowerfx(param_00);
  param_00 delete();
}

battleslideshield_killondeathdisconnectunset(param_00) {
  param_00 endon("death");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "battleSlide_unset");
  param_00 delete();
}

battleslideshield_killonjumpfall(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  param_00 endon("death");
  for(;;) {
    if(!self isonground()) {
      param_00 delete();
      self notify("battleSlideShield_end");
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

battleslideshield_killonsprint(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  param_00 endon("death");
  self waittill("sprint_begin");
  param_00 delete();
  self notify("battleSlideShield_end");
}

battleslideshield_loweronleavearea(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  param_00 endon("death");
  for(;;) {
    if(lengthsquared(param_00.origin - self.origin) > 11664) {
      thread battleslideshield_lower(param_00);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

battleslideshield_lowerontime(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  param_00 endon("death");
  wait(3.5);
  thread battleslideshield_lower(param_00);
}

battleslideshield_unlink(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 unlink();
  self notify("battleSlideShield_unlink");
  thread battleslideshield_lowerontime(param_00);
  thread battleslideshield_loweronleavearea(param_00);
  self notify("battleSlideShield_unlink");
}

battleslideshield_killontime(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  param_00 endon("death");
  self waittill("sprint_slide_end");
  wait(0.75);
  param_00 delete();
  self notify("battleSlideShield_end");
}

battleslideshield_unlinkonstop(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  param_00 endon("death");
  self waittill("sprint_slide_end");
  for(;;) {
    if(lengthsquared(self getvelocity()) < 100) {
      thread battleslideshield_unlink(param_00);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

battleslideshield_break(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  thread battleslideshield_breakfx(param_00);
  self notify("battleSlideShield_end");
}

battleslideshield_raisefx(param_00) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  param_00 endon("death");
  self playlocalsound("heavy_shield_up");
  self playsoundtoteam("heavy_shield_up_npc", "axis", self);
  self playsoundtoteam("heavy_shield_up_npc", "allies", self);
}

battleslideshield_lowerfx(param_00) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  param_00 endon("death");
  self playlocalsound("heavy_shield_down");
  self playsoundtoteam("heavy_shield_down_npc", "axis", self);
  self playsoundtoteam("heavy_shield_down_npc", "allies", self);
}

battleslideshield_damagedfx(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  param_00 endon("death");
  playFX(scripts\engine\utility::getfx("battleSlideShield_damage"), param_02, -1 * param_03);
  playsoundatpos(param_02, "ds_shield_impact");
  param_01 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
}

battleslideshield_breakfx(param_00) {}

setbattleslideoffense() {}

unsetbattleslideoffense() {}

getbattleslideoffensedamage() {
  return 100;
}

setthruster() {
  level._effect["thrusterRadFr"] = loadfx("vfx\iw7\core\mp\powers\thrust_blast\vfx_thrust_blast_radius_fr");
  level._effect["thrusterRadEn"] = loadfx("vfx\iw7\core\mp\powers\thrust_blast\vfx_thrust_blast_radius_en");
  thrusterwatchdoublejump();
}

unsetthruster() {
  if(isDefined(self.thrustfxent)) {
    self.thrustfxent delete();
  }

  self notify("thruster_unset");
}

thrusterwatchdoublejump() {
  self endon("death");
  self endon("disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  for(;;) {
    self waittill("doubleJumpBoostBegin");
    thread thrusterloop();
    thread thrusterdamageloop();
  }
}

thrusterloop() {
  self endon("death");
  self endon("disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");
  if(!scripts\mp\utility::_hasperk("specialty_quieter")) {
    self playsoundonmovingent("demolition_jump_expl");
  }

  thread thrusterstopfx();
  if(!isDefined(self.thrustfxent)) {
    self.thrustfxent = spawn("script_model", self.origin);
    self.thrustfxent setModel("tag_origin");
  } else {
    self.thrustfxent.origin = self.origin;
  }

  wait(0.05);
  for(;;) {
    self playrumbleonentity("damage_light");
    scripts\mp\shellshock::_earthquake(0.1, 0.3, self.origin, 120);
    var_00 = playerphysicstrace(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self.thrustfxent.origin = var_00;
    self.thrustfxent.angles = (90, 0, 0);
    wait(0.05);
    scripts\mp\utility::func_D486(self.thrustfxent, "tag_origin", self.team, scripts\engine\utility::getfx("thrusterRadFr"), scripts\engine\utility::getfx("thrusterRadEn"));
    wait(0.33);
  }
}

thrusterdamageloop() {
  self endon("death");
  self endon("disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");
  for(;;) {
    scripts\mp\utility::radiusplayerdamage(self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1);
    wait(0.05);
  }
}

thrusterstopfx() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("doubleJumpBoostEnd", "thruster_unset");
  wait(0.05);
}

runhover() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  for(;;) {
    if(self ishighjumping() && self getweaponrankinfominxp() > 0.3 && self goal_position(0) > 0) {
      executehover();
      thread watchhoverend();
      self waittill("hover_ended");
      endhover();
    }

    wait(0.1);
  }
}

watchhoverend() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");
  while(self getweaponrankinfominxp() > 0.3) {
    wait(0.05);
  }

  self notify("hover_ended");
}

executehover() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = 1;
  self allowmovement(0);
  self allowjump(0);
  self playlocalsound("ghost_wall_attach");
  var_00 = scripts\engine\utility::spawn_tag_origin();
  self playerlinkto(var_00);
  thread managetimeout(var_00);
}

managetimeout(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  var_01 = self energy_getrestorerate(0);
  self goalflag(0, 1);
  wait(2);
  self notify("hover_ended");
  self goalflag(0, var_01);
  self goal_radius(0, 0);
}

endhover() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = undefined;
  self allowmovement(1);
  self allowjump(1);
  self playlocalsound("ghost_wall_detach");
  self unlink();
}