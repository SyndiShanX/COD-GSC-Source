/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\survival\survival_loadout.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp\calloutmarkerping_cp;
#using scripts\cp\cp_accessories;
#using scripts\cp\cp_loadout;
#using scripts\cp\loadout;
#using scripts\cp\munitions;
#using scripts\cp\super;
#using scripts\cp\survival\survival_loadout;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace survival_loadout;

function init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level.custom_giveloadout = &givedefaultloadout;
  level.move_speed_scale = &updatemovespeedscale;
  level.registerplayercharfunc = &registerplayercharacter;

  if(!isDefined(level.loadoutsgroup)) {
    level.loadoutsgroup = getplayerdataloadoutgroup();
  }

  initnightvisionheadoverrides();
}

function initnightvisionheadoverrides() {
  if(!function_6aafbdd00b977115()) {
    return;
  }

  level.nvgheadoverrides = [];

  foreach(skinref in scripts\cp_mp\operator::function_6ab347c553a20a68()) {
    head = scripts\cp_mp\operator::function_223061772e2a61b9(skinref);
    var_8caf1716b3192f8f = scripts\cp_mp\operator::function_3af837eb38560aad(skinref);
    var_f164251d2631366a = scripts\cp_mp\operator::function_6fa0ec9562a76f6c(skinref);

    if(!isDefined(head) || head == "") {
      break;
    }

    if(var_8caf1716b3192f8f != "") {
      level.nvgheadoverrides[head]["up"] = var_8caf1716b3192f8f;
    }

    if(var_f164251d2631366a != "") {
      level.nvgheadoverrides[head]["down"] = var_f164251d2631366a;
    }
  }

  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_3"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_4"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["down"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["up"] = "none";
}

function givedefaultloadout(var_86db2022c4f0f4bf, var_185ea69b2fe37360, var_7cb3ce39e2414126, var_9b02313fe7ff70da) {
  self setclientomnvar("ui_options_menu", 0);

  if(istrue(self.is_doing_infil)) {
    thread giveloadoutafterinfil(var_86db2022c4f0f4bf, var_185ea69b2fe37360, var_7cb3ce39e2414126);
    return;
  }

  player = self;
  player.changingweapon = undefined;
  player scripts\cp\cp_accessories::clearplayeraccessory();
  player takeallweapons();

  if(!istrue(player.keep_perks)) {
    player _clearperks();
  }

  player thread delayreturningperks(player);

  if(istrue(var_9b02313fe7ff70da)) {
    player _detachall(1);
  } else {
    player _detachall();

    if(isDefined(player.headmodel)) {
      player.headmodel = undefined;
    }

    char_num = get_player_character_num();

    if(isDefined(var_185ea69b2fe37360)) {
      char_num = var_185ea69b2fe37360;
    }

    player thread setmodelfromcustomization(char_num);
    skinref = player lookupcurrentoperatorskin(player.team);
    var_e89fd4c2e2e797b9 = player getplayerfoleytype(skinref);

    if(var_e89fd4c2e2e797b9 == "") {
      var_e89fd4c2e2e797b9 = "vestlight";
    }

    player setclothtype(getxhash(var_e89fd4c2e2e797b9));
  }

  if(istestclient(player)) {
    var_7cb3ce39e2414126 = 1;
    player thread testclient_run_funcs();
  }

  player.spawnperk = 0;
  flag_wait("introscreen_over");

  if(isDefined(level.move_speed_scale)) {
    self[[level.move_speed_scale]]();
  } else {
    updatemovespeedscale();
  }

  player.primaryweapon = nullweapon();
  player thread scripts\cp\weapon::setweaponlaser_internal();
  player notify("giveLoadout");
  player giveperk("specialty_pistoldeath");

  if(isDefined(var_86db2022c4f0f4bf) && var_86db2022c4f0f4bf) {
    return;
  }

  meleeweapon = player.melee_weapon;
  player.default_starting_melee_weapon = meleeweapon;
  player.currentmeleeweapon = meleeweapon;

  if(allow_super(self)) {
    if(!istrue(self.changing_loadout)) {
      scripts\cp\super::give_player_super(var_7cb3ce39e2414126);
    }
  }

  scripts\cp\cp_loadout::give_weapons_from_loadout(self, var_7cb3ce39e2414126);

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  if(isundefinedweapon(player.default_starting_pistol)) {
    if(!isundefinedweapon(player.starting_weapon)) {
      player.default_starting_pistol = player.starting_weapon;
    } else if(isDefined(level.default_weapon)) {
      player.default_starting_pistol = scripts\cp_mp\weapon::buildweapon(level.default_weapon, [], "none", "none", -1);
    } else {
      player.default_starting_pistol = scripts\cp_mp\weapon::buildweapon("iw8_pi_decho_mp", [], "none", "none", -1);
    }
  }

  player.last_stand_pistol = player.default_starting_pistol;

  if(!isundefinedweapon(player.starting_weapon) && player.starting_weapon == player.default_starting_pistol) {} else {
    var_ea6befbe838b7be0 = getrawbaseweaponname(player.default_starting_pistol);
    player.default_starting_pistol = return_wbk_version_of_weapon(player, var_ea6befbe838b7be0, player.default_starting_pistol);
    player _giveweapon(player.default_starting_pistol, undefined, undefined, 1);
  }

  if(!isundefinedweapon(player.starting_weapon)) {
    var_ea6befbe838b7be0 = getrawbaseweaponname(player.starting_weapon);
    player.starting_weapon = return_wbk_version_of_weapon(player, var_ea6befbe838b7be0, player.starting_weapon);
    player _giveweapon(player.starting_weapon, undefined, undefined, 0);
  }

  baseweapon = getrawbaseweaponname(player.default_starting_pistol);
  player[[level.move_speed_scale]]();
  player giveweapon("super_default_zm");
  player assignweaponoffhandspecial("super_default_zm");
  player.specialoffhandgrenade = "super_default_zm";
  starting_weapon = player.default_starting_pistol;

  if(!isundefinedweapon(player.starting_weapon)) {
    starting_weapon = player.starting_weapon;
  }

  player thread wait_and_force_weapon_switch(starting_weapon);
  player set_player_perks();

  if(!is_wave_gametype()) {
    if(!isDefined(player.enabledbasejumping)) {
      player.enabledbasejumping = 0;
      player scripts\cp\utility::allow_player_basejumping(1);
    } else if(player.enabledbasejumping == 0) {
      player scripts\cp\utility::allow_player_basejumping(1);
    }
  }

  if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.execution)) {
    player scripts\cp_mp\execution::_giveexecution(player.operatorcustomization.execution);
  }

  if(istrue(level.disable_nvg)) {
    player setactionslot(2, "");
  }

  player setactionslot(3, "altmode");
  player notify("loadout_given");
  player.changing_loadout = undefined;
  player thread notify_when_loadout_given();
}

