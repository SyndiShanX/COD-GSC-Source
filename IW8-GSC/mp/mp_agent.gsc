/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_agent.gsc
***********************************************/

init_agent(var_0) {
  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  init_spawn_times();
  var_1 = [];
  var_1["_encstr_B15F08D341887E0F1DDB"] = 3;
  var_1["_encstr_BA71144390C3636FBB56898C78637BEC4161CBEBE893"] = 4;
  var_1["_encstr_97D30BE3107FF39715A84930B9"] = 5;
  var_1["_encstr_A6F10A61AAEFF1582559D7CF"] = 6;
  var_1["_encstr_91B50734CA58631D1A"] = 7;
  var_1["_encstr_B607032B8B"] = 8;
  var_1["_encstr_8F9F07D3D81FB62369"] = 9;
  var_1["_encstr_AB960DF80DDBE9AE01FFC2CF387309"] = 10;
  var_1["_encstr_8219049FF2FA"] = 11;
  var_1["_encstr_8D4607ABF0ABE4FB47"] = 12;
  var_1["_encstr_AFF60752796347C440"] = 13;
  var_1["_encstr_888C07D859CE851BCB"] = 14;
  var_2 = 0;
  var_3 = 50;

  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_4, 2);

    if(var_5 == "_encstr_B40101") {
      break;
    }

    var_6 = [];

    foreach(var_11, var_8 in var_1) {
      var_9 = tablelookupbyrow(var_0, var_4, var_8);

      if(var_9 == "_encstr_934C0218")
        var_9 = 0;
      else if(int(var_9) != 0) {
        var_10 = var_9 + "_encstr_B40101";

        if(issubstr(var_10, "_encstr_BD4C024E"))
          var_9 = float(var_9);
        else
          var_9 = int(var_9);
      }

      var_6[var_11] = var_9;
    }

    level.agent_definition[var_5] = var_6;
  }

  level notify("_encstr_A6ED1CC74382502FC35A8916E2776DA0DBCB174BE62CC0FBBFE220BA8A53");
}

init_spawn_times() {
  level.agent_available_to_spawn_time = [];
  level.agent_recycle_interval = 500;
}

setup_bt_and_asm() {
  var_0 = level.agent_definition[self.agent_type];

  if(!isDefined(var_0["_encstr_AB960DF80DDBE9AE01FFC2CF387309"]) || var_0["_encstr_AB960DF80DDBE9AE01FFC2CF387309"] == "_encstr_B40101") {
    return;
  }
  scripts\mp\agents\scriptedagents::ai_init(var_0["_encstr_AB960DF80DDBE9AE01FFC2CF387309"], var_0["_encstr_8219049FF2FA"]);
}

setupweapon(var_0) {
  self.weapon = var_0;
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
}

_id_131FD() {
  if(!isDefined(level.gameskill)) {
    level.gameskill = 0;
    level.difficultytype[0] = "_encstr_8C07031599";
    level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"][level.difficultytype[level.gameskill]] = 1.3;
    level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"][level.difficultytype[level.gameskill]] = 1.0;
  }
}

setup_spawn_struct(var_0) {
  self.spawner = var_0;
}

spawnnewagentaitype(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::string_starts_with(var_0, "_encstr_880B07DFB62BB72B3F"))
    var_0 = "_encstr_880B07DFB62BB72B3F" + var_0;

  if(!isDefined(level.agent_definition[var_0]))
    return undefined;

  var_4 = spawnnewagent(var_0, level.agent_definition[var_0]["_encstr_8AEF05472BC2D6"], var_1, var_2);
  return var_4;
}

