/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3538.gsc
**************************************/

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
  self autospotoverlayoff();
}

unsetautospot() {
  if(!isplayer(self)) {
    return;
  }
  self notify("endAutoSpotAdsWatcher");
  self autospotoverlayoff();
}

autospotadswatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    wait 0.05;

    if(self isusingturret()) {
      self autospotoverlayoff();
      continue;
    }

    var_1 = self playerads();

    if(var_1 < 1 && var_0) {
      var_0 = 0;
      self autospotoverlayoff();
    }

    if(var_1 < 1 && !var_0) {
      continue;
    }
    if(var_1 == 1 && !var_0) {
      var_0 = 1;
      self autospotoverlayon();
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
  scripts\mp\utility\game::removeperk("specialty_regenfaster");
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
  var_0 = self getcurrentweapon();
  var_1 = undefined;

  if(level.tactical) {
    if(weaponclass(var_0) == "sniper") {
      var_1 = 0.85;
    } else {
      var_1 = 0.5;
    }
  } else if(weaponclass(var_0) == "sniper")
    var_1 = 0.85;
  else {
    var_1 = 0.25;
  }

  scripts\mp\weapons::updateviewkickscale(var_1);
}

unsetsharpfocus() {
  self notify("stop_monitorSharpFocus");
  scripts\mp\weapons::updateviewkickscale(1.0);
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
  var_0 = scripts\mp\class::buildweaponname(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid);
  var_1 = scripts\mp\class::buildweaponname(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.var_AEA5);

  if(scripts\mp\utility\game::getweapongroup(var_0) == "weapon_projectile") {
    self setweaponammoclip(var_0, weaponclipsize(var_0));
  }

  if(scripts\mp\utility\game::getweapongroup(var_1) == "weapon_projectile") {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
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
    var_0 = self getweaponslist("primary");

    foreach(var_2 in var_0) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = weaponclipsize(var_2);
      var_5 = var_4 - var_3;
      var_6 = self getweaponammostock(var_2);

      if(var_3 != var_4 && var_6 > 0) {
        if(var_3 + var_6 >= var_4) {
          self setweaponammoclip(var_2, var_4);
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammoclip(var_2, var_3 + var_6);

        if(var_6 - var_5 > 0) {
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammostock(var_2, 0);
      }
    }
  }
}

unsetdoubleload() {
  self notify("endDoubleLoad");
}

setmarksman(var_0) {
  return;

  if(!isDefined(var_0)) {
    var_0 = 10;
  } else {
    var_0 = int(var_0) * 2;
  }

  scripts\mp\utility\game::setrecoilscale(var_0);
  self.recoilscale = var_0;
}

unsetmarksman() {
  return;
  scripts\mp\utility\game::setrecoilscale(0);
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
    var_0 = self getstance() == "crouch" && !self issprintsliding();

    if(!isDefined(self.fastcrouchspeedmod)) {
      if(var_0) {
        self.fastcrouchspeedmod = 0.3;
        scripts\mp\weapons::updatemovespeedscale();
      }
    } else if(!var_0) {
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
  wait 0.75;
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

setrshieldradar_cleanup() {
  self endon("unsetRShieldRadar");
  scripts\engine\utility::waittill_any("disconnect", "death");

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
  scripts\engine\utility::waittill_any("disconnect", "death");

  if(isDefined(self)) {
    unsetrshieldscrambler();
  }
}

unsetrshieldscrambler() {
  self clearscrambler();
  self notify("unsetRShieldScrambler");
}

setstunresistance(var_0) {
  scripts\mp\utility\game::giveperk("specialty_hard_shell");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_0 = int(var_0);

  if(var_0 == 10) {
    self.stunscalar = 0;
  } else {
    self.stunscalar = var_0 / 10;
  }
}

unsetstunresistance() {
  self.stunscalar = 1;
}

applystunresistence(var_0, var_1, var_2) {
  if(var_1 scripts\mp\utility\game::_hasperk("specialty_stun_resistance")) {
    if(isDefined(var_1.stunscalar) && isDefined(var_2)) {
      var_2 = var_2 * var_1.stunscalar;
    }

    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.owner), var_0.owner, var_0);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_1.owner), var_1.owner, var_1);

    if(isplayer(var_3) && var_3 != var_1) {
      var_0 scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }

    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_3, var_4))) {
      var_1 scripts\mp\missions::resistedstun(var_3);
    }
  }

  return var_2;
}

setweaponlaser() {
  if(isagent(self)) {
    return;
  }
  self endon("unsetWeaponLaser");
  wait 0.5;
  thread setweaponlaser_internal();
}

unsetweaponlaser() {
  self notify("unsetWeaponLaser");

  if(isDefined(self.perkweaponlaseron) && self.perkweaponlaseron) {
    scripts\mp\utility\game::disableweaponlaser();
  }

  self.perkweaponlaseron = undefined;
  self.perkweaponlaseroffforswitchstart = undefined;
}

setweaponlaser_waitforlaserweapon(var_0) {
  for(;;) {
    var_0 = getweaponbasename(var_0);

    if(isDefined(var_0) && (var_0 == "iw6_kac_mp" || var_0 == "iw6_arx160_mp")) {
      break;
    }
    self waittill("weapon_change", var_0);
  }
}

setweaponlaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var_0 = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(var_0);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      scripts\mp\utility\game::enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change", var_0);

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      scripts\mp\utility\game::disableweaponlaser();
    }
  }
}

setweaponlaser_monitorweaponswitchstart(var_0) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(var_0);
  }
}

setweaponlaser_onweaponswitchstart(var_0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    scripts\mp\utility\game::disableweaponlaser();
  }

  wait(var_0);
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    scripts\mp\utility\game::enableweaponlaser();
  }
}

setweaponlaser_monitorads() {
  self endon("weapon_change");

  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          scripts\mp\utility\game::disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        scripts\mp\utility\game::enableweaponlaser();
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
  self setaimspreadmovementscale(1.0);
}

blastshieldusetracker(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("end_perkUseTracker");
  level endon("game_ended");

  for(;;) {
    self waittill("empty_offhand");

    if(!scripts\engine\utility::isoffhandweaponsallowed()) {
      continue;
    }
    self[[var_1]](scripts\mp\utility\game::_hasperk("specialty_blastshield"));
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
  scripts\mp\utility\game::restorebasevisionset(1);

  if(!isDefined(self.endgametimer)) {
    return;
  }
  self.endgametimer scripts\mp\hud_util::destroyelem();
  self.endgameicon scripts\mp\hud_util::destroyelem();
}

endgamedeath(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait(var_0 + 1);
  scripts\mp\utility\game::_suicide();
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
    self waittill("damage", var_0, var_1);

    if(!isDefined(var_1.team)) {
      continue;
    }
    if(level.teambased && var_1.team == self.team) {
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
    self.movespeedscaler = scripts\mp\utility\game::lightweightscalar();
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
  scripts\mp\utility\game::giveperk("specialty_bulletaccuracy");
  scripts\mp\utility\game::giveperk("specialty_holdbreath");
}

unsetsteelnerves() {
  scripts\mp\utility\game::removeperk("specialty_bulletaccuracy");
  scripts\mp\utility\game::removeperk("specialty_holdbreath");
}

setdelaymine() {}

unsetdelaymine() {}

setlocaljammer() {
  if(!scripts\mp\killstreaks\emp_common::isemped()) {
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
    self waittill("weapon_change", var_0);

    if(var_0 != "onemanarmy_mp") {
      continue;
    }
    thread selectonemanarmyclass();
  }
}

isonemanarmymenu(var_0) {
  if(var_0 == game["menu_onemanarmy"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && var_0 == game["menu_onemanarmy_defaults_splitscreen"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && var_0 == game["menu_onemanarmy_custom_splitscreen"]) {
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
  self waittill("menuresponse", var_0, var_1);
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);

  if(var_1 == "back" || !isonemanarmymenu(var_0) || scripts\mp\utility\game::isusingremote()) {
    if(self getcurrentweapon() == "onemanarmy_mp") {
      scripts\engine\utility::allow_weapon_switch(0);
      scripts\engine\utility::allow_offhand_weapons(0);
      scripts\engine\utility::allow_usability(0);
      scripts\mp\utility\game::_switchtoweapon(scripts\engine\utility::getlastweapon());
      self waittill("weapon_change");
      scripts\engine\utility::allow_weapon_switch(1);
      scripts\engine\utility::allow_offhand_weapons(1);
      scripts\engine\utility::allow_usability(1);
    }

    return;
  }

  thread giveonemanarmyclass(var_1);
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

giveonemanarmyclass(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::_hasperk("specialty_omaquickchange")) {
    var_1 = 3.0;
    scripts\mp\utility\game::playplayerandnpcsounds(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    var_1 = 6.0;
    scripts\mp\utility\game::playplayerandnpcsounds(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
  }

  thread omausebar(var_1);
  scripts\engine\utility::allow_weapon(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_usability(0);
  wait(var_1);
  scripts\engine\utility::allow_weapon(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);
  self.var_C47E = 1;
  scripts\mp\class::giveloadout(self.pers["team"], var_0);

  if(isDefined(self.carryflag)) {
    self attach(self.carryflag, "J_spine4", 1);
  }

  self notify("changed_kit");
  level notify("changed_kit");
}

omausebar(var_0) {
  self endon("disconnect");
  var_1 = scripts\mp\hud_util::createprimaryprogressbar();
  var_2 = scripts\mp\hud_util::createprimaryprogressbartext();
  var_2 give_zap_perk(&"MPUI_CHANGING_KIT");
  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_0);

  for(var_3 = 0; var_3 < var_0 && isalive(self) && !level.gameended; var_3 = var_3 + 0.05) {
    wait 0.05;
  }

  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

setafterburner() {
  self.trait = "specialty_afterburner";
  self goalflag(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 600, 650));
  self goal_type(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 900, 900));
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
  var_0 = "secondary";
  var_1 = scripts\mp\powers::getcurrentequipment(var_0);

  if(isDefined(var_1)) {
    scripts\mp\powers::removepower(var_1);
  }

  scripts\mp\powers::givepower("power_tacInsert", var_0, 0);
  thread func_BA34();
}

unsettacticalinsertion() {
  self notify("end_monitorTIUse");
}

func_41D2() {
  scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");

  if(isDefined(self.setspawnpoint)) {
    deleteti(self.setspawnpoint);
  }
}

func_12F47() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");

  while(scripts\mp\utility\game::isreallyalive(self)) {
    if(func_9FE9()) {
      self.var_11947 = self.origin;
    }

    wait 0.05;
  }
}

func_9FE9() {
  if(canspawn(self.origin) && self isonground() && !scripts\mp\utility\game::func_11A44()) {
    return 1;
  } else {
    return 0;
  }
}

func_11899(var_0) {
  if(scripts\mp\utility\game::isreallyalive(var_0.owner)) {
    var_0.owner deleteti(self);
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
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 != "flare_mp") {
      continue;
    }
    if(isDefined(self.setspawnpoint)) {
      deleteti(self.setspawnpoint);
    }

    if(!isDefined(self.var_11947)) {
      continue;
    }
    if(scripts\mp\utility\game::touchingbadtrigger()) {
      continue;
    }
    var_2 = self.var_11947 + (0, 0, 16);
    var_3 = self.var_11947 - (0, 0, 2048);
    var_4 = playerphysicstrace(var_2, var_3) + (0, 0, 1);
    var_5 = [];
    var_5[0] = self;
    var_6 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
    var_7 = scripts\engine\trace::ray_trace(var_2, var_3, var_5, var_6, 0);
    var_8 = spawn("script_model", var_4);
    var_8.angles = self.angles;
    var_8.team = self.team;
    var_8.owner = self;
    var_8.enemytrigger = spawn("script_origin", var_4);
    var_8 thread _meth_83EC(self);
    var_8.playerspawnpos = self.var_11947;
    var_8 setotherent(self);
    var_8 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
    var_8 scripts\mp\weapons::explosivehandlemovers(var_7["entity"]);
    scripts\mp\weapons::ontacticalequipmentplanted(var_8);
    self.setspawnpoint = var_8;
    return;
  }
}

_meth_83EC(var_0) {
  self setModel(level.var_108D3["enemy"]);

  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 20));
  } else {
    scripts\mp\entityheadicons::setplayerheadicon(var_0, (0, 0, 20));
  }

  thread _meth_83E8(var_0);
  thread _meth_83E9(var_0);
  thread _meth_83EE(var_0);
  thread _meth_83EF(var_0);
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel(level.var_108D3["friendly"]);
  var_1 setcontents(0);
  var_1 linkto(self);
  var_1 playLoopSound("tactical_insert_lp");
  thread _meth_83ED(self, var_1, var_0);
  self waittill("death");
  var_1 stoploopsound();
  var_1 delete();
}