function notify_when_loadout_given() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!is_raid_gamemode() && !istrue(level.dogtag_revive) && !is_wave_gametype()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  if(!flag_exist("player_spawned_with_loadout")) {
    flag_init("player_spawned_with_loadout");
  }

  flag_set("player_spawned_with_loadout");

  if(!ent_flag_exist("player_spawned_with_loadout")) {
    ent_flag_init("player_spawned_with_loadout");
  }

  ent_flag_set("player_spawned_with_loadout");
  scripts\cp\calloutmarkerping_cp::setuppingspecificvars(self);
  thread scripts\cp\munitions::clear_legacy_pickup_munitions();
}

function giveloadoutafterinfil(var_86db2022c4f0f4bf, var_185ea69b2fe37360, var_7cb3ce39e2414126) {
  self notify("giveLoadoutAfterInfil");
  self endon("disconnect");
  self endon("giveLoadoutAfterInfil");
  self waittill("player_finished_infil");
  givedefaultloadout(var_86db2022c4f0f4bf, var_185ea69b2fe37360, var_7cb3ce39e2414126);
}

function allow_super(player) {
  if(isDefined(level.allow_super)) {
    return [[level.allow_super]](player);
  }

  return 1;
}

function return_wbk_version_of_weapon(player, var_ea6befbe838b7be0, objweapon) {
  level endon("game_ended");
  player endon("disconnect");
  return objweapon;
}

function delayreturningperks(player) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill("spawned_player");
  wait 1;

  if(istrue(player.keep_perks)) {
    if(isDefined(player.zombies_perks)) {
      var_37d6720284e968a1 = getarraykeys(player.zombies_perks);

      foreach(perk in var_37d6720284e968a1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[perk]) && isDefined(level.coop_perk_callbacks[perk].set)) {
          player[[level.coop_perk_callbacks[perk].set]]();
        }
      }
    }

    player.keep_perks = undefined;
  }
}

function release_character_number(player) {
  character_number = player.player_character_num;

  if(!array_contains(level.available_player_characters, character_number) && character_number != 5) {
    level.available_player_characters = array_add(level.available_player_characters, character_number);
  }
}

function get_baseweapon_pap_level(player, baseweapon) {
  if(isDefined(player.pap[baseweapon])) {
    return player.pap[baseweapon].lvl;
  }

  return 1;
}

