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

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("operatorskins.csv", var0, 5);
    var2 = tablelookupbyrow("operatorskins.csv", var0, 17);
    var3 = tablelookupbyrow("operatorskins.csv", var0, 16);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    if(var2 != "") {
      level.nvgheadoverrides[var1]["up"] = var2;
    }

    if(var3 != "") {
      level.nvgheadoverrides[var1]["down"] = var3;
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

function givedefaultloadout(var0, var1, var2, var3) {
  self setclientomnvar("ui_options_menu", 0);

  if(istrue(self.is_doing_infil)) {
    thread giveloadoutafterinfil(var0, var1, var2);
    return;
  }

  var4 = self;
  var4.changingweapon = undefined;
  var4 scripts\cp\cp_accessories::clearplayeraccessory();
  var4 takeallweapons();

  if(!istrue(var4.keep_perks)) {
    var4 scripts\cp\utility::_clearperks();
  }

  thread delayreturningperks(var4);

  if(istrue(var3)) {
    var4 scripts\cp\utility::_detachall(1);
  } else {
    var4 scripts\cp\utility::_detachall();

    if(isDefined(var4.headmodel)) {
      var4.headmodel = undefined;
    }

    var5 = get_player_character_num();

    if(isDefined(var1)) {
      var5 = var1;
    }

    thread setmodelfromcustomization(var4);
    var6 = lookupcurrentoperatorskin(var4, var4.team);
    var7 = getplayerfoleytype(var4, var6);

    if(var7 == "") {
      var7 = "vestlight";
    }

    var4 setclothtype(var7);
  }

  if(initmaxspeedforpathlengthtable(var4)) {
    var2 = 1;
    thread ref_13b0f();
  }

  var4.spawnperk = 0;
  scripts\engine\utility::flag_wait("introscreen_over");

  if(isDefined(level.move_speed_scale)) {
    self[[level.move_speed_scale]]();
  } else {
    updatemovespeedscale();
  }

  var4.primaryweapon = isundefinedweapon();
  var4 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var4 notify("giveLoadout");
  var4 scripts\cp\utility::giveperk("specialty_pistoldeath");
  var4 scripts\cp\utility::giveperk("specialty_expanded_minimap");

  if(isDefined(var0) && var0) {
    return;
  }

  set_player_perks(var4);
  var8 = var4.melee_weapon;
  var4.default_starting_melee_weapon = var8;
  var4.currentmeleeweapon = var8;

  if(allow_super(self)) {
    if(!istrue(self.getc130knownsafeheight)) {
      scripts\cp\coop_super::give_player_super(var2);
    }

    scripts\cp\classes\cp_class_progression::give_player_class(var2);
  }

  scripts\cp\cp_loadout::give_weapons_from_loadout(self, var2);

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  if(getqueuedspleveltransients(var4.default_starting_pistol)) {
    if(!getqueuedspleveltransients(var4.starting_weapon)) {
      var4.default_starting_pistol = var4.starting_weapon;
    } else if(isDefined(level.default_weapon)) {
      var4.default_starting_pistol = scripts\cp\cp_weapon::buildweapon(level.default_weapon, [], "none", "none", -1);
    } else {
      var4.default_starting_pistol = scripts\cp\cp_weapon::buildweapon("iw8_pi_decho_mp", [], "none", "none", -1);
    }
  }

  var4.last_stand_pistol = var4.default_starting_pistol;
  var9 = scripts\cp\utility::getrawbaseweaponname(var4.default_starting_pistol);
  var4.default_starting_pistol = return_wbk_version_of_weapon(var4, var9, var4.default_starting_pistol);
  var4 scripts\cp\utility::_giveweapon(var4.default_starting_pistol, undefined, undefined, 1);

  LOC_000002cd:
    if(!getqueuedspleveltransients(var4.starting_weapon)) {
      var9 = scripts\cp\utility::getrawbaseweaponname(var4.starting_weapon);
      var4.starting_weapon = return_wbk_version_of_weapon(var4, var9, var4.starting_weapon);
      var4 scripts\cp\utility::_giveweapon(var4.starting_weapon, undefined, undefined, 0);
    }

  var10 = scripts\cp\utility::getrawbaseweaponname(var4.default_starting_pistol);
  var4[[level.move_speed_scale]]();
  var4 giveweapon("super_default_zm");
  var4 assignweaponoffhandspecial("super_default_zm");
  var4.specialoffhandgrenade = "super_default_zm";
  var11 = var4.default_starting_pistol;

  if(!getqueuedspleveltransients(var4.starting_weapon)) {
    var11 = var4.starting_weapon;
  }

  thread wait_and_force_weapon_switch(var4);

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    if(!isDefined(var4.move_door_to_pos)) {
      var4.move_door_to_pos = 0;
      var4 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
    } else if(var4.move_door_to_pos == 0) {
      var4 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
    }
  }

  if(isDefined(var4.operatorcustomization) && isDefined(var4.operatorcustomization.execution)) {
    var4 scripts\cp_mp\execution::_giveexecution(var4.operatorcustomization.execution);
  }

  if(istrue(level.disable_nvg)) {
    var4 setactionslot(2, "");
  }

  var4 setactionslot(3, "altmode");
  var4 notify("loadout_given");
  var4.getc130knownsafeheight = undefined;
  thread ref_11ec9();
}

