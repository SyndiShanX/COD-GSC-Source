/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_ctf.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_ctf();
}

setup_callbacks() {
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use;
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_ctf_think;
  level.bot_funcs["_encstr_B2E0163B56A3BEEE2CE88DD07D37B7462BF58DA12CB9D8AC"] = ::cyberteamspawnsetids;
}

setup_bot_ctf() {
  level.damage_stage_final_watcher = ::initcircledata;
  level.damage_taken = ::initcirclepoststarttocircleindex;
  level.damage_players_on_blades = ::get_allied_attackers_for_team;
  level.damage_players_on_bottom = ::get_allied_defenders_for_team;
  level.damage_players_when_enter_trigger = ::customturret;
  level.damagefactor = ::cypher_current_string;
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.teamflags))
    wait 0.05;

  level.teamflags["_encstr_9A8507BA4040188D08"].objectivekey = "_encstr_9A8507BA4040188D08";
  level.teamflags["_encstr_8E8405EA382B2A"].objectivekey = "_encstr_8E8405EA382B2A";
  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_cache_entrances_to_gametype_array(level.teamflags, "_encstr_8EA906F5546E0880");
  var_0 = getzonenearest(level.teamflags["_encstr_9A8507BA4040188D08"].curorigin);

  if(isDefined(var_0))
    botzonesetteam(var_0, "_encstr_9A8507BA4040188D08");

  var_0 = getzonenearest(level.teamflags["_encstr_8E8405EA382B2A"].curorigin);

  if(isDefined(var_0))
    botzonesetteam(var_0, "_encstr_8E8405EA382B2A");

  level.capzones["_encstr_9A8507BA4040188D08"].nearest_node = level.teamflags["_encstr_9A8507BA4040188D08"].trigger.nearest_node;
  level.capzones["_encstr_8E8405EA382B2A"].nearest_node = level.teamflags["_encstr_8E8405EA382B2A"].trigger.nearest_node;
  thread customspeed();
  level.bot_gametype_precaching_done = 1;
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(cypher_iconid())
    return 0;

  return cutscenedone(self.team);
}