function setmodelfromcustomization(char_num) {
  level endon("game_ended");
  assert(isDefined(self));
  assert(isPlayer(self));
  self.melee_weapon = "iw8_knife_mp";
  customization = getoperatorcustomization();
  body = customization[0];
  head = customization[1];
  self.setcustomization_body = body;
  self.setcustomization_head = head;
  self setcustomization(body, head);
  wait 0.05;

  wait 0.5;

  customization = getoperatorcustomization();
  body = customization[0];
  head = customization[1];
  suit = customization[2];

  if(level.script == "cp_raid_complex") {
    if(self ishost()) {
      body = "body_mp_eastern_geist_1_1_lod1";
      head = "head_mp_eastern_geist_1_1";
      suit = "iw9_suit_mp_nikto";
    } else {
      body = "body_mp_eastern_roze_1_1_lod1";
      head = "head_mp_eastern_roze_1_1";
      suit = undefined;
    }
  }

  if(!isagent(self)) {
    self setcustomization(body, head);
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    var_e69fcb0bb9e108b = self getcustomizationviewmodel();
    viewmodelname = getplayerviewmodelfrombody(body);
  } else {
    bodymodelname = "body_opforce_london_terrorist_1_2";
    headmodelname = "head_male_bc_03";
    var_e69fcb0bb9e108b = "viewmodel_mp_base_iw8";
    viewmodelname = "viewmodel_mp_base_iw8";
  }

  operatorref = lookupcurrentoperator(self.team);
  operatorskin = lookupcurrentoperatorskin(self.team);
  operatorcustomization = spawnStruct();
  operatorcustomization.operatorref = operatorref;
  operatorcustomization.skinref = operatorskin;
  operatorcustomization.body = body;
  operatorcustomization.defaultbody = bodymodelname;
  operatorcustomization.head = head;
  operatorcustomization.defaulthead = headmodelname;
  operatorcustomization.vm = viewmodelname;
  operatorcustomization.defaultvm = var_e69fcb0bb9e108b;
  operatorcustomization.gender = getoperatorgender(operatorref);
  operatorcustomization.voice = getoperatorvoice(operatorref, operatorskin);
  operatorcustomization.clothtype = getoperatorclothtype(operatorskin);
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  operatorcustomization.execution = getoperatorexecution(operatorref);
  operatorcustomization.executionquip = getoperatorexecutionquip(operatorref);
  operatorcustomization.suit = suit;
  operatorcustomization.rebuild = 0;
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  self.operatorcustomization = operatorcustomization;
  setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
  self.vehiclecustomization = scripts\cp_mp\vehicles\vehicle::function_1cd6d75165ecbc48();

  if(self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else {
    self function_555e2d32e2756625("");
  }

  if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](self)) {
    self[[level.change_to_terrorist_model_func]](self);
  }

  if(isDefined(level.post_customization_func)) {
    self[[level.post_customization_func]]();
  }
}

function getplayerbodymodel() {
  customization = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  return customization[0];
}

function getplayerviewmodelfrombody(bodyref) {
  viewmodel = scripts\cp_mp\operator::function_aa32c85a2c2a2d8b(bodyref);

  if(!isDefined(viewmodel) || viewmodel == "") {
    viewmodel = "viewhands_mp_base_iw8";
  }

  return viewmodel;
}

function lookupcurrentoperator(team) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  selectedoperatorindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  teamindex = selectedoperatorindex;
  var_498a2226e5aa47ee = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(!level.teambased || var_498a2226e5aa47ee) {
    selectedoperatorindex = undefined;

    if(isai(self)) {
      selectedoperatorindex = self.botoperatorteam;
    } else {
      selectedoperatorindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
    }

    teamindex = selectedoperatorindex;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(teamindex == 0) {
        self.defaultoperatorteam = "allies";
      } else {
        self.defaultoperatorteam = "axis";
      }
    }
  }

  if(!isDefined(level.playercustomizationdata)) {
    level.playercustomizationdata = [];
  }

  clientnum = self getentitynumber();
  level.playercustomizationdata[clientnum] = [];
  operatorref = undefined;

  if(!isDefined(level.playercustomizationdata[clientnum][team])) {
    data = spawnStruct();

    if(isai(self)) {
      data.operatorref = self.botoperatorref;
    } else {
      data.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", teamindex);
    }

    level.playercustomizationdata[clientnum][team] = data;
  }

  operatorref = level.playercustomizationdata[clientnum][team].operatorref;

  if(getdvarint(@ "hash_338da2f6c53885e2", 1) == 1 && self isplayerheadless()) {
    var_a35e0c377810107e = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.headlesscustomizationops)) {
      foreach(opteam in var_a35e0c377810107e) {
        var_ea61dcdcedf141e7 = getarraykeys(level.operatorcustomization[opteam]);

        if(!isDefined(level.headlessopindex)) {
          level.headlessopindex = [];
        }

        if(!isDefined(level.headlessopindex[opteam]) || level.headlessopindex[opteam] > var_ea61dcdcedf141e7.size) {
          level.headlessopindex[opteam] = 0;
        }

        targetref = var_ea61dcdcedf141e7[level.headlessopindex[opteam]];
        assert(var_ea61dcdcedf141e7.size > 1);

        while(isDefined(targetref) && (targetref == "default_western" || targetref == "default_eastern")) {
          level.headlessopindex[opteam] += 1;

          if(level.headlessopindex[opteam] > var_ea61dcdcedf141e7.size) {
            level.headlessopindex[opteam] = 0;
          }

          targetref = var_ea61dcdcedf141e7[level.headlessopindex[opteam]];
        }

        level.headlessopindex[opteam] += 1;
        level.playercustomizationdata[clientnum][opteam] = spawnStruct();
        level.playercustomizationdata[clientnum][opteam].operatorref = targetref;
      }

      self.headlesscustomizationops = 1;
    }

    if(isDefined(level.operatorcustomization[team])) {
      operatorref = level.playercustomizationdata[clientnum][team].operatorref;
    } else {
      if(!isDefined(self.botoperatorteam)) {
        self.botoperatorteam = random(var_a35e0c377810107e);
      }

      operatorref = level.playercustomizationdata[clientnum][self.botoperatorteam].operatorref;
    }
  }

  if(isai(self) || !isDefined(operatorref) || operatorref == "") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[clientnum][team].operatorref)) {
          operatorref = level.playercustomizationdata[clientnum][team].operatorref;
        } else {
          operatorref = self.botoperatorref;
        }
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            var_a35e0c377810107e = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = random(var_a35e0c377810107e);
          }
        }

        team = self.botoperatorteam;

        if(!isDefined(self.pers["operatorIndex"])) {
          selectedoperatorindex = randomint(level.operatorcustomization[team].size);
          self.pers["operatorIndex"] = selectedoperatorindex;
        } else {
          selectedoperatorindex = self.pers["operatorIndex"];
        }

        currentindex = 0;

        foreach(operatorkey, var_eef96dced6dd39f1 in level.operatorcustomization[team]) {
          if(currentindex == selectedoperatorindex) {
            self.botoperatorref = operatorkey;
            operatorref = operatorkey;
            break;
          }

          currentindex++;
        }
      }
    } else {
      operatorref = "wyatt_western";
    }
  }

  return operatorref;
}

