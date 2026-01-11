/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3459.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("agent", ::tryusesquadmate);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("recon_agent", ::tryusereconsquadmate);
}

setup_callbacks() {
  level.agent_funcs["squadmate"] = level.agent_funcs["player"];
  level.agent_funcs["squadmate"]["think"] = ::squadmate_agent_think;
  level.agent_funcs["squadmate"]["on_killed"] = ::on_agent_squadmate_killed;
  level.agent_funcs["squadmate"]["on_damaged"] = ::scripts\mp\agents\agents::on_agent_player_damaged;
  level.agent_funcs["squadmate"]["gametype_update"] = ::no_gametype_update;
}

no_gametype_update() {
  return 0;
}

tryusesquadmate(var_00, var_01) {
  return usesquadmate("agent");
}

tryusereconsquadmate(var_00, var_01) {
  return usesquadmate("reconAgent");
}

usesquadmate(var_00) {
  if(scripts\mp\agents\agent_utility::getnumactiveagents("squadmate") >= 5) {
    self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagents(self) >= 2) {
    self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  var_01 = scripts\mp\agents\agent_utility::getvalidspawnpathnodenearplayer(0, 1);

  if(!isDefined(var_01))
    return 0;

  if(!scripts\mp\utility\game::isreallyalive(self))
    return 0;

  var_02 = var_1.origin;
  var_03 = vectortoangles(self.origin - var_1.origin);
  var_04 = scripts\mp\agents\agents::add_humanoid_agent("squadmate", self.team, undefined, var_02, var_03, self, 0, 0, "veteran");

  if(!isDefined(var_04)) {
    self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  var_4.killstreaktype = var_00;

  if(var_4.killstreaktype == "reconAgent") {
    var_04 thread sendagentweaponnotify("iw6_riotshield_mp");
    var_04 thread finishreconagentloadout();
    var_04 thread scripts\mp\class::giveloadout(self.pers["team"], "reconAgent", 0);
    var_04 scripts\mp\agents\agent_common::set_agent_health(250);
    var_04 scripts\mp\perks\perkfunctions::setlightarmor();
    var_04 setModel("mp_fullbody_synaptic_1");
    var_04 detach(var_4.headmodel);
    var_4.headmodel = undefined;
  } else
    var_04 scripts\mp\perks\perkfunctions::setlightarmor();

  var_04 scripts\mp\utility\game::_setnameplatematerial("player_name_bg_green_agent", "player_name_bg_red_agent");
  return 1;
}

finishreconagentloadout() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");
  scripts\mp\perks\perkfunctions::setlightarmor();
  scripts\mp\utility\game::giveperk("specialty_quickswap");
  scripts\mp\utility\game::giveperk("specialty_regenfaster");
  self botsetdifficultysetting("minInaccuracy", 1.5 * self botgetdifficultysetting("minInaccuracy"));
  self botsetdifficultysetting("maxInaccuracy", 1.5 * self botgetdifficultysetting("maxInaccuracy"));
  self botsetdifficultysetting("minFireTime", 1.5 * self botgetdifficultysetting("minFireTime"));
  self botsetdifficultysetting("maxFireTime", 1.25 * self botgetdifficultysetting("maxFireTime"));
}

sendagentweaponnotify(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");

  if(!isDefined(var_00))
    var_00 = "iw6_riotshield_mp";

  self notify("weapon_change", var_00);
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
      if(!scripts\mp\bots\bots_util::bot_is_guarding_player(self.owner))
        scripts\mp\bots\bots_strategy::bot_guard_player(self.owner, 350);
    }

    wait 0.05;
  }
}

on_agent_squadmate_killed(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  scripts\mp\agents\agents::on_humanoid_agent_killed_common(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, 0);

  if(isplayer(var_01) && isDefined(self.owner) && var_01 != self.owner) {
    self.owner scripts\mp\utility\game::leaderdialogonplayer("squad_killed");
    scripts\mp\damage::onkillstreakkilled("squad_mate", var_01, var_04, var_03, var_02, "destroyed_squad_mate");
  }

  scripts\mp\agents\agent_utility::deactivateagent();
}