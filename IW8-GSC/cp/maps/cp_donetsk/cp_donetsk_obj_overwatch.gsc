/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_obj_overwatch.gsc
***********************************************************/

overwatch_init() {
  level.overwatch_interaction = ::register_interactions;
  level.suicide_bomber_combat_func = ::suicide_bomber_combat_func;
  scripts\engine\utility::flag_init("_encstr_A7940FA1DE9BE816ECCA37FAB92B3AEAC1");

  if(!isDefined(level._effect["_encstr_8215172CAC4EB48536D7AC3CC1C6DB6E5A7BB97DD8C239B356"]))
    level._effect["_encstr_8215172CAC4EB48536D7AC3CC1C6DB6E5A7BB97DD8C239B356"] = loadfx("_encstr_A3462E0426A3A08F9573701A3A68618D26C905FEB16F70AF7FBBD00872426B384B4F1BFD1C375E01A60370587E5B3D12");

  if(!isDefined(level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"]))
    level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"] = loadfx("_encstr_BE1723B3330F5EB17B27CACB95F01C8DE50B9539A5B0B1D75687C163DB6E5A7B9BE2CE3387");
}

register_overwatch_objective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  var_0 = scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("_encstr_8A1B0E5AB87D711F5325E2FFCFFBE744", ::obj_maj_intro_init, ::obj_maj_intro_start, ::obj_maj_intro_end, ::debugbeatobjective, ::debug_start_overwatch);
  [[var_0]]("_encstr_8FE01402E02539572B6DAAA777333FBC27988ABA48AF", ::obj_maj_bombdefuse_init, ::obj_maj_bombdefuse_start, ::obj_maj_bombdefuse_end, ::debugbeatobjective);
  level thread register_spawn_functions();
}

register_interactions() {}

obj_maj_intro_init(var_0) {
  level._id_139B5 = 1;
  level thread spawn_overwatch_extraguns();
  level thread spawn_fake_loots();
  level thread _id_135AC();
  level thread spawn_exfil_heli_and_rpgs();
  level thread _id_131F0();
  level thread _id_11A7D();
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_A7280AF6C4D4AF8ED68E97D8");
  scripts\cp\cp_objectives::reset_subobjective_slot("_encstr_82040C6F3160DFAB4053A3C1F672");
}

obj_maj_intro_start(var_0) {
  wait 1;
  var_1 = scripts\engine\utility::getStruct("_encstr_86111153EBD7FB34D8A3DFED4D383A3788A18A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_position(var_0.objectiveindex, var_1.origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_setlabel(var_0.objectiveindex, &"_encstr_886C27860A7DA9AA12AA92904DAFE9092515D0154A9515A9CB35450544295535BE50054149E9051A42");
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  level thread _id_135AE();
  level thread _id_123FF();
  var_2 = 4100;
  var_3 = var_2 * var_2;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_3))
    wait 0.1;

  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_BE830A4728A1F402732971E2", ["_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9"]);
  level thread play_intro_vo();
  level waittill("_encstr_8DD91A7B67ACC9DD581DD80DAF1CD80BE5AC32FA2D373A4EEDAFCEED");
  var_4 = scripts\engine\utility::getStruct("_encstr_88820CF613A97D987BD626F50CC4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 3500;
  var_3 = var_2 * var_2;

  while(!scripts\cp\utility::any_player_nearby(var_4.origin, var_3))
    wait 0.1;

  level thread play_intro2_vo();
}

obj_maj_intro_end(var_0) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8FE01402E02539572B6DAAA777333FBC27988ABA48AF");
}

obj_maj_bombdefuse_init(var_0) {
  level thread spawn_juggs();
  level thread convoy_start();
  level thread run_helicopter_boss();
}

obj_maj_bombdefuse_start(var_0) {
  level endon("_encstr_84CF0D70849378531A4B47CD8F8229");
  scripts\cp\cp_hacking::hacking_init();
  scripts\cp\utility::_id_123FE("_encstr_A11A18DAABB9FA361CF58D2CCD46D8ED39467DCD1DC291B4ABB6");

  for(var_1 = 0; var_1 < 5; var_1++) {
    hack_relocate(var_1, var_0);
    lb_impulse_dmg_factor_mid_high(var_1, var_0);

    if(var_1 == 4)
      scripts\cp\cp_objectives::lua_objective_complete("_encstr_8FE01402E02539572B6DAAA777333FBC27988ABA48AF");

    if(var_1 == 0)
      lb_impulse_dmg_factor_mid_low(var_0);
    else if(var_1 != 2) {
      objective_unsetlocation(var_0.objectiveindex, 0);
      wait 6;
    }

    if(var_1 == 2) {
      objective_unsetlocation(var_0.objectiveindex, 0);
      level wait_for_tank_deaths();
    }
  }

  wait 1;
  objective_unsetlocation(var_0.objectiveindex, 0);
  level wait_for_boss_death();
  level notify("_encstr_A542198578B5CA4008CBCF39496B9890A167B340485F61F8379311");
  level notify("_encstr_9AD112B71D57B3D953B0B75FA028860AFBB82A7B");
  wait 1;

  if(level.overwatch_tanks.size > 0) {
    objective_setlocation(var_0.objectiveindex, 0, level.overwatch_tanks[0]);
    objective_setplayintro(var_0.objectiveindex, 1);
    objective_setplayoutro(var_0.objectiveindex, 1);
    objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
    scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
    objective_setlabel(var_0.objectiveindex, &"_encstr_95E9256814BE4D5512554A2135AF7A2149A8A1515259A26A5E12F49AA9FAA282E4A56AEBF49092");
    objective_setdescription(var_0.objectiveindex, &"_encstr_9163213B1AFF52697A238B4ACA81F8CEC4FF35A389370FEFFA738562AB37458F3E670F");
    objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_sethot(var_0.objectiveindex, 1);
    objective_setbackground(var_0.objectiveindex, 1);
    objective_addalltomask(var_0.objectiveindex);
    objective_showtoplayersinmask(var_0.objectiveindex);
    level thread _id_13F61(level.overwatch_tanks[0], var_0.objectiveindex);

    while(level.overwatch_tanks.size > 0)
      wait 1;
  }

  level notify("_encstr_8FFE1A07D46D9B13AF5181EA2F73D1868F95DEEC1BD2CBEF40C96770");
  wait 1;
  level thread play_win_vo();
}

_id_13F61(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");
  objective_unsetlocation(var_1, 0);
}

obj_maj_bombdefuse_end(var_0) {
  level stop_emp_effects_on_players();
  level.set_up_blockade_gate_anims = undefined;
  level thread _id_12DD6();
}

wait_for_boss_death() {
  level waittill("_encstr_AD481A3783B0EE9BF5EDECB2C9DD5847C60DBEA156D85ABE13DBB96E");
  wait 1;

  if(!isDefined(level.overwatch_boss) || !isent(level.overwatch_boss)) {
    return;
  }
  var_0 = "_encstr_8ADB137B8935EBDE3B569CEEB08E8DD0FA86AC36D2";
  var_1 = scripts\cp\cp_objectives::requestworldid(var_0, 15);
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 1);
  var_2 = level.overwatch_boss scripts\engine\utility::spawn_tag_origin();
  var_2 notsolid();
  var_2 show();
  var_2 linkTo(level.overwatch_boss, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 256), (0, 0, 0));
  level.overwatch_boss.obj_pos = var_2;
  objective_setlocation(var_1, 0, level.overwatch_boss.obj_pos);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_1);
  objective_setlabel(var_1, &"_encstr_819026D5AA9F596DE8877D65A701581952775DCF043E512656B34F4F4FE913793CDC46A7FC5F497D");
  objective_setdescription(var_1, &"_encstr_8BBD208E604F5F93AE11D94169B1EF35A3DD069D818345A7DD0839C14159396DD349");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_addalltomask(var_1);
  objective_showtoplayersinmask(var_1);
  scripts\cp\utility::_id_123FE("_encstr_8B4E1BD6EA37F5C638F5C6C2378C8DDBE48CAF35D5D9D9594E7358D5A3");
  level thread scripts\cp\utility::objective_update("_encstr_8ADB137B8935EBDE3B569CEEB08E8DD0FA86AC36D2", undefined, undefined, undefined, 1, undefined, 4);

  if(isDefined(level.overwatch_boss) && isalive(level.overwatch_boss))
    level.overwatch_boss waittill("_encstr_AD75063D571AE108");

  scripts\cp\cp_objectives::lua_objective_complete("_encstr_8ADB137B8935EBDE3B569CEEB08E8DD0FA86AC36D2");
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A9851EB8A39F2D2357AC6ED3AF37E8C907BA10D86BB9E133D7A260596AB773BF");
  objective_state(var_1, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::freeworldid(var_0);
}

wait_for_tank_deaths() {
  level waittill("_encstr_BA34164FCD08BAF79FBB0AC2A6EEB336E861C7DC7BB8043F");
  level thread spawn_overwatch_tanks();
  level thread tank_hint_message();
  level thread give_all_players_munition(level.priority_player, 6);
  level._id_121A6 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AC5B163F6DCD5B0F78E3BE44BEE821D292A7837F2F6293C0");
  var_0 = "_encstr_97F214C8922C07501BADF66C813B99D1D95B2048FA82";
  var_1 = scripts\cp\cp_objectives::requestworldid(var_0, 15);
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_1);
  objective_setlabel(var_1, &"_encstr_95E9256814BE4D5512554A2135AF7A2149A8A1515259A26A5E12F49AA9FAA282E4A56AEBF49092");
  objective_setdescription(var_1, &"_encstr_9163213B1AFF52697A238B4ACA81F8CEC4FF35A389370FEFFA738562AB37458F3E670F");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_1, 1);
  objective_setbackground(var_1, 1);
  objective_addalltomask(var_1);
  objective_showtoplayersinmask(var_1);
  scripts\cp\utility::_id_123FE("_encstr_8B4E1BD6EA37F5C638F5C6C2378C8DDBE48CAF35D5D9D9594E7358D5A3");
  level thread scripts\cp\utility::objective_update("_encstr_97F214C8922C07501BADF66C813B99D1D95B2048FA82", undefined, undefined, undefined, 1, undefined, 3);
  level thread _id_13A59();
  level._id_11F68 = var_1;

  while(!isDefined(level.overwatch_tanks) || level.overwatch_tanks.size < 2)
    wait 1;

  while(level.overwatch_tanks.size > 0)
    wait 1;

  level notify("_encstr_91FF15D8F33A8D8B018B48083F4C01FDA2DA58D58FD279");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AC5B163F6DCD5B0F78E3BE44BEE821D292A7837F2F6293C0");
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_97F214C8922C07501BADF66C813B99D1D95B2048FA82");
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
  objective_state(var_1, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::freeworldid(var_0);
}

_id_13A59() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 12544;
  var_1 = scripts\engine\utility::getStruct("_encstr_87820C200E322FC1E7376889AA53", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.origin + (-254, -607, -64);
  var_3 = 180;

  for(;;) {
    wait(var_3);

    if(level.overwatch_tanks.size >= 4) {
      var_4 = "_encstr_AC29107DE84F69BB2F62F39E0BC7EEE0665C";
      var_5 = scripts\cp\cp_objectives::requestworldid(var_4, 2);
      objective_setplayintro(var_5, 1);
      objective_setplayoutro(var_5, 0);
      objective_setbackground(var_5, 0);
      objective_sethot(var_5, 0);
      objective_position(var_5, var_2);
      objective_state(var_5, "_encstr_AF5A081BBAC993AC73A3");
      scripts\cp\cp_objectives::_id_11F80(var_5);
      objective_icon(var_5, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
      objective_setlabel(var_5, &"_encstr_9163213B1AFF52697A238B4ACA81F8CEC4FF35A389370FEFFA738562AB37458F3E670F");
      objective_setownerteam(var_5, "_encstr_9A8507BA4040188D08");
      objective_addalltomask(var_5);
      objective_showtoplayersinmask(var_5);
      level play_vo_delay("_encstr_B1F02268AB1729A10BE19A974502B730917F29F80FFF03A7919387A31A1A0378EC07CABA");
      var_6 = 0;

      for(;;) {
        if(scripts\cp\utility::any_player_nearby(var_2, var_0)) {
          break;
        }

        if(!isDefined(level.overwatch_tanks) || level.overwatch_tanks.size < 2) {
          break;
        }

        if(var_6 > 30) {
          break;
        }

        wait 1;
        var_6 = var_6 + 1;
      }

      if(var_3 > 100)
        var_3 = var_3 - 60;

      objective_state(var_5, "_encstr_8267056410C669");
      scripts\cp\cp_objectives::freeworldid(var_4);
      continue;
    }

    break;
  }
}

debugbeatobjective(var_0) {
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
}

spawn_intro_soldiers() {}

_id_135AE() {
  level._id_135A1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8CBC16507BB20533B903D080C7C34841CA24DD6692C94933");
  level thread _id_1436A(level._id_135A1);
}

spawn_overwatch_soldiers_02(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 4000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_1)) {
      break;
    }

    wait 1;
  }

  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9ABC16C8BB4DB89422EB87992F6BD010E4D431E3628F62EE");
}

spawn_overwatch_soldiers_03() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AFBC16DBD9B29CBBC2D1C686D7DCEDD819D295E49BD70699");
}

spawn_overwatch_soldiers_04() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8DBC16DECE56E4EE16A3B143D737BD36465A59E4B9D70386");
}

spawn_overwatch_soldiers_05() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A5BC1615847FF24B02DCCBF86F5748CD21570718436F7AAE");
}

spawn_juggs() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_ACB010DFB397ABC047030140489A2B80EFB3");
}

vehicle_dismount_watcher(var_0, var_1) {
  self.combatmode = "_encstr_821109FAE81117DA568730";
  thread vehicle_dlog_enterevent();
}

vehicle_dlog_enterevent() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  thread cargo_truck_mg_enterendinternal(1000);
  vehicle_damage_updatestate(1500);

  if(!isDefined(self._id_12925)) {
    thread vehicle_docollisiondamagetoplayer();

    while(!isDefined(self._id_12925))
      wait 0.5;

    self notify("_encstr_A24A0CA3189DB7431B937B3B9780");
  }

  if(isDefined(self._id_12925)) {
    var_0 = 1000;

    if(isDefined(self._id_12925.radius))
      var_0 = self._id_12925.radius;

    vehicle_fob_think(self._id_12925, var_0, "_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  }

  vehicle_docollisiondamagetoplayer();
}

watch_for_player_damage() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(isPlayer(var_1)) {
      self._id_132B8 = 1;
      return;
    }
  }
}