function ref_11ec9() {
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

function giveloadoutafterinfil(var0, var1, var2) {
  self notify("giveLoadoutAfterInfil");
  self endon("disconnect");
  self endon("giveLoadoutAfterInfil");
  self waittill("player_finished_infil");
  givedefaultloadout(var0, var1, var2);
}

function allow_super(var0) {
  if(isDefined(level.allow_super)) {
    return [[level.allow_super]](var0);
  }

  return 1;
}

function return_wbk_version_of_weapon(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");

  if(isDefined(var0.weapon_build_models[var1])) {
    return asmdevgetallstates(var0.weapon_build_models[var1]);
  }

  return var2;
}

function delayreturningperks(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  wait 1;

  if(istrue(var0.keep_perks)) {
    if(isDefined(var0.zombies_perks)) {
      var1 = getarraykeys(var0.zombies_perks);

      foreach(var3 in var1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var3]) && isDefined(level.coop_perk_callbacks[var3].set)) {
          var0[[level.coop_perk_callbacks[var3].set]]();
        }
      }
    }

    var0.keep_perks = undefined;
    return;
  }
}

function release_character_number(var0) {
  var1 = var0.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var1) && var1 != 5) {
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var1);
    return;
  }
}

function get_baseweapon_pap_level(var0, var1) {
  if(isDefined(var0.pap[var1])) {
    return var0.pap[var1].lvl;
  }

  return 1;
}