spawnnewagent(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getfreeagent(var_0);

  if(isDefined(var_6)) {
    if(!isDefined(var_3))
      var_3 = (0, 0, 0);

    var_6.connecttime = gettime();

    if(isDefined(var_5))
      var_6 setup_spawn_struct(var_5);

    if(!isDefined(var_1))
      var_1 = "_encstr_8E8405EA382B2A";

    var_6 set_agent_team(var_1);
    var_6 set_agent_model(var_6, var_0);
    var_6 set_agent_species(var_6, var_0);

    if(is_scripted_agent(var_0))
      var_6 = spawn_scripted_agent(var_6, var_0, var_2, var_3);
    else
      var_6 = spawn_regular_agent(var_6, var_2, var_3);

    var_6 set_agent_team(var_1);
    var_6 setup_agent(var_0);
    var_6 set_agent_spawn_health(var_6, var_0);
    var_6 set_agent_traversal_unit_type(var_6, var_0);
    var_6 add_to_characters_array();
    var_6 _id_131FD();

    if(is_using_behaviortree(var_0))
      var_6 setup_bt_and_asm();

    if(isDefined(var_4)) {
      if(issameweapon(var_4))
        var_6 setupweapon(var_4);
      else
        return undefined;
    }

    var_6 activateagent();
    var_6 scripts\engine\utility::set_ai_number();
  }

  return var_6;
}

watch_for_team_undefined() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(self.team))
      level notify("_encstr_87CD13859DCA7347EBAD5AB99BD2E6CEAF3A560BAD");

    waitframe();
  }
}

set_agent_traversal_unit_type(var_0, var_1) {
  if(!can_set_traversal_unit_type(var_0)) {
    return;
  }
  if(!isDefined(anim.animselector))
    _encstr_8DB11E37B1272D0ED16EE5B073B45BCB2CDCA5B56E596356B11DEDE4E2CE6E8D::init();

  var_0.unittype = level.agent_definition[var_1]["_encstr_BA71144390C3636FBB56898C78637BEC4161CBEBE893"];
}

can_set_traversal_unit_type(var_0) {
  if(is_agent_scripted(var_0))
    return 1;

  return 0;
}

set_agent_model(var_0, var_1) {
  var_2 = level.agent_definition[var_1]["_encstr_A9CE11B9568ED5E0BE5BB72356D8EB66ABDCB1"];

  if(isDefined(var_2)) {
    var_0[[var_2]](var_1);
    return;
  }

  var_0 detachall();
  var_0 setModel(level.agent_definition[var_1]["_encstr_97D30BE3107FF39715A84930B9"]);
  var_0 show();
}

is_scripted_agent(var_0) {
  return level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] != "_encstr_B40101";
}

is_using_behaviortree(var_0) {
  if(!isDefined(level.agent_definition[var_0]))
    return 0;

  return level.agent_definition[var_0]["_encstr_AB960DF80DDBE9AE01FFC2CF387309"] != "_encstr_B40101";
}

spawn_scripted_agent(var_0, var_1, var_2, var_3) {
  var_0.onenteranimstate = var_0 speciesfunc("_encstr_9A2113B7B9AF56738EB2C9EB16734BB5E63A851D59");
  var_0.is_scripted_agent = 1;
  var_4 = level.agent_definition[var_1]["_encstr_8D4607ABF0ABE4FB47"];

  if(!isDefined(var_4))
    var_4 = 15;

  var_5 = level.agent_definition[var_1]["_encstr_AFF60752796347C440"];

  if(!isDefined(var_5))
    var_5 = 50;

  var_6 = level.agent_definition[var_1]["_encstr_888C07D859CE851BCB"];

  if(!isDefined(var_6) || isstring(var_6))
    var_6 = 0;

  var_0 spawnagent(var_2, var_3, level.agent_definition[var_1]["_encstr_A6F10A61AAEFF1582559D7CF"], var_4, var_5, undefined, var_6);
  var_0.agent_height = var_5;
  var_0.agent_radius = var_4;
  var_0.legacy = spawnStruct();
  return var_0;
}

spawn_regular_agent(var_0, var_1, var_2) {
  var_0.is_scripted_agent = 0;
  var_0 spawnagent(var_1, var_2);
  return var_0;
}

is_agent_scripted(var_0) {
  return var_0.is_scripted_agent;
}

agent_go_to_pos(var_0, var_1, var_2, var_3, var_4) {
  if(is_agent_scripted(self))
    self setgoalpos(var_0);
  else
    self botsetscriptgoal(var_0, var_1, var_2, var_3, var_4);
}