vehicle_damage_updatestate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  var_1 = getdvarint("_encstr_B64F13CAF91201E015F8A7B9E008729C7712935F03", var_0);
  var_2 = var_1 * var_1;
  thread watch_for_player_damage();

  for(;;) {
    if(istrue(self._id_132B8)) {
      break;
    }

    if(scripts\cp\utility::any_player_nearby(self.origin, var_2)) {
      break;
    }

    wait 0.5;
  }

  self.ignoreall = 0;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  scripts\cp\cp_modular_spawning::set_goal_radius(500);
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

cargo_truck_mg_enterendinternal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 1000;

  if(isDefined(var_0))
    var_1 = var_0;

  for(;;) {
    level waittill("_encstr_AF930F3991F3E0482B8A5820F23F95888F", var_2);

    if(isDefined(var_2) && isDefined(self.spawnpoint) && distancesquared(self.spawnpoint.origin, var_2.origin) < var_1 * var_1) {
      var_3 = 1000;

      if(isDefined(var_2.target)) {
        var_4 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(isDefined(var_4))
          var_2 = var_4;
      }

      self._id_12925 = var_2;
      return;
    } else
      continue;
  }
}

vehicle_docollisiondamagetoplayer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A24A0CA3189DB7431B937B3B9780");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(500);

  for(;;) {
    var_0 = scripts\cp\utility::get_closest_living_player();

    while(isDefined(var_0) && isalive(var_0)) {
      scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
      wait 5;
    }

    wait 1;
  }
}

vehicle_fob_think(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A24A0CA3189DB7431B937B3B9780");
  self notify("_encstr_8CF010184FEAFB7B1A1DCCD87372BDA125E3");
  self endon("_encstr_8CF010184FEAFB7B1A1DCCD87372BDA125E3");

  if(isDefined(var_2)) {
    level endon(var_2);
    self endon(var_2);
  }

  if(!isDefined(var_1))
    var_1 = 1000;

  var_3 = 2;
  var_4 = int(var_3 * 20);

  while(isDefined(var_0)) {
    scripts\cp\cp_modular_spawning::set_goal_radius(var_1);
    scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    wait(var_3);
  }
}

_id_13582() {
  level._id_13598 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_83950977F7E1059794C627");
}

_id_13583() {
  level._id_13599 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A5950902433F6A2740D607");
}

_id_13584() {
  level._id_1359A = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_869509600B210960AFBF22");
}

_id_13585() {
  level._id_1359B = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB9509F82B5171396F0153");
}

_id_13586() {
  level._id_1359C = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A79509BDEEFAD8D6ECBE53");
}

complete_game() {
  wait 1;

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0].ability_invulnerable = 1;

  announcement("_encstr_8FD709209189F851A4B391");
  wait 5;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

mission_fail() {
  level notify("_encstr_84CF0D70849378531A4B47CD8F8229");
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

spawn_covernode_soldiers() {
  wait 2;
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F");
}

hack_relocate(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  switch (var_0) {
    case 0:
      var_2 = scripts\engine\utility::getStruct("_encstr_88820CF613A97D987BD626F50CC4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_ABEE15B25095E987FB9D5A57A7838FEC57C83A6AB827CA";
      var_5 = (0, 0, 0);
      var_6 = (0, 0, 64);
      var_7 = "_encstr_849C0E8808B557CCD79968A0EE81A30F";
      var_4 = scripts\engine\utility::getStruct("_encstr_BD4714B767ACC9EEC247C6437DDBC9B4765A37EBC098", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_8 = "_encstr_8AB31E506BE2FF298B0F61EF06E3F0570AE249F042FD3363AF5777D3E50B5EB3";
      level thread convoy_start_1();
      level thread spawning_poi_handler("_encstr_990703A2FB", "_encstr_AB07030CC8");
      level thread _id_13582();
      level thread scripts\cp\utility::objective_update("_encstr_8FE01402E02539572B6DAAA777333FBC27988ABA48AF", undefined, undefined, undefined, 1, var_0);
      break;
    case 1:
      var_2 = scripts\engine\utility::getStruct("_encstr_96820CE0CE44AF1D181822E16FD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_93EE1517B8E0EF42550D5A136709DA90EE139F8750BE5A";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "_encstr_8A9C0E275DA261FA8028252F2399686F";
      var_4 = scripts\engine\utility::getStruct("_encstr_8847144FE6D7183C073B196091E77608EF41C5B7C86A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_8 = "_encstr_A6B31E0130BF8926E8FFF41A369170B74D9FF9B6D8FC57D66AF05303E5751F4A";
      var_9 = "_encstr_AC830A60BBA6C928DF7DB806";
      level thread _id_1350A();
      level thread spawn_overwatch_soldiers_02(var_2.origin);
      level thread _id_13583();
      level thread convoy_start_2(var_2.origin);
      level thread wait_to_spawn_convoy_3(var_2.origin);
      level thread spawning_poi_handler("_encstr_AB07030CC8", "_encstr_A70703792B");
      break;
    case 2:
      var_2 = scripts\engine\utility::getStruct("_encstr_87820C200E322FC1E7376889AA53", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_A1EE15B84BAA5667D3F79E24CECB477837D33050A34763";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "_encstr_859C0E80AE928F6049977038C35FF38F";
      var_4 = scripts\engine\utility::getStruct("_encstr_9647140A63F37B2319BBCEFC1745AB7359A778A122B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_8 = "_encstr_B2B31E01932849FB7F9901392D1185105089B74FEFC9D5E0E98540E2A5D08916";
      var_9 = "_encstr_B8830A406B4F87315502AFDB";
      level thread spawn_overwatch_soldiers_03();
      level thread _id_13584();
      level thread spawning_poi_handler("_encstr_A70703792B", "_encstr_A107038F0B");
      break;
    case 3:
      var_2 = scripts\engine\utility::getStruct("_encstr_BD820C285EA231FE226F255732BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_83EE158FF51AD94790B18AD329589362780D071F5D2837";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "_encstr_AD9C0E9063820E35CA8D79752241C91B";
      var_4 = scripts\engine\utility::getStruct("_encstr_BE47143F74E1839B839802AAD9C792A71953B697AF23", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_8 = "_encstr_8AB31E506BE2FF298B0F61EF06E3F0570AE249F042FD3363AF5777D3E50B5EB3";
      var_9 = "_encstr_BD830AABDBA9E87B836F5F81";
      level thread spawn_overwatch_soldiers_04();
      level thread _id_13585();
      level thread convoy_start_4();
      level thread spawning_poi_handler("_encstr_A107038F0B", "_encstr_930703194D");
      break;
    case 4:
      var_2 = scripts\engine\utility::getStruct("_encstr_82820CE02AA3A81025953557D09B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_8BEE15A0BAF00E0A38A7EA470B2C30E1D111F7F0467E2D";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "_encstr_979C0EE5716867929FF3978FF5A8FFC5";
      var_4 = scripts\engine\utility::getStruct("_encstr_8E4714BDCECA9CBB2C478D86F57B9CD23B5ADCD70653", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_8 = "_encstr_A6B31E0130BF8926E8FFF41A369170B74D9FF9B6D8FC57D66AF05303E5751F4A";
      var_9 = "_encstr_87830A2E8B8259A0FD3781DA";
      level thread _id_13A6F(var_2.origin);
      level thread spawn_overwatch_soldiers_05();
      level thread _id_13586();
      level thread convoy_start_5();
      level thread hurt_trigger_manage_dog_tag();
      level thread spawning_poi_handler("_encstr_930703194D", undefined);
      break;
    case 5:
      var_2 = undefined;
      var_3 = "_encstr_8BEE15A0BAF00E0A38A7EA470B2C30E1D111F7F0467E2D";
      var_5 = undefined;
      break;
  }

  objective_setlabel(var_1.objectiveindex, "_encstr_B40101");

  if(isDefined(var_2)) {
    level notify("_encstr_AF930F3991F3E0482B8A5820F23F95888F", var_2);
    objective_setbackground(var_1.objectiveindex, 1);
    objective_setlocation(var_1.objectiveindex, 0, var_2.origin + var_5);
    level thread scripts\cp\cp_objectives::_id_1317E(var_1, var_2.origin);
    objective_icon(var_1.objectiveindex, "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F");
    objective_sethot(var_1.objectiveindex, 0);
    objective_setownerteam(var_1.objectiveindex, "_encstr_A7A408B9CA5D1D4E2C63");
    objective_setlabel(var_1.objectiveindex, &"_encstr_8AEA233482BE355512AAA4216AD77A84251534A229598A9A79E948A4EB22A775E498E95088");
    objective_setdescription(var_1.objectiveindex, &"_encstr_8AEA233482BE355512AAA4216AD77A84251534A229598A9A79E948A4EB22A775E498E95088");
    objective_state(var_1.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
    scripts\cp\cp_objectives::_id_11F80(var_1.objectiveindex);
    level thread relocate_gunship_origin(var_4);
    level thread setup_enemy_sentries(var_0);

    if(isDefined(var_9))
      scripts\cp\crate_drops\cp_crate_drops::_id_12C40(var_9, ["_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9"]);

    var_1.use_old_label = 1;
    level.overwatch_emp_low = 0.8;
    level.overwatch_emp_high = 1.2;
    level.overwatch_emp_free = 5;
    level thread play_jammer_returning_vo();
    level thread handle_wavespawner_amount(var_0);
    var_10 = get_jammer_mdl(var_7);
    level thread setup_router_objective(var_10);
    level waittill("_encstr_85620E029D73756572AFD070B1378DF1");

    if(var_0 == 4)
      level thread _id_13B07();

    level.overwatch_emp_low = 4;
    level.overwatch_emp_high = 9;
    level.overwatch_emp_free = 1.1;
    scripts\cp\utility::_id_123FE(var_8);
    level thread start_hack_threaded(var_1, var_2, var_6, var_0);
    level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
    wait 1;
  }
}

_id_13A6F(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

  foreach(var_3 in var_1)
  var_3 thread scripts\cp\cp_modular_spawning::set_script_origin_other_for_group(var_0);
}

start_hack_threaded(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\cp_objective_mechanics::starthackingdefense;
  var_5 = 30;

  switch (var_3) {
    case 0:
      var_5 = 25;
      break;
    case 1:
      var_5 = 30;
      break;
    case 2:
      var_5 = 35;
      break;
    case 3:
      var_5 = 40;
      break;
    case 4:
      var_5 = 90;
      break;
  }

  if(getdvarint("_encstr_ACC414C319850720253B0A1F61EB116BC180B16F2D44", 0) > 0)
    var_5 = 5;

  level[[var_4]](var_0, var_1.origin - var_2, var_5, "_encstr_93C61053C84BA9391960037DD9271274B108", 320);
  level notify("_encstr_93C61053C84BA9391960037DD9271274B108");
}

_id_11A7D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level._id_121AA)) {
    return;
  }
  level._id_121AA = 0;
  var_0 = scripts\engine\utility::getStruct("_encstr_88820CF613A97D987BD626F50CC4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_96820CE0CE44AF1D181822E16FD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_87820C200E322FC1E7376889AA53", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_BD820C285EA231FE226F255732BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = 2250000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_4))
    wait 0.1;

  var_5 = var_0 node_set_children(1);
  _id_1432E(var_1, var_5);
  var_5 = var_1 node_set_children(2);
  _id_1432E(var_2, var_5);
  var_5 = var_2 node_set_children(3);
  _id_1432E(var_3, var_5);
  var_5 = var_3 node_set_children(4);
  _id_1432E(undefined, var_5);
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  waitframe();

  if(isDefined(var_5))
    next_threshold(var_5);
}

node_set_children(var_0) {
  if(level._id_121AA >= 3)
    return undefined;

  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1.team = "_encstr_9A8507BA4040188D08";
  var_1.id = var_0;
  var_1 makescrambler(level.players[0], "_encstr_B61807364B3A1DD82B");
  level thread _id_12F1D(var_1);
  level._id_121AA = level._id_121AA + 1;
  return var_1;
}

_id_1432E(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  waitframe();

  if(isDefined(var_1))
    next_threshold(var_1);

  if(isDefined(var_0)) {
    var_2 = 2250000;

    while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_2))
      wait 0.1;
  }
}

next_threshold(var_0) {
  if(!isDefined(var_0) || !isent(var_0)) {
    return;
  }
  var_0 clearscrambler();
  var_0 notify("_encstr_B60F10394D3D506691A7B79D075AA6C0D522");
  level._id_121AA = level._id_121AA - 1;
}

_id_12F1D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B60F10394D3D506691A7B79D075AA6C0D522");
  level.players[0] waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    next_threshold(var_0);
}

setup_enemy_sentries(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 0:
      var_1 = "_encstr_A3C90D6B53EFBFFD409527EF676992";
      break;
    case 1:
      var_1 = "_encstr_8FC90DB9C1C277E6CAE4F57BEEFA4C";
      break;
    case 2:
      var_1 = "_encstr_91C90DDC0EB0EE73ACE4D7B7BBEBC8";
      break;
    case 3:
      var_1 = "_encstr_ACC90DE6072CBBE6B2C9D7F6DDEB66";
      break;
    case 4:
      var_1 = "_encstr_ABC90D370E58BBE6CAE4AFBDDDD7A1";
      break;
  }

  if(isDefined(var_1)) {
    level.initlocationcircle = var_1;
    level.initlethalmaxoffsetmap = var_1;
  }
}

wait_for_players_near(var_0) {
  var_1 = 14400;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_1)) {
      break;
    }

    wait 0.25;
  }

  level notify("_encstr_883F12B8FA66B3E98323F8680DF733378FB210C8");
}

emp_effects_on_nearby_players(var_0) {
  level endon("_encstr_B8A01BDC47DB1CD77BCE5993BB0BD18D0DBE59B5E0D7AC6699ACB13A6E");
  var_1 = 193600;

  for(;;) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      var_3 = undefined;

      if(istrue(level.players[var_2].mark_emp_effects)) {
        var_3 = distancesquared(level.players[var_2].origin, var_0);

        if(var_3 > var_1) {
          level.players[var_2] notify("_encstr_B8A01BDC47DB1CD77BCE5993BB0BD18D0DBE59B5E0D7AC6699ACB13A6E");
          level.players[var_2].mark_emp_effects = undefined;
        }

        continue;
      }

      if(!level.players[var_2] scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(var_3))
        var_3 = distancesquared(level.players[var_2].origin, var_0);

      if(var_3 < var_1) {
        level.players[var_2].mark_emp_effects = 1;
        level thread emp_effects_flickering(level.players[var_2]);
      }
    }

    wait 0.25;
  }
}