_meth_83ED(var_0, var_1, var_2) {
  var_0 endon("death");
  wait 0.05;
  var_3 = [];
  var_3["enemy"] = var_0;
  var_3["friendly"] = var_1;

  for(;;) {
    foreach(var_5 in var_3) {
      var_5 hide();
    }

    foreach(var_8 in level.players) {
      var_9 = "friendly";

      if(var_2 scripts\mp\utility\game::isenemy(var_8)) {
        var_9 = "enemy";
      }

      var_5 = var_3[var_9];
      var_5 show();
      scripts\engine\utility::waitframe();
      playfxontagforclients(level.var_108D2[var_9], var_5, "tag_fx", var_8);
    }

    level waittill("joined_team");

    foreach(var_9, var_5 in var_3) {
      stopFXOnTag(level.var_108D2[var_9], var_5, "tag_fx");
    }

    scripts\engine\utility::waitframe();
  }
}

deleteondeath(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_meth_83E8(var_0) {
  scripts\mp\damage::monitordamage(100, "tactical_insertion", ::_meth_83EB, ::_meth_83EA, 1);
}

_meth_83EB(var_0, var_1, var_2, var_3, var_4) {
  return scripts\mp\damage::handlemeleedamage(var_1, var_2);
}

_meth_83EA(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 notify("destroyed_insertion", self.owner);
    var_0 notify("destroyed_equipment");
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }

  var_0 thread deleteti(self);
}

_meth_83EE(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_PATCH_PICKUP_TI");
  thread func_12E8B(var_0);

  for(;;) {
    self waittill("trigger", var_1);
    var_1 playSound("tactical_insert_flare_pu");

    if(!var_1 scripts\mp\utility\game::isjuggernaut()) {
      var_1 thread settacticalinsertion();
    }

    var_1 thread deleteti(self);
  }
}

func_12E8B(var_0) {
  self endon("death");

  for(;;) {
    scripts\mp\utility\game::setselfusable(var_0);
    level scripts\engine\utility::waittill_either("joined_team", "player_spawned");
  }
}

_meth_83EF(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  thread deleteti(self);
}

deleteti(var_0) {
  if(isDefined(var_0.enemytrigger)) {
    var_0.enemytrigger delete();
  }

  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_0 getlinkedparent();
  var_0 delete();
  var_4 = spawn("script_model", var_1);
  var_4.angles = var_2;
  var_4 setModel(level.var_108D3["friendly"]);
  var_4 setcontents(0);

  if(isDefined(var_3)) {
    var_4 linkto(var_3);
  }

  thread func_5F2B(var_4);
}

func_5F2B(var_0) {
  wait 1;
  stopFXOnTag(level.var_108D2["friendly"], var_0, "tag_fx");
  stopFXOnTag(level.var_108D2["enemy"], var_0, "tag_fx");
  var_0 delete();
}

_meth_83E9(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self.enemytrigger setcursorhint("HINT_NOICON");
  self.enemytrigger sethintstring(&"MP_PATCH_DESTROY_TI");
  self.enemytrigger scripts\mp\utility\game::makeenemyusable(var_0);

  for(;;) {
    self.enemytrigger waittill("trigger", var_1);
    var_1 notify("destroyed_insertion", var_0);
    var_1 notify("destroyed_equipment");

    if(isDefined(var_0) && var_1 != var_0) {
      var_0 thread scripts\mp\utility\game::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
    }

    var_1 thread deleteti(self);
  }
}

setpainted(var_0) {
  if(isplayer(self)) {
    var_1 = 0.5;

    if(!scripts\mp\utility\game::_hasperk("specialty_engineer") && !scripts\mp\utility\game::_hasperk("specialty_noscopeoutline")) {
      self.painted = 1;
      var_2 = scripts\mp\utility\game::outlineenableforplayer(self, "orange", var_0, 0, 0, "perk");
      thread watchpainted(var_2, var_1);
      thread watchpaintedagain(var_2);
    }
  }
}

watchpainted(var_0, var_1) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout(var_1, "death");
  self.painted = 0;
  scripts\mp\utility\game::outlinedisable(var_0, self);
  self notify("painted_end");
}

watchpaintedagain(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("painted_again", "painted_end");
  scripts\mp\utility\game::outlinedisable(var_0, self);
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
    self waittill("weapon_change", var_0);

    if(var_0 == "none") {
      continue;
    }
    if(scripts\mp\utility\game::iskillstreakweapon(var_0)) {
      continue;
    }
    if(!scripts\mp\utility\game::isstrstart(var_0, "iw6_") && !scripts\mp\utility\game::isstrstart(var_0, "iw7_")) {
      continue;
    }
    var_1 = undefined;

    if(scripts\mp\utility\game::getweapongroup(var_0) == "weapon_pistol") {
      if(self.loadoutsecondaryattachments.size > 0) {
        var_1 = self.loadoutsecondaryattachments;
      }
    } else if(self.loadoutprimaryattachments.size > 0)
      var_1 = self.loadoutprimaryattachments;

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = 0;
    var_3 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0);

    if(var_3.size == 0) {
      var_2 = 1;
    } else {
      foreach(var_5 in var_1) {
        if(!scripts\engine\utility::array_contains(var_3, var_5)) {
          var_2 = 1;
          break;
        }
      }
    }

    if(!var_2) {
      continue;
    }
    var_7 = [];
    var_8 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_0);

    foreach(var_5 in var_1) {
      if(scripts\engine\utility::array_contains(var_8, var_5)) {
        var_7[var_7.size] = var_5;
      }
    }

    var_1 = var_7;
    var_11 = [];

    foreach(var_13 in var_3) {
      var_14 = 1;

      foreach(var_16 in var_1) {
        if(!scripts\mp\utility\game::attachmentscompatible(var_16, var_13)) {
          var_14 = 0;
          break;
        }
      }

      if(var_14) {
        var_11[var_11.size] = var_13;
      }
    }

    var_3 = var_11;
    var_19 = var_1.size + var_3.size;

    if(var_19 > 4) {
      var_3 = scripts\engine\utility::array_randomize(var_3);
    }

    for(var_20 = 0; var_1.size < 4 && var_20 < var_3.size; var_20++) {
      var_1[var_1.size] = var_3[var_20];
    }

    var_21 = getweaponbasename(var_0);
    var_22 = var_21;

    foreach(var_20, var_5 in var_1) {
      var_24 = scripts\mp\utility\game::attachmentmap_tounique(var_5, var_0);
      var_1[var_20] = var_24;
    }

    var_1 = scripts\engine\utility::alphabetize(var_1);

    foreach(var_5 in var_1) {
      var_22 = var_22 + ("_" + var_5);
    }

    if(var_22 != var_21) {
      var_27 = self getweaponammoclip(var_0);
      var_28 = self getweaponammostock(var_0);
      scripts\mp\utility\game::_takeweapon(var_0);
      self giveweapon(var_22);
      self setweaponammoclip(var_22, var_27);
      self setweaponammostock(var_22, var_28);
      scripts\mp\utility\game::_switchtoweapon(var_22);
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
    return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", self.class_num, "abilitiesPicked", scripts\mp\utility\game::func_7D91(6, 0));
  } else {
    var_0 = [];

    if(isDefined(self.pers["loadoutPerks"])) {
      var_0 = scripts\engine\utility::array_combine(var_0, self.pers["loadoutPerks"]);
    }

    foreach(var_2 in var_0) {
      if(scripts\mp\utility\game::getbaseperkname(var_2) == "specialty_gambler") {
        return 1;
      }
    }
  }

  return 0;
}

givefriendlyperks(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("unsetGambler");
  level endon("game_ended");

  if(!scripts\mp\utility\game::gameflag("prematch_done")) {
    scripts\mp\utility\game::gameflagwait("prematch_done");
  } else if(scripts\mp\utility\game::gameflag("prematch_done") && self.streaktype != "specialist") {
    self waittill("giveLoadout");
  }

  if(!isDefined(self.var_1519)) {
    self.var_1519 = 0;
  }

  if(!self.var_1519) {
    var_1 = getrandom_spammodel(var_0);
    self.var_7658 = var_1;
  } else
    var_1 = self.var_7658;

  scripts\mp\utility\game::giveperk(var_1.id);

  if(var_1.id == "specialty_hardline") {
    scripts\mp\killstreaks\killstreaks::func_F866();
  }

  if(func_1012B()) {
    self playlocalsound("mp_suitcase_pickup");
    self setclientomnvar("ui_gambler_show", var_1.var_E76D);
    thread func_7659();
  }

  if(level.gametype != "infect") {
    self.var_1519 = 1;
  }
}