function lookupcurrentoperatorskin(team) {
  operatorref = lookupcurrentoperator(team);
  skinref = undefined;
  clientnum = self getentitynumber();

  if(getdvarint(@ "hash_338da2f6c53885e2", 1) == 1 && self isplayerheadless()) {
    if(!isDefined(level.playercustomizationdata[clientnum][team].operatorskinref)) {
      if(!isDefined(level.headlessoperatorcustomization)) {
        initheadlessoperatorcustomization();
      }

      curindex = level.headlessoperatorcustomization[operatorref]["curIndex"];
      level.playercustomizationdata[clientnum][team].operatorskinref = level.headlessoperatorcustomization[operatorref]["skinRefs"][curindex];
      level.headlessoperatorcustomization[operatorref]["curIndex"] = level.headlessoperatorcustomization[operatorref]["curIndex"] + 1;

      if(level.headlessoperatorcustomization[operatorref]["curIndex"] >= level.headlessoperatorcustomization[operatorref]["maxIndex"]) {
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
      }
    }
  } else if(!isDefined(level.playercustomizationdata[clientnum][team].operatorskinref)) {
    if(isai(self)) {
      if(!isDefined(self.botskinid)) {
        botpickskinid(operatorref);
      }

      level.playercustomizationdata[clientnum][team].operatorskinref = self.botskinid;
    } else {
      level.playercustomizationdata[clientnum][team].operatorskinref = scripts\cp_mp\operator::function_b3b2c9581b1eea75(operatorref);
    }
  }

  skinref = level.playercustomizationdata[clientnum][team].operatorskinref;

  if(isai(self) && (!isDefined(skinref) || skinref == "") || !isDefined(skinref) || skinref == "") {
    if(isai(self)) {
      if(isDefined(self.botskinid)) {
        skinref = self.botskinid;
      } else {
        botpickskinid(operatorref);
      }
    } else {
      skinref = "shadow_smg_western_basic";
    }
  }

  return skinref;
}

function botpickskinid(operatorref) {
  team = self.team;

  if(isDefined(self.botoperatorteam)) {
    team = self.botoperatorteam;
  }

  if(!isDefined(self.pers["operatorSkinRef"])) {
    var_32d984c24ea6f4be = random(getarraykeys(level.operatorcustomization[team][operatorref]));
    self.pers["operatorSkinRef"] = var_32d984c24ea6f4be;
  } else {
    var_32d984c24ea6f4be = self.pers["operatorSkinRef"];
  }

  self.botskinid = var_32d984c24ea6f4be;
}

function initheadlessoperatorcustomization() {
  if(isDefined(level.headlessoperatorcustomization)) {
    return;
  }

  level.headlessoperatorcustomization = [];

  foreach(skinref in scripts\cp_mp\operator::function_6ab347c553a20a68()) {
    if(scripts\cp_mp\operator::function_9e28d6dc0ac60d69(skinref) != "") {
      operatorref = scripts\cp_mp\operator::function_605079124463a67b(skinref);

      if(!isDefined(level.headlessoperatorcustomization[operatorref])) {
        level.headlessoperatorcustomization[operatorref]["skinRefs"] = [];
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
        level.headlessoperatorcustomization[operatorref]["maxIndex"] = 0;
      }

      level.headlessoperatorcustomization[operatorref]["skinRefs"][level.headlessoperatorcustomization[operatorref]["skinRefs"].size] = skinref;
      level.headlessoperatorcustomization[operatorref]["maxIndex"] = level.headlessoperatorcustomization[operatorref]["maxIndex"] + 1;
    }
  }
}

