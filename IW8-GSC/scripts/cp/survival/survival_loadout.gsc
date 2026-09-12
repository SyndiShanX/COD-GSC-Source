/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\survival\survival_loadout.gsc
****************************************************/

function init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level.custom_giveloadout = &givedefaultloadout;
  level.move_speed_scale = &updatemovespeedscale;
  level.registerplayercharfunc = &registerplayercharacter;

  if(!isDefined(level.loadoutsgroup)) {
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();
  }

  initnightvisionheadoverrides();
}

function initnightvisionheadoverrides() {
  if(!scripts\cp\gametypes\cp_survival::allow_nvg()) {
    return;
  }

  level.nvgheadoverrides = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("operatorskins.csv", var_0, 5);
    var_2 = tablelookupbyrow("operatorskins.csv", var_0, 17);
    var_3 = tablelookupbyrow("operatorskins.csv", var_0, 16);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(var_2 != "") {
      level.nvgheadoverrides[var_1]["up"] = var_2;
    }

    if(var_3 != "") {
      level.nvgheadoverrides[var_1]["down"] = var_3;
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

function givedefaultloadout(var_0, var_1, var_2, var_3) {
  self setclientomnvar("ui_options_menu", 0);

  if(istrue(self.is_doing_infil)) {
    thread giveloadoutafterinfil(var_0, var_1, var_2);
    return;
  }

  var_4 = self;
  var_4.changingweapon = undefined;
  var_4 scripts\cp\cp_accessories::clearplayeraccessory();
  var_4 takeallweapons();

  if(!istrue(var_4.keep_perks)) {
    var_4 scripts\cp\utility::_clearperks();
  }

  thread delayreturningperks(var_4);

  if(istrue(var_3)) {
    var_4 scripts\cp\utility::_detachall(1);
  } else {
    var_4 scripts\cp\utility::_detachall();

    if(isDefined(var_4.headmodel)) {
      var_4.headmodel = undefined;
    }

    var_5 = get_player_character_num();

    if(isDefined(var_1)) {
      var_5 = var_1;
    }

    thread setmodelfromcustomization(var_4);
    var_6 = lookupcurrentoperatorskin(var_4, var_4.team);
    var_7 = getplayerfoleytype(var_4, var_6);

    if(var_7 == "") {
      var_7 = "vestlight";
    }

    var_4 setclothtype(var_7);
  }

  if(initmaxspeedforpathlengthtable(var_4)) {
    var_2 = 1;
    thread ref_13B0F();
  }

  var_4.spawnperk = 0;
  scripts\engine\utility::flag_wait("introscreen_over");

  if(isDefined(level.move_speed_scale)) {
    self[[level.move_speed_scale]]();
  } else {
    updatemovespeedscale();
  }

  var_4.primaryweapon = isundefinedweapon();
  var_4 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var_4 notify("giveLoadout");
  var_4 scripts\cp\utility::giveperk("specialty_pistoldeath");
  var_4 scripts\cp\utility::giveperk("specialty_expanded_minimap");

  if(isDefined(var_0) && var_0) {
    return;
  }

  set_player_perks(var_4);
  var_8 = var_4.melee_weapon;
  var_4.default_starting_melee_weapon = var_8;
  var_4.currentmeleeweapon = var_8;

  if(allow_super(self)) {
    if(!istrue(self.getc130knownsafeheight)) {
      scripts\cp\coop_super::give_player_super(var_2);
    }

    scripts\cp\classes\cp_class_progression::give_player_class(var_2);
  }

  scripts\cp\cp_loadout::give_weapons_from_loadout(self, var_2);

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  if(getqueuedspleveltransients(var_4.default_starting_pistol)) {
    if(!getqueuedspleveltransients(var_4.starting_weapon)) {
      var_4.default_starting_pistol = var_4.starting_weapon;
    } else if(isDefined(level.default_weapon)) {
      var_4.default_starting_pistol = scripts\cp\cp_weapon::buildweapon(level.default_weapon, [], "none", "none", -1);
    } else {
      var_4.default_starting_pistol = scripts\cp\cp_weapon::buildweapon("iw8_pi_decho_mp", [], "none", "none", -1);
    }
  }

  var_4.last_stand_pistol = var_4.default_starting_pistol;
  var_9 = scripts\cp\utility::getrawbaseweaponname(var_4.default_starting_pistol);
  var_4.default_starting_pistol = return_wbk_version_of_weapon(var_4, var_9, var_4.default_starting_pistol);
  var_4 scripts\cp\utility::_giveweapon(var_4.default_starting_pistol, undefined, undefined, 1);

  LOC_000002cd:
    if(!getqueuedspleveltransients(var_4.starting_weapon)) {
      var_9 = scripts\cp\utility::getrawbaseweaponname(var_4.starting_weapon);
      var_4.starting_weapon = return_wbk_version_of_weapon(var_4, var_9, var_4.starting_weapon);
      var_4 scripts\cp\utility::_giveweapon(var_4.starting_weapon, undefined, undefined, 0);
    }

  var_10 = scripts\cp\utility::getrawbaseweaponname(var_4.default_starting_pistol);
  var_4[[level.move_speed_scale]]();
  var_4 giveweapon("super_default_zm");
  var_4 assignweaponoffhandspecial("super_default_zm");
  var_4.specialoffhandgrenade = "super_default_zm";
  var_11 = var_4.default_starting_pistol;

  if(!getqueuedspleveltransients(var_4.starting_weapon)) {
    var_11 = var_4.starting_weapon;
  }

  thread wait_and_force_weapon_switch(var_4);

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    if(!isDefined(var_4.move_door_to_pos)) {
      var_4.move_door_to_pos = 0;
      var_4 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
    } else if(var_4.move_door_to_pos == 0) {
      var_4 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
    }
  }

  if(isDefined(var_4.operatorcustomization) && isDefined(var_4.operatorcustomization.execution)) {
    var_4 scripts\cp_mp\execution::_giveexecution(var_4.operatorcustomization.execution);
  }

  if(istrue(level.disable_nvg)) {
    var_4 setactionslot(2, "");
  }

  var_4 setactionslot(3, "altmode");
  var_4 notify("loadout_given");
  var_4.getc130knownsafeheight = undefined;
  thread ref_11EC9();
}

function ref_11EC9() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!scripts\cp\utility::try_start_driving_func() && !istrue(level.dogtag_revive) && !scripts\cp\utility::turn_off_sniper_laser()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_init("player_spawned_with_loadout");
  }

  scripts\engine\utility::flag_set("player_spawned_with_loadout");

  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");
  }

  scripts\engine\utility::ent_flag_set("player_spawned_with_loadout");

  if(level.ref_12376) {
    scripts\cp\whizby::ref_13263(self);
  }

  thread scripts\cp\cp_munitions::hasmaxammo();
}

