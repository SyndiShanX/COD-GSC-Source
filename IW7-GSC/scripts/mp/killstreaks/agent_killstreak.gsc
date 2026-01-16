/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\agent_killstreak.gsc
*******************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("agent", ::tryusesquadmate);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("recon_agent", ::tryusereconsquadmate);
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

tryusesquadmate(var_0, var_1) {
  return usesquadmate("agent");
}

tryusereconsquadmate(var_0, var_1) {
  return usesquadmate("reconAgent");
}

usesquadmate(var_0) {
  if(scripts\mp\agents\agent_utility::getnumactiveagents("squadmate") >= 5) {
    self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagents(self) >= 2) {
    self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  var_1 = scripts\mp\agents\agent_utility::getvalidspawnpathnodenearplayer(0, 1);
  if(!isDefined(var_1)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  var_2 = var_1.origin;
  var_3 = vectortoangles(self.origin - var_1.origin);
  var_4 = scripts\mp\agents\_agents::add_humanoid_agent("squadmate", self.team, undefined, var_2, var_3, self, 0, 0, "veteran");
  if(!isDefined(var_4)) {
    self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  var_4.killstreaktype = var_0;
  if(var_4.killstreaktype == "reconAgent") {
    var_4 thread sendagentweaponnotify("iw6_riotshield_mp");
    var_4 thread finishreconagentloadout();
    var_4 thread scripts\mp\class::giveloadout(self.pers["team"], "reconAgent", 0);
    var_4 scripts\mp\agents\_agent_common::set_agent_health(250);
    var_4 scripts\mp\perks\perkfunctions::setlightarmor();
    var_4 setModel("mp_fullbody_synaptic_1");
    var_4 detach(var_4.headmodel);
    var_4.headmodel = undefined;
  } else {
    var_4 scripts\mp\perks\perkfunctions::setlightarmor();
  }

  var_4 scripts\mp\utility::_setnameplatematerial("player_name_bg_green_agent", "player_name_bg_red_agent");
  return 1;
}

finishreconagentloadout() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");
  scripts\mp\perks\perkfunctions::setlightarmor();
  scripts\mp\utility::giveperk("specialty_quickswap");
  scripts\mp\utility::giveperk("specialty_regenfaster");
  self getpassivestruct("minInaccuracy", 1.5 * self botgetdifficultysetting("minInaccuracy"));
  self getpassivestruct("maxInaccuracy", 1.5 * self botgetdifficultysetting("maxInaccuracy"));
  self getpassivestruct("minFireTime", 1.5 * self botgetdifficultysetting("minFireTime"));
  self getpassivestruct("maxFireTime", 1.25 * self botgetdifficultysetting("maxFireTime"));
}

sendagentweaponnotify(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");
  if(!isDefined(var_0)) {
    var_0 = "iw6_riotshield_mp";
  }

  self notify("weapon_change", var_0);
}

squadmate_agent_think() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");
  level endon("game_ended");
  for(;;) {
    self botsetflag("prefer_shield_out", 1);
    var_0 = self[[scripts\mp\agents\agent_utility::agentfunc("gametype_update")]]();
    if(!var_0) {
      if(!scripts\mp\bots\_bots_util::bot_is_guarding_player(self.owner)) {
        scripts\mp\bots\_bots_strategy::bot_guard_player(self.owner, 350);
      }
    }

    wait(0.05);
  }
}

on_agent_squadmate_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\agents\_agents::on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  if(isplayer(var_1) && isDefined(self.owner) && var_1 != self.owner) {
    self.owner scripts\mp\utility::leaderdialogonplayer("squad_killed");
    scripts\mp\damage::onkillstreakkilled("squad_mate", var_1, var_4, var_3, var_2, "destroyed_squad_mate");
  }

  scripts\mp\agents\agent_utility::deactivateagent();
}