func_1012B() {
  var_0 = 1;

  if(!level.ingraceperiod && self.var_1519) {
    var_0 = 0;
  }

  if(!scripts\mp\utility\game::allowclasschoice() && level.gametype != "infect") {
    var_0 = 0;
  }

  return var_0;
}

func_7659() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetGambler");
  level endon("game_ended");
  self waittill("luinotifyserver", var_0, var_1);

  if(var_0 == "gambler_anim_complete") {
    self setclientomnvar("ui_gambler_show", -1);
  }
}

getrandom_spammodel(var_0) {
  var_1 = [];
  var_1 = thread sortbyweight(var_0);
  var_1 = thread setbucketval(var_1);
  var_2 = randomint(level.var_151A["sum"]);
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!var_5.weight || var_5.id == "specialty_gambler") {
      continue;
    }
    if(var_5.weight > var_2) {
      var_3 = var_5;
      break;
    }
  }

  return var_3;
}

sortbyweight(var_0) {
  var_1 = [];
  var_2 = [];

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3].weight;
    var_1 = var_0[var_3];

    for(var_5 = var_3 - 1; var_5 >= 0 && is_weight_a_less_than_b(var_0[var_5].weight, var_4); var_5--) {
      var_2 = var_0[var_5];
      var_0[var_5] = var_1;
      var_0[var_5 + 1] = var_2;
    }
  }

  return var_0;
}

is_weight_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
}

setbucketval(var_0) {
  level.var_151A["sum"] = 0;

  foreach(var_2 in var_0) {
    if(!var_2.weight) {
      continue;
    }
    level.var_151A["sum"] = level.var_151A["sum"] + var_2.weight;
    var_2.weight = level.var_151A["sum"];
  }

  return var_0;
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
    var_0 = self _meth_8156();

    foreach(var_2 in var_0) {
      if(level.teambased && var_2.team == self.team) {
        continue;
      }
      if(isalive(var_2) && var_2.sessionstate == "playing") {
        if(!isDefined(var_2.perkoutlined)) {
          var_2.perkoutlined = 0;
        }

        if(!var_2.perkoutlined) {
          var_2.perkoutlined = 1;
        }

        var_2 thread outlinewatcher(self);
      }
    }
  }
}

outlinewatcher(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("eyesOff");
  level endon("game_ended");

  for(;;) {
    var_1 = 1;
    var_2 = var_0 _meth_8156();

    foreach(var_4 in var_2) {
      if(var_4 == self) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      self.perkoutlined = 0;
      self notify("eyesOff");
    }

    wait 0.5;
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
  scripts\mp\utility\game::giveperk("specialty_throwback");
  self setgrenadecookscale(1.5);

  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("grenade_pullback", var_0);

    if(var_0 == "airdrop_marker_mp" || var_0 == "killstreak_uplink_mp" || var_0 == "deployable_vest_marker_mp" || var_0 == "deployable_weapon_crate_marker_mp" || var_0 == "airdrop_juggernaut_mp") {
      self setgrenadethrowscale(1);
    }

    self waittill("grenade_fire", var_1, var_2);
  }
}

func_12D0C() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  scripts\mp\utility\game::removeperk("specialty_throwback");
  self notify("unsetPitcher");
}

setboom() {
  self.trait = "specialty_boom";
}

setboominternal(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  scripts\engine\utility::waitframe();
  triggerportableradarping(self.origin, var_0, 800, 1500);
  var_0 boomtrackplayers(self.origin, self);
}

boomtrackplayers(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_1 == var_3) {
      continue;
    }
    if(scripts\mp\utility\game::isenemy(var_3) && isalive(var_3) && !var_3 scripts\mp\utility\game::_hasperk("specialty_gpsjammer") && distancesquared(var_0, var_3.origin) <= 490000) {
      scripts\mp\missions::func_D991("ch_trait_ping");
    }
  }
}

boomtrackplayerdeath(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("removearchetype");
  var_2 = scripts\engine\utility::waittill_any_timeout(7.0, "death");

  if(var_2 == "timeout" && isDefined(self.markedbyboomperk[var_1])) {
    self.markedbyboomperk[var_1] = undefined;
  } else {
    self waittill("spawned_player");
    self.markedbyboomperk = undefined;
  }
}

unsetboom() {
  self.trait = undefined;
  self notify("unsetBoom");
}

customjuiced(var_0) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.1;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\game::giveperk("specialty_fastreload");
  scripts\mp\utility\game::giveperk("specialty_quickdraw");
  scripts\mp\utility\game::giveperk("specialty_stalker");
  scripts\mp\utility\game::giveperk("specialty_fastoffhand");
  scripts\mp\utility\game::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\game::giveperk("specialty_quickswap");
  thread unsetcustomjuicedondeath();
  thread unsetcustomjuicedonride();
  thread unsetcustomjuicedonmatchend();
  var_1 = var_0 * 1000 + gettime();

  if(!isai(self)) {
    self setclientomnvar("ui_juiced_end_milliseconds", var_1);
  }

  wait(var_0);
  unsetcustomjuiced();
}

unsetcustomjuiced(var_0) {
  if(!isDefined(var_0)) {
    if(scripts\mp\utility\game::isjuggernaut()) {
      if(isDefined(self.var_A4AA)) {
        self.movespeedscaler = self.var_A4AA;
      } else {
        self.movespeedscaler = 0.7;
      }
    } else {
      self.movespeedscaler = 1;

      if(scripts\mp\utility\game::_hasperk("specialty_lightweight")) {
        self.movespeedscaler = scripts\mp\utility\game::lightweightscalar();
      }
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\game::removeperk("specialty_fastreload");
  scripts\mp\utility\game::removeperk("specialty_quickdraw");
  scripts\mp\utility\game::removeperk("specialty_stalker");
  scripts\mp\utility\game::removeperk("specialty_fastoffhand");
  scripts\mp\utility\game::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\game::removeperk("specialty_quickswap");
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
    wait 0.05;

    if(scripts\mp\utility\game::isusingremote()) {
      thread unsetcustomjuiced();
      break;
    }
  }
}

unsetcustomjuicedondeath() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  scripts\engine\utility::waittill_any("death", "faux_spawn");
  thread unsetcustomjuiced(1);
}

unsetcustomjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  thread unsetcustomjuiced();
}

settriggerhappy() {}

settriggerhappyinternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");
  var_0 = self.lastdroppableweaponobj;
  var_1 = self getweaponammostock(var_0);
  var_2 = self getweaponammoclip(var_0);
  self givestartammo(var_0);
  var_3 = self getweaponammoclip(var_0);
  var_4 = var_3 - var_2;
  var_5 = var_1 - var_4;

  if(var_4 > var_1) {
    self setweaponammoclip(var_0, var_2 + var_1);
    var_5 = 0;
  }

  self setweaponammostock(var_0, var_5);
  self playlocalsound("ammo_crate_use");
  self setclientomnvar("ui_trigger_happy", 1);
  wait 0.2;
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

  var_0 = scripts\mp\utility\game::getvalidextraammoweapons();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && var_2 != "none") {
      self givemaxammo(var_2);
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

  var_0 = self.loadoutperkoffhand;

  if(isDefined(var_0) && var_0 != "specialty_null") {
    if(var_0 != "specialty_tacticalinsertion" && var_0 != "smoke_grenade_mp" && var_0 != "player_trophy_system_mp" && var_0 != "shoulder_cannon_mp") {
      self setweaponammoclip(var_0, 2);
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

func_10D79(var_0) {
  if(isDefined(var_0) && var_0 != self) {
    var_1 = self getweaponslistall();
    var_2 = 1;
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(var_5 != "throwingknife_mp") {
        var_3 = self getweaponammoclip(var_5);
        var_2 = var_2 + var_3;
      }
    }

    var_7 = 1;
    var_8 = spawn("script_origin", self.origin);
    var_8.owner = var_0;

    if(!isDefined(var_8.team)) {
      var_8.team = var_0.team;
    }

    var_8.clusterticks = var_2;
    var_8 thread scripts\mp\weapons::func_42D8(var_7);
    var_8 notify("explode", var_8.origin);
    var_8 delete();
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
    self waittill("got_a_kill", var_0, var_1, var_2);
    var_3 = self.origin;
    var_4 = 20;
    var_5 = 20;
    var_6 = spawn("script_model", self.origin + (0, 0, 10));
    var_6 setModel("weapon_life_pack");
    var_6.owner = self;
    var_6.team = self.team;
    var_6 hidefromplayer(self);
    var_7 = spawn("trigger_radius", self.origin, 0, var_4, var_5);
    var_7 thread watchlifepackuse(var_6);
    var_7 thread watchlifepackdeath(var_6);
    var_6 thread hoverlifepack();
    var_6 rotateyaw(1000, 30, 0.2, 0.2);
    var_6 thread watchlifepacklifetime(10, var_7);
    var_6 thread watchlifepackowner();

    foreach(var_9 in level.players) {
      var_6 setlifepackvisualforplayer(var_9);
    }
  }
}

activatelifepackboost(var_0, var_1, var_2) {
  self.lifeboostactive = 1;

  if(isDefined(var_1) && var_1 > 0) {
    thread watchlifepackboostlifetime(var_1);
  }

  if(isDefined(var_2) && var_2) {
    thread watchlifepackuserdeath();
  }

  scripts\mp\utility\game::giveperk("specialty_regenfaster");
  self setclientomnvar("ui_life_link", 1);
  self notify("enabled_life_pack_boost");
  self.lifepackowner = var_0;
  scripts\mp\gamescore::trackbuffassist(var_0, self, "medic_lifepack");
}

watchlifepackboostlifetime(var_0) {
  self endon("death");
  self endon("disconnect");
  wait(var_0);

  if(isDefined(self.lifeboostactive)) {
    disablelifepackboost();
  }
}

disablelifepackboost() {
  if(isDefined(self) && isDefined(self.lifeboostactive)) {
    self.lifeboostactive = undefined;
    self setclientomnvar("ui_life_link", 0);
    self notify("disabled_life_pack_boost");
    scripts\mp\utility\game::removeperk("specialty_regenfaster");
    scripts\mp\gamescore::untrackbuffassist(self.lifepackowner, self, "medic_lifepack");
    self.lifepackowner = undefined;
  }
}

setlifepackvisualforplayer(var_0) {
  if(level.teambased && var_0.team == self.team && var_0 != self.owner) {
    setlifepackoutlinestate(var_0);
    self giveperkequipment(var_0);
    thread watchlifepackoutlinestate(var_0);
  } else
    self hidefromplayer(var_0);
}

setlifepackoutlinestate(var_0) {
  if(isDefined(var_0.lifeboostactive)) {
    if(isDefined(var_0.lifepackoutlines) && var_0.lifepackoutlines.size > 0) {
      foreach(var_2 in var_0.lifepackoutlines) {
        if(self == var_2.pack) {
          scripts\mp\utility\game::outlinedisable(var_2.id, var_2.pack);
          var_0.lifepackoutlines = scripts\engine\utility::array_remove(var_0.lifepackoutlines, var_2);
          var_2 = undefined;
        }
      }
    }
  } else {
    if(!isDefined(var_0.lifepackoutlines)) {
      var_0.lifepackoutlines = [];
    }

    var_4 = spawnStruct();
    var_4.id = scripts\mp\utility\game::outlineenableforplayer(self, "cyan", var_0, 1, 0, "equipment");
    var_4.pack = self;
    var_0.lifepackoutlines = scripts\engine\utility::add_to_array(var_0.lifepackoutlines, var_4);
  }
}

watchlifepackoutlinestate(var_0) {
  self endon("death");

  for(;;) {
    var_0 scripts\engine\utility::waittill_any("enabled_life_pack_boost", "disabled_life_pack_boost");
    setlifepackoutlinestate(var_0);
  }
}

hoverlifepack() {
  self endon("death");
  self endon("phase_resource_pickup");
  var_0 = self.origin;

  for(;;) {
    self moveto(var_0 + (0, 0, 15), 1, 0.2, 0.2);
    wait 1;
    self moveto(var_0, 1, 0.2, 0.2);
    wait 1;
  }
}

watchlifepackuse(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isplayer(var_1)) {
      continue;
    }
    if(var_1.team != var_0.team) {
      continue;
    }
    if(isDefined(var_1.lifeboostactive)) {
      continue;
    }
    if(var_1 == var_0.owner) {
      continue;
    }
    var_1 activatelifepackboost(var_0.owner, 5, 1);
    var_1 playlocalsound("scavenger_pack_pickup");
    var_2 = spawnfx(scripts\engine\utility::getfx("life_pack_pickup"), self.origin);
    triggerfx(var_2);
    var_2 thread scripts\mp\utility\game::delayentdelete(2);

    foreach(var_4 in level.players) {
      if(var_4.team == var_1.team) {
        continue;
      }
      var_2 hidefromplayer(var_4);
    }

    var_0 delete();
  }
}

