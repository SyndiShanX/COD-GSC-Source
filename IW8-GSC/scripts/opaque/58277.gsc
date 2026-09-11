/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58277.gsc
***********************************************/

function init() {
  level._effect["vfx_speed_boost_trail_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_speed_boost_trail");
  level._effect["vfx_speed_boost_screen_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_speed_boost_scrnfx");
  game["dialog"]["powerup_speed_boost"] = "power_up_speed_boost";
  var0 = spawnStruct();
  var0.ref_138fd = "speed_boost";
  var0.parachute_get_path = getdvarfloat("scr_brPowerups_speed_boost_buff_duration", 45);
  var0.asm_playfacialanim_mp = &asm_playfacialanim_mp;
  var0.ref_12a35 = &ref_12a35;
  var0.isdeathshieldskippingenabled = &isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::ref_12af4(var0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_powerup_speed_boost", "extend_time_by", &open_starting_safehouse_door);
}

function asm_playfacialanim_mp() {
  self.player.ref_12834 = 1;
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("powerup_speed_boost", self.player);
  self.player lerpfovbypreset("zombiedefault");
  ref_135b7();
  cac_getaccessorylogic(self.player);
  self.player playlocalsound("mp_powerup_activate_speed_plr");
  _keypadscriptableused_bunkeralt::ref_12425(self.player, "br_rumble_powerup_speed_boost_activated");
}

function isdeathshieldskippingenabled() {
  self notify("singleton_deactivate_func");
  self endon("singleton_deactivate_func");
  self.player.ref_12834 = 0;
  lb_impulse_dmg_threshold_low();
  ref_12bf5(self.player);

  if(isalive(self.player)) {
    self.player playlocalsound("mp_powerup_deactivate_speed_plr");
  }

  self.player lerpfovbypreset("default_2seconds");
}

function ref_12a35() {
  open_starting_safehouse_door(self.ref_12e2d.parachute_get_path);
  self.player playlocalsound("mp_powerup_reactivate_speed_plr");
}

function open_starting_safehouse_door(var0) {
  self.mp_layover_patch = gettime() + var0 * 1000;
  self.player thread _keypadscriptableused_bunkeralt::ref_13f7e(undefined, 4, 2);
}

function ref_135b7() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_speed_boost_trail_fx"), self.player, "j_spine4");
}

function lb_impulse_dmg_threshold_low() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_speed_boost_trail_fx"), self.player, "j_spine4");
}

function cac_getaccessorylogic(var0) {
  thread ref_124ef();

  if(!istrue(self.isjuggernaut) && !isDefined(self.vehicle)) {
    thread ref_124ee();
  }

  if(isDefined(self.vehicle)) {
    thread ref_141fc();
    return;
  }
}

function ref_141fc() {
  level endon("game_ended");
  self endon("stop_powerup");
  self.player endon("death_or_disconnect");

  while(isDefined(self.player.vehicle)) {
    waitframe();
  }

  thread ref_124ee();
}

function ref_141fb() {
  level endon("game_ended");
  self endon("disconnect");

  while(isDefined(self.vehicle)) {
    waitframe();
  }

  thread ref_124e4();
}

function ref_12bf5() {
  thread ref_124e3();

  if(!isDefined(self.vehicle)) {
    thread ref_124e4();
    return;
  }

  thread ref_141fb();
}

function ref_124ee() {
  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.suit)) {
    return;
  }

  if(self.operatorcustomization.suit == "actionhero_mp") {
    return;
  }

  if(!isDefined(self.ref_12147)) {
    self.ref_12147 = self.operatorcustomization.suit;
  }

  self.operatorcustomization.suit = "actionhero_mp";
  scripts\mp\utility\player::_setsuit("actionhero_mp");
}

function ref_124e4() {
  self notify("custom_suit_start");
  self endon("custom_suit_start");

  if(isDefined(self.ref_12147) && self.operatorcustomization.suit != self.ref_12147) {
    self.operatorcustomization.suit = self.ref_12147;
    scripts\mp\utility\player::_setsuit(self.ref_12147);
    self.ref_12147 = undefined;
    return;
  }
}

function ref_124ef() {
  self notify("player_set_infinate_super_sprint");
  self endon("player_set_infinate_super_sprint");
  self endon("death_or_disconnect");
  self refreshsprinttime();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
    scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
    return;
  }
}

function ref_124e3() {
  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::removeperk("specialty_sprintmelee");
    scripts\mp\utility\perk::removeperk("specialty_sprintads");
    scripts\mp\utility\perk::removeperk("specialty_marathon");
    scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
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
    case "rmbl_give_speed_boost_powerup":
      level.player _keypadscriptableused_bunkeralt::ref_1393a("speed_boost");
      break;
    case "rmbl_spawn_speed_boost_powerup":
      var3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("brloot_rumble_powerup_speed_boost", var3);
      break;
    case "rmbl_give_teammate_speed_boost_powerup":
      var4 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      var4 = scripts\engine\utility::array_remove(var4, level.player);
      var4[randomintrange(0, var4.size)] _keypadscriptableused_bunkeralt::ref_1393a("speed_boost");
      break;
  }
}