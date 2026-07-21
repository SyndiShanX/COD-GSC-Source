/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\crafting_system.gsc
***********************************************/

init_craftingsystem(var_0) {
  readcraftingmaterialstable();
  var_1 = getdvarint("_encstr_A6BF1A4E977E81C3F3F25B1B469B68587B5C7B11FF48C1DDA571B747", 0);

  if(var_1 != 0)
    level.starting_currency = var_1;
  else
    level.starting_currency = 0;

  level.currentlycrafteditem = spawnStruct();
  level.currentlycrafteditem.crafteditem = "_encstr_B40101";
  level.currentlycrafteditem.crafteditemmodel = "_encstr_B40101";
  level.currentlycrafteditem.crafteditempowerreference = "_encstr_B40101";
  level.currentlycrafteditem.material1 = 0;
  level.currentlycrafteditem.material2 = 0;
  level.currentlycrafteditem.material3 = 0;
  level.currentlycrafteditem.material4 = 0;
  level._effect["_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"] = loadfx("_encstr_A58B337BB2F1AFF7101B1F07A36FB7C338C1FF4B4268DE83C893DD8BD998EFE33DC02077D1A3072EF40868AF277F3B6B1B0214A48B");
  level._effect["_encstr_BACF20DB718A3036B7031699CB67EDE069D97B71E1B6F8E8FFCAE88082C7A7F8BD2E"] = loadfx("_encstr_AB5C3603AA2B508863800F73D05DD0CBC3A23BCB13B7BFA02DA67551D7B2388267CBF0517AFF61C912871F552F9E10D657934959B2572C40");
  init();
  level.care_package_interaction = ::register_care_package_interaction;
}

getcraftingmaterialmax(var_0, var_1) {
  var_2 = 10;

  switch (var_0) {
    case "_encstr_9BC806E72F38AFE8":
      var_2 = 66000;
      break;
    case "_encstr_ABF605EEBD7B32":
      var_2 = 66000;
      break;
    case "_encstr_AB440A3180D0C0109B17550B":
      var_2 = 66000;
      break;
    case "_encstr_A9F60584641BF3":
      var_2 = 66000;
      break;
    case "_encstr_A31308CAF7CB53920EF7":
      var_2 = 66000;
      break;
    case "_encstr_97780C6DCA22C6DAA9AFA028D8D8":
      var_2 = 66000;
      break;
    case "_encstr_93470D3253AB8A9B90CB9EFD29E3E9":
      var_2 = 66000;
      break;
    case "_encstr_8C7F097F887897DBC9BB57":
      var_2 = 66000;
      break;
    case "_encstr_9B1807D39B48FD93A3":
      var_2 = 66000;
      break;
    case "_encstr_ACC906C827ED7356":
      var_2 = 66000;
      break;
  }

  if(var_1.perk_data["_encstr_8CB91B96CD369CAC0BCD5919FA6BC2A3B2392D58B1E67DEE0BD8C6B23A"])
    var_2 = var_2 * 2;

  return var_2;
}

readcraftingmaterialstable() {
  var_0 = "_encstr_842E18F25FFAC10F80357B80A1089F321A09275A52AD6023C32B";
  level.crafting_table_data = [];

  for(var_1 = 1; var_1 <= 17; var_1++) {
    var_2 = table_look_up(var_0, var_1, 1);
    level.crafting_table_data[var_2] = spawnStruct();
    level.crafting_table_data[var_2].crafteditemindex = var_1;
    level.crafting_table_data[var_2].crafteditem = var_2;
    level.crafting_table_data[var_2].crafteditemmodel = table_look_up(var_0, var_1, 2);
    level.crafting_table_data[var_2].crafteditempowerreference = table_look_up(var_0, var_1, 3);
    level.crafting_table_data[var_2].icon = table_look_up(var_0, var_1, 4);
    level.crafting_table_data[var_2].stringref = table_look_up(var_0, var_1, 5);
    level.crafting_table_data[var_2].crafteditemtype = table_look_up(var_0, var_1, 6);
    level.crafting_table_data[var_2].blueprintref = table_look_up(var_0, var_1, 7);
    level.crafting_table_data[var_2].metal = int(table_look_up(var_0, var_1, 8));
    level.crafting_table_data[var_2].wood = int(table_look_up(var_0, var_1, 9));
    level.crafting_table_data[var_2].explosive = int(table_look_up(var_0, var_1, 10));
    level.crafting_table_data[var_2].wire = int(table_look_up(var_0, var_1, 11));
    level.crafting_table_data[var_2].battery = int(table_look_up(var_0, var_1, 12));
    level.crafting_table_data[var_2].emradiation = int(table_look_up(var_0, var_1, 13));
    level.crafting_table_data[var_2].circuitboard = int(table_look_up(var_0, var_1, 14));
    level.crafting_table_data[var_2].colordye = int(table_look_up(var_0, var_1, 15));
    level.crafting_table_data[var_2].sentry = int(table_look_up(var_0, var_1, 16));
    level.crafting_table_data[var_2].drone = int(table_look_up(var_0, var_1, 17));
  }
}

table_look_up(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, var_1, var_2);
}

throwcrate(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp\cp_powers::power_disablepower();

  while(self isgestureplaying("_encstr_8F2A14B3CADCD70736BC39FACECAE63A573956181853"))
    waitframe();

  var_1 = "_encstr_B40101";

  switch (var_0.weapon_name) {
    case "_encstr_826813691C902EB9B0A5507FFF574ABB61A2B1EBA3":
      var_1 = "_encstr_A3990BDBEF05B561FA5A488BD8";
      break;
    case "_encstr_B4E9147053F0F70EFB580FA689A0BB721C4F3B7918E1":
      var_1 = "_encstr_A7B606DA83796F4A";
      break;
    case "_encstr_9508192DEE707DB0239CB273851B2DDCCAF5B658C9DA9539D7B1C1":
      var_1 = "_encstr_B18B0B578C23412DAE3A487842";
      break;
    case "_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B":
      var_1 = "_encstr_88E10CA1B5B18B5BA00FA7788642";
      var_1 = "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38";
      break;
  }

  scripts\cp\cp_deployablebox::begindeployableviamarker(undefined, var_1, var_0, var_0.weapon_name);
  scripts\cp\cp_powers::power_enablepower();
}

throwammocrate(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp\cp_powers::power_disablepower();

  while(self isgestureplaying("_encstr_8F2A14B3CADCD70736BC39FACECAE63A573956181853"))
    waitframe();

  scripts\cp\cp_deployablebox::begindeployableviamarker(undefined, "_encstr_992E0C97A7734F7BF29B66D945D0", var_0, var_0.weapon_name);
  scripts\cp\cp_powers::power_enablepower();
}

getitemslot(var_0) {
  foreach(var_3, var_2 in level.crafting_table_data) {
    if(var_0 == var_2.blueprintref)
      return var_2.crafteditemtype;
  }
}

remove_crafted_item_from_slot(var_0, var_1) {}

isspecialcrafteditem(var_0) {
  if(var_0 == "_encstr_85A30EDABDCD536A32227BE7A80B351B" || var_0 == "_encstr_A64B15E47457700D3E1B9BB7FF92587ACF4D4959DDBD70")
    return 1;
  else
    return 0;
}

givecrafteditemthruluinotify(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = tablelookup("_encstr_842E18F25FFAC10F80357B80A1089F321A09275A52AD6023C32B", 0, var_0, 1);
  var_2 = level.crafting_table_data[var_1].crafteditemtype;
  var_3 = level.crafting_table_data[var_1].crafteditempowerreference;
  var_4 = scripts\cp\cp_powers::what_power_is_in_slot("_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_4)) {
    if(self.powers[var_4].charges >= self.powers[var_4].maxcharges && var_3 == var_4)
      return;
  }

  if(isspecialcrafteditem(var_1)) {
    if(var_1 == "_encstr_85A30EDABDCD536A32227BE7A80B351B")
      thread scripts\cp\cp_weapon_autosentry::test_crafted_sentry(self);

    if(var_1 == "_encstr_A64B15E47457700D3E1B9BB7FF92587ACF4D4959DDBD70") {
      spendcraftedmaterials(level.crafting_table_data[var_1]);
      thread scripts\cp\equipment\nvg::runnvg();
    }
  }

  switch (var_2) {
    case "_encstr_BE8A0823AF39ADE9B260":
      self.crafteditemstruct.bdpadup = 1;
      self.crafteditemstruct.dpadup = level.crafting_table_data[var_1];
      break;
    case "_encstr_91570A8CDEBBDCFA23380B46":
      self.crafteditemstruct.bdpaddown = 1;
      self.crafteditemstruct.dpaddown = level.crafting_table_data[var_1];
      break;
    case "_encstr_A3D70A63CA333AD78CC15832":
      self.crafteditemstruct.bdpadleft = 1;
      self.crafteditemstruct.dpadleft = level.crafting_table_data[var_1];
      break;
    case "_encstr_91DC0B4EA53BA13AD78C0E0B23":
      self.crafteditemstruct.bdpadright = 1;
      self.crafteditemstruct.dpadright = level.crafting_table_data[var_1];
      break;
  }

  if(var_2 == "_encstr_BA7F0830B3A7859B60B0" || var_2 == "_encstr_AC8F0AE74163F85AAA380AD8") {
    var_5 = undefined;

    if(self.perk_data["_encstr_A2061A07DC2B90299C3AA0D022393F4B9746158B3EFF9E5B83E2A078"])
      var_5 = 1;

    spendcraftedmaterials(level.crafting_table_data[var_1]);
    scripts\cp\cp_powers::givepower(var_3, var_2, undefined, undefined, var_5, 0, 1);
  }

  if(var_2 == "_encstr_BE450734FB03DF9EA9") {
    spendcraftedmaterials(level.crafting_table_data[var_1]);

    if(var_1 == "_encstr_A7B606D883796F4A")
      scripts\cp\cp_armor::givearmor(self, 100);

    if(var_1 == "_encstr_9BBD0C20A36075A34379819AF92A")
      give_health_pack(self, 50);
  }
}