watchlifepackdeath(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

watchlifepacklifetime(var_0, var_1) {
  self endon("death");
  wait(var_0);
  var_1 delete();
  self delete();
}

watchlifepackowner() {
  self endon("death");
  self.owner waittill("disconnect");

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
  var_0 = 0;
  var_1 = 15;
  var_2 = 7.5;
  var_3 = 4;
  var_4 = 5;
  var_5 = 2;
  var_6 = [];
  var_6 = scripts\engine\utility::add_to_array(var_6, (35, 0, 10));
  var_6 = scripts\engine\utility::add_to_array(var_6, (0, 35, 10));
  var_6 = scripts\engine\utility::add_to_array(var_6, (-35, 0, 10));
  var_6 = scripts\engine\utility::add_to_array(var_6, (0, -35, 10));
  self waittill("spawned_player");

  for(;;) {
    self waittill("got_a_kill", var_7, var_8, var_9);

    if(!isDefined(self.toughenedup)) {
      self.toughenedup = 1;
      var_10 = spawnfxforclient(scripts\engine\utility::getfx("toughen_up_screen"), self getEye(), self);
      triggerfx(var_10);
      thread attachtoughenuparmor("j_forehead", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_ri", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_spineupper", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_shield_back", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_ri", level.bulletstormshield["section"].friendlymodel);

      if(var_5 == 1) {
        scripts\mp\utility\game::func_F741(var_1);
        thread watchtoughenuplifetime(var_4);
      } else {
        scripts\mp\lightarmor::setlightarmorvalue(self, 100);
        thread watchtoughenuplightarmorend();
      }

      var_10 thread watchtoughenupplayerend(self);
      continue;
    }

    if(var_5 == 1) {
      self notify("toughen_up_reset");
      thread watchtoughenuplifetime(var_4);
    }
  }
}

attachtoughenuparmor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_0);
  var_6 = spawn("script_model", var_5);
  var_6 setModel(var_1);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  var_6.angles = self.angles;
  var_6 linkto(self, var_0, var_7, var_8);
  var_6 thread watchtoughenupplayerend(self);
  var_6 thread watchtoughenupgameend();
  return var_6;
}

settoughenupmodel(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", self.origin + (0, 0, 50));
  var_4.team = self.owner.team;

  if(var_3 == "friendly") {
    var_4 setModel(level.bulletstormshield["section"].friendlymodel);
  } else {
    var_4 setModel(level.bulletstormshield["section"].enemymodel);
  }

  var_4 linkto(self, "tag_origin", var_1, (0, 90 * (var_2 + 1), 0));
  var_4 hide();
  var_4 thread watchtoughenupplayerend(self.owner);
  var_4 thread watchtoughenupgameend();
  var_4 thread settoughenupvisiblestate(var_3, self.owner);
}

watchtoughenuplightarmorend() {
  self endon("disconnect");
  self waittill("remove_light_armor");
}

watchtoughenupplayerend(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("death", "disconnect", "toughen_up_end");
  var_0.toughenedup = undefined;

  if(var_0 scripts\mp\lightarmor::haslightarmor(var_0)) {
    var_0 unsetlightarmor();
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

watchtoughenuplifetime(var_0) {
  self endon("death");
  self endon("toughen_up_reset");

  while(var_0 > 0) {
    var_0 = var_0 - 1;
    wait 1;
  }

  self notify("toughen_up_end");
}

settoughenupvisiblestate(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_3)) {
      if(canshowtoughenupshield(var_3, var_0)) {
        self giveperkequipment(var_3);
      }
    }

    thread watchtoughenupplayerbegin(var_3, var_0);
    thread watchtoughenupplayer(var_3, var_0);
  }
}

watchtoughenupplayerbegin(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 waittill("spawned_player");
    self hidefromplayer(var_0);

    if(canshowtoughenupshield(var_0, var_1)) {
      self giveperkequipment(var_0);
    }

    thread watchtoughenupplayer(var_0, var_1);
  }
}

canshowtoughenupshield(var_0, var_1) {
  var_2 = 0;

  if(var_1 == "friendly" && var_0.team == self.team || var_1 == "enemy" && var_0.team != self.team) {
    var_2 = 1;
  }

  return var_2;
}

watchtoughenupplayer(var_0, var_1) {}

unsettoughenup() {
  scripts\mp\utility\game::clearhealthshield();
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
  var_0 = 50;
  var_1 = 1200;

  for(;;) {
    var_2 = var_0;
    var_3 = var_1;

    if(isDefined(self.scoutpingradius)) {
      var_2 = self.scoutpingradius;
    }

    if(isDefined(self.scoutsweeptime)) {
      var_3 = self.scoutsweeptime;
    }

    var_2 = int(var_2);
    var_3 = int(var_3);

    if(var_2 != var_0) {
      triggerportableradarpingteam(self.origin, self.team, var_2, var_3);
    }

    wait(var_1 / 1200);
  }
}

updatescoutpingvalues(var_0) {
  var_1 = 0;
  var_2 = 150;
  var_3 = 3000;

  if(isDefined(self.scoutpingmod)) {
    var_1 = self.scoutpingmod;
  }

  if(isDefined(self.scoutpingpreviousstage)) {
    if(var_0 > self.scoutpingpreviousstage) {
      var_4 = var_0 - self.scoutpingpreviousstage;
      var_1 = var_1 + var_4 / 10;
    } else if(var_0 < self.scoutpingpreviousstage) {
      var_4 = self.scoutpingpreviousstage - var_0;
      var_1 = var_1 - var_4 / 10;
    }
  }

  if(isDefined(self.scoutpingmod)) {
    if(var_1 > self.scoutpingmod || var_1 < self.scoutpingmod) {
      var_2 = var_2 + var_2 * var_1 * 1.5;
      var_3 = var_3 - var_3 * var_1 / 1.5;
      self.scoutpingradius = var_2;
      self.scoutsweeptime = var_3;
    }
  }

  if(var_0 == 0) {
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
  }

  self.scoutpingmod = var_1;
  self.scoutpingpreviousstage = var_0;
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
    self waittill("got_a_kill", var_0, var_1, var_2);
    var_3 = var_0 _meth_8113();
    var_4 = "primary";
    var_5 = "none";
    var_6 = getarraykeys(var_0.powers);

    foreach(var_8 in var_6) {
      if(var_0.powers[var_8].slot == var_4) {
        var_5 = var_8;
      }
    }

    if(var_5 == "none") {
      continue;
    }
    var_10 = 20;
    var_11 = 20;
    var_12 = spawn("script_model", var_3.origin + (0, 0, 10));
    var_12.owner = self;
    var_12.team = self.team;
    var_13 = spawn("trigger_radius", var_3.origin, 0, var_10, var_11);
    var_13 thread func_139D9(var_12);
    var_12 thread func_139DA(30, var_13);
    var_12 thread func_139DB();
    var_12 func_B29E(var_5);
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
    } else
      return;

    wait 0.05;
  }
}

func_4650(var_0, var_1, var_2) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self.trigger setcursorhint("HINT_NOICON");

  switch (var_2) {
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

  foreach(var_4 in level.players) {
    if(var_4 == var_0) {
      self.trigger enableplayeruse(var_4);
      continue;
    }

    self.trigger disableplayeruse(var_4);
  }

  self.trigger thread scripts\mp\utility\game::notusableforjoiningplayers(var_0);

  if(isDefined(var_1) && var_1) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", var_0);
    var_0 playlocalsound("scavenger_pack_pickup");
    var_6 = var_2;
    var_7 = "primary";
    var_0 notify("start_copycat");
    var_0 notify("corpse_steal");
    var_8 = "none";
    var_9 = getarraykeys(var_0.powers);

    foreach(var_11 in var_9) {
      if(var_0.powers[var_11].slot == var_7) {
        var_8 = var_11;
      }
    }

    var_0 scripts\mp\powers::removepower(var_8);
    var_0 scripts\mp\powers::givepower(var_6, var_7, 1);
    var_0 thread scripts\mp\weapons::func_139D7(var_6, var_7);
    self.trigger delete();
    self delete();
    self notify("death");
  }
}

func_B29E(var_0) {
  if(scripts\mp\utility\game::isreallyalive(self.owner)) {
    self setotherent(self.owner);
    self.trigger = spawn("script_origin", self.origin, 0, 1, 1);
    self.trigger.owner = self;
    thread func_4650(self.owner, 1, var_0);
  }
}