function giveloadoutafterinfil(var_0, var_1, var_2) {
  self notify("giveLoadoutAfterInfil");
  self endon("disconnect");
  self endon("giveLoadoutAfterInfil");
  self waittill("player_finished_infil");
  givedefaultloadout(var_0, var_1, var_2);
}

function allow_super(var_0) {
  if(isDefined(level.allow_super)) {
    return [[level.allow_super]](var_0);
  }

  return 1;
}

function return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(isDefined(var_0.weapon_build_models[var_1])) {
    return asmdevgetallstates(var_0.weapon_build_models[var_1]);
  }

  return var_2;
}

function delayreturningperks(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  wait 1;

  if(istrue(var_0.keep_perks)) {
    if(isDefined(var_0.zombies_perks)) {
      var_1 = getarraykeys(var_0.zombies_perks);

      foreach(var_3 in var_1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var_3]) && isDefined(level.coop_perk_callbacks[var_3].set)) {
          var_0[[level.coop_perk_callbacks[var_3].set]]();
        }
      }
    }

    var_0.keep_perks = undefined;
    return;
  }
}

function release_character_number(var_0) {
  var_1 = var_0.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var_1) && var_1 != 5) {
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var_1);
    return;
  }
}

function get_baseweapon_pap_level(var_0, var_1) {
  if(isDefined(var_0.pap[var_1])) {
    return var_0.pap[var_1].lvl;
  }

  return 1;
}