giveitembasedoncraftingstruct(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "_encstr_A20A088EDD77B3031B2A":
      if(scripts\cp\utility::turn_off_sniper_laser()) {
        if(!scripts\cp\cp_laststand::buystationsusepaddingdistribution() && (!isDefined(level.players_in_respawn_queue) || level.players_in_respawn_queue.size == 0)) {
          scripts\cp\utility::hint_prompt("_encstr_9560169CB2CE2DD956EB472BB0B6DA16E8B2E6F59958A51B", 1, 2);
          break;
        } else {
          scriptable_autouse_funcs();
          level thread _id_12C8C(self);
          var_2 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B8DC0E023FE332168F451E3295531041", self);
          scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_2);
          self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_A20A088EDD77B3031B2A");
          break;
        }
      }

      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      if(!isDefined(level.players_in_respawn_queue) || istrue(level.disable_respawns)) {} else if(level.players_in_respawn_queue.size == 0)
        self iprintln("_encstr_8EF71A569CF0DA4A63AB091D65109E7318B9EB8A83C797FB481349A0");
      else {
        level.respawn_in_progress = 1;
        scriptable_autouse_funcs();
        scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(self.origin, level.players_in_respawn_queue, self);
        var_2 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B8DC0E023FE332168F451E3295531041", self);
        scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_2);
        self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_A20A088EDD77B3031B2A");

        foreach(var_4 in level.players)
        var_4 thread scripts\cp\cp_hud_message::showsplash("_encstr_BAA1108D38D7EA6E5619FAC9956EC10BDDE6", undefined, self);

        level.respawn_in_progress = undefined;
      }

      break;
    case "_encstr_88CD07337F8B2B8083":
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      if(scripts\cp\cp_weapon::_id_124AD(self)) {
        scripts\cp\cp_weapon::minigamefinishcount(self);
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
      break;
    case "_encstr_A3990BDBEF05B561FA5A488BD8":
      var_6 = giveammocrate();

      if(!istrue(var_6))
        return 0;

      break;
    case "_encstr_A937066AFF52FA4F":
      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      if(isDefined(level.ac130_activate_function)) {
        self notify("_encstr_BD0414B9ED5B4795296049E3306B4117D35813388B23");
        var_6 = self[[level.ac130_activate_function]]();

        if(!istrue(var_6))
          return 0;
      }

      break;
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\airstrike::tryuseairstrike("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);
      break;
    case "_encstr_8DDA0D2327EDB995D7DC1D4EB4DACA":
    case "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD":
      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      var_7 = scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredator();

      if(istrue(var_7)) {
        break;
      } else
        return 0;
    case "_encstr_81790C63488F139BAE0D4A5F10B1":
      if(scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\helper_drone::tryusehelperdrone("_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC");
      break;
    case "_encstr_A9C20C93D2BD8ED737D096951B19":
      var_1 = 0;
      self notify("_encstr_83FA25F6CD2BD7EE8547B143AC27F5CCED9CD7272BB5B7B3D2739DAF322B1C63BDBC1689C69537");
      giveriotshield();
      break;
    case "_encstr_8B2F11706B178D79CB05C8591957405FBCE250":
      var_1 = 0;
      self notify("_encstr_83FA25F6CD2BD7EE8547B143AC27F5CCED9CD7272BB5B7B3D2739DAF322B1C63BDBC1689C69537");
      givegrenadelauncher();
      break;
    case "_encstr_A7B606DA83796F4A":
      var_6 = givearmorcrate();

      if(!istrue(var_6))
        return 0;

      break;
    case "_encstr_B18B0B578C23412DAE3A487842":
      var_6 = giveadrenalinecrate();

      if(!istrue(var_6))
        return 0;

      break;
    case "_encstr_88E10CA1B5B18B5BA00FA7788642":
    case "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38":
      var_6 = givehealthcrate();

      if(!istrue(var_6))
        return 0;

      break;
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      if(!istrue(self.bgivensentry))
        scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4");

      break;
    case "_encstr_AB8E0E73E9709BD298E7141D95E8DF43":
    case "_encstr_9B1807D39B48FD93A3":
      if(!istrue(self.bgivensentry))
        scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturret("_encstr_AA060B6EB2731DE4BCFAEC57E6");

      break;
    case "_encstr_851904B59B34":
      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      return scripts\cp_mp\killstreaks\uav::tryuseuav("_encstr_851904B59B34");
    case "_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9":
      var_6 = give_deployable_cover();

      if(!istrue(var_6))
        return 0;

      break;
    case "_encstr_ACD20F4B118BEF03D380F9335815BC7761":
    case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
      if(istrue(level._id_11E8C) || scripts\cp\cp_objectives::is_objective_active("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959") || scripts\cp\cp_objectives::is_objective_active("_encstr_B4430C432023FB09C10841118DBA")) {
        scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\toma_strike::tryusetomastrike();
      break;
    case "_encstr_AC19044DE657":
      thread scripts\cp\equipment\nvg::runnvg();
      break;
    case "_encstr_886B0D58B2B56F2019B79BDBA305EB":
      self giveandfireoffhand("_encstr_92EA0A290B32FF88A90170EB");
      break;
    case "_encstr_A3C10B770DA547567D0E34DBE6":
      scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2");
      break;
  }

  if(var_1)
    thread watcherforremovingdeployable();

  return 1;
}

give_grenade(var_0, var_1) {
  var_2 = scripts\cp\cp_loadout::get_num_of_charges_for_power(self);
  thread scripts\cp\cp_powers::givepower(var_0, var_1, undefined, undefined, undefined, undefined, 1, var_2);
}

can_purchase_item(var_0) {
  var_1 = scripts\cp\cp_persistence::get_player_currency();

  if(var_1 >= var_0)
    return 1;

  return 0;
}

watcherforremovingdeployable() {
  self notify("_encstr_83FA25F6CD2BD7EE8547B143AC27F5CCED9CD7272BB5B7B3D2739DAF322B1C63BDBC1689C69537");
  self endon("_encstr_83FA25F6CD2BD7EE8547B143AC27F5CCED9CD7272BB5B7B3D2739DAF322B1C63BDBC1689C69537");

  for(;;) {
    self waittill("_encstr_B66E184ECAADDED9ACEB8537E5F5856C3A5A3B59D796D156AD9B");

    if(isDefined(self.last_weapon)) {
      var_0 = scripts\cp\utility::getweapontoswitchbackto();
      self switchtoweapon(var_0);
      self.last_weapon = undefined;
      scripts\cp\utility::clearlowermessage("_encstr_955C0D027B87EB67B9A92237BBE86B");
    }
  }
}

givearmorcrate() {
  return scorerequiresbanking("_encstr_B4E9147053F0F70EFB580FA689A0BB721C4F3B7918E1");
}

giveadrenalinecrate() {
  return scorerequiresbanking("_encstr_9508192DEE707DB0239CB273851B2DDCCAF5B658C9DA9539D7B1C1");
}

givehealthcrate() {
  return scorerequiresbanking("_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B");
}

giveammocrate() {
  return scorerequiresbanking("_encstr_826813691C902EB9B0A5507FFF574ABB61A2B1EBA3");
}

scorerequiresbanking(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self giveandfireoffhand(var_0);
  var_1 = scripts\engine\utility::_id_143AE("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_9A630C851C886BC33D8221E3EEB1");

  if(var_1 == "_encstr_9A630C851C886BC33D8221E3EEB1")
    return undefined;

  return 1;
}

scriptable_autouse_funcs() {
  self.tispawnposition = self.origin;
  self giveandfireoffhand("_encstr_B635099C3C8FEDFB88E9EB");
}

_id_12C8B(var_0) {
  var_0 hide();

  if(!isDefined(self.tispawnposition))
    return 0;

  if(scripts\cp\utility::touchingbadtrigger())
    return 0;

  var_1 = self.tispawnposition + (0, 0, 16);
  var_2 = self.tispawnposition - (0, 0, 2048);
  var_3 = [];
  var_3[0] = self;
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_5 = scripts\engine\trace::ray_trace_detail(var_1, var_2, var_3, var_4, 0);
  var_6 = var_5["_encstr_820E07FAE8780B3A4C"];
  var_7 = var_5["_encstr_BD260953AA97E3F014279D"] + var_6 * (0, 0, 1);
  var_8 = anglesToForward(self.angles);
  var_9 = -1 * var_6;
  var_10 = scripts\engine\utility::flatten_vector(var_8, var_6);
  var_11 = vectorcross(var_10, var_9);
  var_12 = axistoangles(var_9, var_11, var_10);
  var_13 = self.angles;
  var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_14.angles = var_12;
  var_14.owner = self;
  var_14 setModel("_encstr_84651645934BAFC9F778F96298337A4FA385D9C33A96E74A");
  var_14 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_930B07BB1B6B3854FF", 0);
  var_14.set_backup_location = var_0;
  var_14 thread _id_14316(10);
  var_15 = "_encstr_843A1B8CB9A8BE3971130317732F93D748E006D291D16A52563947774D";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_14.minimapid = var_14[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]](var_15, self.team, 1, 1, 0);

  var_16 = var_14 getentitynumber();
  level._id_13A10[var_16] = var_14;
  return 1;
}

_id_14316(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  thread tacinsert_destroy(1);
}

tacinsert_destroy(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  self.isdestroyed = 1;

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.minimapid);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self makeunusable();

  if(isDefined(self.set_backup_location))
    self.set_backup_location delete();

  self notify("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(istrue(var_0)) {
    self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
    self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  }

  thread tacinsert_delayeddelete();
}