emp_effects_flickering(var_0) {
  level endon("_encstr_B8A01BDC47DB1CD77BCE5993BB0BD18D0DBE59B5E0D7AC6699ACB13A6E");
  var_0 endon("_encstr_B8A01BDC47DB1CD77BCE5993BB0BD18D0DBE59B5E0D7AC6699ACB13A6E");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0.75;

  for(;;) {
    var_2 = randomfloatrange(level.overwatch_emp_low, level.overwatch_emp_high);
    level thread scripts\cp_mp\emp_debuff::_id_1241A(var_0, 5);
    var_3 = randomfloat(level.overwatch_emp_free);
    wait(var_2 + var_1 + var_3);
  }
}

_id_131F0() {
  scripts\cp\utility::skydivestreamhintdvars("_encstr_8D390A3813DA6D6BE1AB6828");
}

lb_impulse_dmg_factor_mid_high(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2AE1183D02883F9F417982AEF01C7D1588B8C");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  switch (var_0) {
    case 0:
      var_2 = scripts\engine\utility::getStruct("_encstr_88820CF613A97D987BD626F50CC4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_ABEE15B25095E987FB9D5A57A7838FEC57C83A6AB827CA";
      var_4 = 120;
      var_5 = 60;
      var_6 = 30;
      var_7 = (0, 0, 0);
      var_8 = "_encstr_849C0E8808B557CCD79968A0EE81A30F";
      break;
    case 1:
      var_2 = scripts\engine\utility::getStruct("_encstr_96820CE0CE44AF1D181822E16FD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_93EE1517B8E0EF42550D5A136709DA90EE139F8750BE5A";
      var_4 = 180;
      var_5 = 90;
      var_6 = 45;
      var_7 = (0, 0, 32);
      var_8 = "_encstr_8A9C0E275DA261FA8028252F2399686F";
      level thread take_away_players_gunshipmunition();
      level thread convoy_start_2b();
      break;
    case 2:
      var_2 = scripts\engine\utility::getStruct("_encstr_87820C200E322FC1E7376889AA53", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_A1EE15B84BAA5667D3F79E24CECB477837D33050A34763";
      var_4 = 180;
      var_5 = 90;
      var_6 = 45;
      var_7 = (0, 0, 32);
      var_8 = "_encstr_859C0E80AE928F6049977038C35FF38F";
      level thread take_away_players_gunshipmunition();
      level thread spawn_overwatch_soldiers_03();
      break;
    case 3:
      var_2 = scripts\engine\utility::getStruct("_encstr_BD820C285EA231FE226F255732BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_83EE158FF51AD94790B18AD329589362780D071F5D2837";
      var_4 = 240;
      var_5 = 120;
      var_6 = 60;
      var_7 = (0, 0, 32);
      var_8 = "_encstr_AD9C0E9063820E35CA8D79752241C91B";
      level thread take_away_players_gunshipmunition();
      level thread convoy_start_4b();
      level thread convoy_start_3b();
      break;
    case 4:
      var_2 = scripts\engine\utility::getStruct("_encstr_82820CE02AA3A81025953557D09B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = "_encstr_8BEE15A0BAF00E0A38A7EA470B2C30E1D111F7F0467E2D";
      var_4 = 240;
      var_5 = 120;
      var_6 = 60;
      var_7 = (0, 0, 32);
      var_8 = "_encstr_979C0EE5716867929FF3978FF5A8FFC5";
      level thread take_away_players_gunshipmunition();
      break;
    case 5:
      var_2 = undefined;
      var_3 = "_encstr_9BEE15B59D7DCF253BBD6B0467B5D2FBE126F088B6D8EB";
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      break;
  }

  objective_setlabel(var_1.objectiveindex, "_encstr_B40101");

  if(isDefined(var_2)) {
    level notify("_encstr_A1650F852F652898FB7AA8F0228FC5D8FF");
    objective_setbackground(var_1.objectiveindex, 1);
    objective_setdescription(var_1.objectiveindex, &"_encstr_96B8236882EBA6AA12552921D4BE7A84A451862A25B2A26ACB9A127AE98AAFA428539AA249");
    objective_setlocation(var_1.objectiveindex, 0, var_2.origin + var_7);
    objective_icon(var_1.objectiveindex, "_encstr_88FF1268537C29B806D035FF8E0BEF7B42E9AB60");
    objective_sethot(var_1.objectiveindex, 0);
    objective_setownerteam(var_1.objectiveindex, "_encstr_A7A408B9CA5D1D4E2C63");
    objective_setlabel(var_1.objectiveindex, &"_encstr_BE01201EC7319B919E13FBA3073878C221CD86531C9155C9704FB38B37C6D0776177");
    objective_state(var_1.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
    scripts\cp\cp_objectives::_id_11F80(var_1.objectiveindex);
    level thread hint_jammer_damage(var_2);
    level thread enable_jammer_damage(var_8, var_1.objectiveindex);
    level waittill("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");
    scripts\cp\utility::_id_123FE("_encstr_B40101");
    scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
    level thread play_jammer_destroyed_vo();
    thread scripts\cp\utility::objective_update("_encstr_8FE01402E02539572B6DAAA777333FBC27988ABA48AF", undefined, undefined, undefined, 1, var_0 + 1);
  }
}

stop_emp_effects_on_players() {
  level notify("_encstr_B8A01BDC47DB1CD77BCE5993BB0BD18D0DBE59B5E0D7AC6699ACB13A6E");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level notify("_encstr_99C40CA749E1F16B80389FEB2BB9");
    level.players[var_0].mark_emp_effects = undefined;
  }
}

start_heli_spawner(var_0) {
  switch (var_0) {
    case 1:
    case 0:
      level.lbravo_se_2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B1B30C69D232A09C1F69FB2171B2");
      break;
    case 4:
    case 3:
    case 2:
      level.lbravo_se_3 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BAB30C73DD78D6E6585072605162");
      break;
  }
}

_id_1350A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");
  level waittill("_encstr_85620E029D73756572AFD070B1378DF1");
  level.watchleaderdescriptionchange = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_96E117C922B33B2B8A2772C801EBCD57E35762EA653508ABCA");
  wait 2;
  level.watchmapselectexitonemp = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B85418B11EA343B3170FF0E0DF2788F30BC93A4FB50A03FB9203");
}

buy_points_objectives_handler(var_0, var_1) {
  for(var_2 = 0; var_2 < level.agentarray.size; var_2++) {
    if(distance2dsquared(level.agentarray[var_2].origin, var_0.origin) < var_1) {
      if(isalive(level.agentarray[var_2]))
        return 1;
    }
  }

  return 0;
}

relocate_gunship_origin(var_0) {
  level notify("_encstr_BE3522989F79ABCBCBEB40DE871217D1D173D8F8CB3FA1D3C2D2C36BDA594F3B31A75088");
  level endon("_encstr_BE3522989F79ABCBCBEB40DE871217D1D173D8F8CB3FA1D3C2D2C36BDA594F3B31A75088");

  while(istrue(level.gunshipinuse) || c130_crate())
    wait 0.1;

  level.set_up_blockade_gate_anims = var_0.origin;
}

c130_crate() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0] scripts\cp_mp\killstreaks\gunship::isusinggunship())
      return 1;
  }

  return 0;
}

lb_impulse_dmg_factor_mid_low(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = (0, 0, 96);
  objective_setbackground(var_0.objectiveindex, 0);
  objective_icon(var_0.objectiveindex, "_encstr_B20219D0C32F0357BBB30983221F9A83411E10D97FA87BFB3EE371");
  objective_setownerteam(var_0.objectiveindex, "_encstr_8E8405EA382B2A");
  objective_setprogressteam(var_0.objectiveindex, "_encstr_8E8405EA382B2A");
  objective_setlabel(var_0.objectiveindex, &"_encstr_BE272BEB09517AE79617E1E8BF70D766519B6364D3E13737184C9870062537EAF9DDD7E167494F63C3E570886F");
  level._id_11F67 = 0;
  var_2 = 16900;

  if(!isDefined(level.player_can_mount)) {
    return;
  }
  if(!isDefined(level.player_can_mount.module_vehicles)) {
    return;
  }
  var_3 = level.player_can_mount.module_vehicles[0];

  if(!isDefined(var_3) || !isent(var_3)) {
    return;
  }
  for(var_4 = 0; var_4 <= 7; var_4++)
    objective_unsetlocation(var_0.objectiveindex, var_4);

  for(var_5 = 0; var_5 < var_3.riders.size; var_5++) {
    if(var_5 == 0)
      objective_setlocation(var_0.objectiveindex, 0, var_3);

    if(isalive(var_3.riders[var_5]) && distance2dsquared(var_3.riders[var_5].origin, var_3.origin) < var_2) {
      if(istrue(var_3.riders[var_5].i_see_laststand_player_watcher)) {
        level._id_11F67 = level._id_11F67 + 1;
        var_3.riders[var_5] hudoutlineenable("_encstr_847E18A5C56942E140B80307C8389F2A07D5AF1A2DF9C922C958");
        var_3.riders[var_5] thread _id_1432C();
      }
    }
  }

  while(level._id_11F67 > 0)
    wait 0.1;

  for(var_4 = 0; var_4 <= 7; var_4++)
    objective_unsetlocation(var_0.objectiveindex, var_4);
}

_id_1432C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread zombiekilledlootcachecount(self.origin);
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A78D0C8DB5ECFA1DF6DBEB668527");
  level._id_11F67 = level._id_11F67 - 1;
}

zombiekilledlootcachecount(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 160000;

  for(;;) {
    if(distance2dsquared(self.origin, var_0) > var_1) {
      self hudoutlinedisable();
      self notify("_encstr_A78D0C8DB5ECFA1DF6DBEB668527");
      return;
    }

    wait 2;
  }
}

spawning_poi_handler(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_A30915C703685C9D60BAACF8689AA3B13C97EB158A350B");
  var_3 = 640000;
  var_4 = scripts\engine\utility::getStruct("_encstr_8DBB0ADE4CA6BE4CF66B31FA" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_4.origin, 4500, 10000);

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_4.origin, var_3)) {
      break;
    }

    wait 0.5;
  }

  if(isDefined(var_2))
    wait(var_2);

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_4.origin);

  if(isDefined(var_1)) {
    var_5 = scripts\engine\utility::getStruct("_encstr_8DBB0ADE4CA6BE4CF66B31FA" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_5.origin, 9000, 15000);
    level waittill("_encstr_A30915C703685C9D60BAACF8689AA3B13C97EB158A350B");
    thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_5.origin);
  }
}

stop_if_ground_down(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_3 = 0;

  if(isDefined(var_0) && isDefined(level.players[var_0]))
    var_3++;

  if(isDefined(var_1) && isDefined(level.players[var_1]))
    var_3++;

  if(isDefined(var_2) && isDefined(level.players[var_2]))
    var_3++;

  for(;;) {
    var_4 = 0;

    if(isDefined(var_0) && isDefined(level.players[var_0])) {
      if(!level.players[var_0] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_0].inlaststand))
        var_4++;
    }

    if(isDefined(var_1) && isDefined(level.players[var_1])) {
      if(!level.players[var_1] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_1].inlaststand))
        var_4++;
    }

    if(isDefined(var_2) && isDefined(level.players[var_2])) {
      if(!level.players[var_2] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_2].inlaststand))
        var_4++;
    }

    if(var_4 >= var_3) {
      break;
    }

    wait 0.1;
  }

  level thread mission_fail();
}

convoy_start() {
  level.convoy_speed_override = 14;
  level.convoy_path_jitter = 16;
}

convoy_start_1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_85620E029D73756572AFD070B1378DF1");
  level.player_can_mount = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_84F20BB3F06A5BDAF638A410EB");
  level.player_can_use_munitions = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AA780FCD7B938B3FBF8DAB887BAF22B7FA");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_84F20BB3F06A5BDAF638A410EB");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AA780FCD7B938B3FBF8DAB887BAF22B7FA");
  wait 5;
  level.watchinexecution = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_87E117C626C9859DDED76E1CC2DDDC2B39F553165B5BAC93C4");
  wait 2;
  level.watchleadchange = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A35418316AC321FDCDE9B8A822E395F9AB2F4A3FCD07693DA222");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_87E117C626C9859DDED76E1CC2DDDC2B39F553165B5BAC93C4");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A35418316AC321FDCDE9B8A822E395F9AB2F4A3FCD07693DA222");
}

wait_to_spawn_convoy_3(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 2000;
  var_2 = var_1 * var_1;

  while(!scripts\cp\utility::any_player_nearby(var_0, var_2))
    wait 1;

  wait 20;
  level thread convoy_start_3();
}

convoy_start_2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_86D1123829B74B4368F887F602E5858721E9874F");
  var_1 = 5300;
  var_2 = 1200;
  var_3 = scripts\engine\utility::getStruct("_encstr_B6F20B9C5FA7B38D997B1429E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, squared(var_2))) {
      break;
    }

    wait 0.25;

    if(isDefined(var_3) && scripts\cp\utility::any_player_nearby(var_3.origin, squared(var_1))) {
      break;
    }

    wait 0.25;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B6F20B9C5FA7B38D997B1429E3");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_84820F63CD4702E766E847DF3A5EAC1A17");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B6F20B9C5FA7B38D997B1429E3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_84820F63CD4702E766E847DF3A5EAC1A17");
}

convoy_start_2b() {
  level endon("_encstr_8BD112D8AA22E129D77EB8AE478BF3970891F212");
  wait 20;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A3640C69E5A638C00F9A8BB677C3");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_916710E8B2361ADBAFEDEED72313D78D5B76");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A3640C69E5A638C00F9A8BB677C3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_916710E8B2361ADBAFEDEED72313D78D5B76");
}

convoy_start_3() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_8BD112D8AA22E129D77EB8AE478BF3970891F212");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A6F20BC31AC77338E957DF9713");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB5B0F439A47F3B869D75F179341E8C9EF");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A6F20BC31AC77338E957DF9713");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AB5B0F439A47F3B869D75F179341E8C9EF");
  level.watchmidsideplayerexit = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_88E117A936D3BF53980F26F0064CDD5B73077819C119830B32");
  wait 2;
  level.watchminigunweapon = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BA541836899C2CB3EDD7CD0716BBDCACE47DA9B06BDA2B9CCC13");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_88E117A936D3BF53980F26F0064CDD5B73077819C119830B32");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BA541836899C2CB3EDD7CD0716BBDCACE47DA9B06BDA2B9CCC13");
}