function setmodelfromcustomization(var_0) {
  level endon("game_ended");
  self.melee_weapon = "iw8_knife_mp";
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  var_2 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_1);
  var_3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_2, "skin");
  var_4 = getoperatorcustomization();
  var_5 = var_4[0];
  var_6 = var_4[1];
  self.setcustomization_body = var_5;
  self.setcustomization_head = var_6;
  self setcustomization(var_5, var_6);
  wait 0.05;
  var_4 = getoperatorcustomization();
  var_5 = var_4[0];
  var_6 = var_4[1];
  var_7 = var_4[2];

  if(!isagent(self)) {
    self setcustomization(var_5, var_6);
    var_8 = self getcustomizationbody();
    var_9 = self getcustomizationhead();
    var_10 = self getcustomizationviewmodel();
    var_11 = getplayerviewmodelfrombody(var_5);
  } else {
    var_8 = "body_opforce_london_terrorist_1_2";
    var_9 = "head_male_bc_03";
    var_10 = "viewmodel_mp_base_iw8";
    var_11 = "viewmodel_mp_base_iw8";
  }

  var_6 = lookupcurrentoperator(self.team);
  var_12 = lookupcurrentoperatorskin(self.team);
  var_13 = spawnStruct();
  var_13.operatorref = var_6;
  var_13.skinref = var_12;
  var_13.body = var_9;
  var_13.defaultbody = var_8;
  var_13.head = var_10;
  var_13.defaulthead = var_9;
  var_13.vm = var_11;
  var_13.defaultvm = var_10;
  var_13.gender = getoperatorgender(var_6);
  var_13.voice = getoperatorvoice(var_6, var_12);
  var_13.clothtype = resetplayermovespeedscale(var_12);
  var_13.superfaction = getoperatorsuperfaction(var_6);
  var_13.execution = getoperatorexecution(var_6);
  var_13.oic_rewardammo = resetposition(var_6);
  var_13.suit = var_11;
  var_13.rebuild = 0;
  var_13.superfaction = getoperatorsuperfaction(var_6);
  self.operatorcustomization = var_13;
  setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
  var_14 = spawnStruct();
  var_14.apc = runbrgametypefunc6("apc");
  var_14.c4_pick_up_listener = rundomplateskybeam("apc");
  var_14.check_cannot_spawn_tank = runbrgametypefunc6("atv");
  var_14.get_extra_focus_fire_multipler = runbrgametypefunc6("cargo_truck");
  var_14.vehicle_damage_endburndown = runbrgametypefunc6("jeep");
  var_14.x1opsenableelimination = runbrgametypefunc6("little_bird");
  var_14.ref_139F7 = runbrgametypefunc6("tac_rover");
  var_14.ref_13A47 = runbrgametypefunc6("tank_east");
  var_14.ref_13A48 = rundomplateskybeam("tank_east");
  var_14.ref_13A52 = runbrgametypefunc6("tank_west");
  var_14.ref_13A53 = rundomplateskybeam("tank_west");
  var_14.c130airdrop_heightoverride = runcircles("apc", 4);
  var_14.check_carrier_status = runcircles("atv", 6);
  var_14.get_fake_digit_from_pool = runcircles("cargo_truck", 8);
  var_14.vehicle_damage_enginevisualclearcallback = runcircles("jeep", 10);
  var_14.x1opsendgame = runcircles("little_bird", 12);
  var_14.ref_139F8 = runcircles("tac_rover", 14);
  var_14.check_for_damage_scalar_change = runcontrolledcallback("atv");
  var_14.ref_139FC = runcontrolledcallback("tac_rover");
  var_14.zombieingas = runcontrolledcallback("little_bird");
  self.ref_14238 = var_14;

  if(self.operatorcustomization.gender == "female") {
    self method_87aa("female");
  } else {
    self method_87aa("");
  }

  if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](self)) {
    self[[level.change_to_terrorist_model_func]](self);
  }

  if(isDefined(level.ref_127F3)) {
    self[[level.ref_127F3]]();
    return;
  }
}

function runbrgametypefunc6(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  var_2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var_1, 4);
  return var_2;
}

function runcontrolledcallback(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  var_2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var_1, 10);
  return var_2;
}

function rundomplateskybeam(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  var_2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var_1, 5);
  return var_2;
}

function runcircles(var_0, var_1) {
  var_2 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "horn");
  var_3 = tablelookup("mp_cp/vehiclehorns.csv", 0, var_2, var_1);
  return var_3;
}

function getplayerbodymodel() {
  var_0 = getoperatorcustomization();
  return var_0[0];
}

