/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\agent_killstreak.gsc
*******************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("agent", ::tryusesquadmate);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("recon_agent", ::tryusereconsquadmate);
}

setup_callbacks() {
  level.agent_funcs["squadmate"] = level.agent_funcs["player"];
  level.agent_funcs["squadmate"]["think"] = ::squadmate_agent_think;
  level.agent_funcs["squadmate"]["on_killed"] = ::on_agent_squadmate_killed;
  level.agent_funcs["squadmate"]["on_damaged"] = ::scripts\mp\agents\_agents::on_agent_player_damaged;
  level.agent_funcs["squadmate"]["gametype_update"] = ::no_gametype_update;
}

no_gametype_update() {
  return 0;
}

tryusesquadmate(param_00, param_01) {
  return usesquadmate("agent");
}

tryusereconsquadmate(param_00, param_01) {
  return usesquadmate("reconAgent");
}

usesquadmate(param_00) {
  if(scripts\mp\agents\agent_utility::getnumactiveagents("squadmate") >= 5) {
    self iprintlnbold( & "KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagents(self) >= 2) {
    self iprintlnbold( & "KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  var_01 = scripts\mp\agents\agent_utility::getvalidspawnpathnodenearplayer(0, 1);
  if(!isDefined(var_01)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  var_02 = var_01.origin;
  var_03 = vectortoangles(self.origin - var_01.origin);
  var_04 = scripts\mp\agents\_agents::add_humanoid_agent("squadmate", self.team, undefined, var_02, var_03, self, 0, 0, "veteran");
  if(!isDefined(var_04)) {
    self iprintlnbold( & "KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  var_04.killstreaktype = param_00;
  if(var_04.killstreaktype == "reconAgent") {
    var_04 thread sendagentweaponnotify("iw6_riotshield_mp");
    var_04 thread finishreconagentloadout();
    var_04 thread scripts\mp\class::giveloadout(self.pers["team"], "reconAgent", 0);
    var_04 scripts\mp\agents\_agent_common::set_agent_health(250);
    var_04 scripts\mp\perks\_perkfunctions::setlightarmor();
    var_04 setModel("mp_fullbody_synaptic_1");
    var_04 detach(var_04.headmodel);
    var_04.headmodel = undefined;
  } else {
    var_04 scripts\mp\perks\_perkfunctions::setlightarmor();
  }

  var_04 scripts\mp\utility::_setnameplatematerial("player_name_bg_green_agent", "player_name_bg_red_agent");
  return 1;
}

finishreconagentloadout() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");
  scripts\mp\perks\_perkfunctions::setlightarmor();
  scripts\mp\utility::giveperk("specialty_quickswap");
  scripts\mp\utility::giveperk("specialty_regenfaster");
  self getpassivestruct("minInaccuracy", 1.5 * self botgetdifficultysetting("minInaccuracy"));
  self getpassivestruct("maxInaccuracy", 1.5 * self botgetdifficultysetting("maxInaccuracy"));
  self getpassivestruct("minFireTime", 1.5 * self botgetdifficultysetting("minFireTime"));
  self getpassivestruct("maxFireTime", 1.25 * self botgetdifficultysetting("maxFireTime"));
}

sendagentweaponnotify(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");
  if(!isDefined(param_00)) {
    param_00 = "iw6_riotshield_mp";
  }

  self notify("weapon_change", param_00);
}

squadmate_agent_think() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");
  level endon("game_ended");
  for(;;) {
    self botsetflag("prefer_shield_out", 1);
    var_00 = self[[scripts\mp\agents\agent_utility::agentfunc("gametype_update")]]();
    if(!var_00) {
      if(!scripts\mp\bots\_bots_util::bot_is_guarding_player(self.triggerportableradarping)) {
        scripts\mp\bots\_bots_strategy::bot_guard_player(self.triggerportableradarping, 350);
      }
    }

    wait(0.05);
  }
}

on_agent_squadmate_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  scripts\mp\agents\_agents::on_humanoid_agent_killed_common(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, 0);
  if(isplayer(param_01) && isDefined(self.triggerportableradarping) && param_01 != self.triggerportableradarping) {
    self.triggerportableradarping scripts\mp\utility::leaderdialogonplayer("squad_killed");
    scripts\mp\damage::onkillstreakkilled("squad_mate", param_01, param_04, param_03, param_02, "destroyed_squad_mate");
  }

  scripts\mp\agents\agent_utility::deactivateagent();
}