setup_agent(var_0) {
  var_1 = level.agent_definition[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1["_encstr_A3E30B27A5A3108FCFCA0B50A2"];

  if(!isDefined(var_2)) {
    return;
  }
  self[[var_2]]();
}

set_agent_species(var_0, var_1) {
  if(!isDefined(level.agent_funcs[var_1]))
    level.agent_funcs[var_1] = [];

  var_0.species = level.agent_definition[var_1]["_encstr_B15F08D341887E0F1DDB"];

  if(isDefined(var_0.species) && !isDefined(level.species_funcs[var_0.species]) || !isDefined(level.species_funcs[var_0.species]["_encstr_9A2113B7B9AF56738EB2C9EB16734BB5E63A851D59"])) {
    level.species_funcs[var_0.species] = [];
    level.species_funcs[var_0.species]["_encstr_9A2113B7B9AF56738EB2C9EB16734BB5E63A851D59"] = ::default_on_enter_animstate;
  }

  assign_agent_func("_encstr_8E8A06F7D987435E", ::default_spawn_func);
  assign_agent_func("_encstr_8BB20BDE37D723C2DA859DACC8", ::default_on_damage);
  assign_agent_func("_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46", ::default_on_damage_finished);
  assign_agent_func("_encstr_96330A95DD7FB43840C92ACD", ::default_on_killed);
}

assign_agent_func(var_0, var_1) {
  var_2 = self.agent_type;

  if(!isDefined(level.agent_funcs[var_2][var_0])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][var_0]))
      level.agent_funcs[var_2][var_0] = var_1;
    else
      level.agent_funcs[var_2][var_0] = level.species_funcs[self.species][var_0];
  }
}

set_agent_spawn_health(var_0, var_1) {
  var_0 set_agent_health(level.agent_definition[var_1]["_encstr_91B50734CA58631D1A"]);
}

get_agent_type(var_0) {
  return var_0.agent_type;
}

getfreeagentcount() {
  if(!isDefined(level.agentarray))
    return 0;

  var_0 = gettime();
  var_1 = 0;

  foreach(var_3 in level.agentarray) {
    if(!isDefined(var_3.isactive) || !var_3.isactive) {
      if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
        continue;
      }
      var_4 = var_3 getentitynumber();

      if(isDefined(level.agent_available_to_spawn_time) && isDefined(level.agent_available_to_spawn_time[var_4]) && var_0 < level.agent_available_to_spawn_time[var_4]) {
        continue;
      }
      var_1++;
    }
  }

  return var_1;
}

getfreeagent(var_0) {
  var_1 = undefined;
  var_2 = gettime();

  if(isDefined(level.agentarray)) {
    foreach(var_4 in level.agentarray) {
      if(!isDefined(var_4.isactive) || !var_4.isactive) {
        if(isDefined(var_4.waitingtodeactivate) && var_4.waitingtodeactivate) {
          continue;
        }
        var_5 = var_4 getentitynumber();

        if(isDefined(level.agent_available_to_spawn_time)) {
          if(isDefined(level.agent_available_to_spawn_time[var_5]) && var_2 < level.agent_available_to_spawn_time[var_5]) {
            continue;
          }
          level.agent_available_to_spawn_time[var_5] = undefined;
        }

        var_1 = var_4;
        var_1.agent_type = var_0;
        var_1 initagentscriptvariables();
        var_1 notify("_encstr_AFD60D31349DC673011B537F035078");
        break;
      }
    }
  }

  return var_1;
}

initagentscriptvariables() {
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.isagent = 1;
  self.spawntime = 0;
  self.entity_number = self getentitynumber();
  self.agent_teamparticipant = 0;
  self.agent_gameparticipant = 0;
  self.agentname = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self detachall();
  initplayerscriptvariables();
}