function getplayerviewmodelfrombody(var_0) {
  var_1 = tablelookup("mp/cac/bodies.csv", 1, var_0, 3);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = "viewhands_mp_base_iw8";
  }

  return var_1;
}

function lookupcurrentoperator(var_0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  var_2 = var_1;
  var_3 = scripts\cp\utility::getgametype() == "br";

  if(!level.teambased || var_3) {
    var_1 = undefined;

    if(isai(self)) {
      var_1 = self.botoperatorteam;
    } else {
      var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
    }

    var_2 = var_1;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(var_2 == 0) {
        self.defaultoperatorteam = "allies";
      } else {
        self.defaultoperatorteam = "axis";
      }
    }
  }

  if(!isDefined(level.playercustomizationdata)) {
    level.playercustomizationdata = [];
  }

  var_4 = self getentitynumber();
  level.playercustomizationdata[var_4] = [];
  var_5 = undefined;

  if(!isDefined(level.playercustomizationdata[var_4][var_0])) {
    var_6 = spawnStruct();

    if(isai(self)) {
      var_6.operatorref = self.botoperatorref;
    } else {
      var_6.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_2);
    }

    level.playercustomizationdata[var_4][var_0] = var_6;
  }

  var_5 = level.playercustomizationdata[var_4][var_0].operatorref;

  if(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && self calloutmarkerping_getEnt()) {
    initoperatorcustomization();
    var_7 = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.showempminimap)) {
      foreach(var_9 in var_7) {
        var_10 = getarraykeys(level.operatorcustomization[var_9]);

        if(!isDefined(level.showing_ui_record)) {
          level.showing_ui_record = [];
        }

        if(!isDefined(level.showing_ui_record[var_9]) || level.showing_ui_record[var_9] > var_10.size) {
          level.showing_ui_record[var_9] = 0;
        }

        for(var_11 = var_10[level.showing_ui_record[var_9]]; isDefined(var_11) && (var_11 == "default_western" || var_11 == "default_eastern"); var_11 = var_10[level.showing_ui_record[var_9]]) {
          level.showing_ui_record[var_9] += 1;

          if(level.showing_ui_record[var_9] > var_10.size) {
            level.showing_ui_record[var_9] = 0;
          }
        }

        level.showing_ui_record[var_9] += 1;
        level.playercustomizationdata[var_4][var_9] = spawnStruct();
        level.playercustomizationdata[var_4][var_9].operatorref = var_11;
      }

      self.showempminimap = 1;
    }

    if(isDefined(level.operatorcustomization[var_0])) {
      var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
    } else {
      if(!isDefined(self.botoperatorteam)) {
        self.botoperatorteam = scripts\engine\utility::random(var_7);
      }

      var_5 = level.playercustomizationdata[var_4][self.botoperatorteam].operatorref;
    }
  }

  if(isai(self) || !isDefined(var_5) || var_5 == "") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[var_4][var_0].operatorref)) {
          var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
        } else {
          var_5 = self.botoperatorref;
        }
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            var_7 = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = scripts\engine\utility::random(var_7);
          }
        }

        var_0 = self.botoperatorteam;

        if(!isDefined(self.pers["operatorIndex"])) {
          var_1 = randomint(level.operatorcustomization[var_0].size);
          self.pers["operatorIndex"] = var_1;
        } else {
          var_1 = self.pers["operatorIndex"];
        }

        var_13 = 0;

        foreach(var_15 in level.operatorcustomization[var_0]) {
          if(var_13 == var_1) {
            self.botoperatorref = var_16;
            var_5 = var_16;
            break;
          }

          var_13++;
        }
      }
    } else {
      var_5 = "wyatt_western";
    }
  }

  return var_5;
}