func_139D9(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

func_139DA(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self.trigger delete();
  var_1 delete();
  self delete();
}

func_139DB() {
  self endon("death");
  self.owner waittill("disconnect");

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

  if(scripts\mp\utility\game::isanymlgmatch()) {
    self _meth_8454(6);
  } else {
    self _meth_8454(3);
  }

  scripts\mp\perks\perks_dodgedefense::func_139F9();
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
    var_0 = 0;
    var_1 = level.players;
    var_2 = 0;
    var_3 = scripts\mp\utility\game::_hasperk("specialty_enhanced_sixth_sense");

    if(!scripts\mp\killstreaks\emp_common::isemped()) {
      foreach(var_5 in var_1) {
        if(!isDefined(var_5) || !scripts\mp\utility\game::isreallyalive(var_5)) {
          continue;
        }
        if(var_5.team == self.team) {
          continue;
        }
        if(var_5 scripts\mp\utility\game::_hasperk("specialty_coldblooded")) {
          continue;
        }
        if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_5)) {
          continue;
        }
        var_6 = self.origin - var_5.origin;
        var_7 = anglesToForward(var_5 getplayerangles());
        var_8 = vectordot(var_6, var_7);

        if(var_8 <= 0) {
          continue;
        }
        var_9 = vectornormalize(var_6);
        var_10 = vectornormalize(var_7);
        var_8 = vectordot(var_9, var_10);

        if(var_8 < 0.965926) {
          continue;
        }
        var_0++;
        var_11 = var_5 getEye();
        var_12 = self getEye();

        if(bullettracepassed(var_11, var_12, 0, self)) {
          thread watchperceptionchallengedeath();
          thread watchperceptionchallengeprogress();
          var_2 = var_2 | getsixthsensedirection(var_5);
          thread markassixthsensesource(var_5);
          continue;
        }

        if(var_0 >= 3) {
          scripts\engine\utility::waitframe();
          var_0 = 0;
        }
      }
    }

    if(var_2 > 4) {
      var_2 = 255;
    } else {
      var_2 = 0;
    }

    updatesixthsensevfx(var_2, var_3);
    scripts\engine\utility::waitframe();
  }
}

watchperceptionchallengedeath() {
  self endon("disconnect");

  if(scripts\mp\utility\game::istrue(self.startperceptionchallengewatch)) {
    return;
  }
  scripts\engine\utility::waittill_any("removesixthsense", "death", "perceptionChallengeCheckDone");
  self.startperceptionchallengewatch = 0;
}

watchperceptionchallengeprogress() {
  self endon("disconnect");
  self endon("removesixthsense");
  self endon("death");

  if(scripts\mp\utility\game::istrue(self.startperceptionchallengewatch)) {
    return;
  }
  self.startperceptionchallengewatch = 1;
  wait 10.0;
  scripts\mp\missions::func_D991("ch_trait_perception");
  self notify("perceptionChallengeCheckDone");
}

watchdeathsixthsense() {
  self endon("disconnect");
  self endon("removesixthsense");
  self waittill("death");
  self setclientomnvar("ui_edge_glow", 0);
}

updatesixthsensevfx(var_0, var_1) {
  var_2 = 0;

  if(isDefined(self.var_10224)) {
    var_2 = self.var_10224;
  }

  if(isDefined(var_1) && var_1) {
    if(var_2 != var_0) {
      self.var_10224 = var_0;
    }
  }

  self setclientomnvar("ui_edge_glow", var_0);
}

getsixthsensedirection(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectornormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  } else if(var_5 >= 0.382683) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\game::isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  } else if(var_5 >= -0.382683) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\game::isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  } else if(var_5 >= -0.92388) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\game::isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  } else {
    return 16;
  }
}

markassixthsensesource(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = var_0 getentitynumber();

  if(!isDefined(self.sixthsensesource)) {
    self.sixthsensesource = [];
  } else if(isDefined(self.sixthsensesource[var_1])) {
    self notify("markAsSixthSenseSource");
    self endon("markAsSixthSenseSource");
  }

  self.sixthsensesource[var_1] = 1;
  var_0 scripts\engine\utility::waittill_any_timeout(10, "death");
  self.sixthsensesource[var_1] = 0;
}

setcamoelite() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");

  for(;;) {
    var_0 = 0;
    var_1 = level.players;
    var_2 = 0;

    if(!scripts\mp\killstreaks\emp_common::isemped()) {
      foreach(var_4 in var_1) {
        if(!isDefined(var_4) || !scripts\mp\utility\game::isreallyalive(var_4)) {
          continue;
        }
        if(var_4.team == self.team) {
          continue;
        }
        if(var_4 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
          continue;
        }
        if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_4)) {
          continue;
        }
        var_5 = self.origin - var_4.origin;
        var_6 = anglesToForward(var_4 getplayerangles());
        var_7 = vectordot(var_5, var_6);

        if(var_7 <= 0) {
          continue;
        }
        var_8 = vectornormalize(var_5);
        var_9 = vectornormalize(var_6);
        var_7 = vectordot(var_8, var_9);

        if(var_7 < 0.965926) {
          continue;
        }
        var_0++;
        var_10 = var_4 getEye();
        var_11 = self getEye();

        if(bullettracepassed(var_10, var_11, 0, self)) {
          var_2 = 1;
          break;
        }

        if(var_0 >= 3) {
          scripts\engine\utility::waitframe();
          var_0 = 0;
        }
      }

      scripts\engine\utility::waitframe();
    }

    updatecamoeliteoverlay(var_2);
    scripts\engine\utility::waitframe();
  }
}

updatecamoeliteoverlay(var_0) {}

unsetcamoelite() {}

func_F704() {
  scripts\mp\utility\game::giveperk("specialty_pistoldeath");
}

func_12CBD() {
  scripts\mp\utility\game::removeperk("specialty_pistoldeath");
}

setcarepackage() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("airdrop_assault", 0, 0, self);
}

unsetcarepackage() {}

setuav() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("uav", 0, 0, self);
}

unsetuav() {}

func_F864() {
  scripts\mp\utility\game::giveperk("specialty_bulletdamage");
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
  scripts\mp\utility\game::removeperk("specialty_bulletdamage");
  self notify("watchStoppingPowerKill");
}

func_F678() {
  scripts\mp\utility\game::giveperk("specialty_pistoldeath");
}

func_12C8A() {
  if(scripts\mp\utility\game::_hasperk("specialty_pistoldeath")) {
    scripts\mp\utility\game::removeperk("specialty_pistoldeath");
  }
}

setjuiced(var_0) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.25;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\game::giveperk("specialty_fastreload");
  scripts\mp\utility\game::giveperk("specialty_quickdraw");
  scripts\mp\utility\game::giveperk("specialty_stalker");
  scripts\mp\utility\game::giveperk("specialty_fastoffhand");
  scripts\mp\utility\game::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\game::giveperk("specialty_quickswap");
  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  thread unsetjuicedonmatchend();

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = var_0 * 1000 + gettime();

  if(!isai(self)) {
    self setclientomnvar("ui_juiced_end_milliseconds", var_1);
  }

  wait(var_0);
  unsetjuiced();
}

unsetjuiced(var_0) {
  if(!isDefined(var_0)) {
    if(scripts\mp\utility\game::isjuggernaut()) {
      if(isDefined(self.var_A4AA)) {
        self.movespeedscaler = self.var_A4AA;
      } else {
        self.movespeedscaler = 0.7;
      }
    } else {
      self.movespeedscaler = 1;

      if(scripts\mp\utility\game::_hasperk("specialty_lightweight")) {
        self.movespeedscaler = scripts\mp\utility\game::lightweightscalar();
      }
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\game::removeperk("specialty_fastreload");
  scripts\mp\utility\game::removeperk("specialty_quickdraw");
  scripts\mp\utility\game::removeperk("specialty_stalker");
  scripts\mp\utility\game::removeperk("specialty_fastoffhand");
  scripts\mp\utility\game::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\game::removeperk("specialty_quickswap");
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
    wait 0.05;

    if(scripts\mp\utility\game::isusingremote()) {
      thread unsetjuiced();
      break;
    }
  }
}

unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  scripts\engine\utility::waittill_any("death", "faux_spawn");
  thread unsetjuiced(1);
}

unsetjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_juiced");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
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
    var_0 = 56;
    var_1 = 21;
  } else {
    var_0 = 112;
    var_1 = 32;
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
  self.combathightimer = scripts\mp\hud_util::createtimer("hudsmall", 1.0);
  self.combathightimer scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_0);
  self.combathightimer settimer(10.0);
  self.combathightimer.color = (0.8, 0.8, 0);
  self.combathightimer.archived = 0;
  self.combathightimer.foreground = 1;
  self.combathighicon = scripts\mp\hud_util::createicon("specialty_painkiller", var_1, var_1);
  self.combathighicon.alpha = 0;
  self.combathighicon scripts\mp\hud_util::setparent(self.combathightimer);
  self.combathighicon scripts\mp\hud_util::setpoint("BOTTOM", "TOP");
  self.combathighicon.archived = 1;
  self.combathighicon.sort = 1;
  self.combathighicon.foreground = 1;
  self.combathighoverlay.alpha = 0.0;
  self.combathighoverlay fadeovertime(1.0);
  self.combathighicon fadeovertime(1.0);
  self.combathighoverlay.alpha = 1.0;
  self.combathighicon.alpha = 0.85;
  thread unsetcombathighondeath();
  thread unsetcombathighonride();
  wait 8;
  self.combathighicon fadeovertime(2.0);
  self.combathighicon.alpha = 0.0;
  self.combathighoverlay fadeovertime(2.0);
  self.combathighoverlay.alpha = 0.0;
  self.combathightimer fadeovertime(2.0);
  self.combathightimer.alpha = 0.0;
  wait 2;
  self.damageblockedtotal = undefined;
  scripts\mp\utility\game::removeperk("specialty_combathigh");
}

unsetcombathighondeath() {
  self endon("disconnect");
  self endon("unset_combathigh");
  self waittill("death");
  thread scripts\mp\utility\game::removeperk("specialty_combathigh");
}