function setmodelfromcustomization(var0) {
  level endon("game_ended");
  self.melee_weapon = "iw8_knife_mp";
  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  var2 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var1);
  var3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var2, "skin");
  var4 = getoperatorcustomization();
  var5 = var4[0];
  var6 = var4[1];
  self.setcustomization_body = var5;
  self.setcustomization_head = var6;
  self setcustomization(var5, var6);
  wait 0.05;
  var4 = getoperatorcustomization();
  var5 = var4[0];
  var6 = var4[1];
  var7 = var4[2];

  if(!isagent(self)) {
    self setcustomization(var5, var6);
    var8 = self getcustomizationbody();
    var9 = self getcustomizationhead();
    var10 = self getcustomizationviewmodel();
    var11 = getplayerviewmodelfrombody(var5);
  } else {
    var8 = "body_opforce_london_terrorist_1_2";
    var9 = "head_male_bc_03";
    var10 = "viewmodel_mp_base_iw8";
    var11 = "viewmodel_mp_base_iw8";
  }

  var6 = lookupcurrentoperator(self.team);
  var12 = lookupcurrentoperatorskin(self.team);
  var13 = spawnStruct();
  var13.operatorref = var6;
  var13.skinref = var12;
  var13.body = var9;
  var13.defaultbody = var8;
  var13.head = var10;
  var13.defaulthead = var9;
  var13.vm = var11;
  var13.defaultvm = var10;
  var13.gender = getoperatorgender(var6);
  var13.voice = getoperatorvoice(var6, var12);
  var13.clothtype = resetplayermovespeedscale(var12);
  var13.superfaction = getoperatorsuperfaction(var6);
  var13.execution = getoperatorexecution(var6);
  var13.oic_rewardammo = resetposition(var6);
  var13.suit = var11;
  var13.rebuild = 0;
  var13.superfaction = getoperatorsuperfaction(var6);
  self.operatorcustomization = var13;
  setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
  var14 = spawnStruct();
  var14.apc = runbrgametypefunc6("apc");
  var14.c4_pick_up_listener = rundomplateskybeam("apc");
  var14.check_cannot_spawn_tank = runbrgametypefunc6("atv");
  var14.get_extra_focus_fire_multipler = runbrgametypefunc6("cargo_truck");
  var14.vehicle_damage_endburndown = runbrgametypefunc6("jeep");
  var14.x1opsenableelimination = runbrgametypefunc6("little_bird");
  var14.ref_139f7 = runbrgametypefunc6("tac_rover");
  var14.ref_13a47 = runbrgametypefunc6("tank_east");
  var14.ref_13a48 = rundomplateskybeam("tank_east");
  var14.ref_13a52 = runbrgametypefunc6("tank_west");
  var14.ref_13a53 = rundomplateskybeam("tank_west");
  var14.c130airdrop_heightoverride = runcircles("apc", 4);
  var14.check_carrier_status = runcircles("atv", 6);
  var14.get_fake_digit_from_pool = runcircles("cargo_truck", 8);
  var14.vehicle_damage_enginevisualclearcallback = runcircles("jeep", 10);
  var14.x1opsendgame = runcircles("little_bird", 12);
  var14.ref_139f8 = runcircles("tac_rover", 14);
  var14.check_for_damage_scalar_change = runcontrolledcallback("atv");
  var14.ref_139fc = runcontrolledcallback("tac_rover");
  var14.zombieingas = runcontrolledcallback("little_bird");
  self.ref_14238 = var14;

  if(self.operatorcustomization.gender == "female") {
    self method_87aa("female");
  } else {
    self method_87aa("");
  }

  if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](self)) {
    self[[level.change_to_terrorist_model_func]](self);
  }

  if(isDefined(level.ref_127f3)) {
    self[[level.ref_127f3]]();
    return;
  }
}

function runbrgametypefunc6(var0) {
  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "camo");
  var2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var1, 4);
  return var2;
}

function runcontrolledcallback(var0) {
  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "camo");
  var2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var1, 10);
  return var2;
}

function rundomplateskybeam(var0) {
  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "camo");
  var2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var1, 5);
  return var2;
}

function runcircles(var0, var1) {
  var2 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var0, "horn");
  var3 = tablelookup("mp_cp/vehiclehorns.csv", 0, var2, var1);
  return var3;
}

function getplayerbodymodel() {
  var0 = getoperatorcustomization();
  return var0[0];
}

function getplayerviewmodelfrombody(var0) {
  var1 = tablelookup("mp/cac/bodies.csv", 1, var0, 3);

  if(!isDefined(var1) || var1 == "") {
    var1 = "viewhands_mp_base_iw8";
  }

  return var1;
}