function lookupcurrentoperatorskin(var_0) {
  var_1 = lookupcurrentoperator(var_0);
  var_2 = undefined;
  var_3 = self getentitynumber();

  if(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && self calloutmarkerping_getEnt()) {
    if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
      if(!isDefined(level.showing_bomb_wire_pair_to_player)) {
        thermite_doradiusdamage();
      }

      var_4 = level.showing_bomb_wire_pair_to_player[var_1]["curIndex"];
      level.playercustomizationdata[var_3][var_0].operatorskinindex = level.showing_bomb_wire_pair_to_player[var_1]["lootIDs"][var_4];
      level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] = level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] + 1;

      if(level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] >= level.showing_bomb_wire_pair_to_player[var_1]["maxIndex"]) {
        level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] = 0;
      }
    }
  } else if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
    if(isai(self)) {
      if(!isDefined(self.botskinid)) {
        debug_interaction_toggle(var_1);
      }

      level.playercustomizationdata[var_3][var_0].operatorskinindex = self.botskinid;
    } else {
      level.playercustomizationdata[var_3][var_0].operatorskinindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_1, "skin");
    }
  }

  var_2 = level.playercustomizationdata[var_3][var_0].operatorskinindex;

  if(isai(self) && (!isDefined(var_2) || var_2 == 0) || !isDefined(var_2) || var_2 == 0) {
    if(isai(self)) {
      if(isDefined(self.botskinid)) {
        var_2 = self.botskinid;
      } else {
        debug_interaction_toggle(var_1);
      }
    } else {
      var_2 = 1;
    }
  }

  return var_2;
}

function debug_interaction_toggle(var_0) {
  var_1 = self.team;

  if(isDefined(self.botoperatorteam)) {
    var_1 = self.botoperatorteam;
  }

  if(!isDefined(self.pers["operatorSkinIndex"])) {
    var_2 = randomint(level.operatorcustomization[var_1][var_0].size);
    self.pers["operatorSkinIndex"] = var_2;
  } else {
    var_2 = self.pers["operatorSkinIndex"];
  }

  var_3 = 0;

  foreach(var_5 in level.operatorcustomization[var_2][var_1]) {
    if(var_3 == var_2) {
      var_6 = int(tablelookup("operatorskins.csv", 1, var_8, 0));
      self.botskinid = var_6;
      var_7 = var_6;
      break;
    }

    var_3++;
  }
}

function thermite_doradiusdamage() {
  if(isDefined(level.showing_bomb_wire_pair_to_player)) {
    return;
  }

  level.showing_bomb_wire_pair_to_player = [];
  var_0 = tablelookupgetnumrows("operatorskins.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(tablelookupbyrow("operatorskins.csv", var_1, 18) != "") {
      var_2 = tablelookupbyrow("operatorskins.csv", var_1, 2);
      var_3 = tablelookupbyrow("operatorskins.csv", var_1, 0);

      if(!isDefined(level.showing_bomb_wire_pair_to_player[var_2])) {
        level.showing_bomb_wire_pair_to_player[var_2]["lootIDs"] = [];
        level.showing_bomb_wire_pair_to_player[var_2]["curIndex"] = 0;
        level.showing_bomb_wire_pair_to_player[var_2]["maxIndex"] = 0;
      }

      level.showing_bomb_wire_pair_to_player[var_2]["lootIDs"][level.showing_bomb_wire_pair_to_player[var_2]["lootIDs"].size] = int(var_3);
      level.showing_bomb_wire_pair_to_player[var_2]["maxIndex"] = level.showing_bomb_wire_pair_to_player[var_2]["maxIndex"] + 1;
    }
  }
}

function lookupotheroperator(var_0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", 1, 0);
  var_2 = self getentitynumber();
  var_3 = "";
  var_0 = scripts\engine\utility::ter_op(var_0 == "allies", "axis", "allies");

  if(scripts\cp\utility::getgametype() != "br") {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[var_2][var_0])) {
        var_4 = spawnStruct();
        var_4.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_1);
        level.playercustomizationdata[var_2][var_0] = var_4;
      }

      var_3 = level.playercustomizationdata[var_2][var_0].operatorref;
    }
  }

  return var_3;
}

function initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }

  level.operatorcustomization = [];
  setDvar("cl_streamSync_devNoLatch", 1);

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("operators.csv", var_0, 1);
    var_2 = getoperatorsuperfaction(var_1);
    var_3 = scripts\engine\utility::ter_op(var_2 == 0, "allies", "axis");

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_4 = int(tablelookupbyrow("operators.csv", var_0, 8));

    if(var_4) {
      if(!isDefined(level.operatorcustomization[var_3])) {
        level.operatorcustomization[var_3] = [];
      }

      level.operatorcustomization[var_3][var_1] = [];
    }
  }

  var_5 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("operatorskins.csv", var_5, 2);
    var_6 = tablelookupbyrow("operatorskins.csv", var_5, 1);
    var_7 = tablelookupbyrow("operatorskins.csv", var_5, 4);
    var_8 = tablelookupbyrow("operatorskins.csv", var_5, 5);

    if(!isDefined(var_6) || var_6 == "") {
      break;
    }

    var_3 = getoperatorteambyref(var_1);

    if(!isDefined(var_3)) {
      var_5++;
      continue;
    }

    var_9 = [];
    GscBinSkip0(0x2e, 0, var_7);
  }
}