tacinsert_delayeddelete() {
  wait 1;
  self delete();
}

_id_12C8C(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = "_encstr_9B07158D837DDCAB38CA9C7DE495EC96B3597DD5B9CA19";
  var_2 = [];

  foreach(var_4 in level.players) {
    if(istrue(var_4.inlaststand) && !istrue(var_4.clear_prev_goal)) {
      var_4 scripts\cp\cp_laststand::instant_revive(var_4);
      scripts\cp\cp_armor::givearmor(var_4, 100, 1);
    } else if(istrue(var_4.clear_prev_goal) || isDefined(var_4.last_stand_state) && istrue(var_4.last_stand_state == "_encstr_8FE20AD2903BB77B0E68ADA4"))
      var_2[var_2.size] = var_4;

    var_4 thread scripts\cp\cp_hud_message::showsplash(var_1, undefined, var_0);
  }

  if(var_2.size > 0) {
    wait 5;

    foreach(var_4 in var_2) {
      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 notify("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        scripts\cp\cp_armor::givearmor(var_4, 100, 1);
      }
    }
  }
}

giveriotshield() {
  self.riot_shield_damage = 1000;
  self.last_weapon = self getcurrentweapon();

  if(!istrue(self.has_riot_shield)) {
    var_0 = "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1";
    var_1 = getcompleteweaponname(var_0);
    scripts\cp\utility::_giveweapon(var_1);
    scripts\cp\cp_weapons::switchtoweaponreliable(var_1);
    self.has_riot_shield = 1;
    thread remove_at_shield_death(var_0, 0);
  }

  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_A9C20C93D2BD8ED737D096951B19");
}

remove_at_shield_death(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = undefined;
  var_3 = self getweaponslist("_encstr_BA7F0830B3A7859B60B0");

  foreach(var_5 in var_3) {
    if(var_5.basename == var_0) {
      var_2 = var_5;
      break;
    }
  }

  if(isDefined(var_2)) {
    while(self.riot_shield_damage > var_1)
      waitframe();

    self.riot_shield_broken = 1;

    if(isDefined(self.riotshieldmodel))
      scripts\cp\utility::riotshield_detach(1);
    else if(isDefined(self.riotshieldmodelstowed))
      scripts\cp\utility::riotshield_detach(0);

    wait 1;
    self takeweapon(var_2);
    self switchtoweapon(self.last_weapon);
    self.has_riot_shield = undefined;
    self.riot_shield_broken = undefined;
  }
}

givegrenadelauncher() {
  self.last_weapon = self getcurrentweapon();

  if(istrue(self.has_gl)) {
    var_0 = self.equippedweapons;

    foreach(var_2 in var_0) {
      if(var_2.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
        var_3 = weaponclipsize(var_2);
        self setweaponammoclip(var_2, var_3);
      }
    }
  } else {
    var_5 = "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0";
    var_2 = scripts\cp\cp_weapon::buildweapon(var_5);
    self giveweapon(var_2);
    var_3 = weaponclipsize(var_2);
    self setweaponammoclip(var_2, var_3);
    self setweaponammostock(var_2, 0);
    self switchtoweapon(var_2);
    self.has_gl = 1;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_weapon_pickup(0);
    thread remove_at_ammo_count(var_2.basename, 0);
  }

  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_8B2F11706B178D79CB05C8591957405FBCE250");
}

remove_at_ammo_count(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_82670F7715C9CBB7A829F397FF6F4BB541");
  var_2 = undefined;
  var_3 = self getweaponslist("_encstr_BA7F0830B3A7859B60B0");

  foreach(var_5 in var_3) {
    if(var_5.basename == var_0) {
      var_2 = var_5;
      break;
    }
  }

  if(isDefined(var_2)) {
    for(;;) {
      var_7 = self getammocount(var_2);

      if(var_7 <= var_1) {
        break;
      }

      waitframe();
    }

    scripts\common\utility::allow_weapon_switch(1);
    scripts\common\utility::allow_weapon_pickup(1);
    self takeweapon(var_2);
    var_8 = scripts\cp\utility::getweapontoswitchbackto();
    var_9 = thread scripts\cp\cp_weapons::switchtoweaponreliable(var_8, 0);
    self.has_gl = undefined;
    self notify("_encstr_82670F7715C9CBB7A829F397FF6F4BB541");
  }
}

give_deployable_cover() {
  if(self isthrowinggrenade()) {
    return;
  }
  var_0 = "_encstr_B80E0DD3FF027E48DD5E7582AF27A8";
  self._id_12879 = self getcurrentweapon();
  self giveweapon(var_0);
  self switchtoweapon(var_0);
  self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_81E10A4B8F483EAB573B2AE3");
  self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
    self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
    self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
  }

  scripts\common\utility::allow_melee(0);
  var_1 = fire_deployable_cover();

  if(istrue(var_1))
    return 1;
  else
    scripts\common\utility::allow_melee(1);

  return undefined;
}

laststandoutlineid() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9");
  self endon("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32");
  self endon("_encstr_AACC12E885C6FAD87B9DAC9CEBCD830BEEE65691");
  self waittill("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");
  waitframe();
  scripts\common\utility::allow_melee(1);
  scripts\cp\powers\cp_tactical_cover::_id_139F3();
}

fire_deployable_cover() {
  self endon("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = scripts\cp\cp_weapon::waittill_grenade_fire();

  if(isDefined(var_0.weapon_name) && var_0.weapon_name == "_encstr_B80E0DD3FF027E48DD5E7582AF27A8") {
    var_1 = scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired_super();

    if(istrue(var_1)) {
      thread scripts\cp\powers\cp_tactical_cover::tac_cover_used(var_0);
      scripts\common\utility::allow_melee(1);

      foreach(var_3 in level.players)
      var_3 thread scripts\cp\cp_hud_message::showsplash("_encstr_86FA198DC1F55D9B9523FA91B21CD87B971613D8CA7DD8BDB3B293", undefined, self);

      self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9");
      return 1;
    }
  }

  self notify("_encstr_88361491F9C0A8106BDFB027C56A9B092052C1F39B9A");
  return undefined;
}

give_health_pack(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 forceplaygestureviewmodel("_encstr_8582139D2BDCEB56C5D52D38AFB9589BDBB91ABD8E");
  wait(var_0 getgestureanimlength("_encstr_8582139D2BDCEB56C5D52D38AFB9589BDBB91ABD8E"));
  var_0 thread playfxonplayer();
  var_0.health = int(min(var_0.health + var_1, var_0.maxhealth));

  if(getdvarint("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0) == 1)
    scripts\cp\utility::set_current_health_regen_segment(var_0, scripts\cp\utility::find_new_health_regen_segment_ceiling(var_0));
}

playfxonplayer() {
  var_0 = spawnfxforclient(level._effect["_encstr_88131633B8B9F4DB7108B2EE0E1F21818158AFC320B33522"], self gettagorigin("_encstr_A130084D2FDAD8AA8F62"), self);
  triggerfx(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8D820B49520F0EC02DDE6367EC", self getgestureanimlength("_encstr_8582139D2BDCEB56C5D52D38AFB9589BDBB91ABD8E") + 2);
  var_0 delete();
}

spendcraftedmaterials(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_9BC806E72F38AFE8");
  var_2 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_ABF605EEBD7B32");
  var_3 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_AB440A3180D0C0109B17550B");
  var_4 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_A9F60584641BF3");
  var_5 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_A31308CAF7CB53920EF7");
  var_6 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_97780C6DCA22C6DAA9AFA028D8D8");
  var_7 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_93470D3253AB8A9B90CB9EFD29E3E9");
  var_8 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_8C7F097F887897DBC9BB57");
  var_9 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_9B1807D39B48FD93A3");
  var_10 = self getplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_ACC906C827ED7356");
  var_11 = decrease_material_amount(var_1, var_0.metal);
  var_12 = decrease_material_amount(var_2, var_0.wood);
  var_13 = decrease_material_amount(var_3, var_0.explosive);
  var_14 = decrease_material_amount(var_4, var_0.wire);
  var_15 = decrease_material_amount(var_5, var_0.battery);
  var_16 = decrease_material_amount(var_6, var_0.emradiation);
  var_17 = decrease_material_amount(var_7, var_0.circuitboard);
  var_18 = decrease_material_amount(var_8, var_0.colordye);
  var_19 = decrease_material_amount(var_9, var_0.sentry, 1);
  var_20 = decrease_material_amount(var_10, var_0.drone, 1);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_9BC806E72F38AFE8", var_11);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_ABF605EEBD7B32", var_12);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_AB440A3180D0C0109B17550B", var_13);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_A9F60584641BF3", var_14);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_A31308CAF7CB53920EF7", var_15);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_97780C6DCA22C6DAA9AFA028D8D8", var_16);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_93470D3253AB8A9B90CB9EFD29E3E9", var_17);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_8C7F097F887897DBC9BB57", var_18);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_9B1807D39B48FD93A3", var_19);
  self setplayerdata("_encstr_850703B7D9", "_encstr_A5C814C998486F2D436F69D577F2AB492C1B346BBFCB", "_encstr_ACC906C827ED7356", var_20);
  self.personalcraftingmaterialslist["_encstr_9BC806E72F38AFE8"] = var_11;
  self.personalcraftingmaterialslist["_encstr_ABF605EEBD7B32"] = var_12;
  self.personalcraftingmaterialslist["_encstr_AB440A3180D0C0109B17550B"] = var_13;
  self.personalcraftingmaterialslist["_encstr_A9F60584641BF3"] = var_14;
  self.personalcraftingmaterialslist["_encstr_A31308CAF7CB53920EF7"] = var_15;
  self.personalcraftingmaterialslist["_encstr_97780C6DCA22C6DAA9AFA028D8D8"] = var_16;
  self.personalcraftingmaterialslist["_encstr_93470D3253AB8A9B90CB9EFD29E3E9"] = var_17;
  self.personalcraftingmaterialslist["_encstr_8C7F097F887897DBC9BB57"] = var_18;
  self.personalcraftingmaterialslist["_encstr_9B1807D39B48FD93A3"] = var_19;
  self.personalcraftingmaterialslist["_encstr_ACC906C827ED7356"] = var_20;
}