initplayerscriptvariables() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  scripts\common\input_allow::clear_allow_info("_encstr_AC20072B9FA9487832");
  scripts\common\input_allow::clear_allow_info("_encstr_8E170DEB5287C7806DA30733AC1680");
  scripts\common\input_allow::clear_allow_info("_encstr_A3760DF666334316CD32AE2B58079B");
  scripts\common\input_allow::clear_allow_info("_encstr_9BE40A0BC09BCEF7C0F33441");
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;

  if(isDefined(level.gametype_agent_init))
    self[[level.gametype_agent_init]]();
}

set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.agentteam = var_0;
  self.pers["_encstr_8AEF05472BC2D6"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

add_to_characters_array() {
  for(var_0 = 0; var_0 < level.characters.size; var_0++) {
    if(level.characters[var_0] == self)
      return;
  }

  level.characters[level.characters.size] = self;
}

agentfunc(var_0) {
  return level.agent_funcs[self.agent_type][var_0];
}

speciesfunc(var_0) {
  return level.species_funcs[self.species][var_0];
}

validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  if(isagent(var_0) && !isDefined(var_0.classname))
    return undefined;

  return var_0;
}

set_agent_health(var_0) {
  self.agenthealth = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}

default_spawn_func(var_0, var_1, var_2) {}

is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team)
      return 1;

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team)
      return 1;
  }

  return 0;
}