function getoperatorteambyref(var_0) {
  foreach(var_2 in level.operatorcustomization) {
    foreach(var_4 in var_2) {
      if(var_5 == var_0) {
        return var_6;
      }
    }
  }

  return undefined;
}

function pickdefaultoperatorskin(var_0) {
  var_1 = 0;
  var_2 = self.primaryweapon;

  if(isDefined(var_2)) {
    var_3 = scripts\cp\cp_weapon::getweapongroup(var_2);

    switch (var_3) {
      case "weapon_assault":
        var_1 = 0;
        break;
      case "weapon_smg":
        var_1 = 1;
        break;
      case "weapon_dmr":
      case "weapon_sniper":
        var_1 = 2;
        break;
      case "weapon_lmg":
        var_1 = 3;
        break;
      case "weapon_shotgun":
        var_1 = 4;
        break;
      default:
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

function getoperatorcustomization() {
  var_0 = lookupcurrentoperator(self.team);
  var_1 = lookupcurrentoperatorskin(self.team);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if((var_0 == "default_western" || var_0 == "default_eastern") && (var_1 == 274 || var_1 == 275)) {
    initdefaultoperatorskins();
    var_5 = level.teambased && scripts\cp\utility::getgametype() != "br";

    if(!isDefined(self.defaultoperatorteam) || var_5 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
      var_6 = "allies";

      if(var_0 == "default_eastern") {
        var_6 = "axis";
      }

      self.defaultoperatorteam = var_6;

      if(self.team != "allies" && self.team != "axis") {
        self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      }
    }

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = 0;
    }

    var_2 = level.defaultoperatorskins[self.defaultoperatorteam]["body"][self.pers["defaultOperatorSkinIndex"]];

    if(!isDefined(self.pers["defaultOperatorHeadIndex"])) {
      self.pers["defaultOperatorHeadIndex"] = scripts\engine\utility::random(level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]]);
    }

    var_3 = self.pers["defaultOperatorHeadIndex"];
    var_4 = "iw8_suit_mp_wyatt";
  } else {
    var_2 = tablelookup("operatorskins.csv", 0, var_1, 4);
    var_3 = tablelookup("operatorskins.csv", 0, var_1, 5);
    var_4 = tablelookup("operators.csv", 1, var_0, 19);
  }

  self.bodymodelname = var_2;
  self.backuphead = var_3;
  self.backupsuit = var_4;
  var_7 = [];
  GscBinSkip0(0x2e, 0, var_2);
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
  level.defaultoperatorskins["allies"]["suit"] = ["iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
  level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
  level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
  level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
  level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_nvg_1"];
  level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt", "iw8_suit_mp_wyatt"];
}

function getoperatorexecution(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "execution");

  if(var_1 == 0) {
    self.loadoutexecution = tablelookup("operators.csv", 1, var_0, 24);
  } else {
    self.loadoutexecution = tablelookup("mp_cp/executiontable.csv", 0, var_1, 1);
  }

  return self.loadoutexecution;
}

function resetposition(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "taunt");

  if(var_1 == 0) {
    self.ref_1195C = tablelookup("operators.csv", 1, var_0, 23);
  } else {
    self.ref_1195C = tablelookup("operatorquips.csv", 0, var_1, 6);
  }

  return self.ref_1195C;
}

function getoperatorsuperfaction(var_0) {
  var_1 = tablelookup("operators.csv", 1, var_0, 3);
  return int(var_1);
}

function getoperatorvoice(var_0, var_1) {
  if(var_0 == "default_eastern" || var_0 == "default_western") {
    var_2 = tablelookup("operatorskins.csv", 0, var_1, 24);

    if(isDefined(var_2) && var_2 != "") {
      return var_2;
    }
  }

  var_2 = tablelookup("operators.csv", 1, var_0, 10);
  return var_2;
}

function resetplayermovespeedscale(var_0) {
  var_1 = tablelookupbyrow("operatorskins.csv", var_0, 22);
  return var_1;
}

