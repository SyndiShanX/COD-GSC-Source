/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\adrenaline.gsc
***********************************************/

function init() {}

function ref_11D0F() {
  self.ref_138AC = 1;
  wait 3;
  self.ref_138AC = undefined;
}

function useadrenaline() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self notify("force_regeneration");
  thread ref_11D0F();
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(getdvarint("scr_adrenaline_BR_allow_overdrive", 1) == 1) {
    var_0 = scripts\mp\utility\game::unset_relic_grounded();

    if(var_0) {
      if(isDefined(self.are_players_nearby_turret) && isDefined(self.are_players_nearby_turret["speed_boost"])) {
        var_1 = self.are_players_nearby_turret["speed_boost"].mp_layover_patch - gettime();
        var_1 /= 1000;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_powerup_speed_boost", "extend_time_by")) {
          self.are_players_nearby_turret["speed_boost"][[scripts\cp_mp\utility\script_utility::getsharedfunc("br_powerup_speed_boost", "extend_time_by")]](var_1 + 3);
        }

        return true;
      } else {
        thread ref_12170();
      }
    }
  }

  adrenaline_missiononuse();
  self.adrenalinepoweractive = 1;
  self refreshsprinttime();
  GscBinSkip4(0x35);
}

function removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("removeAdrenaline");
    self.adrenalinepoweractive = undefined;
    return;
  }
}

function onequipmenttaken(var_0, var_1) {
  removeadrenaline();
}

function onequipmentfired(var_0, var_1, var_2) {
  if(self isthrowingbackgrenade()) {
    self method_87a9();

    if(isDefined(var_2)) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = int(max(var_3 - 1, 0));
      self setweaponammoclip(var_2, var_4);
    }
  }

  useadrenaline();
}

function gethealthperframe() {
  return 8;
}

function adrenaline_removeonplayernotifies() {
  scripts\engine\utility::ref_143A5("death", "healed");
  thread removeadrenaline();
}

function adrenaline_removeondamage() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(level.deletescriptableinstanceaftertime_proc) && istrue(level.deleteallglass) && isPlayer(var_1) && var_1 != self && var_0 > level.deletescriptableinstanceaftertime_proc) {
      if(istrue(level.deleteable)) {
        self notify("healhRegenThink");
      }

      thread removeadrenaline();
      return;
    }

    if(level.gametype == "br" && (var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_UNKNOWN")) {
      continue;
    }

    thread removeadrenaline();
    return;
  }
}

function adrenaline_removeongameend() {
  level waittill("game_ended");
  thread removeadrenaline();
}

function adrenaline_missiononuse() {
  if(self.health >= self.maxhealth) {
    self.usedadrenalineatfullhp = 1;
    thread adrenaline_missionondeaththink();
    return;
  }
}

function adrenaline_missionondeaththink() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("adrenaline_missionOnDeathThink");
  self endon("adrenaline_missionOnDeathThink");
  self waittill("death");
  self.usedadrenalineatfullhp = undefined;
}

function ref_12170() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = self;
  binoculars_isads(var_0);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", getdvarint("scr_adrenaline_overdrive_duration", 3));

  if(isDefined(self.are_players_nearby_turret) && isDefined(self.are_players_nearby_turret["speed_boost"])) {
    return;
  }

  binoculars_hidetargetmarker(var_0);
}

function binoculars_isads() {
  self.movespeedscaler = level.deletesecretstashhud;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("zombiedefault");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  binoculars_init();
}

function binoculars_hidetargetmarker() {
  self notify("stopOverdriveAudio");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::removeperk("specialty_sprintmelee");
    scripts\mp\utility\perk::removeperk("specialty_sprintads");
    scripts\mp\utility\perk::removeperk("specialty_marathon");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("default_2seconds");
  binoculars_hascoldblooded();
}

function binoculars_init() {
  if(!isDefined(self.ref_12147)) {
    self.ref_12147 = self.operatorcustomization.suit;
    self.operatorcustomization.suit = "adrenalinesuit_mp";
    scripts\mp\utility\player::_setsuit("adrenalinesuit_mp");
    return;
  }
}

function binoculars_hascoldblooded() {
  if(isDefined(self.ref_12147)) {
    self.operatorcustomization.suit = self.ref_12147;
    scripts\mp\utility\player::_setsuit(self.ref_12147);
    self.ref_12147 = undefined;
    return;
  }
}