getuniquematerialscost(var_0) {
  if(level.crafting_table_data[var_0].wood > 0)
    return level.crafting_table_data[var_0].wood;
  else if(level.crafting_table_data[var_0].explosive > 0)
    return level.crafting_table_data[var_0].explosive;
  else if(level.crafting_table_data[var_0].wire > 0)
    return level.crafting_table_data[var_0].wire;
  else if(level.crafting_table_data[var_0].battery > 0)
    return level.crafting_table_data[var_0].battery;
  else if(level.crafting_table_data[var_0].emradiation > 0)
    return level.crafting_table_data[var_0].emradiation;
  else if(level.crafting_table_data[var_0].circuitboard > 0)
    return level.crafting_table_data[var_0].circuitboard;
  else if(level.crafting_table_data[var_0].colordye > 0)
    return level.crafting_table_data[var_0].colordye;
  else if(level.crafting_table_data[var_0].sentry > 0)
    return level.crafting_table_data[var_0].sentry;
  else if(level.crafting_table_data[var_0].drone > 0)
    return level.crafting_table_data[var_0].drone;
}

decrease_material_amount(var_0, var_1, var_2) {
  if(var_1 > 1 && !isDefined(var_2))
    var_1 = var_1 - self.perk_data["_encstr_932916FF506F3817571253396AD34398078F257BC3D4F8D5"];

  var_3 = var_0 - var_1;
  return var_3;
}

init() {
  level.carepackagedropnodes = getEntArray("_encstr_8264161B5839AC07586CD6C2ECCAF51939DB1CEB0BE495C2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  initkillstreak();
  initheli();
  initcratedata();
}

drop_marker_after_time() {
  var_0 = 30;

  while(var_0 >= 0) {
    iprintln("_encstr_AA8F2D272713EF23588768288A61F16FFB96851D96FBABEB38BA384877B6516BC26E71905EA21F330CD260705AEEA3" + var_0);
    var_0--;
    wait 1;
  }

  var_1 = level.players[0];
  var_2 = var_1.origin + (0, 0, 666);
  var_3 = var_1.angles;
  airdropvisualmarkeractivate(var_1.origin);
  thread dropkillstreakcratefromscriptedheli(var_1, var_1.team, "_encstr_A31207CBF788523281", var_2, var_1.angles, var_1.origin);
}

initkillstreak() {}

initheli() {
  level.littlebirds = [];
  level.heliconfigs = [];
  var_0 = "_encstr_BA67082278D537E3C827";
  var_1 = spawnStruct();
  var_1.canbedamaged = 1;
  var_1.maxhealth = 500;
  var_1.hitstokill = 3;
  var_1.vodestroyed = "_encstr_8254149193BDB92B19C97B38FA8C569BA3937B97B2C8";
  var_1.callout = "_encstr_85131AA2179204181B5B8783B7CF4BA2F8439A3C390752F0BB152A38";
  var_1.enginevfxtag = "_encstr_BE48103A2C3BFA95733B4BE62BD7B1CA333A";
  level.heliconfigs[var_0] = var_1;
}

initcratedata() {
  var_0 = spawnStruct();
  var_0.configs = [];
  var_0.crates = [];
  var_0.usablecrates = [];
  level.cratedata = var_0;
  level.mpplayerallowcrateuse = scripts\common\utility::allow_crate_use;
  level.cratedata.mountmantlemodel = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  initcratedropdata();
  thread watchallcrateusability();
}

getleveldata(var_0) {
  var_1 = level.cratedata.configs[var_0];

  if(!isDefined(var_1)) {
    var_1 = getemptyleveldata();
    level.cratedata.configs[var_0] = var_1;
  }

  return var_1;
}

getemptyleveldata() {
  var_0 = spawnStruct();
  var_0.friendlymodel = "_encstr_9BBA2105BB0834A3C7331379F92F63EF4013839BC3287F47574389F2E373776538E121";
  var_0.enemymodel = "_encstr_9A531E68A4212F8B4ED3F7572FB12B1A9A7BAA287BF753FFD237518806EF9AA3";
  var_0.dummymodel = "_encstr_99861EB55AC6A5A32C9CE5BED88593AC1C0B36B6583BB2FA81137D23BA6B6B5E";
  var_0.mountmantlemodel = getdefaultmountmantlemodel();
  var_0.objweapon = isundefinedweapon();
  var_0.timeout = 90;
  var_0.headiconoffset = 0;
  var_0.minimapicon = "_encstr_83372430F717B8CFBA3C68E31552D9C644DB7880778FB36BA2A4D7FC6FE9CDABA13FF848FB51";
  var_0.usetag = "_encstr_BA300854E318F1FF9699";
  var_0.userange = 128;
  var_0.usefov = 360;
  var_0.usepriority = -10000;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 1.0;
  var_0.navobstaclebounds = (30, 10, 64);
  var_0.navobstacleupdatedistsqr = 64;
  var_0.dangerzoneheight = 1000;
  var_0.dangerzoneradius = 200;
  var_0.activatecallback = undefined;
  var_0.deactivatecallback = undefined;
  var_0.capturecallback = undefined;
  var_0.rerollcallback = undefined;
  var_0.destroycallback = undefined;
  var_0.destroyoncapture = 1;
  var_0.onecaptureperplayer = 0;
  var_0.destroyvisualscallback = getdefaultdestroyvisualscallback();
  var_0.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  var_0.capturevisualscallback = getdefaultcapturevisualscallback();
  var_0.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  var_0.capturestring = &"_encstr_84621F6383AC13CAB1815810A15731FBE498E4F318152306E901E1F9A94F7CC77F";
  var_0.rerollstring = &"_encstr_BA5B1DB49262984D2A92150AD2A97D1229E42AD479AA05B2AF29A229F48962";
  var_0.headicon = "_encstr_B22914319F20C51FD203815A68B3E77D807FB7952D98";
  var_0.supportsreroll = 0;
  var_0.supportsownercapture = 1;
  var_0.supportsothercapture = 1;
  return var_0;
}

createcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = getleveldata(var_2);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_9.angles = var_4;

  if(var_9 scripts\cp\utility::touchingbadtrigger()) {
    var_9 delete();
    var_0 notify("_encstr_B29C1531DADF6068171799E7513F60B5D3016BF81227A6");
    return undefined;
  }

  var_9.owner = var_0;
  var_9.team = var_1;
  var_9.objweapon = var_8.objweapon;
  var_9.cratetype = var_2;
  var_9.useobject = undefined;
  var_9.navobstacle = undefined;
  var_9.headiconid = undefined;
  var_9.minimapid = undefined;
  var_9.dangerzoneid = undefined;
  var_9.navobstacleid = undefined;
  var_9.destination = var_5;
  var_9.headiconactive = 0;
  var_9.minimapiconactive = 0;
  var_9.physicsactivated = 0;
  var_9.isdestroyed = 0;
  var_9.data = var_7;
  var_9.headicon = var_8.headicon;
  var_9.minimapicon = var_8.minimapicon;
  var_9.capturestring = var_8.capturestring;
  var_9.rerollstring = var_8.rerollstring;
  var_9.supportsreroll = var_8.supportsreroll;
  var_9 setModel(var_8.dummymodel);
  var_9 setnodeploy(1);
  var_9 setCanDamage(0);
  var_9 makeunusable();
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_10.angles = var_4;
  var_10.crate = var_9;
  var_10 setModel(var_8.friendlymodel);
  var_10 linkTo(var_9);
  var_9.friendlymodel = var_10;
  var_11 = undefined;

  if(isDefined(var_8.enemymodel)) {
    if(level.teambased) {} else {}

    var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_11.angles = var_4;
    var_11.cratedata = var_9;
    var_11 setModel(var_8.enemymodel);
    var_11 linkTo(var_9);
  }

  var_9.enemymodel = var_11;

  if(isDefined(var_9.enemymodel))
    var_9 thread watchvisibility();

  var_12 = undefined;
  var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3 + (0, 0, 300));
  var_12 setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");

  if(isDefined(self.scenenode)) {
    if(var_6)
      var_12 thread looselinkTo(var_9, (0, 0, 0));
    else
      var_12 linkTo(var_9);
  }

  var_9.killcament = var_12;
  var_9 addtolists();
  var_9 thread watchcratedestroyearly();

  if(var_6)
    var_9 activatecratephysics(::activatecratefirsttime, "_encstr_83030E85D8A35AD958E8953439B01D56");

  return var_9;
}