function getoperatorgender(var_0) {
  var_1 = scripts\engine\utility::ter_op(tablelookup("operators.csv", 1, var_0, 11) == "0", "male", "female");
  return var_1;
}

function get_player_character_num() {
  if(isDefined(self.player_character_num)) {
    return self.player_character_num;
  }

  var_1 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = var_1;
  return var_1;
}

function setplayerhudphoto(var_0, var_1) {
  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();

  if(var_2 == 4) {
    var_2 = 0;
  }

  var_0.bit_position = get_bit_position(var_2);
  var_0.player_character_index = var_1;

  if(isDefined(level.skip_playerhudphoto)) {
    var_0.player_character_index = 1;
    var_1 = 1;
  }

  wait 5;
}

function set_player_photo_status(var_0, var_1) {
  set_player_photo_option(var_0, "zm_player_status", get_status_bit_value(var_1));
}

function set_player_photo_option(var_0, var_1, var_2) {
  if(isDefined(var_0.bit_position)) {
    setomnvarbit(var_1, var_0.bit_position.bit_3, var_2.bit_3);
    setomnvarbit(var_1, var_0.bit_position.bit_2, var_2.bit_2);
    setomnvarbit(var_1, var_0.bit_position.bit_1, var_2.bit_1);
    var_0.photosetup = 1;
    return;
  }
}

function get_bit_position(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 3:
      var_1.bit_3 = 11;
      var_1.bit_2 = 10;
      var_1.bit_1 = 9;
      break;
    case 2:
      var_1.bit_3 = 8;
      var_1.bit_2 = 7;
      var_1.bit_1 = 6;
      break;
    case 1:
      var_1.bit_3 = 5;
      var_1.bit_2 = 4;
      var_1.bit_1 = 3;
      break;
    case 0:
      var_1.bit_3 = 2;
      var_1.bit_2 = 1;
      var_1.bit_1 = 0;
      break;
  }

  return var_1;
}

function get_character_bit_value(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 0:
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 0;
      break;
    case 1:
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 1;
      break;
    case 2:
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 0;
      break;
    case 3:
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 1;
      break;
    case 4:
      var_1.bit_3 = 1;
      var_1.bit_2 = 0;
      var_1.bit_1 = 0;
      break;
  }

  return var_1;
}

function get_status_bit_value(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "healthy":
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 0;
      break;
    case "damaged":
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 1;
      break;
    case "laststand":
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 0;
      break;
    case "afterlife":
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 1;
      break;
  }

  return var_1;
}

function setcharactermodels(var_0, var_1, var_2, var_3) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var_0);
  self setviewmodel(var_2);
  self attach(var_1, "", 1);
  self.bodymodel = var_0;
  self.headmodel = var_1;
  self.viewmodel = var_2;
}

function getplayermodelindex() {
  return false;
}

function getplayerfoleytype(var_0) {
  return tablelookupbyrow("operatorskins.csv", var_0, 22);
}

function updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1;
    var_0 += self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale)) {
      var_0 = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      var_0 = self.siege_speedscale;
    } else if(isDefined(self.overrideweaponspeed_speedscale)) {
      var_0 = self.overrideweaponspeed_speedscale;
    }

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod)) {
      var_0 += var_1.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      var_0 += self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      var_0 += self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      var_0 += self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var_0 += self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var_0 += self.weaponpassivespeedonkillmod;
    }

    var_0 = min(1.5, var_0);
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  self setmovespeedscale(var_0 * self.movespeedscaler * self.combatspeedscalar);
}

function getplayerspeedbyweapon(var_0) {
  var_1 = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on") {
    return 1;
  }

  if(!self.weaponlist.size) {
    var_1 = 0.9;
  } else {
    var_2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var_2)) {
      var_1 = level.superweapons[createheadicon(var_2)].movespeed;
    } else {
      var_3 = weaponinventorytype(var_2);

      if(var_3 != "primary" && var_3 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var_2 = self.saved_lastweapon;
        } else {
          var_2 = undefined;
        }
      }

      if(!isDefined(var_2) || !self hasweapon(var_2)) {
        var_1 = getweaponspeedslowest();
      } else {
        var_1 = getweaponspeed(var_2);
      }
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
}

function getweaponspeed(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  var_2 = level.weaponmapdata[var_1].speed;
  return var_2;
}