convoy_start_3b() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 15;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1640CA925E678804FDACBF62783");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_81A3107CC31014AFB8F053D9530E374D08BF");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1640CA925E678804FDACBF62783");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_81A3107CC31014AFB8F053D9530E374D08BF");
}

convoy_start_4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_83D1121956B9C116BBB9F58DDBCDCEB7BCF50366");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95F20B7323969855019F84072A");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_88950F4756C643DB7DBDDDAF0DEB63DA3B");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_95F20B7323969855019F84072A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_88950F4756C643DB7DBDDDAF0DEB63DA3B");
  wait 2;
  level.watchoverheat = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8EE11736C44E2CCEBDEBB9830B779BB24EEB4D166BB559391A");
  wait 2;
  level.watchparachutersoverhead = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AA5418E91E182884DF59D388FA8C7A5DB5DF125FAB0D600AF978");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8EE11736C44E2CCEBDEBB9830B779BB24EEB4D166BB559391A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AA5418E91E182884DF59D388FA8C7A5DB5DF125FAB0D600AF978");
}

convoy_start_4b() {
  wait 40;
}

convoy_start_5() {
  level notify("_encstr_8CD1128CB2E63858DDCDD7367B73B3DE5ED7C00D");
  wait 15;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B4F20BE89536A1DEF5BDBBAFA9");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AC6A0FC84AE2B9ED9F7F1399659FD3855C");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B4F20BE89536A1DEF5BDBBAFA9");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AC6A0FC84AE2B9ED9F7F1399659FD3855C");
}

hurt_trigger_manage_dog_tag() {
  level notify("_encstr_8CD1128CB2E63858DDCDD7367B73B3DE5ED7C00D");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A2640CB55AE2397A37CF3BD18D9D");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8CD3105B30DF0CAFE6B077A775A9A7D51B88");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A2640CB55AE2397A37CF3BD18D9D");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8CD3105B30DF0CAFE6B077A775A9A7D51B88");
}