bot_ctf_think() {
  self notify("_encstr_A1340E4628EBD8CABB525738702B7D22");
  self endon("_encstr_A1340E4628EBD8CABB525738702B7D22");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.next_flag_hide_time = 0;
  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self.role))
      _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damagepercent();

    var_2 = scripts\mp\utility\game::getotherteam(self.team)[0];

    if(cutscenedone(self.team)) {
      if(isDefined(level.deactivate_laser_trap_parent) && isDefined(level.deactivate_laser_trap_parent[var_2]))
        level.deactivate_laser_trap_parent[var_2] = undefined;
    }

    var_3 = 0;

    if(self.role == "_encstr_AA7B09475984AF0F6F0F0B") {
      if(cypher_iconid())
        var_3 = 1;
      else if(!customusefunc())
        var_3 = distancesquared(self.origin, level.teamflags[var_2].curorigin) < squared(get_flag_protect_radius());
    } else if(!cutscenedone(self.team))
      var_3 = !cycle_thrust_fx();

    self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", var_3);
    var_1 = 0;

    if(cypher_iconid()) {
      if(cutscenedone(self.team)) {
        clear_defend();
        var_1 = 1;

        if(!var_0) {
          var_0 = 1;
          self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
        }

        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "_encstr_99CC09DA9020C4ECD149AD");
      } else if(_encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damagedisabledfeedback(self.team) == 1)
        cypher_id_pool();
      else if(gettime() > self.next_flag_hide_time) {
        clear_defend();
        var_4 = getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        var_5 = self botnodepick(var_4, var_4.size * 0.15, "_encstr_99FA13CDF69159FA1AA5C856D7C2CDF2BBD02B9C56");

        if(!isDefined(var_5))
          var_5 = level.capzones[self.team].nearest_node;

        var_6 = self botsetscriptgoalnode(var_5, "_encstr_99CC09DA9020C4ECD149AD");

        if(var_6)
          self.next_flag_hide_time = gettime() + 15000;
      }
    } else if(self.role == "_encstr_AA7B09475984AF0F6F0F0B") {
      if(customusefunc()) {
        if(!scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          var_7 = level.teamflags[var_2].carrier;
          scripts\mp\bots\bots_strategy::bot_guard_player(var_7, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "_encstr_99CC09DA9020C4ECD149AD")
          self botclearscriptgoal();

        self botsetscriptgoal(level.teamflags[var_2].curorigin, 16, "_encstr_9A2B0A12F03587575B7BBEA5", undefined, 300);
      }
    } else if(!cutscenedone(self.team))
      cypher_id_pool();
    else if(!is_protecting_flag()) {
      self botclearscriptgoal();
      var_8["_encstr_91F90CB98DBD93B2F533B10BEC9B"] = "_encstr_850A0BF7D10EA25388CE05CD63";
      var_8["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = "_encstr_8EA906F5546E0880" + level.teamflags[self.team].objectivekey;
      var_8["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"] = level.teamflags[self.team].trigger.nearest_node;
      scripts\mp\bots\bots_strategy::bot_protect_point(level.teamflags[self.team].curorigin, get_flag_protect_radius(), var_8);
    }

    if(var_0 && !var_1) {
      var_0 = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

cypher_id_pool() {
  var_0 = undefined;
  var_1 = level.teamflags[self.team];
  var_2 = var_1.carrier;

  if(!isDefined(var_2))
    var_0 = var_1.curorigin;
  else if(self botcanseeentity(var_2)) {
    var_0 = var_2.origin;

    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0 && !cutscenedone(self.team)) {
      if(!isDefined(level.deactivate_laser_trap_parent))
        level.deactivate_laser_trap_parent = [];

      if(!isDefined(level.deactivate_laser_trap_parent[var_2.team]))
        level.deactivate_laser_trap_parent[var_2.team] = [];

      level.deactivate_laser_trap_parent[var_2.team]["_encstr_97FE07DE392D76D2CD"] = var_0;
      level.deactivate_laser_trap_parent[var_2.team]["_encstr_84EF055338A18F"] = gettime();
    }
  } else if(isDefined(var_1.curcarrierorigin)) {
    if(isDefined(var_1.compassicons["_encstr_ACFC091AE8AB2FCBE15119"])) {
      if(var_1.objidpingfriendly)
        var_0 = var_1.curcarrierorigin;
      else
        var_0 = var_2.origin;
    }
  } else
    var_0 = var_1.curorigin;

  if(isDefined(var_0)) {
    clear_defend();
    self botsetscriptgoal(var_0, 16, "_encstr_99CC09DA9020C4ECD149AD");
  } else {
    var_3 = undefined;
    var_4 = undefined;

    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0) {
      if(isDefined(level.deactivate_laser_trap_parent) && isDefined(level.deactivate_laser_trap_parent[var_2.team])) {
        var_4 = gettime() - level.deactivate_laser_trap_parent[var_2.team]["_encstr_84EF055338A18F"];

        if(var_4 < 10000)
          var_3 = level.deactivate_laser_trap_parent[var_2.team]["_encstr_97FE07DE392D76D2CD"];
      }
    }

    if(isDefined(var_3)) {
      if(var_4 < 5000) {
        clear_defend();
        self botsetscriptgoal(var_3, 16, "_encstr_99CC09DA9020C4ECD149AD");
      } else if(!scripts\mp\bots\bots_util::bot_is_patrolling()) {
        scripts\mp\bots\bots_strategy::bot_defend_stop();
        scripts\mp\bots\bots_strategy::bot_patrol_area(var_3, 400);
      }
    } else {
      clear_defend();
      var_5 = self botgetscriptgoaltype();

      if(var_5 == "_encstr_9A2B0A12F03587575B7BBEA5" || var_5 == "_encstr_99CC09DA9020C4ECD149AD")
        self botclearscriptgoal();

      scripts\mp\bots\bots_personality::update_personality_default();
    }
  }
}

clear_defend() {
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();
}

is_protecting_flag() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

get_flag_protect_radius() {
  if(isalive(self) && !isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(800, var_1 / 5.5);
  }

  if(!isDefined(level.protect_radius))
    return 900;

  return level.protect_radius;
}

initcircledata(var_0) {
  var_1 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damagedisabledfeedback(var_0);

  if(var_1 == 1)
    return 1;

  if(cutscenedone(var_0))
    var_2 = var_1 * 0.67;
  else {
    var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

    if(cutscenedone(var_3))
      var_2 = var_1 * 0.5;
    else
      var_2 = var_1 * 0.4;
  }

  var_4 = int(scripts\mp\utility\script::roundup(var_2));
  var_5 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0];
  var_6 = game["_encstr_96040B1D59B0AD35B1F64E599B"][scripts\engine\utility::get_enemy_team(var_0)];

  if(var_5 + 1 < var_6)
    var_4 = int(min(var_4 + 1, var_1));

  return var_4;
}

initcirclepoststarttocircleindex(var_0) {
  var_1 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damagedisabledfeedback(var_0);
  return var_1 - initcircledata(var_0);
}

get_allied_attackers_for_team(var_0) {
  return _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damageby(var_0, level.capzones[var_0].curorigin, get_flag_protect_radius());
}

get_allied_defenders_for_team(var_0) {
  return _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damageclonewatch(var_0, level.capzones[var_0].curorigin, get_flag_protect_radius());
}

customspeed() {
  level notify("_encstr_A9A51B3E7FC3FEDF0342D138AA919970A31D36ADC773260BEA4A289802");
  level endon("_encstr_A9A51B3E7FC3FEDF0342D138AA919970A31D36ADC773260BEA4A289802");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::damage_shield_reduction();
}

cyberteamspawnsetids(var_0) {
  if(var_0 == self.node_closest_to_defend_center)
    return 1.0;

  if(!is_protecting_flag())
    return 1.0;

  var_1 = var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels("_encstr_81360CC1419287A86B8C894B33EB", "_encstr_BEDE0A927847672908F9796B");

  if(var_1)
    return 1.0;

  return 0.2;
}

cutscenedone(var_0) {
  return level.teamflags[var_0] scripts\mp\gameobjects::ishome();
}

cyber_bot_pickup_emp(var_0) {
  return isDefined(level.teamflags[var_0].carrier);
}

cycle_thrust_fx() {
  return cyber_bot_pickup_emp(self.team);
}

customusefunc() {
  var_0 = scripts\mp\utility\game::getotherteam(self.team)[0];
  return cyber_bot_pickup_emp(var_0);
}

cypher_iconid() {
  return isDefined(self.carryflag);
}

customturret() {
  if(cypher_iconid())
    return 0;

  return 1;
}

cypher_current_string() {
  if(cypher_iconid())
    return 1;

  return 0;
}