default_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_14 = undefined;

  if(istrue(self._encstr_82B61D186381B9D0E711DB40E7F7FB41F6CBB821EBA7F5E98722D1CFF63F61))
    var_2 = int(var_2 * 0.0);

  if(istrue(self._encstr_888A1DE459C8D51B2B7DA5E6B1BDDA5AB9B37DB62BB1CA2BEB32856BB0ECCA) && var_4 == "_encstr_8DED0A21C79B660BC7588981")
    var_2 = int(var_2 * 0.1);

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]))
    var_14 = level.agent_funcs[self.unittype]["_encstr_8C841417DFC0FF7B93D802B938E5F9B339B1998F6549"];

  if(isDefined(var_14)) {
    var_15 = [[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_15))
      return var_15;
  } else {
    var_14 = level.agent_funcs[self.agent_type]["_encstr_8C841417DFC0FF7B93D802B938E5F9B339B1998F6549"];

    if(isDefined(var_14))
      [[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(is_friendly_damage(var_13, var_0)) {
    return;
  }
  if(istrue(var_13.agentdamagefeedback)) {
    var_16 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")) {
      var_16 = isDefined(var_12) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")]](var_12.basename);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_A23615C3AE1239608DF3D0B84FA71925CAD74D5E067AEF"))
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_A23615C3AE1239608DF3D0B84FA71925CAD74D5E067AEF")]](var_0, var_1, var_13, var_2, var_4, var_12, var_8, var_3, 0, 0, var_16);
    }
  }

  if(istrue(self._encstr_846A1D03EF69CF5B5F69EFF17AD0B75B96B8FE375807E140C9EBCE63C7721E))
    self[[level.agent_funcs[var_13.unittype]["_encstr_8BB20BDE37D723C2DA859DACC8"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);

  if(isDefined(level.binoculars_runadslogic))
    var_13[[level.binoculars_runadslogic]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  else if(isDefined(var_13.unittype) && isDefined(level.agent_funcs[var_13.unittype]) && isDefined(level.agent_funcs[var_13.unittype]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]))
    var_13[[level.agent_funcs[var_13.unittype]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  else
    var_13[[level.agent_funcs[var_13.agent_type]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = self.health;
  var_16 = var_5;
  self.damagedby = var_1;
  self.damagepoint = var_6;
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_16, var_6, var_7, var_8, var_9, 0.0, var_11, var_12);

  if(self.health > 0 && self.health < var_15) {
    self notify("_encstr_B60D055B0E3128");
    scripts\asm\asm_mp::_id_12E1D();
  }

  if(isalive(self)) {
    if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"])) {
      var_17 = level.agent_funcs[self.unittype]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"];

      if(isDefined(var_17)) {
        [[var_17]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
        return;
      }
    } else if(isDefined(self.agent_type)) {
      var_17 = level.agent_funcs[self.agent_type]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"];

      if(isDefined(var_17))
        [[var_17]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    }
  }
}

default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.on_zombie_agent_killed_common))
    self[[self.on_zombie_agent_killed_common]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  else
    on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"])) {
    var_9 = level.agent_funcs[self.unittype]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"];

    if(isDefined(var_9))
      [[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else {
    var_9 = level.agent_funcs[self.agent_type]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"];

    if(isDefined(var_9))
      [[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  deactivateagent();
}

default_on_enter_animstate(var_0, var_1) {
  self.aistate = var_1;

  switch (var_1) {
    case "_encstr_B8C809C3F5BF6B6D9093AF":
      self.do_immediate_ragdoll = 1;
      scripts\asm\shared\mp\utility::dotraversal();
      self.do_immediate_ragdoll = 0;
      break;
    default:
      break;
  }

  cleardamagehistory();
}

cleardamagehistory() {
  self.recentdamages = [];
  self.damagelistindex = 0;
}

deactivateagent() {
  var_0 = self getentitynumber();
  level.agent_available_to_spawn_time[var_0] = gettime() + 500;
}

getnumactiveagents(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_AF1904A7F929";

  var_1 = getactiveagentsoftype(var_0);
  return var_1.size;
}

getactiveagentsoftype(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray))
    return var_1;

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "_encstr_AF1904A7F929" || var_3.agent_type == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getaliveagentsofteam(var_0) {
  var_1 = [];

  foreach(var_3 in level.agentarray) {
    if(isalive(var_3) && isDefined(var_3.team) && var_3.team == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

getactiveagentsofspecies(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray))
    return var_1;

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.species == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getaliveagents() {
  var_0 = [];

  foreach(var_2 in level.agentarray) {
    if(isalive(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

activateagent() {
  self.isactive = 1;
  self.spawn_time = gettime();
}

bot_choose_attack_role(var_0, var_1) {
  if(var_0 != "_encstr_8D4E0A501FCB898912CB3FA3")
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!var_1 scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  return 1;
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = bot_choose_attack_role(var_3, var_0);
  self asmdodeathtransition(self.asmname);

  if(isDefined(self.deathanimduration))
    var_8 = self.deathanimduration;
  else if(var_8 == 0)
    var_8 = 500;

  if(isDefined(self.fncleanupbt))
    self[[self.fncleanupbt]]();

  if(isDefined(self.nocorpse)) {
    return;
  }
  var_11 = self;
  self.body = self cloneagent(var_8);

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(var_3) && var_3 == "_encstr_9B0D099AD3887D91252954")
      self.ragdoll_directionscale = 0;

    if(!istrue(self._blackboard.invehicle) || istrue(self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll)) {
      if(var_10)
        self.body isbnetigrplayer(var_0);
      else if(should_do_immediate_ragdoll(self)) {
        if(isDefined(self.ragdollhitloc) && isDefined(self.ragdollimpactvector))
          self.body startragdollfromimpact(self.ragdollhitloc, self.ragdollimpactvector);
        else
          do_immediate_ragdoll(self.body);
      } else
        thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
    } else {
      self.body enablelinkTo();

      if(istrue(self._blackboard.chosenvehicleanimpos.linktoblend))
        self.body linktoblendtotag(self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag, 0);
      else
        self.body linktomoveoffset(self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag);

      if(isDefined(self._blackboard.vehicledeathwait))
        thread delaystartragdoll(self.body, var_6, var_4, var_0, var_3);
      else
        self.body thread _id_129E6(self._blackboard.currentvehicle);
    }
  } else if(istrue(self.burningtodeath)) {
    if(self isscriptable()) {
      var_12 = self getscriptablepartstate("_encstr_832419E027822057A30578FD9FAA59A8C703B091EF27B8FF4B2DE4", 1);

      if(isDefined(var_12) && var_12 == "_encstr_930B07BB1B6B3854FF") {
        self.body setscriptablepartstate("_encstr_832419E027822057A30578FD9FAA59A8C703B091EF27B8FF4B2DE4", "_encstr_930B07BB1B6B3854FF");
        thread _id_13FC8(self.body);
        thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
      }
    }
  } else if(var_10)
    self.body isbnetigrplayer(var_0);
  else if(should_do_immediate_ragdoll(self)) {
    if(isDefined(self.ragdollhitloc) && isDefined(self.ragdollimpactvector))
      self.body startragdollfromimpact(self.ragdollhitloc, self.ragdollimpactvector);
    else
      do_immediate_ragdoll(self.body);
  } else
    thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
}

_id_129E6(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(self isragdoll()) {
    return;
  }
  if(isDefined(var_0)) {
    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(var_0) || var_0 scripts\common\vehicle_code::vehicle_iscorpse()) {
        self unlink();
        self startragdoll();
        return;
      }

      waitframe();
    }
  }
}

should_do_immediate_ragdoll(var_0) {
  if(istrue(var_0.do_immediate_ragdoll))
    return 1;

  if(istrue(var_0.forceragdollimmediate))
    return 1;

  return 0;
}

do_immediate_ragdoll(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector)) {
    var_0 startragdollfromimpact(var_0.ragdollhitloc, var_0.ragdollimpactvector);
    return;
  }

  var_1 = 10;
  var_2 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && isPlayer(self.attacker) && var_2 == "_encstr_A6C7065BACB1CA95")
    var_1 = 5;

  var_3 = self.damagetaken;

  if(var_2 == "_encstr_A6260731BAD8D82BD1" || isDefined(self.damagemod) && self.damagemod == "_encstr_9B0D099AD3887D91252954")
    var_3 = min(var_3, 300);

  var_4 = var_1 * var_3;
  var_5 = max(0.3, self.damagedir[2]);
  var_6 = (self.damagedir[0], self.damagedir[1], var_5);

  if(isDefined(self.ragdoll_directionscale))
    var_6 = var_6 * self.ragdoll_directionscale;
  else
    var_6 = var_6 * var_4;

  if(self.forceragdollimmediate)
    var_6 = var_6 + self.prevanimdelta * 20 * 10;

  if(isDefined(self.ragdoll_start_vel))
    var_6 = var_6 + self.ragdoll_start_vel * 10;

  var_7 = self.damagelocation;

  if(isDefined(self.ragdoll_damagelocation_none) && var_7 == "_encstr_8BBA05185F8B99")
    var_7 = self.ragdoll_damagelocation_none;

  var_0 startragdollfromimpact(var_7, var_6);
}

delaystartragdoll(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 getcorpseanim();

    if(animhasnotetrack(var_6, "_encstr_96CB0FA7D73837F551A9E2AAD71F5D7AD1"))
      return;
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_8 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536)
        return;
    }
  }

  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 isragdoll()) {
    return;
  }
  var_6 = var_0 getcorpseanim();

  if(animisleaf(var_6)) {
    var_10 = 0.35;
    var_11 = getnotetracktimes(var_6, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C");

    if(isDefined(var_11) && var_11.size > 0)
      var_10 = var_11[0];
    else {
      var_11 = getnotetracktimes(var_6, "_encstr_824216F3BD31A1E094D1A121852939A46110C004018FF878");

      if(isDefined(var_11) && var_11.size > 0)
        var_10 = var_11[0];
    }

    var_12 = var_10 * getanimlength(var_6) - level.frameduration / 1000;

    if(var_12 > 0)
      wait(var_12);
  }

  self unlink();

  if(isDefined(var_0)) {
    if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector))
      var_0 startragdollfromimpact(var_0.ragdollhitloc, var_0.ragdollimpactvector);
    else
      var_0 startragdoll();
  }
}

_id_13FC8(var_0) {
  var_1 = self.asm.archetype == "_encstr_87E80E37DE63915AB2E4BED8EEF59893";

  if(!var_1)
    wait 0.7;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 getwartrackpassengerenabled("_encstr_A5C012C16D8A921BB227EA1BD14D71792DE0790A", 1);

  if(!var_1)
    var_0 dontinterpolate();

  wait 0.95;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_832419E027822057A30578FD9FAA59A8C703B091EF27B8FF4B2DE4", "_encstr_8882099673858D1D4B6756");
}