activatecratefirsttime() {
  activatecrate(1);
}

activatecrate(var_0) {
  self notify("_encstr_83030E85D8A35AD958E8953439B01D56");
  deactivatecratephysics();

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  createmountmantlemodel();

  if(istrue(var_0))
    createminimapicon();

  outline_crate_in_hud();

  if(isDefined(level.nuclear_crate_interaction))
    self.crate_interaction = [[level.nuclear_crate_interaction]](self);

  level.nuclear_crate = self.crate_interaction;
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.activatecallback))
    self thread[[var_1.activatecallback]](var_0);
}

deactivatecrate(var_0) {
  if(!istrue(var_0))
    activatecratephysics(::activatecrate, "_encstr_83030E85D8A35AD958E8953439B01D56");

  _destroynavobstacle();
  destroymountmantlemodel();

  if(istrue(var_0))
    destroyminimapicon();

  _destroyheadicon();
  makecrateunusable();
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.deactivatecallback))
    self thread[[var_1.deactivatecallback]](var_0);
}

capturecrate(var_0) {
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.capturecallback))
    self thread[[var_1.capturecallback]](var_0);

  if(var_1.destroyoncapture) {
    var_2 = 0;

    if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel))
        self thread[[var_1.capturevisualscallback]](self.enemymodel);

      var_2 = var_1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var_2);
  }
}

destroycrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  if(!isDefined(var_0) && isDefined(self.scenenode)) {
    self.destroyonactivate = 1;
    return;
  }

  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.destroycallback))
    self thread[[var_1.destroycallback]](var_0);

  var_2 = 0;

  if(!istrue(var_0)) {
    if(self.physicsactivated) {
      if(isDefined(var_1.destroyvisualscallback)) {
        self thread[[var_1.destroyvisualscallback]](self.friendlymodel);

        if(isDefined(self.enemymodel))
          self thread[[var_1.destroyvisualscallback]](self.enemymodel);

        var_2 = var_1.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel))
        self thread[[var_1.capturevisualscallback]](self.enemymodel);

      var_2 = var_1.capturevisualsdeletiondelay;
    }
  }

  thread deletecrate(var_2);
}

deletecrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  if(isDefined(self.owner))
    self.owner notify("_encstr_B29C1531DADF6068171799E7513F60B5D3016BF81227A6");

  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.crate = undefined;
    self.scenenode = undefined;
  }

  removefromlists(self getentitynumber());
  self setCanDamage(0);
  self setnonstick(1);
  self hide();
  makecrateunusable();

  if(isDefined(self.useobject))
    self.useobject delete();

  destroydangerzone();
  _destroynavobstacle();
  destroymountmantlemodel();

  if(self.physicsactivated) {
    self physicsstopserver();
    self physics_unregisterforcollisioncallback();
  }

  self.unresolved_collision_func = undefined;
  destroyminimapicon();
  _destroyheadicon();

  if(isDefined(self.killcament))
    self.killcament delete();

  wait(var_0);

  if(isDefined(self.friendlymodel))
    self.friendlymodel delete();

  if(isDefined(self.enemymodel))
    self.enemymodel delete();

  self delete();
}

watchcratedestroyearly() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.timeout)) {}

  watchcratedestroyearlyinternal();
  thread destroycrate();
}

watchcratedestroyearlyinternal(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner)) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  else if(isDefined(self.owner))
    self.owner waittill("_encstr_B29C1531DADF6068171799E7513F60B5D3016BF81227A6");
  else
    level waittill("_encstr_BACC0FDF770D70BD87435179196F6058E7");
}

initcratedropdata() {
  var_0 = spawnStruct();
  var_0.helis = [];
  var_1 = getEnt("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1))
    var_0.heliheight = var_1.origin[2];
  else
    var_0.heliheight = 850;

  var_0.heliheightoffset = 128;
  level.cratedropdata = var_0;
  initscriptedhelidropdata();
}

initscriptedhelidropdata() {
  initscriptedhelidropanims();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

initscriptedhelidropanims() {
  level.scr_animtree["_encstr_BAE50DE60E739BA638C72068AF47B9"] = #animtree;
  level.scr_anim["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = % _encstr_96481ACB13F8792333494A31676D873F9FDF9B62A37F2924B81B7860;
  level.scr_animname["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = "_encstr_96481ACB13F8792333494A31676D873F9FDF9B62A37F2924B81B7860";
  level.scr_animtree["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"] = #animtree;
  level.scr_anim["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = % _encstr_9AB41FB607BE8D85E42B0EC21BDA16CE95AF83C2390B1B0DEA4756BE998D2FD2B9;
  level.scr_animname["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = "_encstr_9AB41FB607BE8D85E42B0EC21BDA16CE95AF83C2390B1B0DEA4756BE998D2FD2B9";
  initscriptedhelidropvehicleanims();
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

initscriptedhelidropvehicleanims() {
  level.scr_animtree["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"] = #animtree;
  level.scr_anim["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"] = % _encstr_A69E1C75CFF7F3D6C3874F2F779A41B725F69BFA9B2023AA1749384A2D70;
}

watchdropcratefrommanualheliinternal() {
  if(self.hasowner) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.heli setvehgoalpos(self.dropposition, 1);
  self.heli scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 2);

  if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
    thread docratedropfrommanualheli();
    return;
  }

  self.heli setyawspeed(40, 20, 20, 0.3);

  if(distancesquared(self.heli.origin, self.dropposition) > 5184) {
    self.heli scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8B7205D9ED5958");

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      thread docratedropfrommanualheli();
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.25);

    if(isDefined(self.crate) && !istrue(self.crate.isdestroyed))
      thread docratedropfrommanualheli();

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }
    self.heli scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.5);

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }
    if(distancesquared(self.heli.origin, self.exitposition) > 5184) {
      self.heli vehicle_setspeed(50, 30);
      self.heli setvehgoalpos(self.exitposition, 1);
      self.heli scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8B7205D9ED5958");
    }
  }
}

docratedropfrommanualheli() {
  var_0 = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  var_0 thread activatecratephysics(::activatecratefirsttime, "_encstr_85AD0950914BBF136ACB7F");
}

dropcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getcratedropcaststart(var_3, 1);
  var_8 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = getcratedropdestination(var_7, getcratedropcastend(var_7, 1));

    if(!isDefined(var_5))
      return undefined;
  }

  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_9.angles = var_8;
  var_9 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_9.owner = var_0;
  var_9.team = var_1;
  var_9.hasowner = isDefined(var_0);
  var_10 = createheli(var_0, var_1, var_7, var_8);
  var_10.scenenode = var_10;
  var_10 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  var_10.animname = "_encstr_88F312368593CABEC1B08DB6583BACD734591B4B";
  var_9.heli = var_10;
  var_9.heliendtime = gettime() + getanimlength(level.scr_anim["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"]) * 1000;
  var_9.latestendtime = var_9.heliendtime;
  var_11 = createcrate(var_0, var_1, var_2, var_7, var_8, var_5, 0, var_6);
  var_11.angles = var_8;
  var_11.scenenode = var_9;
  var_11.friendlymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);

  if(isDefined(var_11.enemymodel))
    var_11.enemymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);

  var_11.animname = "_encstr_BAE50DE60E739BA638C72068AF47B9";
  var_11 scripts\common\anim::setanimtree();
  var_12 = level.scr_anim["_encstr_BAE50DE60E739BA638C72068AF47B9"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"];
  var_13 = getanimlength(var_12) * 1000;
  var_14 = getnotetracktimes(var_12, "_encstr_865911769EE30BB3D93FF0A807F56EB14B8577")[0] * var_13;
  var_15 = getnotetracktimes(var_12, "_encstr_8D9916AE06039019B1FEF07BEF65D9FBB5B929D23FCF200D")[0] * var_13;
  var_9.crate = var_11;
  var_9.cratedroptime = gettime() + var_14;
  var_9.cratestoptrailtime = gettime() + var_15;
  var_9.crateendtime = gettime() + var_13;
  var_9.latestendtime = scripts\engine\utility::ter_op(var_9.crateendtime > var_9.latestendtime, var_9.crateendtime, var_9.latestendtime);
  var_16 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_16.angles = var_8;
  var_16.scenenode = var_9;
  var_16 setModel("_encstr_84041096733396D8BE38C2C9166CD0AB1DCA");
  var_16 hide();
  var_16.animname = "_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21";
  var_16 scripts\common\anim::setanimtree();
  var_9.chute = var_16;
  var_9.chuteendtime = gettime() + getanimlength(level.scr_anim["_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"]) * 1000;
  var_9.latestendtime = scripts\engine\utility::ter_op(var_9.chuteendtime > var_9.latestendtime, var_9.chuteendtime, var_9.latestendtime);
  var_9 thread watchdropcratefromscriptedheli();
  return var_9;
}

