/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_sasquatch\zombie_sasquatch_agent.gsc
*************************************************************************/

zombiesasquatchagentinit() {
  registerscriptedagent();
}

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\zombie_sasquatch::_id_DEE8();
  scripts\asm\zombie_sasquatch\mp\states::_id_2371();
  thread _id_FAB0();
  _id_AE11();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition))
    level waittill("scripted_agents_initialized");

  if(!isDefined(level.species_funcs))
    level.species_funcs = [];

  level.species_funcs["zombie_sasquatch"] = [];
  level.agent_definition["zombie_sasquatch"]["setup_func"] = ::setupagent;
  level.agent_definition["zombie_sasquatch"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["zombie_sasquatch"] = [];
  level.agent_funcs["zombie_sasquatch"]["on_damaged"] = scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged;
  level.agent_funcs["zombie_sasquatch"]["gametype_on_damage_finished"] = scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["zombie_sasquatch"]["gametype_on_killed"] = scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiekilled;
  level.agent_funcs["zombie_sasquatch"]["on_killed"] = ::onsasquatchkilled;
  level.agent_funcs["zombie_sasquatch"]["on_damaged_finished"] = ::onsasquatchdamagefinished;
}

_id_AE11() {
  level._effect["sasquatch_rock_hit"] = loadfx("vfx/iw7/levels/cp_rave/sasquatch/vfx_rave_sas_projectile_impact.vfx");
}

setupagent() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.saved_actionslotdata = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  self.disabledweapon = undefined;
  self.disabledweaponswitch = undefined;
  self.disabledoffhandweapons = undefined;
  self.disabledusability = 1;
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;
  self.can_be_killed = 0;
  self.attack_spot = undefined;
  self.marked_for_death = undefined;
  self.trap_killed_by = undefined;
  self.hastraversed = 0;
  self.immune_against_nuke = 1;
  self.aistate = "idle";
  self.movemode = "run";
  self.sharpturnnotifydist = 150;
  self.radius = 20;
  self.height = 53;
  self._id_252B = 26 + self.radius;
  self._id_2539 = 54;
  self._id_253A = -64;
  self._id_4D45 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1.0;
  self._id_C081 = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self._id_2AB2 = 0;
  self._id_2AB8 = 1;
  self.timelineevents = 0;
  self.allowcrouch = 1;
  self.defaultgoalradius = self.radius + 1;
  self.dismember_crawl = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.dismember_crawl = 0;
  self._id_B0FC = 1;
  self.full_gib = 0;
  self.croc_chomp = 0;
  self.spawn_round_num = level.wave_num;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self.last_damage_time_on_player = [];
  self.allowpain = 1;
  self setavoidanceradius(45);

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1)
    self._id_AB3F = 1;

  self.entered_playspace = 1;
  thread _id_899C();
}

_id_FACE(var_0) {
  self setModel("zmb_sasquatch_fullbody");
}

setup_eye_glow() {
  self endon("death");
  self emissiveblend(1, 0.1);
  wait 1;
  self setscriptablepartstate("right_eye", "active");
  self setscriptablepartstate("left_eye", "active");
}

_id_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  var_0 = self._id_164D[self.asmname];
  var_1 = var_0._id_4BC0;
  var_2 = anim.asm[self.asmname].states[var_1];
  scripts\asm\asm::_id_2388(self.asmname, var_1, var_2, var_2._id_116FB);
  scripts\asm\asm::_id_238A(self.asmname, "idle", 0.2, undefined, undefined, undefined);
}

onsasquatchkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self emissiveblend(1, 0);
  self setscriptablepartstate("right_eye", "inactive");
  self setscriptablepartstate("left_eye", "inactive");
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

onsasquatchdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  scripts\mp\mp_agent::default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}