unsetcombathighonride() {
  self endon("disconnect");
  self endon("unset_combathigh");

  for(;;) {
    wait 0.05;

    if(scripts\mp\utility\game::isusingremote()) {
      thread scripts\mp\utility\game::removeperk("specialty_combathigh");
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
  wait 0.05;

  if(!isDefined(self.lastkilledby)) {
    return;
  }
  if(level.teambased && self.team == self.lastkilledby.team) {
    return;
  }
  var_0 = spawnStruct();
  var_0.showto = self;
  var_0.icon = "compassping_revenge";
  var_0.offset = (0, 0, 64);
  var_0.width = 10;
  var_0.height = 10;
  var_0.archived = 0;
  var_0.delay = 1.5;
  var_0.constantsize = 0;
  var_0.pintoscreenedge = 1;
  var_0.fadeoutpinnedicon = 0;
  var_0.is3d = 0;
  self.revengeparams = var_0;
  self.lastkilledby scripts\mp\entityheadicons::setheadicon(var_0.showto, var_0.icon, var_0.offset, var_0.width, var_0.height, var_0.archived, var_0.delay, var_0.constantsize, var_0.pintoscreenedge, var_0.fadeoutpinnedicon, var_0.is3d);
  thread watchrevengedeath();
  thread watchrevengekill();
  thread watchrevengedisconnected();
  thread watchrevengevictimdisconnected();
  thread watchstoprevenge();
}

watchrevengedeath() {
  self endon("stopRevenge");
  self endon("disconnect");
  var_0 = self.lastkilledby;

  for(;;) {
    var_0 waittill("spawned_player");
    var_0 scripts\mp\entityheadicons::setheadicon(self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, self.revengeparams.width, self.revengeparams.height, self.revengeparams.archived, self.revengeparams.delay, self.revengeparams.constantsize, self.revengeparams.pintoscreenedge, self.revengeparams.fadeoutpinnedicon, self.revengeparams.is3d);
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
  var_0 = self.lastkilledby;
  self waittill("stopRevenge");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3, var_2 in var_0.entityheadicons) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 destroy();
  }
}

watchrevengevictimdisconnected() {
  var_0 = self.objidfriendly;
  var_1 = self.lastkilledby;
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");
  self waittill("disconnect");

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_4, var_3 in var_1.entityheadicons) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 destroy();
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
  scripts\mp\perks\perk_mark_targets::marktarget_init();
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
  scripts\mp\utility\game::adddamagemodifier("dodgeDefense", 0.5, 0, ::dodgedefenseignorefunc);
}

unsetdodgedefense() {
  scripts\mp\utility\game::removedamagemodifier("dodgeDefense", 0);
}

dodgedefenseignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!(isDefined(var_2.dodging) && var_2.dodging && var_2 scripts\mp\utility\game::_hasperk("specialty_dodge_defense"))) {
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
    var_0 = self getcurrentweapon();
    scripts\mp\utility\game::_takeweapon("iw7_fists_mp");
    self giveweapon("iw7_fistslethal_mp");

    if(var_0 == "iw7_fists_mp") {
      scripts\mp\utility\game::_switchtoweapon("iw7_fistslethal_mp");

      if(isDefined(self.gettingloadout) && self.gettingloadout && isDefined(self.spawnweaponobj) && self.spawnweaponobj == "iw7_fists_mp") {
        self setspawnweapon("iw7_fistslethal_mp");
        self.spawnweaponobj = "iw7_fistslethal_mp";
      }
    }
  }
}

unsetmeleekill() {
  scripts\mp\utility\game::_takeweapon("iw7_fistsperk_mp");

  if(self hasweapon("iw7_fistslethal_mp")) {
    var_0 = self getcurrentweapon();
    scripts\mp\utility\game::_takeweapon("iw7_fistslethal_mp");
    self giveweapon("iw7_fists_mp");

    if(var_0 == "iw7_fistslethal_mp") {
      scripts\mp\utility\game::_switchtoweapon("iw7_fists_mp");
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
    self waittill("got_a_kill", var_0, var_1, var_2);

    if(isDefined(var_1) && !scripts\mp\utility\game::iskillstreakweapon(var_1)) {
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
    foreach(var_1 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_1)) {
        continue;
      }
      if(var_1.team == self.team) {
        continue;
      }
      if(var_1 scripts\mp\utility\game::_hasperk("specialty_coldblooded")) {
        continue;
      }
      if(var_1 scripts\mp\utility\game::_hasperk("specialty_gpsjammer")) {
        continue;
      }
      if(length2d(var_1 getvelocity()) < 150 && !isDefined(var_1.campfire_temp_dialog) && distance2d(self.origin, var_1.origin) < 1024) {
        thread func_49EE(var_1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_49EE(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(self) || !scripts\mp\utility\game::isreallyalive(self)) {
    return;
  }
  var_0.campfire_temp_dialog = 1;
  var_1 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_1 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_1, "active", var_0.origin, "cb_compassping_sniper_enemy", self);
    scripts\mp\objidpoolmanager::minimap_objective_team(var_1, self.team);
    var_0 thread watchfordeath(var_1);
  }

  while(length2d(var_0 getvelocity()) < 150) {
    wait 2;
  }

  scripts\mp\objidpoolmanager::returnminimapid(var_1);
  var_0.campfire_temp_dialog = undefined;
}

watchfordeath(var_0) {
  scripts\engine\utility::waittill_any("death", "disconnect");
  scripts\mp\objidpoolmanager::returnminimapid(var_0);
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
  thread scripts\mp\playertrophysystem::func_D446();
}

func_12D04() {
  self.trait = undefined;
  thread scripts\mp\playertrophysystem::func_D448();
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

feedbackruggedeqp(var_0, var_1) {}

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
  var_0 = self.engstructks;
  thread engineer_watchownerdisconnect(var_0, "unsetOutlineKillstreaks");

  for(;;) {
    var_1 = level.var_1655;

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model)) {
          if(engineer_shouldoutlineent(var_3, var_0)) {
            engineer_addoutlinedent(var_3, var_0);
          }
        }
      }
    }

    wait 0.1;
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
  var_0 = self.engstructeqp;
  thread engineer_watchownerdisconnect(var_0, "unsetEngineer");

  for(;;) {
    var_1 = func_7D96();

    foreach(var_3 in var_1) {
      if(engineer_shouldoutlineent(var_3, var_0)) {
        engineer_addoutlinedent(var_3, var_0);
      }
    }

    wait 0.1;
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
  var_0 = spawnStruct();
  var_0.owner = self;
  var_0.var_C78E = [];
  var_0.outlinedids = [];
  return var_0;
}

engineer_addoutlinedent(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = var_1.outlinedids[var_2];

  if(isDefined(var_3)) {
    thread engineer_removeoutlinedent(var_2, var_1);
  }

  var_3 = scripts\mp\utility\game::outlineenableforplayer(var_0, "red", var_1.owner, 0, 1, "level_script");
  var_1.var_C78E[var_2] = var_0;
  var_1.outlinedids[var_2] = var_3;
  thread engineer_removeoutlinedentondeath(var_2, var_1);
}

engineer_removeoutlinedent(var_0, var_1) {
  var_1 notify("engineer_removeOutlinedEnt_" + var_0);
  var_2 = var_1.var_C78E[var_0];
  var_3 = var_1.outlinedids[var_0];
  scripts\mp\utility\game::outlinedisable(var_3, var_2);
  var_1.var_C78E[var_0] = undefined;
  var_1.outlinedids[var_0] = undefined;
}

engineer_removeoutlinedentondeath(var_0, var_1) {
  var_1 endon("engineer_clearOutlinedEnts");
  var_1 endon("engineer_removeOutlinedEnt_" + var_0);
  var_2 = var_1.var_C78E[var_0];
  var_2 waittill("death");
  thread engineer_removeoutlinedent(var_0, var_1);
}

engineer_clearoutlinedents(var_0) {
  var_0 notify("engineer_clearOutlinedEnts");

  foreach(var_3, var_2 in var_0.outlinedids) {
    scripts\mp\utility\game::outlinedisable(var_2, var_0.var_C78E[var_3]);
  }
}

engineer_shouldoutlineent(var_0, var_1) {
  var_2 = var_0 getentitynumber();

  if(isDefined(var_1.outlinedids[var_2])) {
    return 0;
  }

  var_3 = var_0.owner;

  if(!scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_3, var_1.owner))) {
    return 0;
  }

  return 1;
}

engineer_watchownerdisconnect(var_0, var_1) {
  if(isDefined(var_1)) {
    var_0.owner endon(var_1);
  }

  var_0 endon("engineer_clearOutlinedEnts");
  var_0.owner waittill("disconnect");
  thread engineer_clearoutlinedents(var_0);
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

    wait 0.1;
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

  for(var_0 = 0; var_0 < 0.06; var_0 = var_0 + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.208333;
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
      wait 0.4;

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
  foreach(var_1 in level.players) {
    var_1 notify("end_spawnview");
  }
}

setheadgear() {
  thread scripts\mp\equipment\headgear::func_E855();
}

unsetheadgear() {}

setftlslide() {
  self.trait = "specialty_ftlslide";

  if(scripts\mp\utility\game::isanymlgmatch() && level.tactical) {
    self setsuit("assassin_mlgslide_mp_tactical");
  } else if(scripts\mp\utility\game::isanymlgmatch()) {
    self setsuit("assassin_mlgslide_mp");
  } else if(level.tactical) {
    self setsuit("assassin_slide_mp_tactical");
  } else {
    self setsuit("assassin_slide_mp");
  }
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
    foreach(var_1 in self.pers["killstreaks"]) {
      var_1.earned = 0;
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
  self.awarenessqueryrate = 2.0;
  thread awarenessmonitorstance();

  for(;;) {
    wait(self.awarenessqueryrate);

    foreach(var_1 in level.players) {
      if(var_1.team == self.team) {
        continue;
      }
      if(var_1 scripts\mp\utility\game::_hasperk("specialty_coldblooded")) {
        continue;
      }
      if(var_1 isonground() && !var_1 issprinting() && !var_1 iswallrunning() && !var_1 issprintsliding()) {
        continue;
      }
      if(distance2d(var_1.origin, self.origin) < self.awarenessradius) {
        thread playincomingwarning(var_1);
      }
    }
  }
}

playincomingwarning(var_0) {
  self setscriptablepartstate("heightened_senses", "scrn_pulse");
  self playrumbleonentity("damage_heavy");
  var_0 playsoundtoplayer("ghost_senses_ping", self);
  wait 0.2;

  if(isDefined(self)) {
    self setscriptablepartstate("heightened_senses", "default");

    if(scripts\mp\utility\game::isreallyalive(self)) {
      self playrumbleonentity("damage_heavy");

      if(isDefined(var_0) && scripts\mp\utility\game::isreallyalive(var_0)) {
        var_0 playsoundtoplayer("ghost_senses_ping", self);
      }
    }
  }
}

awarenessmonitorstance() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 = self getstance();
    var_1 = self getvelocity();

    switch (var_0) {
      case "stand":
        self.awarenessradius = 400;
        self.awarenessqueryrate = 2.0;
        break;
      case "crouch":
        self.awarenessradius = 650;
        self.awarenessqueryrate = 1.0;
        break;
      case "prone":
        self.awarenessradius = 700;
        self.awarenessqueryrate = 0.5;
        break;
    }

    wait 0.01;
  }
}