function getweaponspeedslowest() {
  var_0 = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponspeed(var_2);

      if(var_3 == 0) {
        continue;
      }

      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else {
    var_0 = 0.9;
  }

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

function clampweaponspeed(var_0) {
  return clamp(var_0, 0, 1);
}

function getweaponheaviestvalue() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponweight(var_2);

      if(var_3 == 0) {
        continue;
      }

      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else {
    var_0 = 8;
  }

  var_0 = clampweaponweightvalue(var_0);
  return var_0;
}

function getweaponweight(var_0) {
  var_1 = undefined;
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_1 = float(tablelookup("mp/statstable.csv", 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = float(tablelookup(level.game_mode_statstable, 4, var_2, 8));
  }

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = 10;
  }

  return var_1;
}

function clampweaponweightvalue(var_0) {
  return clamp(var_0, 0, 11);
}

function wait_and_force_weapon_switch(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  var_1 = self getweaponslistprimaries();

  if(!self hasweapon(var_0)) {
    var_0 = var_1[0];
  }

  add_ammo_if_needed(var_1);
  self setspawnweapon(var_0);
}

function add_ammo_if_needed(var_0) {
  if(isDefined(self.perk_data) && istrue(self.perk_data["weapons_have_full_ammo"])) {
    foreach(var_2 in var_0) {
      self givemaxammo(var_2);
    }

    return;
  }
}

function init_core_mp_perks() {
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

  for(;;) {
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
  var_0 = 0;

  while(var_0 < 0.08) {
    self.movespeedscaler += 0.01;
    updatemovespeedscale();
    wait 0.4375;
    var_0 += 0.01;
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

  for(;;) {
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
    var_0 = 4;
    var_1 = 0;
    var_2 = 0;
    var_2 = var_0;

    if(isDefined(level.player_suit)) {
      self setsuit(level.player_suit);
    } else {
      self setsuit("iw8_suit_cp");
    }

    self.suit = "iw8_suit_cp";
    self allowdoublejump(0);
    self allowslide(var_2 &var_0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);
  self notify("set_player_perks");
}

function registerplayercharacter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();
  var_17.body_model = var_2;
  var_17.view_model = var_3;
  var_17.head_model = var_4;
  var_17.hair_model = var_5;
  var_17.vo_prefix = var_6;
  var_17.vo_suffix = var_7;
  var_17.pap_gesture = var_8;
  var_17.revive_gesture = var_9;
  var_17.photo_index = var_10;
  var_17.fate_card_weapon = var_11;
  var_17.intro_music = var_12;
  var_17.intro_gesture = var_13;
  var_17.melee_weapon = asmdevgetallstates(var_14);
  var_17.starting_weapon = asmdevgetallstates(var_16);
  var_17.post_setup_func = var_15;
  level.player_character_info[var_0] = var_17;

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  if(var_1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var_0;
    return;
  }
}

function respawnitems_assignrespawnitems(var_0) {
  self.respawnitems = var_0;
}

function ref_13B0F() {
  if(!initmaxspeedforpathlengthtable(self)) {
    return;
  }

  if(getdvarint("scr_testclient_dontspawn", 0) > 0) {
    return;
  }

  thread scripts\cp\utility::notify_delay("loadout_given", 7);
  thread ref_13B0D();
}

function ref_13B0D() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 0;

  if(getdvarint("scr_testclient_damage", 0) > 0) {
    var_0 = 1;
  }

  wait 5;
  announcement("^2Testclient setting loadout...");
  wait 5;

  for(;;) {
    if(getdvarint("scr_testclient_damage", 0) == 0) {
      waitframe();
      continue;
    }

    if(var_0 == 2) {
      scripts\engine\utility::ref_143A6("landed_after_respawn", "revive_done", "revive");
      wait 7.5;
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.health + 1, self.origin, self);
      announcement("^1TestClient Downed");
    }

    if(var_0 == 0) {
      setDvar("scr_testclient_damage", 0);
    }

    if(var_0 == 1) {
      var_0 = 2;
    }
  }
}

function getcustomization() {
  var_0 = [];

  if(isDefined(self.operatorcustomization)) {
    GscBinSkip0(0x2e, "body", self.operatorcustomization.body);
  }

  [var_0] = getoperatorcustomization();
  var_0 = var_1[1];
  return var_0;
}