function lookupcurrentoperator(var0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  var2 = var1;
  var3 = scripts\cp\utility::getgametype() == "br";

  if(!level.teambased || var3) {
    var1 = undefined;

    if(isai(self)) {
      var1 = self.botoperatorteam;
    } else {
      var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
    }

    var2 = var1;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(var2 == 0) {
        self.defaultoperatorteam = "allies";
      } else {
        self.defaultoperatorteam = "axis";
      }
    }
  }

  if(!isDefined(level.playercustomizationdata)) {
    level.playercustomizationdata = [];
  }

  var4 = self getentitynumber();
  level.playercustomizationdata[var4] = [];
  var5 = undefined;

  if(!isDefined(level.playercustomizationdata[var4][var0])) {
    var6 = spawnStruct();

    if(isai(self)) {
      var6.operatorref = self.botoperatorref;
    } else {
      var6.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var2);
    }

    level.playercustomizationdata[var4][var0] = var6;
  }

  var5 = level.playercustomizationdata[var4][var0].operatorref;

  if(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && self calloutmarkerping_getEnt()) {
    initoperatorcustomization();
    var7 = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.showempminimap)) {
      foreach(var9 in var7) {
        var10 = getarraykeys(level.operatorcustomization[var9]);

        if(!isDefined(level.showing_ui_record)) {
          level.showing_ui_record = [];
        }

        if(!isDefined(level.showing_ui_record[var9]) || level.showing_ui_record[var9] > var10.size) {
          level.showing_ui_record[var9] = 0;
        }

        for(var11 = var10[level.showing_ui_record[var9]]; isDefined(var11) && (var11 == "default_western" || var11 == "default_eastern"); var11 = var10[level.showing_ui_record[var9]]) {
          level.showing_ui_record[var9] += 1;

          if(level.showing_ui_record[var9] > var10.size) {
            level.showing_ui_record[var9] = 0;
          }
        }

        level.showing_ui_record[var9] += 1;
        level.playercustomizationdata[var4][var9] = spawnStruct();
        level.playercustomizationdata[var4][var9].operatorref = var11;
      }

      self.showempminimap = 1;
    }

    if(isDefined(level.operatorcustomization[var0])) {
      var5 = level.playercustomizationdata[var4][var0].operatorref;
    } else {
      if(!isDefined(self.botoperatorteam)) {
        self.botoperatorteam = scripts\engine\utility::random(var7);
      }

      var5 = level.playercustomizationdata[var4][self.botoperatorteam].operatorref;
    }
  }

  if(isai(self) || !isDefined(var5) || var5 == "") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[var4][var0].operatorref)) {
          var5 = level.playercustomizationdata[var4][var0].operatorref;
        } else {
          var5 = self.botoperatorref;
        }
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            var7 = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = scripts\engine\utility::random(var7);
          }
        }

        var0 = self.botoperatorteam;

        if(!isDefined(self.pers["operatorIndex"])) {
          var1 = randomint(level.operatorcustomization[var0].size);
          self.pers["operatorIndex"] = var1;
        } else {
          var1 = self.pers["operatorIndex"];
        }

        var13 = 0;

        foreach(var15 in level.operatorcustomization[var0]) {
          if(var13 == var1) {
            self.botoperatorref = var16;
            var5 = var16;
            break;
          }

          var13++;
        }
      }
    } else {
      var5 = "wyatt_western";
    }
  }

  return var5;
}

function lookupcurrentoperatorskin(var0) {
  var1 = lookupcurrentoperator(var0);
  var2 = undefined;
  var3 = self getentitynumber();

  if(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && self calloutmarkerping_getEnt()) {
    if(!isDefined(level.playercustomizationdata[var3][var0].operatorskinindex)) {
      if(!isDefined(level.showing_bomb_wire_pair_to_player)) {
        thermite_doradiusdamage();
      }

      var4 = level.showing_bomb_wire_pair_to_player[var1]["curIndex"];
      level.playercustomizationdata[var3][var0].operatorskinindex = level.showing_bomb_wire_pair_to_player[var1]["lootIDs"][var4];
      level.showing_bomb_wire_pair_to_player[var1]["curIndex"] = level.showing_bomb_wire_pair_to_player[var1]["curIndex"] + 1;

      if(level.showing_bomb_wire_pair_to_player[var1]["curIndex"] >= level.showing_bomb_wire_pair_to_player[var1]["maxIndex"]) {
        level.showing_bomb_wire_pair_to_player[var1]["curIndex"] = 0;
      }
    }
  } else if(!isDefined(level.playercustomizationdata[var3][var0].operatorskinindex)) {
    if(isai(self)) {
      if(!isDefined(self.botskinid)) {
        debug_interaction_toggle(var1);
      }

      level.playercustomizationdata[var3][var0].operatorskinindex = self.botskinid;
    } else {
      level.playercustomizationdata[var3][var0].operatorskinindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var1, "skin");
    }
  }

  var2 = level.playercustomizationdata[var3][var0].operatorskinindex;

  if(isai(self) && (!isDefined(var2) || var2 == 0) || !isDefined(var2) || var2 == 0) {
    if(isai(self)) {
      if(isDefined(self.botskinid)) {
        var2 = self.botskinid;
      } else {
        debug_interaction_toggle(var1);
      }
    } else {
      var2 = 1;
    }
  }

  return var2;
}

function debug_interaction_toggle(var0) {
  var1 = self.team;

  if(isDefined(self.botoperatorteam)) {
    var1 = self.botoperatorteam;
  }

  if(!isDefined(self.pers["operatorSkinIndex"])) {
    var2 = randomint(level.operatorcustomization[var1][var0].size);
    self.pers["operatorSkinIndex"] = var2;
  } else {
    var2 = self.pers["operatorSkinIndex"];
  }

  var3 = 0;

  foreach(var5 in level.operatorcustomization[var2][var1]) {
    if(var3 == var2) {
      var6 = int(tablelookup("operatorskins.csv", 1, var8, 0));
      self.botskinid = var6;
      var7 = var6;
      break;
    }

    var3++;
  }
}