function lookupotheroperator(team) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  teamindex = ter_op(team == "allies", 1, 0);
  clientnum = self getentitynumber();
  operatorref = "";
  team = ter_op(team == "allies", "axis", "allies");

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[clientnum][team])) {
        data = spawnStruct();
        data.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", teamindex);
        level.playercustomizationdata[clientnum][team] = data;
      }

      operatorref = level.playercustomizationdata[clientnum][team].operatorref;
    }
  }

  return operatorref;
}

function initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }

  level.operatorcustomization = [];
  setDvar(@ "hash_2b669ad6c3e1d864", 1);
  operatorrefs = scripts\cp_mp\operator::getoperatorrefs();

  foreach(operatorref in operatorrefs) {
    superfaction = scripts\cp_mp\operator::getoperatorsuperfaction(operatorref);
    team = ter_op(superfaction == 0, "allies", "axis");

    if(!isDefined(operatorref) || operatorref == "") {
      break;
    }

    unlocked = scripts\cp_mp\operator::isoperatorunlocked(operatorref);

    if(unlocked) {
      if(!isDefined(level.operatorcustomization[team])) {
        level.operatorcustomization[team] = [];
      }

      level.operatorcustomization[team][operatorref] = [];
    }
  }

  foreach(skinref in scripts\cp_mp\operator::function_6ab347c553a20a68()) {
    operatorref = scripts\cp_mp\operator::function_605079124463a67b(skinref);
    body = scripts\cp_mp\operator::function_8eba78e65f4be793(skinref);
    head = scripts\cp_mp\operator::function_223061772e2a61b9(skinref);
    team = getoperatorteambyref(operatorref);

    if(!isDefined(team)) {
      continue;
    }

    customization = [];
    customization[0] = body;
    customization[1] = head;
    level.operatorcustomization[team][operatorref][skinref] = customization;
  }
}

function getoperatorteambyref(operatorref) {
  foreach(operators in level.operatorcustomization) {
    foreach(operatorskins in operators) {
      if(operator == operatorref) {
        return team;
      }
    }
  }

  return undefined;
}

function pickdefaultoperatorskin(team) {
  selectedindex = 0;
  weapon = self.primaryweapon;

  if(isDefined(weapon)) {
    weapongroup = scripts\cp\weapon::getweapongroup(weapon);

    switch (weapongroup) {
      case #"hash_8af0086b038622b5":
      case #"hash_dd616da0b395a0b0":
        selectedindex = 0;
        break;
      case #"hash_ab10f9c080fe4faf":
        selectedindex = 1;
        break;
      case #"hash_47368bc0d2ef1565":
      case #"hash_c095d67337b1f5a1":
        selectedindex = 2;
        break;
      case #"hash_bef5ec0b3e197ae":
        selectedindex = 3;
        break;
      case #"hash_16cf6289ab06bd30":
        selectedindex = 4;
        break;
      default:
        selectedindex = 1;
        break;
    }
  }

  return selectedindex;
}

function getoperatorcustomization() {
  operatorref = lookupcurrentoperator(self.team);
  skinref = lookupcurrentoperatorskin(self.team);
  body = undefined;
  head = undefined;
  suit = undefined;

  if((operatorref == "default_western" || operatorref == "default_eastern") && (skinref == "274" || skinref == "275")) {
    initdefaultoperatorskins();
    var_3060e7b91e020425 = level.teambased && !scripts\cp_mp\utility\game_utility::isbrstylegametype();

    if(!isDefined(self.defaultoperatorteam) || var_3060e7b91e020425 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
      team = "allies";

      if(operatorref == "default_eastern") {
        team = "axis";
      }

      self.defaultoperatorteam = team;

      if(self.team != "allies" && self.team != "axis") {
        self.defaultoperatorteam = ter_op(cointoss(), "allies", "axis");
      }
    }

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = 0;
    }

    body = level.defaultoperatorskins[self.defaultoperatorteam]["body"][self.pers["defaultOperatorSkinIndex"]];

    if(!isDefined(self.pers["defaultOperatorHeadIndex"])) {
      self.pers["defaultOperatorHeadIndex"] = random(level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]]);
    }

    head = self.pers["defaultOperatorHeadIndex"];
    suit = "iw9_suit_generic_west_mp";
  } else {
    body = scripts\cp_mp\operator::function_8eba78e65f4be793(skinref);
    head = scripts\cp_mp\operator::function_223061772e2a61b9(skinref);
    suit = scripts\cp_mp\operator::function_ada9a2308a4046e2(operatorref);
  }

  self.bodymodelname = body;
  self.backuphead = head;
  self.backupsuit = suit;
  customization = [];
  customization[0] = body;
  customization[1] = head;
  customization[2] = suit;
  return customization;
}

function initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }

  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
  level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
  level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1"];
  level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
  level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
  level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
  level.defaultoperatorskins["allies"]["suit"] = ["iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
  level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
  level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
  level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
  level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_nvg_1"];
  level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp"];
}

function getoperatorexecution(operatorref) {
  self.loadoutexecution = scripts\cp_mp\operator::function_5e2fa33279816be2(operatorref);
  return self.loadoutexecution;
}

function getoperatorexecutionquip(operatorref) {
  self.loadoutexecutionquip = scripts\cp_mp\operator::function_ac45022bf37cddfb(operatorref);
  return self.loadoutexecutionquip;
}

function getoperatorsuperfaction(operatorref) {
  faction = scripts\cp_mp\operator::getoperatorsuperfaction(operatorref);
  return int(faction);
}

function getoperatorvoice(operatorref, operatorskin) {
  if(operatorref == "default_eastern" || operatorref == "default_western") {
    voice = scripts\cp_mp\operator::function_c7f632b62e2da6dc(operatorskin);

    if(isDefined(voice) && voice != "") {
      return voice;
    }
  }

  voice = scripts\cp_mp\operator::getoperatorvoice(operatorref);
  return voice;
}

function getoperatorclothtype(skinref) {
  clothtype = scripts\cp\loadout::getoperatorclothtype(skinref);
  return clothtype;
}

function getoperatorgender(operatorref) {
  gender = scripts\cp_mp\operator::getoperatorgender(operatorref);
  return gender;
}

function get_player_character_num() {
  var_d22d0a192d3c62ad = getdvarint(@ "hash_fc0849115db82d44", -1);

  if(var_d22d0a192d3c62ad != -1) {
    self.player_character_num = var_d22d0a192d3c62ad;
    return var_d22d0a192d3c62ad;
  }

  if(isDefined(self.player_character_num)) {
    return self.player_character_num;
  }

  choice = random(level.available_player_characters);
  self.player_character_num = choice;
  return choice;
}

function setplayerhudphoto(player, character_index) {
  player endon("disconnect");
  entity_number = player getentitynumber();

  if(entity_number == 4) {
    entity_number = 0;
  }

  player.bit_position = get_bit_position(entity_number);
  player.player_character_index = character_index;

  if(isDefined(level.skip_playerhudphoto)) {
    player.player_character_index = 1;
    character_index = 1;
  }

  wait 5;
}

function set_player_photo_status(player, status) {
  set_player_photo_option(player, "zm_player_status", get_status_bit_value(status));
}

function set_player_photo_option(player, omnvar, bit_value) {
  if(isDefined(player.bit_position)) {
    setomnvarbit(omnvar, player.bit_position.bit_3, bit_value.bit_3);
    setomnvarbit(omnvar, player.bit_position.bit_2, bit_value.bit_2);
    setomnvarbit(omnvar, player.bit_position.bit_1, bit_value.bit_1);
    player.photosetup = 1;
  }
}

function get_bit_position(entity_number) {
  bit_position = spawnStruct();

  switch (entity_number) {
    case 3:
      bit_position.bit_3 = 11;
      bit_position.bit_2 = 10;
      bit_position.bit_1 = 9;
      break;
    case 2:
      bit_position.bit_3 = 8;
      bit_position.bit_2 = 7;
      bit_position.bit_1 = 6;
      break;
    case 1:
      bit_position.bit_3 = 5;
      bit_position.bit_2 = 4;
      bit_position.bit_1 = 3;
      break;
    case 0:
      bit_position.bit_3 = 2;
      bit_position.bit_2 = 1;
      bit_position.bit_1 = 0;
      break;
  }

  return bit_position;
}

function get_character_bit_value(photo_index) {
  bit_value = spawnStruct();

  switch (photo_index) {
    case 0:
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 0;
      bit_value.bit_1 = 0;
      break;
    case 1:
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 0;
      bit_value.bit_1 = 1;
      break;
    case 2:
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 1;
      bit_value.bit_1 = 0;
      break;
    case 3:
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 1;
      bit_value.bit_1 = 1;
      break;
    case 4:
      bit_value.bit_3 = 1;
      bit_value.bit_2 = 0;
      bit_value.bit_1 = 0;
      break;
  }

  return bit_value;
}

function get_status_bit_value(status) {
  bit_value = spawnStruct();

  switch (status) {
    case #"hash_f6a928810bf81022":
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 0;
      bit_value.bit_1 = 0;
      break;
    case #"hash_58a5071e5fca9a8c":
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 0;
      bit_value.bit_1 = 1;
      break;
    case #"hash_df6b3b2585101bc7":
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 1;
      bit_value.bit_1 = 0;
      break;
    case #"hash_fdabb2d8523f47eb":
      bit_value.bit_3 = 0;
      bit_value.bit_2 = 1;
      bit_value.bit_1 = 1;
      break;
  }

  return bit_value;
}

