/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\agents.gsc
***********************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(level.gametype == "_encstr_B607038AAB") {
    if(!scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe())
      return;
  }

  setup_callbacks();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level thread scripts\mp\agents\agent_common::init();
  level thread scripts\mp\killstreaks\agent_killstreak::init();
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  level.agent_funcs["_encstr_8BB007E03658CBCAE4"] = [];
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_8E8A06F7D987435E"] = ::spawn_agent_player;
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_B672066D30FF90B7"] = _encstr_9615268BD18667DA6837F78D098A66B72D4BC662B85DB759987BBD8DE9D02AC7C063BAEB28BCFF8E::bot_war_think;
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_96330A95DD7FB43840C92ACD"] = ::on_agent_player_killed;
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::on_agent_player_damaged;
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"] = ::agent_damage_finished;
}

wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs))
    wait 0.05;
}

add_humanoid_agent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = scripts\mp\agents\agent_common::connectnewagent(var_0, var_1, var_2);

  if(isDefined(var_9))
    var_14.classcallback = var_9;

  if(isDefined(var_14))
    var_14 thread[[var_14 scripts\mp\agents\agent_utility::agentfunc("_encstr_8E8A06F7D987435E")]](var_3, var_4, var_5, var_6, var_7, var_8, var_10, var_11, var_12, var_13);

  return var_14;
}

spawn_agent_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(level.getspawnpoint))
    waitframe();

  if(self.hasdied)
    wait(randomintrange(6, 10));

  scripts\mp\agents\agent_utility::initplayerscriptvariables(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_10 = var_0;
    var_11 = var_1;
    self.lastspawnpoint = spawnStruct();
    self.lastspawnpoint.origin = var_10;
    self.lastspawnpoint.angles = var_11;
  } else {
    var_12 = self[[level.getspawnpoint]]();
    var_10 = var_12.origin;
    var_11 = var_12.angles;
    self.lastspawnpoint = var_12;
  }

  scripts\mp\agents\agent_utility::activateagent();
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  var_13 = var_10 + (0, 0, 25);
  var_14 = var_10;
  var_15 = playerphysicstrace(var_13, var_14);

  if(distancesquared(var_15, var_13) > 1)
    var_10 = var_15;

  self spawnagent(var_10, var_11);

  if(isDefined(var_3) && var_3)
    scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  else
    scripts\mp\bots\bots_util::bot_set_personality("_encstr_8B1608EC43B8D647A113");

  if(isDefined(var_5))
    scripts\mp\bots\bots_util::bot_set_difficulty(var_5);

  initplayerclass();
  scripts\mp\agents\agent_common::set_agent_health(100);

  if(isDefined(var_4) && var_4)
    self.respawn_on_death = 1;

  if(isDefined(var_2))
    scripts\mp\agents\agent_utility::set_agent_team(var_2.team, var_2);

  if(isDefined(self.owner))
    thread destroyonownerdisconnect(self.owner);

  self enableanimstate(0);
  self takeallweapons();
  self[[level.onspawnplayer]]();

  if(!istrue(var_6))
    scripts\mp\class::giveloadout(self.team, self.class, 1);

  thread scripts\mp\bots\bots::bot_think_watch_enemy(1);
  thread scripts\mp\bots\bots::bot_think_crate();
  thread scripts\mp\bots\bots_strategy::bot_think_tactical_goals();
  self thread[[scripts\mp\agents\agent_utility::agentfunc("_encstr_B672066D30FF90B7")]]();

  if(!self.hasdied)
    scripts\mp\spawnlogic::addtoparticipantsarray();

  self.hasdied = 0;

  if(!istrue(var_7))
    thread scripts\mp\weapons::onplayerspawned();

  if(!istrue(var_8))
    thread scripts\mp\healthoverlay::manageplayerregen();

  if(!istrue(var_9))
    thread scripts\mp\battlechatter_mp::onplayerspawned();

  level notify("_encstr_8B36155A8B88F79AC5B917E797FDA24CD11315A6C2F0BA", self);
  level notify("_encstr_96F40E2EE81F737DFFEA49B0B297056B", self);
  self notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
}

destroyonownerdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  childthread watchownerstatus("_encstr_8D820B49520F0EC02DDE6367EC", var_0);
  childthread watchownerstatus("_encstr_81170C244F9CBDE72C01BB99A298", var_0);
  childthread watchownerstatus("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", var_0);
}

watchownerstatus(var_0, var_1) {
  var_1 waittill(var_0);
  self notify("_encstr_AD4911F6BB37AC9CF58CD2B98DDB9BE6CA6CE8");

  if(scripts\mp\hostmigration::waittillhostmigrationdone())
    wait 0.05;

  self suicide();
}