function thermite_doradiusdamage() {
  if(isDefined(level.showing_bomb_wire_pair_to_player)) {
    return;
  }

  level.showing_bomb_wire_pair_to_player = [];
  var0 = tablelookupgetnumrows("operatorskins.csv");

  for(var1 = 0; var1 < var0; var1++) {
    if(tablelookupbyrow("operatorskins.csv", var1, 18) != "") {
      var2 = tablelookupbyrow("operatorskins.csv", var1, 2);
      var3 = tablelookupbyrow("operatorskins.csv", var1, 0);

      if(!isDefined(level.showing_bomb_wire_pair_to_player[var2])) {
        level.showing_bomb_wire_pair_to_player[var2]["lootIDs"] = [];
        level.showing_bomb_wire_pair_to_player[var2]["curIndex"] = 0;
        level.showing_bomb_wire_pair_to_player[var2]["maxIndex"] = 0;
      }

      level.showing_bomb_wire_pair_to_player[var2]["lootIDs"][level.showing_bomb_wire_pair_to_player[var2]["lootIDs"].size] = int(var3);
      level.showing_bomb_wire_pair_to_player[var2]["maxIndex"] = level.showing_bomb_wire_pair_to_player[var2]["maxIndex"] + 1;
    }
  }
}

function lookupotheroperator(var0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var1 = scripts\engine\utility::ter_op(var0 == "allies", 1, 0);
  var2 = self getentitynumber();
  var3 = "";
  var0 = scripts\engine\utility::ter_op(var0 == "allies", "axis", "allies");

  if(scripts\cp\utility::getgametype() != "br") {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[var2][var0])) {
        var4 = spawnStruct();
        var4.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var1);
        level.playercustomizationdata[var2][var0] = var4;
      }

      var3 = level.playercustomizationdata[var2][var0].operatorref;
    }
  }

  return var3;
}

function initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }

  level.operatorcustomization = [];
  setDvar("cl_streamSync_devNoLatch", 1);

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("operators.csv", var0, 1);
    var2 = getoperatorsuperfaction(var1);
    var3 = scripts\engine\utility::ter_op(var2 == 0, "allies", "axis");

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var4 = int(tablelookupbyrow("operators.csv", var0, 8));

    if(var4) {
      if(!isDefined(level.operatorcustomization[var3])) {
        level.operatorcustomization[var3] = [];
      }

      level.operatorcustomization[var3][var1] = [];
    }
  }

  var5 = 0;

  for(;;) {
    var1 = tablelookupbyrow("operatorskins.csv", var5, 2);
    var6 = tablelookupbyrow("operatorskins.csv", var5, 1);
    var7 = tablelookupbyrow("operatorskins.csv", var5, 4);
    var8 = tablelookupbyrow("operatorskins.csv", var5, 5);

    if(!isDefined(var6) || var6 == "") {
      break;
    }

    var3 = getoperatorteambyref(var1);

    if(!isDefined(var3)) {
      var5++;
      continue;
    }

    var9 = [];
    GscBinSkip0(0x2e, 0, var7);
  }
}

function getoperatorteambyref(var0) {
  foreach(var2 in level.operatorcustomization) {
    foreach(var4 in var2) {
      if(var5 == var0) {
        return var6;
      }
    }
  }

  return undefined;
}

function pickdefaultoperatorskin(var0) {
  var1 = 0;
  var2 = self.primaryweapon;

  if(isDefined(var2)) {
    var3 = scripts\cp\cp_weapon::getweapongroup(var2);

    switch (var3) {
      case "weapon_assault":
        var1 = 0;
        break;
      case "weapon_smg":
        var1 = 1;
        break;
      case "weapon_dmr":
      case "weapon_sniper":
        var1 = 2;
        break;
      case "weapon_lmg":
        var1 = 3;
        break;
      case "weapon_shotgun":
        var1 = 4;
        break;
      default:
        var1 = 1;
        break;
    }
  }

  return var1;
}