function setcharactermodels(bodymodelname, headmodelname, viewmodelname, hairmodel) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(bodymodelname);
  self setviewmodel(viewmodelname);
  self attach(headmodelname, "", 1);
  self.bodymodel = bodymodelname;
  self.headmodel = headmodelname;
  self.viewmodel = viewmodelname;
}

function getplayermodelindex() {
  return false;
}

function getplayerfoleytype(skinref) {
  return scripts\cp\loadout::getplayerfoleytype(skinref);
}

function updatemovespeedscale() {
  speedperc = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    speedperc = 1;
    speedperc += self.playerstreakspeedscale;
  } else {
    speedperc = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale)) {
      speedperc = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      speedperc = self.siege_speedscale;
    } else if(isDefined(self.overrideweaponspeed_speedscale)) {
      speedperc = self.overrideweaponspeed_speedscale;
    }

    chilldata = self.chill_data;

    if(isDefined(chilldata) && isDefined(chilldata.speedmod)) {
      speedperc += chilldata.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      speedperc += self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      speedperc += self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      speedperc += self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      speedperc += self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      speedperc += self.weaponpassivespeedonkillmod;
    }

    speedperc = min(1.5, speedperc);
  }

  self.weaponspeed = speedperc;
  assert(isDefined(self.weaponspeed));
  assert(isDefined(self.movespeedscaler));

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  self setmovespeedscale(speedperc * self.movespeedscaler * self.combatspeedscalar);
}

function getplayerspeedbyweapon(player) {
  weaponspeed = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar(@ "hash_5cca8d7e65a3830b", "on") == "on") {
    return 1;
  }

  if(!self.weaponlist.size) {
    weaponspeed = 0.9;
  } else {
    weapon = self getcurrentweapon();

    if(issuperweapon(weapon)) {
      weaponspeed = level.superweapons[getcompleteweaponname(weapon)].movespeed;
    } else {
      weaponinvtype = weaponinventorytype(weapon);

      if(weaponinvtype != "primary" && weaponinvtype != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          weapon = self.saved_lastweapon;
        } else {
          weapon = undefined;
        }
      }

      if(!isDefined(weapon) || !self hasweapon(weapon)) {
        weaponspeed = getweaponspeedslowest();
      } else {
        weaponspeed = getweaponspeed(weapon);

        if(!isDefined(weaponspeed) || weaponspeed == 0) {
          weaponspeed = 1;
        }
      }
    }
  }

  weaponspeed = clampweaponspeed(weaponspeed);
  return weaponspeed;
}

function getweaponspeed(weapon) {
  rootweapon = getbaseweaponname(weapon);
  assertex(isDefined(rootweapon), "Invalid weapon passed to getWeaponSpeed(): " + rootweapon);
  weaponspeed = level.weaponmapdata[rootweapon].speed;
  return weaponspeed;
}

function getweaponspeedslowest() {
  var_6155ff1652d3374f = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      weaponspeed = getweaponspeed(weapon);

      if(weaponspeed == 0) {
        continue;
      }

      if(weaponspeed < var_6155ff1652d3374f) {
        var_6155ff1652d3374f = weaponspeed;
      }
    }

    if(var_6155ff1652d3374f == 2) {
      assertmsg("<dev string:x1c>");
    }
  } else {
    var_6155ff1652d3374f = 0.9;
  }

  var_6155ff1652d3374f = clampweaponspeed(var_6155ff1652d3374f);
  return var_6155ff1652d3374f;
}

function clampweaponspeed(value) {
  assertex(value >= 0 && value <= 1, "clampWeaponSpeed() passed invalid value: " + value);
  return clamp(value, 0, 1);
}

function getweaponheaviestvalue() {
  heaviestweaponvalue = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      weaponweight = getweaponweight(weapon);

      if(weaponweight == 0) {
        continue;
      }

      if(weaponweight < heaviestweaponvalue) {
        heaviestweaponvalue = weaponweight;
      }
    }

    if(heaviestweaponvalue == 1000) {
      assertmsg("<dev string:x1c>");

      foreach(weapon in self.weaponlist) {
        assertmsg("<dev string:x39>" + getcompleteweaponname(weapon));
      }
    }

  } else {
    heaviestweaponvalue = 8;
  }

  heaviestweaponvalue = clampweaponweightvalue(heaviestweaponvalue);
  return heaviestweaponvalue;
}

function getweaponweight(weapon) {
  baseweapon = getbaseweaponname(weapon);
  weaponspeed = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d(baseweapon, #"speedscale");

  if(!isDefined(weaponspeed) || weaponspeed < 1) {
    weaponspeed = float(tablelookup(level.game_mode_statstable, 4, baseweapon, 8));
  }

  if(!isDefined(weaponspeed) || weaponspeed < 1) {
    weaponspeed = 10;
  }

  return weaponspeed;
}

function clampweaponweightvalue(value) {
  return clamp(value, 0, 11);
}

function wait_and_force_weapon_switch(starting_weapon) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  weapon_list = self getweaponslistprimaries();

  if(!self hasweapon(starting_weapon)) {
    starting_weapon = weapon_list[0];
  }

  add_ammo_if_needed(weapon_list);
  self setspawnweapon(starting_weapon);
}