similar_convoy_settings(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_farz(1000);
  var_4 thread scripts\cp\cp_convoy_manager::set_suspend_at_end_path(1);
  level thread allow_driver_exit(var_4);
  level waittill("_encstr_8E76095022AA99515FE620" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

allow_driver_exit(var_0) {
  waitframe();
  var_0 notify("_encstr_AA0117D053B4796F8B1D1085F7A347E3E9A399708B59D3C3D3");
  var_0 scripts\cp\cp_convoy_manager::_id_1307D(0);
}

register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("_encstr_8DE3256C07D77BB39539770B8E8DD0EBC6E49585E8B2F59B369CA507E8D7D8B76BC11B563A2B46"))
    scripts\engine\utility::flag_init("_encstr_8DE3256C07D77BB39539770B8E8DD0EBC6E49585E8B2F59B369CA507E8D7D8B76BC11B563A2B46");

  scripts\engine\utility::flag_wait("_encstr_8DE3256C07D77BB39539770B8E8DD0EBC6E49585E8B2F59B369CA507E8D7D8B76BC11B563A2B46");
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", 18, 18, 18, 0.1, 0, "_encstr_84FE10129B386DEBCB48FA61711D3722E83F", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", ::setup_manual_goalpos);
  [[var_0]]("_encstr_ACB010DFB397ABC047030140489A2B80EFB3", 3, 3, 3, 0.1, 0, "_encstr_ACB010DFB397ABC047030140489A2B80EFB3", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_ACB010DFB397ABC047030140489A2B80EFB3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_ACB010DFB397ABC047030140489A2B80EFB3", ::vehicle_dismount_watcher);
  [[var_0]]("_encstr_8CBC16507BB20533B903D080C7C34841CA24DD6692C94933", 10, 10, 10, 0.1, 0, "_encstr_8CBC16507BB20533B903D080C7C34841CA24DD6692C94933", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8CBC16507BB20533B903D080C7C34841CA24DD6692C94933", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8CBC16507BB20533B903D080C7C34841CA24DD6692C94933", ::_id_1220A);
  [[var_0]]("_encstr_9ABC16C8BB4DB89422EB87992F6BD010E4D431E3628F62EE", 7, 7, 7, 0.1, 0, "_encstr_9ABC16C8BB4DB89422EB87992F6BD010E4D431E3628F62EE", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_9ABC16C8BB4DB89422EB87992F6BD010E4D431E3628F62EE", undefined, 20000, 30000);
  [[var_0]]("_encstr_AFBC16DBD9B29CBBC2D1C686D7DCEDD819D295E49BD70699", 9, 9, 9, 0.1, 0, "_encstr_AFBC16DBD9B29CBBC2D1C686D7DCEDD819D295E49BD70699", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AFBC16DBD9B29CBBC2D1C686D7DCEDD819D295E49BD70699", undefined, 20000, 30000);
  [[var_0]]("_encstr_8DBC16DECE56E4EE16A3B143D737BD36465A59E4B9D70386", 7, 7, 7, 0.1, 0, "_encstr_8DBC16DECE56E4EE16A3B143D737BD36465A59E4B9D70386", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8DBC16DECE56E4EE16A3B143D737BD36465A59E4B9D70386", undefined, 20000, 30000);
  [[var_0]]("_encstr_A5BC1615847FF24B02DCCBF86F5748CD21570718436F7AAE", 7, 7, 7, 0.1, 0, "_encstr_A5BC1615847FF24B02DCCBF86F5748CD21570718436F7AAE", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A5BC1615847FF24B02DCCBF86F5748CD21570718436F7AAE", undefined, 20000, 30000);
  [[var_0]]("_encstr_86BC16E0FBC7454B2FC4068B971F3031EF9238B0039139AB", 7, 7, 7, 0.1, 0, "_encstr_86BC16E0FBC7454B2FC4068B971F3031EF9238B0039139AB", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_86BC16E0FBC7454B2FC4068B971F3031EF9238B0039139AB", undefined, 20000, 30000);
  [[var_0]]("_encstr_A9851EB8A39F2D2357AC6ED3AF37E8C907BA10D86BB9E133D7A260596AB773BF", 1, 1, 8, 0.1, 0, "_encstr_A9851EB8A39F2D2357AC6ED3AF37E8C907BA10D86BB9E133D7A260596AB773BF", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A9851EB8A39F2D2357AC6ED3AF37E8C907BA10D86BB9E133D7A260596AB773BF", undefined, 20000, 30000);
  [[var_0]]("_encstr_AC5B163F6DCD5B0F78E3BE44BEE821D292A7837F2F6293C0", 0, 12, 100, [scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "_encstr_AC5B163F6DCD5B0F78E3BE44BEE821D292A7837F2F6293C0", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_86BC16E0FBC7454B2FC4068B971F3031EF9238B0039139AB", undefined, 20000, 30000);
  [[var_0]]("_encstr_83950977F7E1059794C627", 2, 2, 2, 0.1, 0, "_encstr_83950977F7E1059794C627", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_83950977F7E1059794C627", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_83950977F7E1059794C627", ::spawn_in_cover);
  [[var_0]]("_encstr_A5950902433F6A2740D607", 1, 1, 1, 0.1, 0, "_encstr_A5950902433F6A2740D607", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A5950902433F6A2740D607", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A5950902433F6A2740D607", ::spawn_in_cover);
  [[var_0]]("_encstr_869509600B210960AFBF22", 4, 4, 4, 0.1, 0, "_encstr_869509600B210960AFBF22", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_869509600B210960AFBF22", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_869509600B210960AFBF22", ::spawn_in_cover);
  [[var_0]]("_encstr_AB9509F82B5171396F0153", 2, 2, 2, 0.1, 0, "_encstr_AB9509F82B5171396F0153", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AB9509F82B5171396F0153", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB9509F82B5171396F0153", ::spawn_in_cover);
  [[var_0]]("_encstr_A79509BDEEFAD8D6ECBE53", 3, 3, 3, 0.1, 0, "_encstr_A79509BDEEFAD8D6ECBE53", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A79509BDEEFAD8D6ECBE53", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A79509BDEEFAD8D6ECBE53", ::spawn_in_cover);
  [[var_0]]("_encstr_96E117C922B33B2B8A2772C801EBCD57E35762EA653508ABCA", 5, 5, 5, 0.1, 0, "_encstr_96E117C922B33B2B8A2772C801EBCD57E35762EA653508ABCA", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_96E117C922B33B2B8A2772C801EBCD57E35762EA653508ABCA", ::play_hack_reminder_goto2);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_96E117C922B33B2B8A2772C801EBCD57E35762EA653508ABCA", undefined, 20000, 30000);
  [[var_0]]("_encstr_B85418B11EA343B3170FF0E0DF2788F30BC93A4FB50A03FB9203", 5, 5, 5, 0.1, 0, "_encstr_B85418B11EA343B3170FF0E0DF2788F30BC93A4FB50A03FB9203", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B85418B11EA343B3170FF0E0DF2788F30BC93A4FB50A03FB9203", undefined, 20000, 30000);
  [[var_0]]("_encstr_87E117C626C9859DDED76E1CC2DDDC2B39F553165B5BAC93C4", 5, 5, 5, 0.1, 0, "_encstr_87E117C626C9859DDED76E1CC2DDDC2B39F553165B5BAC93C4", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_87E117C626C9859DDED76E1CC2DDDC2B39F553165B5BAC93C4", undefined, 20000, 30000);
  [[var_0]]("_encstr_A35418316AC321FDCDE9B8A822E395F9AB2F4A3FCD07693DA222", 5, 5, 5, 0.1, 0, "_encstr_A35418316AC321FDCDE9B8A822E395F9AB2F4A3FCD07693DA222", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A35418316AC321FDCDE9B8A822E395F9AB2F4A3FCD07693DA222", undefined, 20000, 30000);
  [[var_0]]("_encstr_88E117A936D3BF53980F26F0064CDD5B73077819C119830B32", 5, 5, 5, 0.1, 0, "_encstr_88E117A936D3BF53980F26F0064CDD5B73077819C119830B32", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_88E117A936D3BF53980F26F0064CDD5B73077819C119830B32", undefined, 20000, 30000);
  [[var_0]]("_encstr_BA541836899C2CB3EDD7CD0716BBDCACE47DA9B06BDA2B9CCC13", 5, 5, 5, 0.1, 0, "_encstr_BA541836899C2CB3EDD7CD0716BBDCACE47DA9B06BDA2B9CCC13", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_BA541836899C2CB3EDD7CD0716BBDCACE47DA9B06BDA2B9CCC13", undefined, 20000, 30000);
  [[var_0]]("_encstr_8EE11736C44E2CCEBDEBB9830B779BB24EEB4D166BB559391A", 5, 5, 5, 0.1, 0, "_encstr_8EE11736C44E2CCEBDEBB9830B779BB24EEB4D166BB559391A", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8EE11736C44E2CCEBDEBB9830B779BB24EEB4D166BB559391A", undefined, 20000, 30000);
  [[var_0]]("_encstr_AA5418E91E182884DF59D388FA8C7A5DB5DF125FAB0D600AF978", 5, 5, 5, 0.1, 0, "_encstr_AA5418E91E182884DF59D388FA8C7A5DB5DF125FAB0D600AF978", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AA5418E91E182884DF59D388FA8C7A5DB5DF125FAB0D600AF978", undefined, 20000, 30000);
  [[var_0]]("_encstr_A7AD18D457CED986598DB47D6E3858EEE62B9CAFD458B5A6BEC4", 2, 2, 2, 0.1, 0, "_encstr_A7701B535D76B334B2C64B7D370785DDE695C9F5D416DA5BCAC953AF13", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A7701B535D76B334B2C64B7D370785DDE695C9F5D416DA5BCAC953AF13", undefined, 20000, 30000);
  [[var_0]]("_encstr_A3AD1802953B32E96259974113077A8760B735A98A3BAB63672E", 2, 2, 2, 0.1, 0, "_encstr_A3701BD4AECECE34B28DB4AF3783B077E62B9CFA9A58B6DA5993D4AF46", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A3701BD4AECECE34B28DB4AF3783B077E62B9CFA9A58B6DA5993D4AF46", undefined, 20000, 30000);
  [[var_0]]("_encstr_93AD18A9AECEEC86CA36B4EB9B072CBBCDACC97D530B5BA6EB33", 2, 2, 2, 0.1, 0, "_encstr_93701BD4D5B37634CAC65AEB6E1C85EE372B27D74D85B56BCA9C53F599", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_93701BD4D5B37634CAC65AEB6E1C85EE372B27D74D85B56BCA9C53F599", undefined, 20000, 30000);
  [[var_0]]("_encstr_91AD18AAC3EA5798F53BC881BF1871BFA26F1EB89CE23B6BE772", 2, 2, 2, 0.1, 0, "_encstr_9B701B9ABA76EC86B2C6A5FACD38C27737564EF54DB05BD6CAC9D4BE0D", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_9B701B9ABA76EC86B2C6A5FACD38C27737564EF54DB05BD6CAC9D4BE0D", undefined, 20000, 30000);
  [[var_0]]("_encstr_84F20BB3F06A5BDAF638A410EB", 4, 4, 4, 0.1, 0, "_encstr_84F20BB3F06A5BDAF638A410EB", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_AA780FCD7B938B3FBF8DAB887BAF22B7FA", 2, 2, 2, 0.1, 0, "_encstr_84F20BB3F06A5BDAF638A410EB", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_84F20BB3F06A5BDAF638A410EB", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AA780FCD7B938B3FBF8DAB887BAF22B7FA", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_84F20BB3F06A5BDAF638A410EB", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AA780FCD7B938B3FBF8DAB887BAF22B7FA", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_84F20BB3F06A5BDAF638A410EB");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_AA780FCD7B938B3FBF8DAB887BAF22B7FA");
  [[var_0]]("_encstr_B6F20B9C5FA7B38D997B1429E3", 4, 4, 4, 0.1, 0, "_encstr_B6F20B9C5FA7B38D997B1429E3", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_84820F63CD4702E766E847DF3A5EAC1A17", 2, 2, 2, 0.1, 0, "_encstr_B6F20B9C5FA7B38D997B1429E3", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B6F20B9C5FA7B38D997B1429E3", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_84820F63CD4702E766E847DF3A5EAC1A17", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B6F20B9C5FA7B38D997B1429E3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_84820F63CD4702E766E847DF3A5EAC1A17", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_B6F20B9C5FA7B38D997B1429E3");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_84820F63CD4702E766E847DF3A5EAC1A17");
  [[var_0]]("_encstr_A3640C69E5A638C00F9A8BB677C3", 4, 4, 4, 0.1, 0, "_encstr_A3640C69E5A638C00F9A8BB677C3", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_916710E8B2361ADBAFEDEED72313D78D5B76", 2, 2, 2, 0.1, 0, "_encstr_A3640C69E5A638C00F9A8BB677C3", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A3640C69E5A638C00F9A8BB677C3", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_916710E8B2361ADBAFEDEED72313D78D5B76", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A3640C69E5A638C00F9A8BB677C3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_916710E8B2361ADBAFEDEED72313D78D5B76", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_A3640C69E5A638C00F9A8BB677C3");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_916710E8B2361ADBAFEDEED72313D78D5B76");
  [[var_0]]("_encstr_A6F20BC31AC77338E957DF9713", 4, 4, 4, 0.1, 0, "_encstr_A6F20BC31AC77338E957DF9713", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_AB5B0F439A47F3B869D75F179341E8C9EF", 2, 2, 2, 0.1, 0, "_encstr_A6F20BC31AC77338E957DF9713", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A6F20BC31AC77338E957DF9713", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB5B0F439A47F3B869D75F179341E8C9EF", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A6F20BC31AC77338E957DF9713", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AB5B0F439A47F3B869D75F179341E8C9EF", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_A6F20BC31AC77338E957DF9713");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_AB5B0F439A47F3B869D75F179341E8C9EF");
  [[var_0]]("_encstr_A1640CA925E678804FDACBF62783", 4, 4, 4, 0.1, 0, "_encstr_A1640CA925E678804FDACBF62783", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_81A3107CC31014AFB8F053D9530E374D08BF", 2, 2, 2, 0.1, 0, "_encstr_A1640CA925E678804FDACBF62783", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1640CA925E678804FDACBF62783", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_81A3107CC31014AFB8F053D9530E374D08BF", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A1640CA925E678804FDACBF62783", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_81A3107CC31014AFB8F053D9530E374D08BF", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_A1640CA925E678804FDACBF62783");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_81A3107CC31014AFB8F053D9530E374D08BF");
  [[var_0]]("_encstr_95F20B7323969855019F84072A", 4, 4, 4, 0.1, 0, "_encstr_95F20B7323969855019F84072A", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_88950F4756C643DB7DBDDDAF0DEB63DA3B", 2, 2, 2, 0.1, 0, "_encstr_95F20B7323969855019F84072A", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_95F20B7323969855019F84072A", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_88950F4756C643DB7DBDDDAF0DEB63DA3B", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_95F20B7323969855019F84072A", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_88950F4756C643DB7DBDDDAF0DEB63DA3B", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_95F20B7323969855019F84072A");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_88950F4756C643DB7DBDDDAF0DEB63DA3B");
  [[var_0]]("_encstr_B4F20BE89536A1DEF5BDBBAFA9", 4, 4, 4, 0.1, 0, "_encstr_B4F20BE89536A1DEF5BDBBAFA9", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_AC6A0FC84AE2B9ED9F7F1399659FD3855C", 2, 2, 2, 0.1, 0, "_encstr_B4F20BE89536A1DEF5BDBBAFA9", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B4F20BE89536A1DEF5BDBBAFA9", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC6A0FC84AE2B9ED9F7F1399659FD3855C", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B4F20BE89536A1DEF5BDBBAFA9", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AC6A0FC84AE2B9ED9F7F1399659FD3855C", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_B4F20BE89536A1DEF5BDBBAFA9");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_AC6A0FC84AE2B9ED9F7F1399659FD3855C");
  [[var_0]]("_encstr_A2640CB55AE2397A37CF3BD18D9D", 4, 4, 4, 0.1, 0, "_encstr_A2640CB55AE2397A37CF3BD18D9D", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_8CD3105B30DF0CAFE6B077A775A9A7D51B88", 2, 2, 2, 0.1, 0, "_encstr_A2640CB55AE2397A37CF3BD18D9D", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2640CB55AE2397A37CF3BD18D9D", ::_id_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8CD3105B30DF0CAFE6B077A775A9A7D51B88", ::_id_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A2640CB55AE2397A37CF3BD18D9D", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8CD3105B30DF0CAFE6B077A775A9A7D51B88", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_A2640CB55AE2397A37CF3BD18D9D");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "_encstr_8CD3105B30DF0CAFE6B077A775A9A7D51B88");
}

_id_1220A(var_0, var_1) {
  self.sightmaxdistance = 2000;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

_id_13210(var_0, var_1) {
  self.i_see_laststand_player_watcher = 1;
  self.equip_armor = 1;
  self.equip_helmet = 1;
  self.maxhealth = 600;
  self.health = 600;
  self.dontkilloff = 1;
}

monitor_wave_spawning() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A542198578B5CA4008CBCF39496B9890A167B340485F61F8379311");

  for(;;) {
    if(isDefined(level.spawned_enemies)) {
      if(level.spawned_enemies.size > 22) {
        scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
        wait 30;
      }

      if(level.spawned_enemies.size < 8)
        scripts\cp\cp_modular_spawning::unpause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
    }

    wait 1;
  }
}

setup_manual_goalpos(var_0, var_1) {
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "_encstr_84FE10129B386DEBCB48FA61711D3722E83F":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      break;
  }
}

_id_1436A(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_85620E029D73756572AFD070B1378DF1");

  while(var_0.ai_spawned.size <= 5)
    wait 1;

  while(var_0.activecount > 4)
    wait 1;

  level notify("_encstr_83C017EDBBFA0B6C8E4B3BC247ACFA99D24EDC3AAFEE85D9CA");
}

play_hack_reminder_goto2(var_0) {
  thread _id_12941();
}

_id_12941(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_81A8077D3088BFA631");
  wait 1;
  var_0 = scripts\engine\utility::getStruct("_encstr_BEE11452D9414FA7906D4F7AC5602FDFFDB61A8AA1A9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp\cp_modular_spawning::set_goal_radius(var_0.radius);
  scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
  wait(randomintrange(25, 35));
  thread vehicle_docollisiondamagetoplayer();
}

spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "_encstr_922406B1A6FD5E05")) {
      if(issubstr(var_1.type, "_encstr_A5AD0568019C63"))
        var_2 = var_2 + (0, 90, 0);
      else if(issubstr(var_1.type, "_encstr_8253061E2B5FE330") || issubstr(var_1.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_1.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_1.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
        var_2 = var_2 - (0, 90, 0);
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
  } else {}
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_830F1BACDC23FABB586756F5E8BAD9DE66BB854EBE37C18577375993CD");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

stopwaveandstartthisone(var_0) {
  level notify("_encstr_849A189DF887F13F278BA279E67A48CB47984B48F7F008F20592");
  wait 0.5;
  [[var_0]]();
}

handle_wavespawner_amount(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = "_encstr_91350EDBCE2B39DD161DC6D07DD87BEE";
      break;
    case 3:
      var_1 = "_encstr_917C0F7B3BCA39BBC2D1C61AD786A5B31A";
      break;
    case 4:
      var_1 = "_encstr_814C1040B58D063C9A73A8C849D852DE53F8";
      break;
  }

  if(var_0 == 0) {
    level scripts\engine\utility::_id_143A5("_encstr_85620E029D73756572AFD070B1378DF1", "_encstr_83C017EDBBFA0B6C8E4B3BC247ACFA99D24EDC3AAFEE85D9CA");
    wait 15;
  }

  if(var_0 == 4) {
    level scripts\engine\utility::_id_143A5("_encstr_85620E029D73756572AFD070B1378DF1");
    wait 15;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(1, var_1);
}

handle_pause_wavespawning() {
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
}

setup_router_objective(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = (11.9, 14.59, 40.5);
  var_2 = rotatevector(var_1, var_0.angles);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + var_2);
  var_3.angles = var_0.angles + (0, 180, 0);
  var_3 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_A57217730B9F43C71F5957BB435832730BB18F3570E363BFA0", &"_encstr_8FFE23B7C757899B3E13A7482397F7AA23DF5DCC4B51E5E31A6FF15917C7F1F2B4B9699BDE", 25, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BD1805CB69C063", 275, 110, 88, 60);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  for(;;) {
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(!var_4 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_4 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
    break;
  }

  level notify("_encstr_85620E029D73756572AFD070B1378DF1", var_0);
  var_3 makeunusable();
  var_3 setModel("_encstr_AFAA1DF783ABC1A329532B5B3F4E9A15F0E9AAF1D960919B6863235BBBF6A2");
  var_3 setscriptablepartstate("_encstr_A7F409337A498D17F7B75B", "_encstr_99AD06D3A5B1538B");
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  var_3 setscriptablepartstate("_encstr_A7F409337A498D17F7B75B", "_encstr_B4BA07CC5ADCB4CDD0");
  wait 30;
  var_3 delete();
}

spawn_overwatch_tanks() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BA7215E89D75DB80629B1070E742B64718D8077317C3DC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.altgunnerturret = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";
  level.overwatch_tanks = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level thread spawn_overwatch_tank(var_0[var_1], var_1);
    wait(1 + randomfloat(0.5));
  }
}

_id_135AD() {
  if(!isDefined(level.overwatch_tanks))
    level.overwatch_tanks = [];

  var_0 = scripts\engine\utility::getStruct("_encstr_B1511A570555C397D05B16DC5698C6CA39730FB393089A4760C10AA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread spawn_overwatch_tank(var_0, undefined, 250);
}

spawn_overwatch_tank(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = 50;

  var_3 = spawnStruct();
  var_4 = spawnStruct();
  var_3.origin = var_0.origin;
  var_3.angles = var_0.angles;
  var_3.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_3.owner = undefined;
  var_3.team = "_encstr_8E8405EA382B2A";
  var_3.faceawayfromowner = 0;
  var_3.cancapture = 0;
  var_3.cancaptureimmediately = 0;
  var_3.activateimmediately = 1;
  var_3.cantimeout = 0;
  var_3.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_3);
  var_3.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";
  var_5 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_3, var_4);

  if(!isDefined(var_5)) {
    return;
  }
  wait 10;

  if(isDefined(var_1)) {
    var_5.objiconid = var_1;
    objective_setlocation(level._id_11F68, var_5.objiconid, var_5);
  }

  level.overwatch_tanks[level.overwatch_tanks.size] = var_5;

  if(!isDefined(level.vo_paratroopers))
    level.vo_paratroopers = [];

  level.vo_paratroopers[level.vo_paratroopers.size] = var_5;
  var_5 thread tank_waittill_death();
  var_5 endon("_encstr_AD75063D571AE108");
  var_5 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_5 thread tank_hitmarkers();
  setheadiconsnaptoedges(var_5.headicon, 8000);
  var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_5, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_5, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  var_8 = 250000;
  var_9 = 36000000;
  var_10 = scripts\engine\utility::getStructArray("_encstr_AF1F14A7FC690B637B109A226179DEC36DF020211510", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = sortbydistance(var_10, var_5.origin)[0];
  var_5._id_13A4C = build_tank_path(var_11);
  var_5._id_13A46 = build_tank_duration(var_11);
  var_5 startpathnodes(var_5._id_13A4C, var_5._id_13A46, 0, 0.5, 0.5, 0, 0, 1);
  var_5 thread _id_14350();

  for(;;) {
    var_12 = var_5 scripts\cp\utility::get_closest_living_player(var_9);

    if(!isDefined(var_12)) {
      wait 1;
      continue;
    }

    if(istrue(var_12.binvehicle) && isDefined(var_12.vehicle)) {
      if(var_6 turretcantarget(var_12.vehicle.origin + (0, 0, 50)))
        var_6 settargetentity(var_12.vehicle);

      if(var_7 turretcantarget(var_12.vehicle.origin + (0, 0, 50)))
        var_7 settargetentity(var_12.vehicle);
    } else {
      var_6 _id_130F2(var_12, 9, var_2, var_8);
      var_7 settargetentity(var_12);
    }

    var_5 thread tank_shoot_at_target(var_7, 1);
    var_5 thread tank_shoot_at_target(var_6, undefined, 0.5);
    wait(randomfloatrange(11, 16));
  }
}

_id_130F2(var_0, var_1, var_2, var_3) {
  if(distancesquared(self.origin, var_0.origin) < var_3)
    self settargetentity(var_0);
  else {
    if(var_1 > randomint(9)) {
      if(!isDefined(var_2))
        var_2 = 20;

      var_4 = randomfloatrange(var_2 * -1, var_2);
      var_5 = randomfloatrange(var_2 * -1, var_2);
      var_6 = randomfloatrange(var_2 * -1, var_2);
      self settargetentity(var_0, (var_4, var_5, var_6));
      return;
    }

    self settargetentity(var_0);
  }
}

tank_hint_message() {
  wait 12;

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].team == "_encstr_9A8507BA4040188D08" && level.players[var_0] scripts\cp_mp\utility\player_utility::_isalive())
      level.players[var_0] thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_954027D00A7D9A5584AA9424D4BEA784942AA151A4CA544D978AA09CB47D110A6A82E8A8EB84A89841", 4);
  }
}

tank_hitmarkers() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
    }
  }
}

tank_shoot_at_target(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_3 = 8;
  var_4 = 2;

  if(istrue(var_1)) {
    var_3 = randomintrange(80, 120);
    var_4 = 0.05;
  }

  if(isDefined(var_2))
    wait(var_2);

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_0 shootturret();
    wait(weaponfiretime("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83") + var_4);
  }
}

build_tank_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2.origin)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

build_tank_duration(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = 4; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = 4)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.headicon))
    setheadiconimage(self.headicon);

  if(isDefined(self.objiconid))
    objective_unsetlocation(level._id_11F68, self.objiconid);

  level.overwatch_tanks = scripts\engine\utility::array_remove(level.overwatch_tanks, self);
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);
}

_id_14350() {
  self endon("_encstr_AD75063D571AE108");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

isprogressionmismatch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  while(getdvarint("_encstr_8C611937C627D732AC31BA76D7DB9D9593BB588EC6D0F5C4DE379B", 0) == 0)
    wait 1;

  level notify("_encstr_AD481A3783B0EE9BF5EDECB2C9DD5847C60DBEA156D85ABE13DBB96E");
}

run_helicopter_boss() {
  scripts\engine\utility::flag_init("_encstr_8E6716D788D9CFEF6B4870BF3CEDB4D4509CBAB7FD7D4F8F");
  level waittill("_encstr_AD481A3783B0EE9BF5EDECB2C9DD5847C60DBEA156D85ABE13DBB96E");
  level thread spawn_enemy_lbravo("_encstr_8E6716D788D9CFEF6B4870BF3CEDB4D4509CBAB7FD7D4F8F");
  level thread play_helicopter_vo();
  level stop_emp_effects_on_players();
  wait 1;
  scripts\engine\utility::flag_set("_encstr_8E6716D788D9CFEF6B4870BF3CEDB4D4509CBAB7FD7D4F8F");
}

spawn_enemy_lbravo(var_0) {
  if(scripts\engine\utility::flag_exist("_encstr_B6520A8E7852C3499BE8AC34"))
    scripts\engine\utility::flag_set("_encstr_B6520A8E7852C3499BE8AC34");

  var_1 = scripts\engine\utility::getStruct("_encstr_9B6810FA67AB0B71335563A1E7C3AB89EF2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_1.classname_mp = "_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8";
  var_1.script_modelname = "_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71";
  var_1.vehicletype = "_encstr_A60D0E2307118F4150A11F847AC08F30";
  level.overwatch_boss = scripts\common\vehicle::vehicle_spawn(var_1);
  level.overwatch_boss scripts\cp\helicopter\cp_helicopter::heli_mg_create("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED", "_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753", "_encstr_99FE0B2B19086F6B9DC5D387E1");
  level.overwatch_boss.spawnpoint = var_1;
  level.overwatch_boss.isheli = 1;
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = level.overwatch_boss;
  level.overwatch_boss.vehicletype = "_encstr_88CD07337F8B2B8083";
  level.overwatch_boss.health = 50000;
  level.overwatch_boss.maxhealth = 50000;
  level.overwatch_boss.team = "_encstr_8E8405EA382B2A";
  level.overwatch_boss setvehicleteam(level.overwatch_boss.team);
  level.overwatch_boss setmaxpitchroll(15, 15);
  level.overwatch_boss.health_remaining = 1500;
  level.overwatch_boss.showseasonalcontent = 1500;
  level.overwatch_boss.bullets_can_damage = 1;
  level.overwatch_boss thread flag_think(var_0, 0);
  level.overwatch_boss thread setup_pilot("_encstr_91A20B39B11731F50B2A7B0183", (0, 0, -20));
  level.overwatch_boss thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(undefined, 1500);
  level.overwatch_boss sethoverparams(25, 15, 10);
  level.overwatch_boss.minigun makeunusable();
  level.overwatch_boss.minigun hide();
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(level.overwatch_boss);
  level.overwatch_boss.circle_radius = 6000;
  level.overwatch_boss.should_move_to_target_dist = 7000;
  level.overwatch_boss.heli_can_target_dist = 7000;
  level.overwatch_boss.new_target_dist = 1200;
}

flag_think(var_0, var_1) {
  level.overwatch_boss endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_wait(var_0);

  if(istrue(var_1))
    level thread scripts\cp\helicopter\cp_helicopter::heli_rocket_think_default(level.overwatch_boss);
  else
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(level.overwatch_boss);
}

follow_path_until(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(isDefined(var_1)) {
    self cleartargetyaw();
    self cleargoalyaw();
    self.gotopos = var_1.origin;
    var_2 = self.gotopos;

    if(distance2dsquared(self.origin, var_2) > 640000) {
      self setneargoalnotifydist(300);
      self vehicle_setspeed(40, 30, 30);
      self setvehgoalpos(var_2, 0);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var_2, 0);
    }

    scripts\engine\utility::_id_143BB(15, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");

    if(isDefined(var_1.target) && var_1.target != var_0) {
      var_1 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      continue;
    }

    break;
  }

  var_3 = var_1;
  var_1 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  arrive_at_exfil_location(self, var_1, var_3);
}

arrive_at_exfil_location(var_0, var_1, var_2) {
  var_0 setvehgoalpos(var_2.origin, 1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 settargetyaw(var_1.angles[1]);
  var_0 setyawspeed(40, 25, 25, 0);
  wait 3;
  level notify("_encstr_AF0119589B2260A512E98715F14AE1C9915B21A807CBB969FA8D08");
  var_0.goalradius = 4;
  var_0 setvehgoalpos(var_1.origin, 1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 vehicle_setspeedimmediate(0);
  var_0 thread heli_sfx_shutdown();
  var_0 vehicle_cleardrivingstate();
  var_0 notify("_encstr_88900C8656D84BD7B185B932598C");
}

heli_sfx_shutdown() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_957B1923D3C7A76B4891B3FBBBA1D8EF18988180501F55E59507C8");
  wait 2;
  self vehicle_turnengineoff();
  level waittill("_encstr_86E50C03102BF76A7B07239CF817");
  self playSound("_encstr_A147180EA249715BDED7A3202BD770BBA20CE88E3AE2DF60AD03");
  wait 2;
  self vehicle_turnengineon();
}

setup_pilot(var_0, var_1, var_2) {
  var_3 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(isDefined(var_0))
    var_3 = var_0;

  var_4 = (0, 0, 0);

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = (0, 0, 0);

  if(isDefined(var_2))
    var_5 = var_2;

  if(!self tagexists(var_3))
    var_3 = "_encstr_AB680B55361AD76B09EB28E886";

  self.pilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_3));
  self.pilot setModel("_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30");
  self.pilot linkTo(self, var_3, var_4, var_5);
  self.pilot scriptmodelplayanim("_encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC");
}

heli_damagemonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;
  self.health = 1000000;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    self.health = 1000000;

    if(isDefined(var_2) && var_2 == self) {
      continue;
    }
    if(isDefined(var_14) && isDefined(var_14.owner) && var_14.owner == self) {
      continue;
    }
    if(is_snipe_kill(var_2, var_4, var_10)) {
      var_0++;

      if(var_0 == 2) {
        var_2 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_2 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");
        thread do_heli_crash(var_2);
        return;
      }

      var_2.lasthitmarkertime = undefined;
      var_2 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      continue;
    }

    if(!isexplosivedamagemod(var_5)) {
      if(istrue(self.bullets_can_damage))
        var_1 = var_1 * 0.1;
      else
        var_1 = 0;

      var_2.lasthitmarkertime = undefined;
      var_2 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
    } else {
      var_2.lasthitmarkertime = undefined;
      var_2 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8");

      if(isDefined(var_10) && var_10.basename == "_encstr_A93010035F88EE71B82FAD78F10352C7C518") {} else if(var_1 < 700)
        var_1 = 700;

      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
    }

    self.health_remaining = self.health_remaining - var_1;

    if(self.health_remaining <= self.showseasonalcontent * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"], self.origin);
      self.deathfx = 1;
    }

    if(self.health_remaining <= self.showseasonalcontent * 0.5 && !isDefined(self.deathfx1)) {
      playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], self.origin);
      self.deathfx1 = 1;
    }

    if(self.health_remaining <= self.showseasonalcontent * 0.75 && !isDefined(self.deathfx2))
      self.deathfx2 = 1;

    if(self.health_remaining <= 0) {
      thread ishelperdrone(self.origin);

      if(isDefined(var_10) && issubstr(var_10.basename, "_encstr_8DCB085BEF657B4DCF0B")) {
        if(isDefined(var_2) && isPlayer(var_2))
          var_2 thread scripts\cp\cp_achievement::scriptable_setups();
      }

      if(isDefined(var_2) && isPlayer(var_2))
        var_2 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");

      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot))
        self.pilot delete();

      self delete();
    }
  }
}