function getoperatorcustomization() {
  var0 = lookupcurrentoperator(self.team);
  var1 = lookupcurrentoperatorskin(self.team);
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;

  if((var0 == "default_western" || var0 == "default_eastern") && (var1 == 274 || var1 == 275)) {
    initdefaultoperatorskins();
    var5 = level.teambased && scripts\cp\utility::getgametype() != "br";

    if(!isDefined(self.defaultoperatorteam) || var5 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
      var6 = "allies";

      if(var0 == "default_eastern") {
        var6 = "axis";
      }

      self.defaultoperatorteam = var6;

      if(self.team != "allies" && self.team != "axis") {
        self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      }
    }

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = 0;
    }

    var2 = level.defaultoperatorskins[self.defaultoperatorteam]["body"][self.pers["defaultOperatorSkinIndex"]];

    if(!isDefined(self.pers["defaultOperatorHeadIndex"])) {
      self.pers["defaultOperatorHeadIndex"] = scripts\engine\utility::random(level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]]);
    }

    var3 = self.pers["defaultOperatorHeadIndex"];
    var4 = "iw8_suit_mp_wyatt";
  } else {
    var2 = tablelookup("operatorskins.csv", 0, var1, 4);
    var3 = tablelookup("operatorskins.csv", 0, var1, 5);
    var4 = tablelookup("operators.csv", 1, var0, 19);
  }

  self.bodymodelname = var2;
  self.backuphead = var3;
  self.backupsuit = var4;
  var7 = [];
  GscBinSkip0(0x2e, 0, var2);
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

function getoperatorexecution(var0) {
  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var0, "execution");

  if(var1 == 0) {
    self.loadoutexecution = tablelookup("operators.csv", 1, var0, 24);
  } else {
    self.loadoutexecution = tablelookup("mp_cp/executiontable.csv", 0, var1, 1);
  }

  return self.loadoutexecution;
}

function resetposition(var0) {
  var1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var0, "taunt");

  if(var1 == 0) {
    self.ref_1195c = tablelookup("operators.csv", 1, var0, 23);
  } else {
    self.ref_1195c = tablelookup("operatorquips.csv", 0, var1, 6);
  }

  return self.ref_1195c;
}

function getoperatorsuperfaction(var0) {
  var1 = tablelookup("operators.csv", 1, var0, 3);
  return int(var1);
}

function getoperatorvoice(var0, var1) {
  if(var0 == "default_eastern" || var0 == "default_western") {
    var2 = tablelookup("operatorskins.csv", 0, var1, 24);

    if(isDefined(var2) && var2 != "") {
      return var2;
    }
  }

  var2 = tablelookup("operators.csv", 1, var0, 10);
  return var2;
}

function resetplayermovespeedscale(var0) {
  var1 = tablelookupbyrow("operatorskins.csv", var0, 22);
  return var1;
}

function getoperatorgender(var0) {
  var1 = scripts\engine\utility::ter_op(tablelookup("operators.csv", 1, var0, 11) == "0", "male", "female");
  return var1;
}

function get_player_character_num() {
  if(isDefined(self.player_character_num)) {
    return self.player_character_num;
  }

  var1 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = var1;
  return var1;
}

function setplayerhudphoto(var0, var1) {
  var0 endon("disconnect");
  var2 = var0 getentitynumber();

  if(var2 == 4) {
    var2 = 0;
  }

  var0.bit_position = get_bit_position(var2);
  var0.player_character_index = var1;

  if(isDefined(level.skip_playerhudphoto)) {
    var0.player_character_index = 1;
    var1 = 1;
  }

  wait 5;
}

function set_player_photo_status(var0, var1) {
  set_player_photo_option(var0, "zm_player_status", get_status_bit_value(var1));
}

function set_player_photo_option(var0, var1, var2) {
  if(isDefined(var0.bit_position)) {
    setomnvarbit(var1, var0.bit_position.bit_3, var2.bit_3);
    setomnvarbit(var1, var0.bit_position.bit_2, var2.bit_2);
    setomnvarbit(var1, var0.bit_position.bit_1, var2.bit_1);
    var0.photosetup = 1;
    return;
  }
}