watchdropcratefromscriptedheli() {
  self endon("_encstr_AD75063D571AE108");
  scripts\common\anim::anim_first_frame_solo(self.heli, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
  scripts\common\anim::anim_first_frame_solo(self.crate, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
  scripts\common\anim::anim_first_frame_solo(self.chute, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli))
    self.heli thread destroyheli();

  if(isDefined(self.crate))
    self.crate thread destroycrate();

  if(isDefined(self.chute))
    self.chute thread destroychute();

  self delete();
}

watchdropcratefromscriptedheliinternal() {
  var_0 = undefined;

  while(gettime() <= self.latestendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team)
              self.ownerjoinedteam = 1;
          }
        } else
          self.ownerdisconnected = 1;
      }
    }

    if(!isDefined(var_0))
      var_0 = 1;
    else if(var_0) {
      if(isDefined(self.heli)) {
        self.heli setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
        self.heli setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_930B07BB1B6B3854FF", 1);
        thread scripts\common\anim::anim_single_solo(self.heli, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
      }

      if(isDefined(self.crate)) {
        self.crate.friendlymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

        if(isDefined(self.crate.enemymodel))
          self.crate.enemymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

        thread scripts\common\anim::anim_single_solo(self.crate, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
      }

      if(isDefined(self.chute)) {
        self.chute show();
        thread scripts\common\anim::anim_single_solo(self.chute, "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");
      }

      var_0 = 0;
    } else {
      var_1 = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);
      var_2 = gettime() > self.cratedroptime;
      var_3 = gettime() > self.cratestoptrailtime;

      if(isDefined(self.heli)) {
        var_4 = gettime() > self.heliendtime;

        if(var_1 || var_4)
          self.heli destroyheli();
      }

      if(isDefined(self.crate)) {
        var_4 = gettime() > self.crateendtime;

        if(var_4)
          thread docratedropfromscriptedheli();
        else if(var_2) {
          if(var_3) {
            self.crate.friendlymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 1);

            if(isDefined(self.crate.enemymodel))
              self.crate.enemymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 1);
          } else {
            self.crate.friendlymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 1);

            if(isDefined(self.crate.enemymodel))
              self.crate.enemymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 1);
          }

          if(var_1)
            self.crate thread destroycrate();
        } else if(var_1)
          self.crate thread destroycrate();
        else if(!isDefined(self.heli) || istrue(self.heli.isdestroyed))
          thread docratedropfromscriptedheli();
      }

      if(isDefined(self.chute)) {
        var_4 = gettime() > self.chuteendtime;

        if(var_4)
          self.chute thread destroychute();
        else if(!var_2 && !isDefined(self.crate))
          self.chute thread destroychute();
      }
    }

    waitframe();
  }
}

docratedropfromscriptedheli() {
  var_0 = self.crate;
  self.crate.scenenode = undefined;
  self.crate = undefined;
  var_0 stopanimScripted();
  var_0 activatecratephysics(::activatecratefirsttime, "_encstr_85AD0950914BBF136ACB7F");
}

destroychute() {
  if(isDefined(self.scenenode))
    self.scenenode.chute = undefined;

  self delete();
}

getcratedropcaststart(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1))
    var_2 = var_0 * (1, 1, 1) + (0, 0, getscriptedhelidropheight());
  else
    var_2 = var_0 + (0, 0, 25);

  return var_2;
}

getcratedropcastend(var_0, var_1) {
  return var_0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var_1), 8000, 8000));
}

getcratedropdestination(var_0, var_1) {
  var_2 = undefined;
  var_3 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_4 = scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
  var_5 = physics_raycast(var_0, var_1, var_3, var_4, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_5) && var_5.size > 0)
    var_2 = var_5[0]["_encstr_BD260953AA97E3F014279D"];

  return var_2;
}

createheli(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_0) && isPlayer(var_0))
    var_4 = spawnhelicopter(var_0, var_2, var_3, "_encstr_82930F3B09E0FF8A23751B4BA7579135C8", "_encstr_8E6717B31078F217FA1874BF7EEBAA59C9920B76FC7D014D98");
  else
    var_4 = spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, "_encstr_82930F3B09E0FF8A23751B4BA7579135C8", "_encstr_8E6717B31078F217FA1874BF7EEBAA59C9920B76FC7D014D98");

  if(!isDefined(var_4))
    return undefined;

  if(isDefined(var_1))
    var_4 setvehicleteam(var_1);

  var_5 = level.heliconfigs["_encstr_BA67082278D537E3C827"];
  var_4.owner = var_0;
  var_4.team = var_1;
  var_4.health = var_5.maxhealth;
  var_4.helitype = "_encstr_BA67082278D537E3C827";
  var_4 scripts\cp\utility::killstreak_make_vehicle("_encstr_82930F3B09E0FF8A23751B4BA7579135C8", var_5.scorepopup, var_5.vodestroyed, undefined, var_5.callout);
  var_4 scripts\cp\utility::killstreak_set_death_callback("_encstr_82930F3B09E0FF8A23751B4BA7579135C8", ::destroyhelicallback);
  var_4 setCanDamage(0);
  var_4 thread watchhelidestroyearly();
  return var_4;
}

watchhelidestroyearly() {
  self endon("_encstr_AD75063D571AE108");
  watchhelidestroyearlyinternal();
  thread destroyheli();
}

watchhelidestroyearlyinternal() {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner)) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_ABA008615A631510C7EA");
}

destroyheli() {
  thread deleteheli(0);
}

deleteheli(var_0) {
  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait(var_0);
  self delete();
}

destroyhelicallback(var_0) {
  destroyheli();
}

getscriptedhelidropheight() {
  return level.cratedropdata.heliheight + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

addhelidroppingcratetolist(var_0) {
  var_1 = var_0 getentitynumber();
  level.cratedropdata.helis[var_1] = var_0;
}

removehelidroppingcratefromlist(var_0) {
  level.cratedropdata.helis[var_0] = undefined;
}

makecrateusable() {
  var_0 = getleveldata(self.cratetype);
  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(var_0.supportsownercapture && var_0.supportsothercapture) {
    thread watchcrateuse(1);
    var_1 = self.useobject;

    if(!isDefined(var_1)) {
      var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_0.usetag));
      var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_1 linkTo(self);
      var_1 makeunusable();
      self.useobject = var_1;
    }

    thread watchcrateuse(2, var_1);
  } else if(var_0.supportsownercapture)
    thread watchcrateuse(1);
  else
    thread watchcrateuse(2);
}

watchcrateuse(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A32412C07AC7D579C239B98315AD80A697227849");

  if(isDefined(var_1))
    var_1 endon("_encstr_AD75063D571AE108");

  if(var_0 == 1) {
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
    self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  var_2 = getleveldata(self.cratetype);
  var_3 = gettriggerobject(var_1);
  var_3.usetype = var_0;
  var_3 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  var_3 sethinttag(var_2.usetag);
  var_3 sethintdisplayrange(var_2.userange);
  var_3 sethintdisplayfov(var_2.usefov);
  var_3 setuserange(var_2.userange);
  var_3 setusefov(var_2.usefov);
  var_3 setusepriority(var_2.usepriority);
  var_3 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");

  if(var_3.usetype == 1 && self.supportsreroll)
    var_3 setHintString(self.rerollstring);
  else
    var_3 setHintString(self.capturestring);

  var_3.userate = 1;
  var_3.curprogress = 0;
  var_3.usetime = scripts\engine\utility::ter_op(var_0 == 1, var_2.ownerusetime, var_2.otherusetime);
  var_3.inuse = 0;
  var_3.playerusing = undefined;

  for(;;) {
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(canstartusingcrate(var_4, var_1)) {
      startusingcrate(var_4, var_1);
      var_3.playerusing = var_4;
      var_5 = watchcrateuseinternal(var_4, var_1);

      if(isDefined(var_4))
        stopusingcrate(var_4, var_1);

      var_3.playerusing = undefined;

      if(istrue(var_5)) {
        if(var_2.onecaptureperplayer) {
          if(!isDefined(self.playerscaptured))
            self.playerscaptured = [];

          self.playerscaptured[var_4 getentitynumber()] = var_4;
        }

        thread capturecrate(var_4);
      }
    }
  }
}

watchcrateuseinternal(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype != 1) {
    var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
    var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
    var_0 endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  var_2.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);

  while(cankeepusingcrate(var_0, var_1) && var_0 useButtonPressed()) {
    var_2.curprogress = var_2.curprogress + level.framedurationseconds * var_2.userate;

    if(var_2.curprogress >= var_2.usetime)
      return 1;

    waitframe();
  }

  return 0;
}

