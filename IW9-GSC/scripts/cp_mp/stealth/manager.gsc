/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\stealth\manager.gsc
***********************************************/

main() {
  scripts\smartobjects\utility::init_smartobjects();
  scripts\stealth\manager::main();
  level.stealth.fnaddeventplaybcs = _id_35DE402EFC5ACFB3::addeventplaybcs;
  level.fngetcorpsearrayfunc = ::get_corpse_array;
  level.stealth.fngetplayerdrone = ::get_player_drone;
  level._id_4FA3C4EB77C24130 = ::_id_4FA3C4EB77C24130;
  level._id_C5E87DFA7679B0A5 = ::_id_D3110770982EEA0E;
  level thread _id_7E4CE548F5795C03();
  set_detect_ranges();
  set_corpse_detect_ranges();
  level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);
  level thread manager_thread();
  level thread update_stealth_spotted_thread();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("stealth", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("stealth", "init")]]();
}

_id_4FA3C4EB77C24130() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("stealth_enemy", "init"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("stealth_enemy", "init")]]();
}

_id_D3110770982EEA0E(_id_65661AE3A873C9AE) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("stealth", "spotted_event_handler"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("stealth", "spotted_event_handler")]](_id_65661AE3A873C9AE);
}

empty(_id_59A075FA10AA3736, _id_59A074FA10AA3503, _id_59A073FA10AA32D0, _id_59A07AFA10AA4235, _id_59A079FA10AA4002, _id_59A078FA10AA3DCF, _id_59A077FA10AA3B9C, _id_59A07EFA10AA4B01, _id_59A07DFA10AA48CE, _id_C61A7AF2A6570232) {}

set_detect_ranges() {}

set_corpse_detect_ranges() {
  array["sight_dist"] = 512;
  array["detect_dist"] = 256;
  array["found_dist"] = 128;
  scripts\stealth\corpse::set_corpse_ranges(array);
}

_id_7E4CE548F5795C03() {
  while(!isDefined(level.stealth))
    waitframe();

  _id_7DC093FB71342953["prone"] = 1000;
  _id_7DC093FB71342953["crouch"] = 2000;
  _id_7DC093FB71342953["stand"] = getdvarint("dvar_113E6612D6E3BB87", 2750);
  _id_B6B642CBEFF52B88["prone"] = 150;
  _id_B6B642CBEFF52B88["crouch"] = 350;
  _id_B6B642CBEFF52B88["stand"] = 600;
  _id_7DC093FB71342953["shadow_prone"] = 0.05;
  _id_7DC093FB71342953["shadow_crouch"] = 0.05;
  _id_7DC093FB71342953["shadow_stand"] = 0.3;
  _id_3B0034EB96B13650["prone"] = 1500;
  _id_3B0034EB96B13650["crouch"] = 2500;
  _id_3B0034EB96B13650["stand"] = getdvarint("dvar_4689DE43493D4968", 3250);
  _id_D0F35FC0A5C3DF79["prone"] = 250;
  _id_D0F35FC0A5C3DF79["crouch"] = 1000;
  _id_D0F35FC0A5C3DF79["stand"] = 1800;
  _id_3B0034EB96B13650["shadow_prone"] = 0.01;
  _id_3B0034EB96B13650["shadow_crouch"] = 0.02;
  _id_3B0034EB96B13650["shadow_stand"] = 0.38;
  _id_8F3F480583606401["prone"] = 1.1;
  _id_8F3F480583606401["crouch"] = 1.15;
  _id_8F3F480583606401["stand"] = 1.2;
  _id_FAC370D058479827["prone"] = 0;
  _id_FAC370D058479827["crouch"] = 0;
  _id_FAC370D058479827["stand"] = 0;
  _id_FB574B7959625BF0["prone"] = 0;
  _id_FB574B7959625BF0["crouch"] = 0;
  _id_FB574B7959625BF0["stand"] = 0;
  scripts\stealth\utility::set_detect_ranges(_id_7DC093FB71342953, _id_3B0034EB96B13650, _id_8F3F480583606401);
  scripts\stealth\utility::set_min_detect_range_darkness(_id_B6B642CBEFF52B88, _id_D0F35FC0A5C3DF79);
  scripts\stealth\utility::_id_0F3883FE06A11269(_id_FAC370D058479827, _id_FB574B7959625BF0);
  _id_04E4F703E8EA149C["spotted"]["explosion"] = getdvarint("dvar_A164303E1057F68B", 3000);
  _id_04E4F703E8EA149C["hidden"]["explosion"] = getdvarint("dvar_4FF0D45555734622", 2500);
  _id_04E4F703E8EA149C["spotted"]["gunshot"] = getdvarint("dvar_816440654797AA4E", 2500);
  _id_04E4F703E8EA149C["hidden"]["gunshot"] = getdvarint("dvar_0AF518075D89400D", 2500);
  _id_04E4F703E8EA149C["spotted"]["gunshot_teammate"] = getdvarint("dvar_57AD54B68036F52A", 2500);
  _id_04E4F703E8EA149C["hidden"]["gunshot_teammate"] = getdvarint("dvar_EC133BCFE15D64F9", 2500);
  _id_04E4F703E8EA149C["spotted"]["footstep"] = 128;
  _id_04E4F703E8EA149C["hidden"]["footstep"] = getdvarint("dvar_5110FBB11D551C74", 64);
  _id_04E4F703E8EA149C["spotted"]["footstep_walk"] = 512;
  _id_04E4F703E8EA149C["hidden"]["footstep_walk"] = getdvarint("dvar_9300ACAD842264A5", 256);
  _id_04E4F703E8EA149C["spotted"]["footstep_sprint"] = 768;
  _id_04E4F703E8EA149C["hidden"]["footstep_sprint"] = getdvarint("dvar_042B014DF24F71FA", 512);
  scripts\stealth\manager::set_custom_distances(_id_04E4F703E8EA149C);

  if(isDefined(level._id_2921E9FC2C12207C))
    [[level._id_2921E9FC2C12207C]]();
}

manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    threat_sight_set_dvar(1);
    scripts\engine\utility::flag_wait("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    scripts\stealth\manager::event_change("spotted");
    scripts\engine\utility::flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    scripts\stealth\manager::event_change("hidden");
    waittillframeend;
  }
}

threat_sight_set_dvar(enabled) {
  if(enabled && !_func_7A21AA652F0613B0()) {
    return;
  }
  setDvar("ai_threatSight", enabled);
}

update_stealth_spotted_thread() {
  waitframe();
  _id_5560C6A46094816F = 0;

  for(;;) {
    _id_65661AE3A873C9AE = scripts\stealth\manager::anyone_in_combat();

    if(_id_65661AE3A873C9AE) {
      if(!_id_5560C6A46094816F && isDefined(level.stealth.stealth_spotted_delay)) {
        wait(level.stealth.stealth_spotted_delay);

        if(!scripts\stealth\manager::anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_set("stealth_spotted");

        foreach(player in level.players) {
          if(isDefined(player.stealth)) {
            if(isDefined(level._id_C5E87DFA7679B0A5))
              player[[level._id_C5E87DFA7679B0A5]](1);

            _id_F950051ECB0CD613 = player scripts\stealth\utility::get_group_flagname("stealth_spotted");
            scripts\engine\utility::flag_set(_id_F950051ECB0CD613);
          }
        }
      }
    } else if(scripts\engine\utility::flag("stealth_spotted")) {
      scripts\engine\utility::flag_clear("stealth_spotted");

      foreach(player in level.players) {
        if(isDefined(player.stealth)) {
          if(isDefined(level._id_C5E87DFA7679B0A5))
            player[[level._id_C5E87DFA7679B0A5]](0);

          _id_F950051ECB0CD613 = player scripts\stealth\utility::get_group_flagname("stealth_spotted");
          scripts\engine\utility::flag_clear(_id_F950051ECB0CD613);
        }
      }
    }

    _id_5560C6A46094816F = _id_65661AE3A873C9AE;
    waitframe();
  }
}

get_corpse_array() {
  if(!isDefined(level.stealth.corpses))
    return [];

  foreach(_id_AC0E594AC96AA3A8, v in level.stealth.corpses) {
    if(!isDefined(level.stealth.corpses[_id_AC0E594AC96AA3A8]))
      level.stealth.corpses[_id_AC0E594AC96AA3A8] = undefined;
  }

  return level.stealth.corpses;
}

monitor_death_thread(_id_448A418E975E9B01, _id_6A01DAAB475B44AB) {
  other = undefined;
  team = self.team;

  if(isDefined(self.stealth.override_damage_auto_range))
    _id_448A418E975E9B01 = self.stealth.override_damage_auto_range;
  else if(isDefined(level.stealth.override_damage_auto_range))
    _id_448A418E975E9B01 = level.stealth.override_damage_auto_range;

  if(isDefined(self.stealth.override_damage_sight_range))
    _id_6A01DAAB475B44AB = self.stealth.override_damage_sight_range;
  else if(isDefined(level.stealth.override_damage_sight_range))
    _id_6A01DAAB475B44AB = level.stealth.override_damage_sight_range;

  self waittill("death");
  body = self getcorpseentity();

  if(isDefined(body))
    level.stealth.corpses[body getentitynumber()] = body;

  if(!isDefined(self.lastattacker)) {
    return;
  }
  other = self.lastattacker;

  if(!isPlayer(other) && (!isDefined(other.owner) || !isPlayer(other.owner))) {
    return;
  }
  if(isDefined(other.owner))
    other = other.owner;

  if(!isDefined(other.team) || other.team == team) {
    return;
  }
  _func_AAD7A0EA8AC4CA23("ally_killed", self, other, _id_448A418E975E9B01, _id_6A01DAAB475B44AB);
}

get_player_drone(player) {
  if(isDefined(player.scout_drone))
    return player.scout_drone;

  if(isDefined(player.emp_drone))
    return player.emp_drone;

  return undefined;
}