function get_bit_position(var0) {
  var1 = spawnStruct();

  switch (var0) {
    case 3:
      var1.bit_3 = 11;
      var1.bit_2 = 10;
      var1.bit_1 = 9;
      break;
    case 2:
      var1.bit_3 = 8;
      var1.bit_2 = 7;
      var1.bit_1 = 6;
      break;
    case 1:
      var1.bit_3 = 5;
      var1.bit_2 = 4;
      var1.bit_1 = 3;
      break;
    case 0:
      var1.bit_3 = 2;
      var1.bit_2 = 1;
      var1.bit_1 = 0;
      break;
  }

  return var1;
}

function get_character_bit_value(var0) {
  var1 = spawnStruct();

  switch (var0) {
    case 0:
      var1.bit_3 = 0;
      var1.bit_2 = 0;
      var1.bit_1 = 0;
      break;
    case 1:
      var1.bit_3 = 0;
      var1.bit_2 = 0;
      var1.bit_1 = 1;
      break;
    case 2:
      var1.bit_3 = 0;
      var1.bit_2 = 1;
      var1.bit_1 = 0;
      break;
    case 3:
      var1.bit_3 = 0;
      var1.bit_2 = 1;
      var1.bit_1 = 1;
      break;
    case 4:
      var1.bit_3 = 1;
      var1.bit_2 = 0;
      var1.bit_1 = 0;
      break;
  }

  return var1;
}

function get_status_bit_value(var0) {
  var1 = spawnStruct();

  switch (var0) {
    case "healthy":
      var1.bit_3 = 0;
      var1.bit_2 = 0;
      var1.bit_1 = 0;
      break;
    case "damaged":
      var1.bit_3 = 0;
      var1.bit_2 = 0;
      var1.bit_1 = 1;
      break;
    case "laststand":
      var1.bit_3 = 0;
      var1.bit_2 = 1;
      var1.bit_1 = 0;
      break;
    case "afterlife":
      var1.bit_3 = 0;
      var1.bit_2 = 1;
      var1.bit_1 = 1;
      break;
  }

  return var1;
}

function setcharactermodels(var0, var1, var2, var3) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var0);
  self setviewmodel(var2);
  self attach(var1, "", 1);
  self.bodymodel = var0;
  self.headmodel = var1;
  self.viewmodel = var2;
}

function getplayermodelindex() {
  return false;
}

function getplayerfoleytype(var0) {
  return tablelookupbyrow("operatorskins.csv", var0, 22);
}

function updatemovespeedscale() {
  var0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var0 = 1;
    var0 += self.playerstreakspeedscale;
  } else {
    var0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale)) {
      var0 = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      var0 = self.siege_speedscale;
    } else if(isDefined(self.overrideweaponspeed_speedscale)) {
      var0 = self.overrideweaponspeed_speedscale;
    }

    var1 = self.chill_data;

    if(isDefined(var1) && isDefined(var1.speedmod)) {
      var0 += var1.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      var0 += self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      var0 += self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      var0 += self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var0 += self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var0 += self.weaponpassivespeedonkillmod;
    }

    var0 = min(1.5, var0);
  }

  self.weaponspeed = var0;

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  self setmovespeedscale(var0 * self.movespeedscaler * self.combatspeedscalar);
}

function getplayerspeedbyweapon(var0) {
  var1 = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on") {
    return 1;
  }

  if(!self.weaponlist.size) {
    var1 = 0.9;
  } else {
    var2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var2)) {
      var1 = level.superweapons[createheadicon(var2)].movespeed;
    } else {
      var3 = weaponinventorytype(var2);

      if(var3 != "primary" && var3 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var2 = self.saved_lastweapon;
        } else {
          var2 = undefined;
        }
      }

      if(!isDefined(var2) || !self hasweapon(var2)) {
        var1 = getweaponspeedslowest();
      } else {
        var1 = getweaponspeed(var2);
      }
    }
  }

  var1 = clampweaponspeed(var1);
  return var1;
}

function getweaponspeed(var0) {
  var1 = scripts\cp\utility::getbaseweaponname(var0);
  var2 = level.weaponmapdata[var1].speed;
  return var2;
}

function getweaponspeedslowest() {
  var0 = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var2 in self.weaponlist) {
      var3 = getweaponspeed(var2);

      if(var3 == 0) {
        continue;
      }

      if(var3 < var0) {
        var0 = var3;
      }
    }
  } else {
    var0 = 0.9;
  }

  var0 = clampweaponspeed(var0);
  return var0;
}