makecrateunusable() {
  self notify("_encstr_A32412C07AC7D579C239B98315AD80A697227849");
  level.cratedata.usablecrates[self getentitynumber()] = undefined;
  self.isusable = 0;

  if(isDefined(self.playerusing))
    stopusingcrate(self.playerusing);

  self.playerusing = undefined;
  self makeunusable();

  if(isDefined(self.useobject)) {
    if(isDefined(self.useobject.playerusing))
      stopusingcrate(self.useobject.playerusing, self.useobject);

    self.useobject makeunusable();
  }
}

startusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);
}

stopusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);
}

canstartusingcrate(var_0, var_1, var_2) {
  if(!var_0 scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 isonladder())
    return 0;

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()]))
    return 0;

  if(!self.isusable)
    return 0;

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    return canstartusingcratetriggerobject(var_0, var_1);

  return 1;
}

canstartusingcratetriggerobject(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(isDefined(var_2.playerusing) && var_2.playerusing != var_0)
    return 0;

  if(var_2.usetype == 1 && (!isDefined(self.owner) || var_0 != self.owner))
    return 0;

  return 1;
}

cankeepusingcrate(var_0, var_1) {
  if(!scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 meleeButtonPressed())
    return 0;

  if(!self.isusable)
    return 0;

  return 1;
}

watchallcrateusability() {
  for(;;) {
    foreach(var_1 in level.cratedata.usablecrates) {
      var_1 makeusable();

      if(isDefined(var_1.useobject))
        var_1.useobject makeusable();

      foreach(var_3 in level.players) {
        var_1 enableplayeruse(var_3);

        if(isDefined(var_1.useobject))
          var_1.useobject enableplayeruse(var_3);

        if(!var_1 canstartusingcrate(var_3, var_1.useobject, 0)) {
          var_1 disableplayeruse(var_3);

          if(isDefined(var_1.useobject))
            var_1.useobject disableplayeruse(var_3);

          continue;
        }

        if(!var_1 canstartusingcratetriggerobject(var_3, undefined))
          var_1 disableplayeruse(var_3);

        if(isDefined(var_1.useobject)) {
          if(!var_1 canstartusingcratetriggerobject(var_3, var_1.useobject))
            var_1 disableplayeruse(var_3);
        }
      }
    }

    wait 0.1;
  }
}

gettriggerobject(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0), var_0, self);
}

activatecratephysics(var_0, var_1) {
  stophandlingmovingplatforms();
  self.physicsactivated = 1;
  self.unresolved_collision_func = ::crateunresolvedcollisioncallback;
  self unlink();
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_2 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_2, (0, 0, -1));
  self physics_registerforcollisioncallback();
  self.dangerzoneid = createdangerzone();
  thread watchcrateimpact();
  thread watchcratesettle(var_0, var_1);
}

deactivatecratephysics() {
  handlemovingplatforms();

  if(!self.physicsactivated) {
    return;
  }
  self.physicsactivated = 0;
  self notify("_encstr_AC4317157F32E79371CB0BA06FB3AB1B8BE787ABD04BBB3933");
  self.unresolved_collision_func = undefined;
  self physicsstopserver();
  self physics_unregisterforcollisioncallback();
  destroydangerzone();
}

watchcrateimpact() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AC4317157F32E79371CB0BA06FB3AB1B8BE787ABD04BBB3933");

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_6 > 500)
      playFX(scripts\engine\utility::getfx("_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"), var_4, var_5);
  }
}

watchcratesettle(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_1))
    self endon(var_1);

  watchcratesettleinternal();

  if(scripts\cp\utility::touchingbadtrigger())
    thread destroycrate();

  if(isDefined(var_0))
    self thread[[var_0]]();
}

watchcratesettleinternal() {
  self endon("_encstr_AC4317157F32E79371CB0BA06FB3AB1B8BE787ABD04BBB3933");
  wait 1;
  var_0 = getleveldata(self.cratetype);
  var_1 = gettime() + 10000;

  while(gettime() < var_1) {
    var_2 = self physics_getbodyid(0);
    var_3 = physics_getbodylinvel(var_2);

    if(lengthsquared(var_3) <= 0.5) {
      break;
    }

    waitframe();
  }
}

createdangerzone() {
  destroydangerzone();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;
  self.dangerzoneid = var_1;
  return var_1;
}

spawnuniversaldangerzone(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  self.dangerzoneid = var_4;
  return var_4;
}

destroydangerzone() {
  var_0 = self.dangerzoneid;
  self.dangerzoneid = undefined;
}

_createnavobstacle() {
  self notify("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");
  self endon("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  var_0 = getleveldata(self.cratetype);
  var_1 = createnavobstaclebybounds(self.origin, var_0.navobstaclebounds, self.angles);
  self.navobstacleid = var_1;
  childthread _watchnavobstacle(var_1, self.origin, var_0.navobstacleupdatedistsqr);
  return var_1;
}

_watchnavobstacle(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");

  while(distancesquared(var_1, self.origin) < var_2)
    wait 0.5;

  thread _createnavobstacle();
}

_destroynavobstacle() {
  self notify("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  self.navobstacleid = undefined;
}

createmountmantlemodel() {
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel))
      self.mountmantlemodel delete();

    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    var_1 dontinterpolate();
    var_1.angles = self.angles;
    var_1 clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    var_1 linkTo(self);
    self.mountmantlemodel = var_1;
  }
}

destroymountmantlemodel() {
  if(isDefined(self.mountmantlemodel))
    self.mountmantlemodel delete();

  self.mountmantlemodel = undefined;
}

crateunresolvedcollisioncallback(var_0) {
  var_0 dodamage(1000, var_0.origin, self.owner, self, "_encstr_8D4E0A501FCB898912CB3FA3", self.objweapon);
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isPlayer(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive())
    childthread scripts\cp\cp_movers::unresolved_collision_nearest_node(var_0, undefined, self);
}

_createheadicon() {
  if(isDefined(self.headiconid))
    setheadiconimage(self.headiconid);

  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.headicon)) {
    if(level.teambased && isDefined(self.team)) {} else if(isDefined(self.owner)) {} else {}
  }

  self.headiconid = var_1;
  self.headiconactive = 1;

  foreach(var_3 in level.players) {
    if(var_3 == self.owner) {
      self hudoutlineenableforclient(var_3, "_encstr_810A1ACA3DEBD0CB5857E97411DC16A69FEFE779E4E0E942D35F90BA");
      continue;
    }

    self hudoutlineenableforclient(var_3, "_encstr_847E18A5C56942E140B80307C8389F2A07D5AF1A2DF9C922C958");
  }

  return var_1;
}

outline_crate_in_hud() {
  foreach(var_1 in level.players)
  self hudoutlineenableforclient(var_1, "_encstr_810A1ACA3DEBD0CB5857E97411DC16A69FEFE779E4E0E942D35F90BA");
}

_destroyheadicon() {
  if(isDefined(self.boxiconid))
    thread scripts\cp\utility::ent_deleteheadicon(self, self.boxiconid);

  if(isDefined(self.headiconid))
    setheadiconimage(self.headiconid);

  self hudoutlinedisable();
  self.headiconid = undefined;
  self.headiconactive = 0;
}

createminimapicon() {
  destroyminimapicon();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.minimapicon)) {}

  self.minimapid = var_1;
  self.minimapiconactive = 1;
  return var_1;
}

destroyminimapicon() {
  if(isDefined(self.minimapid))
    scripts\cp\cp_objectives::returnminimapid(self.minimapid);

  self.minimapid = undefined;
  self.minimapiconactive = 0;
}

handlemovingplatforms() {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
  var_0 = spawnStruct();
  var_0.deathoverridecallback = ::onmovingplatformdeath;
  scripts\cp\cp_movers::handle_moving_platforms(var_0);
}

stophandlingmovingplatforms() {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
}

onmovingplatformdeath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  waitframe();
  deactivatecrate();
}

watchvisibility() {
  self endon("_encstr_AD75063D571AE108");

  foreach(var_1 in level.players)
  updatevisibilityforplayer(var_1);

  waitframe();
  childthread watchvisibilityinternal();
}

watchvisibilityinternal() {
  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298", var_0);
    updatevisibilityforplayer(var_0);
  }
}

updatevisibilityforplayer(var_0) {
  self.friendlymodel hidefromplayer(var_0);
  self.enemymodel hidefromplayer(var_0);

  if(var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    self.friendlymodel showtoplayer(var_0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var_0.team == self.team)
      self.friendlymodel showtoplayer(var_0);
    else
      self.enemymodel showtoplayer(var_0);

    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var_0 == self.owner)
      self.friendlymodel showtoplayer(var_0);
    else
      self.enemymodel showtoplayer(var_0);

    return;
  }
}

looselinkTo(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A5820C6DC0A74BE50CC02B370140");
  self endon("_encstr_8DA90F0D38E28E8DFB6180A27978A5556A");

  while(istrue(self.physicsactivated)) {
    self.origin = var_0.origin + var_1;
    waitframe();
  }

  self linkTo(var_0);
}

addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

removefromlists(var_0) {
  if(!isDefined(level.cratedata)) {
    return;
  }
  level.cratedata.crates[var_0] = undefined;
}