ishelperdrone(var_0) {
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0);
}

is_snipe_kill(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "_encstr_850707F7E5833355B8";

  if(!ispointnearpilot(self, var_1) || !var_3)
    return 0;

  return 1;
}

do_heli_crash(var_0) {
  thread crash_deathfx();
  self.vehicle_skipdeathmodel = 1;
  self.delay_before_delete = 0.25;
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  self notify("_encstr_AD75063D571AE108", var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", undefined, self.origin);
  scripts\common\vehicle_code::vehicle_docrash(var_0, "_encstr_AF07075BAD51B88D02");
  self makecorpse();
}

crash_deathfx() {
  self waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", var_0);
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
}

ispointnearpilot(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20)
    return 1;

  if(distance(var_1, var_5) <= 20)
    return 1;

  if(distance(var_1, var_6) <= 20)
    return 1;

  return 0;
}

debug_start_overwatch(var_0) {
  thread threaded_debug_start();
}

threaded_debug_start() {
  scripts\engine\utility::flag_wait("_encstr_8DE3256C07D77BB39539770B8E8DD0EBC6E49585E8B2F59B369CA507E8D7D8B76BC11B563A2B46");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A5CC1AB8CB3DC8E472BBB7A9FFCA25B0C56726B3F361801DC9E3B747", 1);
}

give_all_players_munition(var_0, var_1) {
  level endon("_encstr_A1650F852F652898FB7AA8F0228FC5D8FF");
  wait 0.1;

  if(isDefined(var_1))
    wait(var_1);

  for(var_2 = 0; var_2 < level.players.size; var_2++)
    level.players[var_2] thread each_player_remotestarted();

  level thread wait_for_gunship_used();
  level thread force_gunship_off_time();

  for(var_2 = 0; var_2 < level.players.size; var_2++)
    level thread give_gunship_access_after_personal_delay(level.players[var_2], var_0);
}

each_player_remotestarted() {
  level endon("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread changepropkey();

  while(!isDefined(level.gunship_intromodel))
    wait 0.1;

  level.gunship_intromodel waittill("_encstr_B83F124F639ABEB0B94B91ED4B21FFC9B0A38D78");
  level notify("_encstr_BEB60B605A2217735FEE2D36FD", self);
}

changepropkey() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");
  level endon("_encstr_A24C1DAF191D4F034F9B98B9D708E29621B16730686A94E2AEDC39AB39A832");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BD0414B9ED5B4795296049E3306B4117D35813388B23");
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(self, "_encstr_87500D7F058A49D1C023FF02B990F4");
  level waittill("_encstr_BEB60B605A2217735FEE2D36FD", var_0);

  if(isDefined(var_0) && var_0 != self)
    scripts\cp\utility::setlowermessage("_encstr_82A9084471E83D63FFA7", &"_encstr_BE121F1A82EBA6AA1255A4904DBED348492A0D2A252B15D4F2C43D9A154A501A51", 5);
}

wait_for_gunship_used() {
  level endon("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");
  level waittill("_encstr_BEB60B605A2217735FEE2D36FD", var_0);
  level thread track_gunship_uses_per_player();
  take_away_players_gunshipmunition();
}

track_gunship_uses_per_player() {
  wait 5;

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(!isDefined(level.players[var_0].gunship_uses)) {
      if(level.players[var_0] scripts\cp_mp\killstreaks\gunship::isusinggunship())
        level.players[var_0].gunship_uses = 1;

      continue;
    }

    if(level.players[var_0] scripts\cp_mp\killstreaks\gunship::isusinggunship())
      level.players[var_0].gunship_uses++;
  }
}

give_gunship_access_after_personal_delay(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A24C1DAF191D4F034F9B98B9D708E29621B16730686A94E2AEDC39AB39A832");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = 5;
  var_3 = 3;
  var_4 = 3;

  if(!isDefined(var_0.gunship_uses)) {
    if(isDefined(var_1) && var_1 == var_0)
      var_4 = var_4 - var_3;
  } else {
    for(var_5 = 0; var_5 < var_0.gunship_uses; var_5++)
      var_4 = var_4 + var_2;

    if(isDefined(var_1) && var_1 == var_0)
      var_4 = var_4 - var_3;
  }

  if(var_4 > 0)
    wait(var_4);

  var_0.saved_lastweapon = var_0 getcurrentweapon().basename;
  var_6 = scripts\cp\loot_system::get_empty_munition_slot(var_0);

  if(isDefined(var_6) && !istrue(var_0 _id_1246B())) {
    var_0 scripts\cp\cp_munitions::give_munition_to_slot("_encstr_A937066AFF52FA4F", var_6, "_encstr_8D390A3813DA6D6BE1AB6828");
    var_0._id_121AB = var_6;

    if(!isDefined(var_0.gunship_uses)) {
      wait 3;
      var_0 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_84E72209534F67A320ABDECE32294F8DF2BF81295F3EFDE7DEC755C01A300B773F1389A1", 4);
    }
  }
}

_id_1246B() {
  foreach(var_1 in self.munition_slots) {
    if(isDefined(var_1._id_134E2) && var_1._id_134E2 == "_encstr_8D390A3813DA6D6BE1AB6828")
      return 1;
  }

  return 0;
}

force_gunship_off_time() {
  level endon("_encstr_BEB60B605A2217735FEE2D36FD");
  level waittill("_encstr_BEB60B605A2217735FEE2D36FD");
  take_away_players_gunshipmunition();
}

take_away_players_gunshipmunition() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(isDefined(level.players[var_0]._id_121AB)) {
      var_1 = level.players[var_0]._id_121AB;
      var_2 = level.players[var_0].munition_slots[var_1];

      if(isDefined(var_2) && isDefined(var_2._id_134E2) && var_2._id_134E2 == "_encstr_8D390A3813DA6D6BE1AB6828") {
        level.players[var_0] haspassedsquadleader(var_1, var_2.ref);
        level.players[var_0] scripts\cp\cp_munitions::update_lua_inventory_slot(var_1);
      }
    }
  }

  level notify("_encstr_A24C1DAF191D4F034F9B98B9D708E29621B16730686A94E2AEDC39AB39A832");
}

haspassedsquadleader(var_0, var_1) {
  for(var_2 = 0; var_2 < self.munition_slots.size; var_2++) {
    if(var_2 == var_0) {
      if(isDefined(self.munition_slots[var_2].ref) && self.munition_slots[var_2].ref == var_1 && isDefined(self.munition_slots[var_2]._id_134E2) && self.munition_slots[var_2]._id_134E2 == "_encstr_8D390A3813DA6D6BE1AB6828") {
        scripts\cp\cp_munitions::give_munition_to_slot("_encstr_8BBA05185F8B99", var_0);
        var_3 = "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4";

        switch (var_0) {
          case 0:
            var_3 = "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4";
            break;
          case 1:
            var_3 = "_encstr_B1D214B107F5B5BACD96A3D2BDE6D764EB1DD25BB24E";
            break;
          case 2:
            var_3 = "_encstr_8DBB14C60EF5DAAEE64B3A4BDBE67D99F51D5ADAB29C";
            break;
          case 3:
            var_3 = "_encstr_A62B148E6FE78A15A820A3DFF840C7E70F8594855DE5";
            break;
        }

        self setclientomnvar(var_3, 0);
        self.munition_slots[var_2]._id_134E2 = undefined;
        level thread _id_11E0B(self);
      }
    }
  }
}