function add_ammo_if_needed(weapon_list) {
  if(isDefined(self.perk_data) && istrue(self.perk_data["weapons_have_full_ammo"])) {
    foreach(weapon in weapon_list) {
      self givemaxammo(weapon);
    }
  }
}

function init_core_mp_perks() {
  println("<dev string:x46>");
  println("<dev string:x6c>");
  println("<dev string:x46>");

  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.perksetfuncs["specialty_momentum"] = &setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = &unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = &setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = &unsetfreefall;
}

function setmomentum() {
  thread runmomentum();
}

function runmomentum() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  while(true) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait 0.1;
  }
}

function graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread momentum_monitormovement();
  thread momentum_monitordamage();
  var_51438b11657961cc = 0;

  while(var_51438b11657961cc < 0.08) {
    self.movespeedscaler += 0.01;
    updatemovespeedscale();
    wait 0.035 / 0.08;
    var_51438b11657961cc += 0.01;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

function momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

function momentum_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  while(true) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

function momentum_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

function unsetmomentum() {
  self notify("momentum_unset");
}

function setfreefall() {}

function unsetfreefall() {}

function set_player_perks() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");

  if(game["state"] != "postgame") {
    wait 0.1;
    move_slide = 4;
    moveid = 0;
    movemask = 0;
    movemask = move_slide;

    if(isDefined(level.player_suit)) {
      scripts\cp\utility\player::_setsuit(level.player_suit);
    } else {
      scripts\cp\utility\player::_setsuit("iw9_suit_cp");
    }

    self.suit = "iw9_suit_cp";
    self allowdoublejump(0);
    self allowslide(movemask &move_slide);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);
  self notify("set_player_perks");
}

function registerplayercharacter(character_index, var_80d695139e2ad462, body_model, view_model, head_model, hair_model, vo_prefix, vo_suffix, pap_gesture, revive_gesture, photo_index, fate_card_weapon, intro_music, intro_gesture, melee_weapon, post_setup_func, starting_weapon) {
  character_info = spawnStruct();
  character_info.body_model = body_model;
  character_info.view_model = view_model;
  character_info.head_model = head_model;
  character_info.hair_model = hair_model;
  character_info.vo_prefix = vo_prefix;
  character_info.vo_suffix = vo_suffix;
  character_info.pap_gesture = pap_gesture;
  character_info.revive_gesture = revive_gesture;
  character_info.photo_index = photo_index;
  character_info.fate_card_weapon = fate_card_weapon;
  character_info.intro_music = intro_music;
  character_info.intro_gesture = intro_gesture;
  character_info.melee_weapon = makeweaponfromstring(melee_weapon);
  character_info.starting_weapon = makeweaponfromstring(starting_weapon);
  character_info.post_setup_func = post_setup_func;
  level.player_character_info[character_index] = character_info;

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  if(var_80d695139e2ad462 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = character_index;
  }
}

function respawnitems_assignrespawnitems(respawnitems) {
  self.respawnitems = respawnitems;
}

function testclient_run_funcs() {
  if(!istestclient(self)) {
    return;
  }

  if(getdvarint(@ "hash_a31a2982a3eb161d", 0) > 0) {
    return;
  }

  thread notify_delay("loadout_given", 7);
  thread testclient_dev_laststand();
}

function testclient_dev_laststand() {
  level endon("game_ended");
  self endon("disconnect");
  var_b9c45882c66b8295 = 0;

  if(getdvarint(@ "hash_42e908dd6c9a5170", 0) > 0) {
    var_b9c45882c66b8295 = 1;
  }

  wait 5;
  announcement("^2Testclient setting loadout...");
  wait 5;

  while(true) {
    if(getdvarint(@ "hash_42e908dd6c9a5170", 0) == 0) {
      waitframe();
      continue;
    }

    if(var_b9c45882c66b8295 == 2) {
      waittill_any_3("landed_after_respawn", "revive_done", "revive");
      wait 7.5;
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.health + 1, self.origin, self);
      announcement("^1TestClient Downed");
    }

    if(var_b9c45882c66b8295 == 0) {
      setDvar(@ "hash_42e908dd6c9a5170", 0);
    }

    if(var_b9c45882c66b8295 == 1) {
      var_b9c45882c66b8295 = 2;
    }
  }
}

function getcustomization() {
  customization = [];

  if(isDefined(self.operatorcustomization)) {
    customization["body"] = self.operatorcustomization.body;
    customization["head"] = self.operatorcustomization.head;
  } else {
    data = getoperatorcustomization();
    customization["body"] = data[0];
    customization["head"] = data[1];
  }

  return customization;
}