awarenessaudiopulse() {
  self endon("death");
  self endon("disconnect");
  self endon("stop_awareness");

  for(;;) {
    playLoopSound(self.origin + (0, 0, 5), "ghost_senses_ping");
    wait 2.0;
  }
}

unsetadsawareness() {
  self notify("unsetADSAwareness");
  self.trait = undefined;
  self setscriptablepartstate("heightened_senses", "default");
}

setrearguard() {
  self.trait = "specialty_rearguard";
  scripts\mp\perks\perk_rearguard::func_E814();
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
    var_0 = gettime();

    foreach(var_3, var_2 in self.enemies) {
      if(!isDefined(var_2)) {
        bulletoutlineremoveenemy(undefined, var_3);
        continue;
      }

      if(var_2 scripts\mp\utility\game::_hasperk("specialty_noscopeoutline")) {
        bulletoutlineremoveenemy(var_2, var_3);
        continue;
      }

      if(var_0 >= self.enemyendtimes[var_3]) {
        bulletoutlineremoveenemy(var_2, var_3);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

watchbulletoutlinecleanup() {
  self.player scripts\engine\utility::waittill_any("disconnect", "unsetBulletOutline");

  foreach(var_2, var_1 in self.enemies) {
    if(isDefined(var_1)) {
      bulletoutlineremoveenemy(var_1, var_2);
    }
  }
}

bulletoutlineaddenemy(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_4 = gettime() + var_1 * 1000;
  self.enemies[var_3] = var_0;

  if(!isDefined(self.enemyids[var_3])) {
    self.enemyids[var_3] = scripts\mp\utility\game::outlineenableforplayer(var_0, "red", self.player, 1, 0, "perk");
  }

  if(!isDefined(self.enemyendtimes[var_3]) || !isDefined(var_2) || var_2) {
    self.enemyendtimes[var_3] = var_4;
  }
}

bulletoutlineremoveenemy(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0 getentitynumber();
  }

  self.enemies[var_1] = undefined;
  self.enemyendtimes[var_1] = undefined;

  if(isDefined(var_0)) {
    scripts\mp\utility\game::outlinedisable(self.enemyids[var_1], var_0);
  }

  self.enemyids[var_1] = undefined;
}

bulletoutlinecheck(var_0, var_1, var_2, var_3) {
  if(!(var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_EXPLOSIVE_BULLET")) {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!(isplayer(var_0) || scripts\mp\utility\game::func_9F22(var_0)) || !(isplayer(var_1) || scripts\mp\utility\game::func_9F22(var_1))) {
    return;
  }
  var_4 = var_0;

  if(isDefined(var_0.owner)) {
    var_4 = var_0.owner;
  }

  var_5 = var_1;

  if(isDefined(var_1.owner)) {
    var_5 = var_1.owner;
  }

  if(!scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_4, var_5))) {
    return;
  }
  if(isplayer(var_0) && isplayer(var_1) && scripts\mp\utility\game::func_C7A0(var_0 getEye(), var_1 getEye())) {
    return;
  }
  if(isDefined(var_0.bulletoutline) && !var_1 scripts\mp\utility\game::_hasperk("specialty_noscopeoutline")) {
    var_0.bulletoutline bulletoutlineaddenemy(var_1, 1);
  }

  if(isDefined(var_1.bulletoutline) && !var_0 scripts\mp\utility\game::_hasperk("specialty_noscopeoutline")) {
    var_1.bulletoutline bulletoutlineaddenemy(var_0, 2.0, 0);
  }
}

func_E8A9() {
  self endon("death");
  self endon("disconnect");
  var_0 = scripts\mp\utility\game::getuniqueid();

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !scripts\mp\utility\game::isreallyalive(var_2)) {
        continue;
      }
      if(var_2.team == self.team || var_2 == self) {
        continue;
      }
      if(var_2 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
        continue;
      }
      if(var_2 scripts\mp\equipment\cloak::func_9FC1()) {
        thread markempsignatures(var_2, var_0);
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
    if(scripts\mp\utility\game::isusingremote()) {
      scripts\engine\utility::waitframe();
      scripts\mp\utility\game::removeperk("specialty_tracker");

      while(scripts\mp\utility\game::isusingremote()) {
        scripts\engine\utility::waitframe();
      }

      scripts\mp\utility\game::giveperk("specialty_tracker");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

markempsignatures(var_0, var_1) {
  if(!isDefined(var_0.empmarked)) {
    var_0.empmarked = [];
  }

  if(isDefined(var_0.empmarked[var_1]) && var_0.empmarked[var_1] == "active") {
    return;
  }
  var_0.empmarked[var_1] = "active";
  thread empvfx(var_0, var_1);
  var_0 scripts\engine\utility::waittill_any("death", "cloak_end");
  var_0.empmarked[var_1] = undefined;
}

empvfx(var_0, var_1) {
  var_2 = ["j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le"];

  while(var_0 scripts\mp\equipment\cloak::func_9FC1()) {
    playfxontagforclients(scripts\engine\utility::getfx("tracker_cloak_tag"), var_0, var_2[randomint(var_2.size - 1)], self);
    wait 0.25;
  }

  var_0.empmarked[var_1] = undefined;
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
  var_0 = 1;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = self.origin;
  var_7 = 0;

  if(1) {
    var_7 = 1;
    self setplayerghost(1);
    thread ghostadvanceduavwatcher();
  } else {
    thread ghostadvanceduavwatcher();

    for(;;) {
      var_7 = 0;

      if(scripts\mp\utility\game::isusingremote() || scripts\engine\utility::is_true(self.isplanting) || scripts\engine\utility::is_true(self.isdefusing) || self ismantling()) {
        var_7 = 1;
      } else {
        if(var_5 > 1) {
          var_5 = 0;

          if(distancesquared(var_6, self.origin) < level.var_B75E) {
            var_2 = 1;
          } else {
            var_2 = 0;
          }

          var_6 = self.origin;
        }

        var_8 = self getvelocity();
        var_9 = lengthsquared(var_8);

        if(var_9 > level.minspeedsq && var_2 == 0) {
          var_7 = 1;
        }
      }

      if(var_7 == 1) {
        var_3 = 0;

        if(var_0 == 0) {
          var_1 = 0;
          var_0 = 1;
          self setplayerghost(1);
        }
      } else {
        var_3++;

        if(var_0 == 1 && var_3 >= level._meth_848A) {
          var_1 = 1;
          var_0 = 0;
          self setplayerghost(0);
        }
      }

      if(var_1 == 1) {
        level notify("radar_status_change");
      }

      var_5 = var_5 + level.timeperiod;
      wait(level.timeperiod);
    }
  }
}

ghostadvanceduavwatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_gpsjammer");

  for(;;) {
    if(level.teambased) {
      if(isDefined(level.activeadvanceduavs) && scripts\mp\utility\game::istrue(level.activeadvanceduavs[scripts\mp\utility\game::getotherteam(self.team)])) {
        self setplayerghost(0);

        while(scripts\mp\utility\game::istrue(level.activeadvanceduavs[scripts\mp\utility\game::getotherteam(self.team)])) {
          scripts\engine\utility::waitframe();
        }

        self setplayerghost(1);
      }
    } else {
      foreach(var_1 in level.players) {
        if(var_1 == self) {
          continue;
        }
        if(scripts\mp\utility\game::istrue(level.activeadvanceduavs[var_1.guid]) && level.activeadvanceduavs[var_1.guid] > 0) {
          self setplayerghost(0);

          while(scripts\mp\utility\game::istrue(level.activeadvanceduavs[var_1.guid]) && level.activeadvanceduavs[var_1.guid] > 0) {
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

groundpoundshield_onimpact(var_0) {
  thread groundpoundshield_raiseondelay();
}

groundpoundshield_raiseondelay() {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundLand");
  wait 0.25;
  groundpoundshield_raise();
}

groundpoundshield_raise() {
  if(isDefined(self.groundpoundshield)) {
    thread groundpoundshield_lower(self.groundpoundshield);
  }

  var_0 = self.origin + anglesToForward(self.angles) * 5;
  var_1 = self.angles + (0, 90, 0);
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("weapon_shinguard_col_wm");
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel("weapon_shinguard_fr_wm");
  var_3.outlineid = scripts\mp\utility\game::func_C793(var_3, "cyan", 0, 0, "equipment");
  var_4 = spawn("script_model", var_0);
  var_4.angles = var_1;
  var_4 setModel("weapon_shinguard_en_wm");
  var_4.outlineid = scripts\mp\utility\game::func_C793(var_4, "orange", 0, 0, "equipment");
  var_2.visfr = var_3;
  var_2.visen = var_4;
  var_2.owner = self;
  var_2 setCanDamage(1);
  var_2 _meth_847F(1);
  var_2.health = 9999;
  var_2.shieldhealth = 210;
  self.groundpoundshield = var_2;
  var_5 = level.characters;

  foreach(var_7 in var_5) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(level.teambased && var_7.team == self.team) {
      var_4 hidefromplayer(var_7);
      continue;
    }

    var_3 hidefromplayer(var_7);
  }

  thread groundpoundshield_monitorjoinedteam(var_2);
  thread groundpoundshield_loweronleavearea(var_2);
  thread groundpoundshield_lowerontime(var_2, 3.25);
  thread groundpoundshield_loweronjump(var_2);
  thread groundpoundshield_deleteondisconnect(var_2);
  thread groundpoundshield_monitorhealth(var_2);
  thread groundpound_raisefx();
  return var_2;
}

groundpoundshield_lower(var_0) {
  self notify("groundPoundShield_end");

  if(!isDefined(var_0)) {
    return;
  }
  thread groundpoundshield_lowerfx();
  thread groundpoundshield_deleteshield(var_0);
}

groundpoundshield_break(var_0) {
  self notify("groundPoundShield_end");

  if(!isDefined(var_0)) {
    return;
  }
  thread func_865E();
  thread groundpoundshield_deleteshield(var_0);
}

groundpoundshield_monitorhealth(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_2)) {
      if(var_2 == self || var_2.team != self.team) {
        var_0.shieldhealth = var_0.shieldhealth - var_1;
      }
    }

    var_0.health = 9999;
    thread groundpoundshield_damagedfx(var_2, var_4, var_3);

    if(var_0.shieldhealth <= 0) {
      thread groundpoundshield_break(var_0);
      return;
    } else if(var_0.shieldhealth <= 105.0) {
      if(var_0.visfr.model != "weapon_shinguard_dam_wm") {
        var_0.visfr setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\game::func_C7AA(var_0.visfr);
      }

      if(var_0.visen.model != "weapon_shinguard_dam_wm") {
        var_0.visen setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\game::func_C7AA(var_0.visen);
      }
    }
  }
}

groundpoundshield_loweronjump(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  var_1 = self isjumping();
  var_2 = undefined;

  for(;;) {
    var_2 = var_1;
    var_1 = self isjumping();

    if(!var_2 && var_1) {
      thread groundpoundshield_lower(var_0);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

groundpoundshield_lowerontime(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  wait(var_1);
  thread groundpoundshield_lower(var_0);
}

groundpoundshield_loweronleavearea(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  while(isDefined(var_0)) {
    if(lengthsquared(var_0.origin - self.origin) > 11664) {
      thread groundpoundshield_lower(var_0);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

groundpoundshield_deleteondisconnect(var_0) {
  self endon("groundPoundShield_deleteShield");
  scripts\engine\utility::waittill_any("death", "disconnect", "groundPound_unset");
  thread groundpoundshield_deleteshield(var_0);
}

groundpoundshield_monitorjoinedteam(var_0) {
  self endon("groundPoundShield_deleteShield");
  var_1 = self.team;

  for(;;) {
    level waittill("joined_team", var_2);

    if(level.teambased && var_2.team == var_1) {
      var_0.visfr giveperkequipment(var_2);
      var_0.visen hidefromplayer(var_2);
      continue;
    }

    var_0.visfr hidefromplayer(var_2);
    var_0.visen giveperkequipment(var_2);
  }
}

groundpoundshield_deleteshield(var_0) {
  self notify("groundPoundShield_deleteShield");
  scripts\mp\utility\game::outlinedisable(var_0.visfr.outlineid, var_0.visfr);
  scripts\mp\utility\game::outlinedisable(var_0.visen.outlineid, var_0.visen);
  var_0.visfr delete();
  var_0.visen delete();
  var_0 delete();
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

groundpoundshield_damagedfx(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  playFX(scripts\engine\utility::getfx("groundPoundShield_impact"), var_1, -1 * var_2);
  playLoopSound(var_1, "ds_shield_impact");
  var_0 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
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

groundpoundshock_onimpact(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShock_unset");
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "groundPoundLandTier0":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_1 = 144;
      break;
    case "groundPoundLandTier1":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_1 = 180;
      break;
    case "groundPoundLandTier2":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_lrg");
      var_1 = 216;
      break;
  }

  thread groundpoundshock_onimpactfx(var_1, var_2);
  var_3 = undefined;

  if(level.teambased) {
    var_3 = scripts\mp\utility\game::getteamarray(scripts\mp\utility\game::getotherteam(self.team));
  } else {
    var_3 = level.characters;
  }

  var_4 = var_1 * var_1;
  var_5 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 0, 0);

  foreach(var_7 in var_3) {
    if(!isDefined(var_7) || var_7 == self || !var_7 scripts\mp\killstreaks\emp_common::func_FFC5()) {
      continue;
    }
    if(lengthsquared(var_7 getEye() - self getEye()) > var_4) {
      continue;
    }
    var_8 = physics_raycast(self getEye(), var_7 getEye(), var_5, undefined, 0, "physicsquery_closest");

    if(isDefined(var_8) && var_8.size > 0) {
      continue;
    }
    thread groundpoundshock_empplayer(var_7);
  }

  var_10 = scripts\mp\weapons::getempdamageents(self.origin, var_1, 0, undefined);

  foreach(var_12 in var_10) {
    if(isDefined(var_12.owner) && !scripts\mp\weapons::friendlyfirecheck(self, var_12.owner)) {
      continue;
    }
    var_12 notify("emp_damage", self, 3);
  }
}

groundpoundshock_empplayer(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 scripts\mp\killstreaks\emp_common::func_20C3();
  scripts\mp\gamescore::func_11ACE(self, var_0, "groundpound_mp");
  var_0 shellshock("concussion_grenade_mp", 3);
  wait 3;
  var_0 scripts\mp\killstreaks\emp_common::func_E0F3();

  if(isDefined(self)) {
    scripts\mp\gamescore::untrackdebuffassist(self, var_0, "groundpound_mp");
  }
}

groundpoundshock_onimpactfx(var_0, var_1) {
  playFX(var_1, self.origin + (0, 0, 20), (0, 0, 1));
}

setgroundpoundboost() {
  thread scripts\mp\equipment\ground_pound::func_8655(8, 8, ::groundpoundboost_onimpact, "groundPoundBoost_unset");
}

unsetgroundpoundboost() {
  self notify("groundPoundBoost_unset");
}

groundpoundboost_onimpact(var_0) {
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

battleslideshield_monitorhealth(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");

  while(isDefined(var_0)) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread battleslideshield_damagedfx(var_0, var_2, var_4, var_3);

    if(var_0.health <= 0) {
      thread battleslideshield_break(var_0);
      var_0 delete();
      continue;
    }

    if(var_0.health <= 125.0) {
      if(var_0.model != "weapon_shinguard_dam_wm") {
        var_0 setModel("weapon_shinguard_dam_wm");
      }

      continue;
    }

    if(var_0.model != "weapon_shinguard_wm") {
      var_0 setModel("weapon_shinguard_wm");
    }
  }
}

battleslideshield_raise() {
  if(isDefined(self.battleslideshield)) {
    thread battleslideshield_lower(self.battleslideshield);
  }

  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 setModel("weapon_shinguard_wm");
  var_0 setCanDamage(1);
  var_0.health = 250;
  var_0 linkto(self, "tag_origin", (30, 0, 0), (0, 90, 0));
  var_0 show();
  self.battleslideshield = var_0;
  thread battleslideshield_killonjumpfall(var_0);
  thread battleslideshield_killonsprint(var_0);
  thread battleslideshield_killontime(var_0);
  thread battleslideshield_unlinkonstop(var_0);
  thread battleslideshield_monitorhealth(var_0);
  thread battleslideshield_killondeathdisconnectunset(var_0);
  thread battleslideshield_raisefx(var_0);
  return var_0;
}

battleslideshield_lower(var_0) {
  self notify("battleSlideShield_end");

  if(!isDefined(var_0)) {
    return;
  }
  thread battleslideshield_lowerfx(var_0);
  var_0 delete();
}

battleslideshield_killondeathdisconnectunset(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any("death", "disconnect", "battleSlide_unset");
  var_0 delete();
}

battleslideshield_killonjumpfall(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");

  for(;;) {
    if(!self isonground()) {
      var_0 delete();
      self notify("battleSlideShield_end");
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

battleslideshield_killonsprint(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_begin");
  var_0 delete();
  self notify("battleSlideShield_end");
}

battleslideshield_loweronleavearea(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  var_0 endon("death");

  for(;;) {
    if(lengthsquared(var_0.origin - self.origin) > 11664) {
      thread battleslideshield_lower(var_0);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

battleslideshield_lowerontime(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  wait 3.5;
  thread battleslideshield_lower(var_0);
}

battleslideshield_unlink(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 unlink();
  self notify("battleSlideShield_unlink");
  thread battleslideshield_lowerontime(var_0);
  thread battleslideshield_loweronleavearea(var_0);
  self notify("battleSlideShield_unlink");
}

battleslideshield_killontime(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_slide_end");
  wait 0.75;
  var_0 delete();
  self notify("battleSlideShield_end");
}

battleslideshield_unlinkonstop(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_slide_end");

  for(;;) {
    if(lengthsquared(self getvelocity()) < 100) {
      thread battleslideshield_unlink(var_0);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

battleslideshield_break(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  thread battleslideshield_breakfx(var_0);
  self notify("battleSlideShield_end");
}

battleslideshield_raisefx(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
  self playlocalsound("heavy_shield_up");
  self playsoundtoteam("heavy_shield_up_npc", "axis", self);
  self playsoundtoteam("heavy_shield_up_npc", "allies", self);
}

battleslideshield_lowerfx(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
  self playlocalsound("heavy_shield_down");
  self playsoundtoteam("heavy_shield_down_npc", "axis", self);
  self playsoundtoteam("heavy_shield_down_npc", "allies", self);
}

battleslideshield_damagedfx(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
  playFX(scripts\engine\utility::getfx("battleSlideShield_damage"), var_2, -1 * var_3);
  playLoopSound(var_2, "ds_shield_impact");
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
}

battleslideshield_breakfx(var_0) {}

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

  if(!scripts\mp\utility\game::_hasperk("specialty_quieter")) {
    self playsoundonmovingent("demolition_jump_expl");
  }

  thread thrusterstopfx();

  if(!isDefined(self.thrustfxent)) {
    self.thrustfxent = spawn("script_model", self.origin);
    self.thrustfxent setModel("tag_origin");
  } else
    self.thrustfxent.origin = self.origin;

  wait 0.05;

  for(;;) {
    self playrumbleonentity("damage_light");
    scripts\mp\shellshock::_earthquake(0.1, 0.3, self.origin, 120);
    var_0 = playerphysicstrace(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self.thrustfxent.origin = var_0;
    self.thrustfxent.angles = (90, 0, 0);
    wait 0.05;
    scripts\mp\utility\game::func_D486(self.thrustfxent, "tag_origin", self.team, scripts\engine\utility::getfx("thrusterRadFr"), scripts\engine\utility::getfx("thrusterRadEn"));
    wait 0.33;
  }
}

thrusterdamageloop() {
  self endon("death");
  self endon("disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");

  for(;;) {
    scripts\mp\utility\game::radiusplayerdamage(self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1);
    wait 0.05;
  }
}

thrusterstopfx() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("doubleJumpBoostEnd", "thruster_unset");
  wait 0.05;
}

runhover() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");

  for(;;) {
    if(self ishighjumping() && self playerads() > 0.3 && self goal_position(0) > 0) {
      executehover();
      thread watchhoverend();
      self waittill("hover_ended");
      endhover();
    }

    wait 0.1;
  }
}

watchhoverend() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");

  while(self playerads() > 0.3) {
    wait 0.05;
  }

  self notify("hover_ended");
}

executehover() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = 1;
  self goal_head_icon(0);
  self allowjump(0);
  self playlocalsound("ghost_wall_attach");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self getweaponvariantattachments(var_0);
  thread managetimeout(var_0);
}

managetimeout(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  var_1 = self energy_getrestorerate(0);
  self goalflag(0, 1.0);
  wait 2;
  self notify("hover_ended");
  self goalflag(0, var_1);
  self goal_radius(0, 0);
}

endhover() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = undefined;
  self goal_head_icon(1);
  self allowjump(1);
  self playlocalsound("ghost_wall_detach");
  self unlink();
}