_id_11E0B(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\cp\utility::setlowermessage("_encstr_8322185723F0F3A8F0BB793A31F8E71BDDA92FF7FBA63B99D861", &"_encstr_BAE826F642A1F7E70A17A921677FFC8D58BF7EE5ECC913EF5F47E9595FB0F4615112C5E1F5616B35");
  wait 3;
  var_0 scripts\cp\utility::clearlowermessage("_encstr_8322185723F0F3A8F0BB793A31F8E71BDDA92FF7FBA63B99D861");
}

_id_13B07() {
  wait 15;
  var_0 = scripts\engine\utility::getStructArray("_encstr_A58511522B9DC33BE823C739901968A0D82FFB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread _id_135AD();
  level thread _id_1358F();
  level thread _id_135D5();
  wait 5;

  for(var_1 = 0; var_1 < 4; var_1++) {
    foreach(var_3 in var_0) {
      var_4 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level thread watchalleyplayerexit(var_3.origin, var_4.origin);
      wait(0.2 + randomfloat(0.75));
    }

    wait(40 + randomfloat(6));
    level notify("_encstr_9A0912DCA3ED83F5D67B398E0B9CD7DCADDEDA95");
  }
}

_id_135D5() {
  wait 15;
  level._id_121A5 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A9851EB8A39F2D2357AC6ED3AF37E8C907BA10D86BB9E133D7A260596AB773BF");
}

_id_12A06(var_0) {
  var_1 = randomfloatrange(var_0 * -1, var_0);
  var_2 = randomfloatrange(var_0 * -1, var_0);
  return (var_1, var_2, 0);
}

_id_1358F() {
  level endon("_encstr_8FFE1A07D46D9B13AF5181EA2F73D1868F95DEEC1BD2CBEF40C96770");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.vehicle_occupancy_giveriotshield = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7AD18D457CED986598DB47D6E3858EEE62B9CAFD458B5A6BEC4");
  level thread _id_138BD(60, "_encstr_A7AD18D457CED986598DB47D6E3858EEE62B9CAFD458B5A6BEC4");
  wait 4;
  level.vehicle_occupancy_handleplayerbc = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A3AD1802953B32E96259974113077A8760B735A98A3BAB63672E");
  level thread _id_138BD(60, "_encstr_A3AD1802953B32E96259974113077A8760B735A98A3BAB63672E");
  wait 4;
  spawn_lmg_soldiers_04(level.vehicle_occupancy_giveriotshield);
  level.vehicle_occupancy_hidecashbag = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_93AD18A9AECEEC86CA36B4EB9B072CBBCDACC97D530B5BA6EB33");
  level thread _id_138BD(60, "_encstr_93AD18A9AECEEC86CA36B4EB9B072CBBCDACC97D530B5BA6EB33");
  wait 4;
  spawn_lmg_soldiers_04(level.vehicle_occupancy_handleplayerbc);
  level.vehicle_occupancy_instanceisregistered = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91AD18AAC3EA5798F53BC881BF1871BFA26F1EB89CE23B6BE772");
  level thread _id_138BD(60, "_encstr_91AD18AAC3EA5798F53BC881BF1871BFA26F1EB89CE23B6BE772");
}

_id_138BD(var_0, var_1) {
  wait(var_0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
}

spawn_lmg_soldiers_04(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;

  for(;;) {
    if(var_0.currentmodulekills >= var_0.spawn_count) {
      break;
    }

    if(var_1 > 120) {
      break;
    }

    wait 0.5;
    var_1 = var_1 + 0.5;
  }
}

watchalleyplayerexit(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = undefined;

  if(isvector(var_0)) {
    var_2 = spawnStruct();
    var_2.origin = var_0;
    var_2.angles = (0, 0, 0);
    var_0 = var_2;
  }

  var_3 = self;
  var_4 = undefined;

  if(!isent(self)) {
    var_3 = var_2;
    var_4 = var_3.origin;
  } else
    var_4 = self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB");

  if(!isDefined(var_1))
    var_1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);

  thread _id_142E2(var_1);
  var_5 = scripts\engine\utility::spawn_tag_origin(var_4, (0, 0, 0));
  playFX(scripts\engine\utility::getfx("_encstr_935811B333E1AFCC8DC29CB2AF3616EACDB134"), var_3.origin + (0, 0, 3) + anglesToForward(var_3.angles) * 8, anglesToForward(var_3.angles));
  playsoundatpos(var_4, "_encstr_B60E16BB0F39D8F0B2D7959107AB3890D9226136F769881D");
  var_5 show();
  var_6 = 5;
  thread movemortar(var_5, var_4, var_1, var_6, 1200);
  var_5 setModel("_encstr_A103252B175D960EB6CA373AEBB6BD391D0B4EAF9B34AC36B1F52DD61C4EB7CE5ADC2B46BE60C4");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"), var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 playLoopSound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");
  wait(var_6 - 1.7);
  var_5 playSound("_encstr_8D6815EEACC2E0FAADBDC98EB0C97D4BDC36EDADB4E6CE");
  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"), var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 stoploopsound();
  var_7 = (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("_encstr_AA84191EFD527731C70F18A8C311E993B96713271509019BA11308", var_1);
  thread _id_11D31(var_1);
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 + (0, 0, 2));
  var_8 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_8 show();
  var_8.angles = (270, 0, 0);
  var_5 delete();
  wait 0.5;
  playFXOnTag(level._effect["_encstr_928B140D7B634890872150E8926C2816C98783B7D7DA"], var_8, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level waittill("_encstr_9A0912DCA3ED83F5D67B398E0B9CD7DCADDEDA95");
  stopFXOnTag(level._effect["_encstr_928B140D7B634890872150E8926C2816C98783B7D7DA"], var_8, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 1;
  var_8 delete();
}

movemortar(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1200;

  if(isDefined(var_4))
    var_5 = var_4;

  var_6 = 1 / (var_3 / 0.05);
  var_7 = 0;

  while(var_7 < 1) {
    var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_5, var_7);
    var_0 anglemortar();
    var_7 = var_7 + var_6;
    wait 0.05;
  }

  var_0.origin = var_2;
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

_id_142E2(var_0) {
  if(gettime() < level._id_11E67) {
    return;
  }
  var_1 = ["_encstr_A5E52889A3B1F6C8238130493519793E8A1B61170FAB507847A2DB411AFFB0EDB397F787D7720421312A", "_encstr_B1E528193C7DB1076EEBDAC26B16BED8B0631BDBAE8EFAD6ED9C4716277D851D8EB06CDAD29BD9D79118", "_encstr_81DC25910FAF36C137F5D62CDA2CFAD8166EE6EBDADE9CD1164EBE0BD1E816D85BD2379DFA2606", "_encstr_82DC254DD071BE5743B8CF8B09FFD6631FC786DFC07BADABA6C6A069339BCE4EC08BCDBF810312"];
  var_2 = scripts\cp\utility::give_all_players_nearby(var_0, squared(384));
  var_3 = scripts\engine\utility::random(var_1);

  foreach(var_5 in var_2)
  thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_5, var_3);

  level._id_11E67 = gettime() + 30000;
}

_id_11D31(var_0) {
  var_1 = 3;
  var_2 = 45;
  wait(var_1);
  var_3 = scripts\cp\cp_outline_utility::addoutlineoccluder(var_0, 300);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 show();
  var_5 = getEnt("_encstr_B1601D97C782C250DF5FC33905C9900D39173B37AB5B805834348B763AE55A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_4, "_encstr_8823119675DAFF897F878020BB99612B219D8F");
    var_4 clonebrushmodeltoscriptmodel(var_5);
    var_4 setmovertransparentvolume();
  } else
    var_4 delete();

  level waittill("_encstr_9A0912DCA3ED83F5D67B398E0B9CD7DCADDEDA95");

  if(isDefined(var_4))
    var_4 delete();

  scripts\cp\cp_outline_utility::removeoutlineoccluder(var_3);
}

enable_jammer_damage(var_0, var_1) {
  level thread mdl_allow_damage_jammers(var_0, var_1);
  level waittill("_encstr_97A311A6B0D66B2BC9F58DB7BBA12BC23647A1", var_2);
  wait 0.75;
  level notify("_encstr_8D6611D42CDADA2B4E7D91ACB9D1C97BF2568C");
  level.priority_player = var_2;
}

hint_jammer_damage(var_0) {
  var_1 = 193600;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(level.players[var_2].team == "_encstr_9A8507BA4040188D08" && level.players[var_2] scripts\cp_mp\utility\player_utility::_isalive()) {
      if(distancesquared(level.players[var_2].origin, var_0.origin) < var_1)
        level.players[var_2] thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_96B8236882EBA6AA12552921D4BE7A84A451862A25B2A26ACB9A127AE98AAFA428539AA249", 4);
    }
  }
}

mdl_allow_damage_jammers(var_0, var_1) {
  var_2 = get_jammer_mdl(var_0);
  var_2 thread allow_jammer_takedamage(var_1);
  var_2 thread jammer_hitmarkers();
}

get_jammer_mdl(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_849C0E8808B557CCD79968A0EE81A30F":
      var_1 = "_encstr_8106150B21A7C0DB18D9687691DD51BAFFADA741CFB89A";
      break;
    case "_encstr_8A9C0E275DA261FA8028252F2399686F":
      var_1 = "_encstr_870615637BDAF64EC8B7D2AF419577AAEF20E851AFE0AD";
      break;
    case "_encstr_859C0E80AE928F6049977038C35FF38F":
      var_1 = "_encstr_96061528986240EA2881CA3F3BC8EBD3F869FAC176BFFA";
      break;
    case "_encstr_AD9C0E9063820E35CA8D79752241C91B":
      var_1 = "_encstr_AD06156BE0EA08E95B760851B55A7DDA59D91401AF32CB";
      break;
    case "_encstr_979C0EE5716867929FF3978FF5A8FFC5":
      var_1 = "_encstr_850615F7EB84D25148CE844EA0689DCB700B53031F972F";
      break;
    case "_encstr_AA9C0E98529BDEED669220787BB111BB":
      var_1 = "_encstr_AA06156EB43B9BC236FA4D16D6B5954EF5B61936FA186C";
      break;
  }

  var_2 = getEnt(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  return var_2;
}