agent_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isalive(self)) {
    if(isDefined(var_0) || isDefined(var_1)) {
      if(!isDefined(var_0))
        var_0 = var_1;

      if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
        if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
          return 0;
      }

      if(isDefined(var_0.classname) && var_0.classname == "_encstr_AA650C2C57D17BFAD15DE4C9591D")
        var_1 = var_0;

      if(isDefined(var_1) && var_4 != "_encstr_87A10C9D24E997A01F21838F3D34" && var_4 != "_encstr_AB590C99ED78875F650F3951034D") {
        if(level.teambased) {
          if(isDefined(var_1.team) && var_1.team != self.team)
            self setagentattacker(var_1);
        } else
          self setagentattacker(var_1);
      }
    }

    self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);

    if(!isDefined(self.isactive))
      self.waitingtodeactivate = 1;

    return 1;
  }
}

on_agent_generic_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;
  var_13 = scripts\mp\utility\damage::attackerishittingteam(self.owner, var_1) || var_12;

  if(!(var_12 && self.agent_type == "_encstr_811D0C63ED6F2733535F5B48F21B")) {
    if(level.teambased && var_13 && !level.friendlyfire)
      return 0;

    if(!level.teambased && var_12)
      return 0;
  }

  if(isDefined(var_4) && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    return 0;

  if(!isDefined(self) || !scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(isDefined(var_1) && var_1.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9" && isDefined(var_1.type) && var_1.type == "_encstr_872F0D0B92FB65A14D31958951B518")
    return 0;

  if(var_5 == "_encstr_B1F01210EF24C8A77BAA9D97C4E1C350809FB840")
    return 0;

  if(issubstr(var_5, "_encstr_92590EFBF91ED25750D8D7DC30B88E8A") && var_4 == "_encstr_A1ED0BA9FF84562B60BA073E83")
    var_2 = self.health + 1;

  if(isDefined(var_0) && isDefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == self)
    var_2 = self.health + 1;

  if(var_2 <= 0)
    return 0;

  if(isDefined(var_1) && var_1 != self && var_2 > 0 && (!isDefined(var_8) || var_8 != "_encstr_A32D07CFD14BAA94D0")) {
    if(var_3 &level.idflags_stun)
      var_14 = "_encstr_9B1905D3B92BF0";
    else
      var_14 = "_encstr_A5AE098ADB583E0AF7A5AB";

    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback(var_14, var_2 >= self.health);
  }

  if(isDefined(level.modifyplayerdamage))
    var_2 = [[level.modifyplayerdamage]](var_0, self, var_1, var_2, var_4, var_5, var_6, var_7, var_8);

  return self[[scripts\mp\agents\agent_utility::agentfunc("_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

on_agent_player_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;

  if(!level.teambased && var_13)
    return 0;

  if(issameweapon(var_5))
    var_14 = createheadicon(var_5);
  else
    var_14 = var_5;

  var_12 = asmdevgetallstates(var_14);

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](var_12, var_0);

  scripts\mp\damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_12, var_6, var_7, var_8, var_9, var_10, var_11);
}

on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner))
    scripts\mp\damage::onkillstreakkilled("_encstr_8D450BAF70EFE6EA1FCDC829E1", var_1, var_4, var_3, var_2, "_encstr_B85515B5DFB369331797404027236BD33A07A049B69B03");

  thread scripts\mp\weapons::dropscavengerfordeath(var_1);

  if(self.isactive) {
    self.hasdied = 1;

    if(scripts\mp\utility\game::getgametypenumlives() != 1 && (isDefined(self.respawn_on_death) && self.respawn_on_death))
      self thread[[scripts\mp\agents\agent_utility::agentfunc("_encstr_8E8A06F7D987435E")]]();
    else
      scripts\mp\agents\agent_utility::deactivateagent();
  }
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    scripts\mp\damage::launchshield(var_2, var_3);

    if(!var_9) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread scripts\mp\weapons::deletepickupafterawhile();
        var_10.owner = self;
        var_10.ownersattacker = var_1;
        var_10 makeunusable();
      }
    }
  }

  if(var_9)
    self[[level.weapondropfunction]](var_1, var_3, undefined, var_2);

  scripts\mp\riotshield::riotshield_clear();

  if(isDefined(self.nocorpse)) {
    return;
  }
  self.body = self cloneagent(var_8);
  thread scripts\mp\damage::_startragdoll(self.body, var_3, var_0);
}

initplayerclass() {
  if(isDefined(self.class_override))
    self.class = self.class_override;
  else if(scripts\mp\bots\bots_loadout::bot_setup_loadout_callback())
    self.class = "_encstr_A7AA09C616D81B26586CB5";
  else
    self.class = "_encstr_A78007C63685CD3789";
}