function clampweaponspeed(var0) {
  return clamp(var0, 0, 1);
}

function getweaponheaviestvalue() {
  var0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var2 in self.weaponlist) {
      var3 = getweaponweight(var2);

      if(var3 == 0) {
        continue;
      }

      if(var3 < var0) {
        var0 = var3;
      }
    }
  } else {
    var0 = 8;
  }

  var0 = clampweaponweightvalue(var0);
  return var0;
}

function getweaponweight(var0) {
  var1 = undefined;
  var2 = scripts\cp\utility::getbaseweaponname(var0);
  var1 = float(tablelookup("mp/statstable.csv", 4, var2, 8));

  if(!isDefined(var1) || var1 < 1) {
    var1 = float(tablelookup(level.game_mode_statstable, 4, var2, 8));
  }

  if(!isDefined(var1) || var1 < 1) {
    var1 = 10;
  }

  return var1;
}

function clampweaponweightvalue(var0) {
  return clamp(var0, 0, 11);
}

function wait_and_force_weapon_switch(var0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  var1 = self getweaponslistprimaries();

  if(!self hasweapon(var0)) {
    var0 = var1[0];
  }

  add_ammo_if_needed(var1);
  self setspawnweapon(var0);
}

function add_ammo_if_needed(var0) {
  if(isDefined(self.perk_data) && istrue(self.perk_data["weapons_have_full_ammo"])) {
    foreach(var2 in var0) {
      self givemaxammo(var2);
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
  var0 = 0;

  while(var0 < 0.08) {
    self.movespeedscaler += 0.01;
    updatemovespeedscale();
    wait 0.4375;
    var0 += 0.01;
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
    var0 = 4;
    var1 = 0;
    var2 = 0;
    var2 = var0;

    if(isDefined(level.player_suit)) {
      self setsuit(level.player_suit);
    } else {
      self setsuit("iw8_suit_cp");
    }

    self.suit = "iw8_suit_cp";
    self allowdoublejump(0);
    self allowslide(var2 &var0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);
  self notify("set_player_perks");
}

function registerplayercharacter(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16) {
  var17 = spawnStruct();
  var17.body_model = var2;
  var17.view_model = var3;
  var17.head_model = var4;
  var17.hair_model = var5;
  var17.vo_prefix = var6;
  var17.vo_suffix = var7;
  var17.pap_gesture = var8;
  var17.revive_gesture = var9;
  var17.photo_index = var10;
  var17.fate_card_weapon = var11;
  var17.intro_music = var12;
  var17.intro_gesture = var13;
  var17.melee_weapon = asmdevgetallstates(var14);
  var17.starting_weapon = asmdevgetallstates(var16);
  var17.post_setup_func = var15;
  level.player_character_info[var0] = var17;

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  if(var1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var0;
    return;
  }
}

function respawnitems_assignrespawnitems(var0) {
  self.respawnitems = var0;
}

function ref_13b0f() {
  if(!initmaxspeedforpathlengthtable(self)) {
    return;
  }

  if(getdvarint("scr_testclient_dontspawn", 0) > 0) {
    return;
  }

  thread scripts\cp\utility::notify_delay("loadout_given", 7);
  thread ref_13b0d();
}

function ref_13b0d() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = 0;

  if(getdvarint("scr_testclient_damage", 0) > 0) {
    var0 = 1;
  }

  wait 5;
  announcement("^2Testclient setting loadout...");
  wait 5;

  for(;;) {
    if(getdvarint("scr_testclient_damage", 0) == 0) {
      waitframe();
      continue;
    }

    if(var0 == 2) {
      scripts\engine\utility::ref_143a6("landed_after_respawn", "revive_done", "revive");
      wait 7.5;
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.health + 1, self.origin, self);
      announcement("^1TestClient Downed");
    }

    if(var0 == 0) {
      setDvar("scr_testclient_damage", 0);
    }

    if(var0 == 1) {
      var0 = 2;
    }
  }
}

function getcustomization() {
  var0 = [];

  if(isDefined(self.operatorcustomization)) {
    GscBinSkip0(0x2e, "body", self.operatorcustomization.body);
  }

  [var0] = getoperatorcustomization();
  var0 = var1[1];
  return var0;
}