allow_jammer_takedamage(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 400;

  if(getdvarint("_encstr_ACC414C319850720253B0A1F61EB116BC180B16F2D44", 0) > 0)
    var_1 = 10;

  self.health = var_1;
  self.maxhealth = var_1;
  var_2 = var_1 * 0.8;
  var_3 = var_1 * 0.6;
  var_4 = var_1 * 0.4;
  self setCanDamage(1);
  self setCanRadiusDamage(1);

  while(self.health > var_2)
    wait 0.1;

  objective_sethot(var_0, 0);
  playFXOnTag(level._effect["_encstr_8FD81BE0F883617B3F3473CE0A0823A17B63457A4061BF9D9998298F6A"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playLoopSound("_encstr_81FE233F573A70F898399B735E74509DE23F85A3C75225389FCFC1A8465F78C08F6E7731CB");

  while(self.health > var_3)
    wait 0.1;

  stopFXOnTag(level._effect["_encstr_8FD81BE0F883617B3F3473CE0A0823A17B63457A4061BF9D9998298F6A"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self stoploopsound();
  playFXOnTag(level._effect["_encstr_A3D81B67330FBEE696CECD2CC6BE530BB6B52B93BE23165B0BB32BF591"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playLoopSound("_encstr_93F9239BD8B9EB8D0ED7B98EB0C8D2AEADAFA62CB6AD56C9F546B0B6C2D9597D1864BE1B0E");

  while(self.health > var_4)
    wait 0.1;

  stopFXOnTag(level._effect["_encstr_A3D81B67330FBEE696CECD2CC6BE530BB6B52B93BE23165B0BB32BF591"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self stoploopsound();
  playFXOnTag(level._effect["_encstr_93D81B676687AFB9D2EC9B85D8BE3585D6AD2B93D7230BAD2C9D95FA33"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playLoopSound("_encstr_84ED2323792067C6A097434C83680CB7D9962A8AAD09477A01D9492D9B48D7D7DF83F1E24B");

  while(self.health > 0)
    wait 0.1;

  var_5 = undefined;
  self waittill("_encstr_B2BE0788BAF573592F", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

  if(isDefined(var_7) && isDefined(var_7.team) && var_7.team != "_encstr_8E8405EA382B2A")
    var_5 = var_7;

  stopFXOnTag(level._effect["_encstr_93D81B676687AFB9D2EC9B85D8BE3585D6AD2B93D7230BAD2C9D95FA33"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self stoploopsound();
  self playSound("_encstr_AAA51B479040CFA279307AB307095AAD4809AB9748982D7BCFB5C7EEFD");
  playFXOnTag(level._effect["_encstr_A1D81B1D3583289FD361E896FB31F2C897737022D6C1F7472787B06792"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playLoopSound("_encstr_872723E7EF10D14398FED21BD1D0818B797F1B274BC93A2AB9A14EA5C9F0D5616F3147AB19");
  level notify("_encstr_97A311A6B0D66B2BC9F58DB7BBA12BC23647A1", var_5);
  wait 120;
  stopFXOnTag(level._effect["_encstr_A1D81B1D3583289FD361E896FB31F2C897737022D6C1F7472787B06792"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self stoploopsound();
  self playSound("_encstr_B44C1D2B9F2889EF5F86433BA9BD3FFBD87FBA812B684FE390532F71318043");
}

jammer_hitmarkers() {
  level endon("_encstr_97A311A6B0D66B2BC9F58DB7BBA12BC23647A1");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
    }
  }
}

_id_12DD6() {
  wait 10;
  scripts\engine\utility::flag_init("_encstr_93D00ED3760F28BFBF521679BA5367CB");
  level thread scripts\cp\utility::objective_update("_encstr_9A3514E0BA041F4873D58E04A903B1392152D010A25D", undefined, undefined, undefined, 1, undefined, 2);
  var_0 = scripts\engine\utility::getStruct("_encstr_88681280B6F4F82D18E393C4110CF39859E9B207", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_8D6B0FDEEEBECAC3CCA5B1EBB9C185BBDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_1248F = var_1;
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("_encstr_88681280B6F4F82D18E393C4110CF39859E9B207");
  waitframe();
  level notify("_encstr_91750BE60B41C076B37326D770", var_0.origin);
  level waittill("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  _id_130A8(level.heli_trip_vehicle);

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp_mp\xmike109::screenent_d("_encstr_811D0B60AF6F53294F409B09B3");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_3 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_A5320F42E803A71B1B98DCC5AE6637ADA1");
        continue;
      }

      var_3 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_8B5E131A59B0230DEA73E8959CBEADED91BE3BB21D");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_B45009027C7997B8E14BAB", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_88790841A4862D62A29A", 1);
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_9A3514E0BA041F4873D58E04A903B1392152D010A25D");
  scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");

  for(var_5 = 0; var_5 < level.players.size; var_5++)
    level.players[var_5].ability_invulnerable = 1;

  wait 1;
  scripts\cp\utility::skydiveontacinsertplacement();
  wait 1.5;
  wait 3;
  scripts\engine\utility::flag_set("_encstr_93D00ED3760F28BFBF521679BA5367CB");
}

spawn_fake_loots() {
  var_0 = ["_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6"];
  var_1 = getEntArray("_encstr_8FA00F02403B7237C9E5BBB868300F7D71", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 thread scripts\cp\utility::create_fake_loot(var_0);
}

spawn_overwatch_extraguns() {
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("_encstr_92CA0FBDCEB293DDB0A38D0DAFCE573737", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_weapon::buildweapon(var_2.script_noteworthy, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    var_4 = createheadicon(var_3);
    var_5 = spawn("_encstr_B2010820C5337B67C8CF" + var_4, var_2.origin);

    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_5.angles = var_2.angles;
    var_5 itemweaponsetammo(weaponclipsize(var_3), weaponmaxammo(var_3));
  }
}

_id_135AC() {
  if(istrue(level._id_11F69)) {
    return;
  }
  level._id_11F69 = 1;

  if(!isDefined(level.atvs))
    level.atvs = [];

  var_0 = scripts\engine\utility::getStructArray("_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
}

spawn_exfil_heli_and_rpgs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 3;
  var_0 = scripts\engine\utility::getStructArray("_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = 9000000;
  var_3 = [];
  var_4 = vehicle_getarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isent(var_4[var_5]) && isDefined(var_4[var_5].vehiclename) && var_4[var_5].vehiclename == "_encstr_8C190467402B" && !var_4[var_5] issuspendedvehicle() && distance2dsquared(var_1.origin, var_1.origin) < var_2)
      var_3[var_3.size] = var_4[var_5];
  }

  foreach(var_7 in var_3) {
    var_7 thread little_bird_mg_deathcallback();
    var_7 hudoutlineenable("_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40");
  }

  var_9 = level scripts\engine\utility::_id_143B9(60, "_encstr_85620E029D73756572AFD070B1378DF1");
  level notify("_encstr_AABF1570C28A9B11D30DC0C7F4537E7FF3FBA8900AA7F7");

  foreach(var_7 in var_3) {
    if(isent(var_7) && !var_7 issuspendedvehicle())
      var_7 hudoutlinedisable();
  }
}

little_bird_mg_deathcallback() {
  level endon("_encstr_AABF1570C28A9B11D30DC0C7F4537E7FF3FBA8900AA7F7");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    wait 0.1;

    if(!istrue(self.isempty)) {
      break;
    }
  }

  self hudoutlinedisable();
}

make_enemies_ignore_you() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\cp\utility::isignoremeenabled())
    scripts\cp\utility::allow_player_ignore_me(1);

  scripts\engine\utility::_id_143A6("_encstr_B45E151389187A1756D9AA720325DF72902BAD8D251047", "_encstr_8CF116A04FF6FB411A9A574136F393031FFB0878BF867101", "_encstr_AD75063D571AE108");

  if(scripts\cp\utility::isignoremeenabled())
    scripts\cp\utility::allow_player_ignore_me(0);
}

play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0))
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08", var_3, var_5, var_6);

  if(isDefined(var_1))
    wait(var_1);

  if(isDefined(var_2))
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
}

vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 / 1000;
  return var_1;
}

suicide_bomber_combat_func() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp\utility::get_closest_living_player();
  self getenemyinfo(var_0);

  for(;;) {
    self.bomberusegrenade = 0;

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on))
        self.bombertarget = self.enemy.vehicle_riding_on;
      else
        self.bombertarget = undefined;
    }

    wait 1;
  }
}

_id_123FF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE2011580117086F453760981644C3BF388577");
  level endon("_encstr_82110E2B659031D94945A3CA98B953E2");

  for(;;) {
    wait(randomfloatrange(20, 35));
    level play_vo_delay("_encstr_999C211428C1AE9F083FC90673325FE4813BF0051F9B0906ABCC530231D5C977CF6A88");
    wait(randomfloatrange(15, 25));
    level play_vo_delay("_encstr_BEE721A3F0DE5B3BA7E8940EE9AB81F420384F0B31B38412D19B1B05D84DBAAF0E92E2");
    wait(randomfloatrange(15, 25));
    level play_vo_delay("_encstr_88E72161430E01EB6FB06488C7BA612B8B488861E62843B15FEA8B27864681774937FA");
  }
}

play_intro_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_BE2011580117086F453760981644C3BF388577");
  level endon("_encstr_82110E2B659031D94945A3CA98B953E2");
  wait 2;
  level play_vo_delay("_encstr_87B61F81104F082F2B5FFFF38F52E0201E2FCB7BFECCD0EB0183C5EBC70A282AF0");
  level play_vo_delay("_encstr_93D01FD160C10837C7F170D9DB2F78B023D5457FE17340734F3A4BC0822330126A");
  level play_vo_delay("_encstr_A6B61F23705EDBBB2768148E692B016FC330E3E740D31302279E5A8445DDD97B63");
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B");
  level notify("_encstr_8DD91A7B67ACC9DD581DD80DAF1CD80BE5AC32FA2D373A4EEDAFCEED");
}

play_intro2_vo() {
  level play_vo_delay("_encstr_96D01F91C3AFD883CD7DC6B037E6D77B679527DD58471B1AAF139CA52B33BE8618");
  level._id_139B5 = 0;
}

play_jammer_destroyed_vo() {
  if(!isDefined(level.vo_jammerdestroyed))
    level.vo_jammerdestroyed = 1;
  else
    level.vo_jammerdestroyed++;

  var_0 = undefined;
  var_1 = undefined;
  level._id_139B5 = 1;

  switch (level.vo_jammerdestroyed) {
    case 1:
      var_0 = "_encstr_A9DC331F3BB73A607BE193AFA85317A28DDDE2532F59F2B0069897FB40C8E25A73EE210F85BF3BD2282087AB9940D792FB08B952D7";
      var_1 = undefined;
      break;
    case 2:
      var_0 = "_encstr_86DC33320FBE368337BEB1B0CDE6AFDBB3CAE4EEB01DC643FA371B392CADC48D56C97D3259B98EE4ED2FAC19D7CD7BB3D5DCD72360";
      var_1 = 1;
      break;
    case 3:
      var_0 = "_encstr_B1F42D68AB1729A10BE11997C223B7108677407837D4E1A9919286265E3A1538FDB3A1188F8B5B557A388D2539F7F9";
      var_1 = 2;
      break;
    case 4:
      var_0 = "_encstr_87DC333A784129AB56114C4B3B5380EF7BDAA863E9E19FB83EA8562357DA829A536B61EA9D6BFD53A0B3B7281002AFB1A31866FD9F";
      var_1 = undefined;
      break;
    case 5:
      var_0 = "_encstr_A2FD28AAE2407FEA60BF6471FFB8F9877CF94303A9AD27A4292B6C748FD0BE4B2F10FA3AB106AF5122B1";
      var_1 = 3;
      level.vo_jammerdestroyed = undefined;
      break;
  }

  if(isDefined(var_0)) {
    level.vehicle_cp_createlate = gettime();
    level play_vo_delay(var_0, undefined, undefined, undefined, 0.2);
  }

  if(isDefined(var_1)) {
    switch (var_1) {
      case 1:
        wait 0.2;
        level play_vo_delay("_encstr_8C4A2C9AD2706FFA704F9461D530C9970CE9731359BD17B439019166E9588DBBBD46FA6AA19EFF2CE87FD94F5BE2");
        level play_vo_delay("_encstr_9A4A2C2403D6B72AD7D1E20A60C1294F2B65BACF171B0F74E7203AF2D8391D6301C03358BD8167FC5DA127F97AD9");
        break;
      case 2:
        wait 0.2;
        level play_vo_delay("_encstr_96322D57F17FB6F0A3AF6A47D8BFBF2F6788B7B377921B688291F5327029BD3F0B8468EE334321F0A8BEC98A311290");
        level play_vo_delay("_encstr_B4512CCFDA29B3CB7E7F0B3775AD61E7C8C1C29311887B82400147135941AA3223EE3EDC09980BAA204F02DF1D57");
        level notify("_encstr_BA34164FCD08BAF79FBB0AC2A6EEB336E861C7DC7BB8043F");
        var_2 = ["_encstr_BE1E254C0B08D80B02477A991551778F27B17BED0B8C2789309287E65B822684626878FA198B43", "_encstr_AF1E25ACFB2E4FA25F491AB2F05351F741693C2F959377EB23B80269188916EFD843B6DF383392", "_encstr_8134251703698B3F3881C091B3EB4FAA7E942D6775F3413123CB8A11836A108F823872BFA91F8A", "_encstr_823425C8C3FA1B07E67D6385E6DCD71B8536C6EDEAD1FAD185E6D67DB90EB0BBDC5AE6EC7D460C"];
        level play_vo_delay(scripts\engine\utility::random(var_2), undefined, undefined, undefined, 1);
        break;
      case 3:
        level notify("_encstr_AD481A3783B0EE9BF5EDECB2C9DD5847C60DBEA156D85ABE13DBB96E");
        break;
    }
  }

  level._id_139B5 = 0;
}

play_jammer_returning_vo() {
  if(!isDefined(level.vo_jammerreturning))
    level.vo_jammerreturning = 1;
  else
    level.vo_jammerreturning++;

  level._id_139B5 = 1;
  var_0 = undefined;

  switch (level.vo_jammerreturning) {
    case 2:
      var_0 = "_encstr_A69A2DF9F30FDEE8BA3F81933BE2C990C35AB303CA1B06E0590BA7AD514DE8E957836E2B12F345482DF9B58F47A242";
      break;
    case 3:
      var_0 = "_encstr_AA9A2D3287D71B839B7DC616E66EFADEB3592777163A1B86FAE66C4EB0B52636599C7D4E2B1D579C9BD2CDB3FA6460";
      break;
    case 4:
      var_0 = "_encstr_B29A2D60A31F51D903F911AFCA3BBF189E4F58BB2FECE9A1A99A9E2EA6320D20F5BBA9A08784634D620437BC318FF1";
      break;
    case 5:
      var_0 = "_encstr_AA9A2D3287D71B839B7DC616E66EFADEB3592777163A1B86FAE66C4EB0B52636599C7D4E2B1D579C9BD2CDB3FA6460";
      break;
  }

  if(isDefined(level.vehicle_cp_createlate)) {
    if(gettime() < level.vehicle_cp_createlate + 6000)
      wait 6;
  }

  if(isDefined(var_0)) {
    wait 0.35;
    level play_vo_delay(var_0, undefined, undefined, undefined, 0.25);
  }

  level._id_139B5 = 0;
}

play_helicopter_vo() {
  level._id_139B5 = 1;
  level play_vo_delay("_encstr_AC6C28C86B3937FB375F31BF6BEFC6E7DB02F0C8928B6FB0AF8DC8A55DAF8E51C77AA001FA66AF6E66E0", undefined, undefined);
  level._id_139B5 = 0;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_AC6C28C86B3937FB375F31BF6BEFC6E7DB02F0C8928B6FB0AF8DC8A55DAF8E51C77AA001FA66AF6E66E0");
  level play_vo_delay("_encstr_AC6C28C86B3937FB375F31BF6BEFC6E7DB02F0C8928B6FB0AF8DC8A55DAF8E51C77AA001FA66AF6E66E0", undefined, undefined, 1, undefined, 40);
  level.overwatch_boss waittill("_encstr_AD75063D571AE108", var_0);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_AC6C28C86B3937FB375F31BF6BEFC6E7DB02F0C8928B6FB0AF8DC8A55DAF8E51C77AA001FA66AF6E66E0");

  if(isDefined(var_0) && isPlayer(var_0))
    thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_8CDC13176D9251D3D01B12DF73891B0BFE87A7EFF7");
}

heli_help(var_0) {
  level.overwatch_boss endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait(var_0);
    level thread give_all_players_munition(level.priority_player);
  }
}

tank_help(var_0) {
  level endon("_encstr_91FF15D8F33A8D8B018B48083F4C01FDA2DA58D58FD279");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait(var_0);
    level thread give_all_players_munition(level.priority_player);
  }
}

play_win_vo() {
  level._id_139B5 = 1;
  level play_vo_delay("_encstr_A30A2A9B2399561AB0A929E76B5BB8B2BB879B9C5ABD296CB67FF0E77B33C0F04F9FFA40B3948AF3B9A92383");
  wait 1;
  level play_vo_delay("_encstr_8A562A89837F4E782AAF3F23B59639B773CAC3937A8BF670C965233FB3FCF0582F02F858D3033DC81F7F9DB1");
  wait 1;
  level play_vo_delay("_encstr_8D0A2A8CE17D6C0E37BE36B09BCDEBB7B3569C77583AB1A1D7DA4B37DCA5ED377DC6EDB638B12B3ACAAF3303");
  wait 1;
  level play_vo_delay("_encstr_9A562A61D071B8A75761E0A9AAF7C820D325D5CF71E3F0E3BF7AB81353EF986021BB6743084D18357F311B73");
  level._id_139B5 = 0;
}

_id_130A8(var_0) {
  foreach(var_2 in level.players)
  var_2 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_2 in level.players) {
    if(!istrue(var_2.try_to_punish_with_jugg)) {
      continue;
    }
    var_5 = var_2 getEye();
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_6.angles = (0, 200, 0);
    var_6 linkTo(var_0);
    var_2 playerhide();
    var_2 allowfire(0);
    var_2 disableoffhandweapons();
    var_2 disableusability();
    var_2 allowmovement(0);
    var_2 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_2 spawn_endgame_camera(var_6);
    var_2 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}