getdefaultcapturevisualscallback() {
  return::defaultcapturevisualscallback;
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

getdefaultcapturevisualsdeletiondelay() {
  var_0 = 1;
  return var_0 + getanimlength(%_encstr_9BB1276BC1BED62D36963A85C997FA8D584E56830B1B5BC2D92BFA37A34EB0E037FA992C8DB15AE6EC);
}

#using_animtree("_encstr_B40101");

defaultcapturevisualscallback(var_0) {
  var_0 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_95EB0866891B23FB85B3", 0);
  var_0 setscriptablepartstate("_encstr_95EB0866891B23FB85B3", "_encstr_99AD06D3A5B1538B", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(getanimlength(%_encstr_9BB1276BC1BED62D36963A85C997FA8D584E56830B1B5BC2D92BFA37A34EB0E037FA992C8DB15AE6EC));
  var_0 setscriptablepartstate("_encstr_95EB0866891B23FB85B3", "_encstr_961804BD954A", 0);
}

getdefaultdestroyvisualsdeletiondelay() {
  return 0;
}

getdefaultdestroyvisualscallback() {
  return::defaultdestroyvisualscallback;
}

defaultdestroyvisualscallback(var_0) {}

getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

getcratedatabytype(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.supportsreroll = var_1;
  return var_2;
}

dropkillstreakcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
  var_7 = getcratedatabytype(var_2, 0);
  var_8 = dropcratefromscriptedheli(var_0, var_1, var_6, var_3, var_4, var_5, var_7);

  if(!isDefined(var_8))
    return undefined;
  else if(!isDefined(var_8.crate))
    return undefined;

  return var_8.crate;
}

fauxvehiclecount() {
  return level.fauxvehiclecount;
}

incrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0))
    level.fauxvehiclecount++;
  else
    level.fauxvehiclecount = level.fauxvehiclecount + var_0;
}

decrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0))
    level.fauxvehiclecount--;
  else
    level.fauxvehiclecount = level.fauxvehiclecount - var_0;

  if(level.fauxvehiclecount < 0)
    level.fauxvehiclecount = 0;
}

airdropvisualmarkeractivate(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_1 = var_1 + (0, 0, 1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3 setModel("_encstr_B231139B17092E334F8B5AE1B097FBE460BD371569");
  var_3 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);
  thread delete_model_and_fx_on_crate_drop(var_2, var_3);
}

delete_model_and_fx_on_crate_drop(var_0, var_1) {
  scripts\engine\utility::_id_143A5("_encstr_B29C1531DADF6068171799E7513F60B5D3016BF81227A6", "_encstr_912D0C88C37F03B7D2A6CE5ABFFB");
  var_0 delete();
  var_1 delete();
}

register_care_package_interaction() {
  scripts\cp\cp_interaction::register_interaction("_encstr_96DF194E12B333B97BDF761001EA0FBF8F666DAAA239386B1C859E", "_encstr_A3BA05E0735C50", undefined, ::care_package_hint, ::care_package_activate, 0, 0, undefined);
}

care_package_hint(var_0, var_1) {
  return &"_encstr_85D5248BC0502731077A737EE76B85A7A038F77EAFCD17E8BC58867388DBCD417BEC1704D727";
}

care_package_activate(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1[[var_0.give_loadout_func]]();
  var_0.box thread deletecrate(0.05);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

is_player_care_package_owner(var_0, var_1) {
  if(var_1 == var_0.box.owner)
    return 1;
  else
    return 0;
}

care_package_createinteraction(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";
  var_1.script_noteworthy = "_encstr_96DF194E12B333B97BDF761001EA0FBF8F666DAAA239386B1C859E";
  var_1.requires_power = 0;
  var_1.box = var_0;
  var_1.spend_type = "_encstr_A3BA05E0735C50";
  var_1.cost = 0;
  var_1.give_loadout_func = ::give_updated_loadout;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_0.interaction = var_1;
  return var_0;
}

give_updated_loadout(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1)
  var_0 takeweapon(var_3);

  var_5 = spawnStruct();
  var_6 = var_0 scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var_7 = scripts\cp\cp_loadout::loadout_updateclasscustom(var_5, var_6);
  give_and_switch_to_loadout_weapons(var_0, var_7);
  var_8 = 1;
  var_9 = scripts\cp\cp_loadout::get_grenade_from_struct(var_7.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_9))
    var_9 = "_encstr_81580B52FF3F7F3D195A6A61A7";

  var_10 = scripts\cp\cp_loadout::get_grenade_from_struct(var_7.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_10))
    var_10 = "_encstr_B81D0C38EDBB56C9F599B12CDC34";

  var_11 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");
  var_0 scripts\cp\cp_munitions::reset_munitions(var_0, var_11);
  var_0 thread scripts\cp\cp_powers::givepower(var_9, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, var_8);
  var_0 thread scripts\cp\cp_powers::givepower(var_10, "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, var_8);
}

give_and_switch_to_loadout_weapons(var_0, var_1) {
  var_1.loadoutprimaryobject = var_0 scripts\cp\cp_loadout::give_primary_weapon(var_0, var_1);
  var_1.loadoutsecondaryobject = var_0 scripts\cp\cp_loadout::give_secondary_weapon(var_0, var_1);
  var_0.starting_weapon = var_1.loadoutprimaryobject;
  var_0.default_starting_pistol = var_1.loadoutsecondaryobject;
  var_2 = weaponclipsize(var_1.loadoutprimaryobject);
  var_3 = weaponmaxammo(var_1.loadoutprimaryobject);
  var_0 giveweapon(var_1.loadoutprimaryobject);
  var_0 setweaponammoclip(var_1.loadoutprimaryobject, var_2);
  var_0 setweaponammostock(var_1.loadoutprimaryobject, var_3);
  var_0 switchtoweaponimmediate(var_1.loadoutprimaryobject);
  var_2 = weaponclipsize(var_1.loadoutsecondaryobject);
  var_3 = weaponmaxammo(var_1.loadoutsecondaryobject);
  var_0 giveweapon(var_1.loadoutsecondaryobject);
  var_0 setweaponammoclip(var_1.loadoutsecondaryobject, var_2);
  var_0 setweaponammostock(var_1.loadoutsecondaryobject, var_3);
  var_0 switchtoweaponimmediate(var_1.loadoutsecondaryobject);
}

airdrop_trigger_watcher() {
  level notify("_encstr_A7E7188828602BD3383A87015E40505F45CB68180710267CB550");
  level endon("_encstr_A7E7188828602BD3383A87015E40505F45CB68180710267CB550");
  level.airdrop_requests = 0;

  for(;;) {
    level waittill("_encstr_974219BE68680E2AE5EFFBFFFB1DD26DA8167287E310CDA345A3C3", var_0, var_1, var_2);

    if(is_player_allowed_to_airdrop(var_0)) {
      if(should_allow_airdrop()) {
        var_0.loadout_in_progress = 1;
        airdrop_new_loadout_near_player(var_0);
      } else
        var_0 iprintln("_encstr_B2EE40610AC16BDBD97F29096E23836EEF300E6A7099DB0F7097332A88CB9BB719C2967130FB5627698F0A359F53477A914A0A8A1843CAA283B7ED2D1F5B3F05EB92");

      continue;
    }

    var_0 iprintln("_encstr_9976671EA2B99F61530660133F70FD409F2223A824E5F0A2C9333FEBC5D0A86318FE97E06BA85327C3210E4036C4B27173BE152367E092E5602B533D9A58B9F824E86AC7D7B7BB892618A2B9BA6FEAD837AFC27A071172F1FF626AADF640F94BB721E25B830A583D8D");
  }
}

is_player_allowed_to_airdrop(var_0) {
  if(istrue(var_0.loadout_in_progress))
    return 0;

  return 1;
}

airdrop_new_loadout_near_player(var_0, var_1) {
  var_2 = (0, 0, 0);

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = var_0.origin;

  var_3 = (var_2[0], var_2[1], 1000);
  var_4 = vectortoangles(var_2);

  if(!isDefined(var_0) || !isPlayer(var_0))
    thread dropkillstreakcratefromscriptedheli(var_0, "_encstr_9A8507BA4040188D08", "_encstr_A31207CBF788523281", var_3, var_4, var_2);
  else
    thread dropkillstreakcratefromscriptedheli(var_0, var_0.team, "_encstr_A31207CBF788523281", var_3, var_4, var_2);
}

should_allow_airdrop() {
  var_0 = allow_airdrop_internal();

  if(istrue(var_0))
    return 1;

  return 0;
}

allow_airdrop_internal() {
  var_0 = 0;

  if(!isDefined(level.airdrop_requests))
    level.airdrop_requests = 0;

  if(level.airdrop_requests > 4)
    return 0;

  increment_airdrop_requests();
  return 1;
}

increment_airdrop_requests() {
  level.airdrop_requests++;
  iprintln("_encstr_93DA24E51302A0B4E48C9CBDE040299517AE2B9B1D9B0129CD8DC92B166E568C84805A10F21A" + level.airdrop_requests);
}

decrement_airdrop_requests() {
  level.airdrop_requests--;
  iprintln("_encstr_93DA24E51302A0B4E48C9CBDE040299517AE2B9B1D9B0129CD8DC92B166E568C84805A10F21A" + level.airdrop_requests);
}

support_box_spawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_1;
  var_0.mpstreaksysteminfo = var_2;
  var_0.mpstreaksysteminfo.attackerisinflictor = gettime();
  return var_0;
}