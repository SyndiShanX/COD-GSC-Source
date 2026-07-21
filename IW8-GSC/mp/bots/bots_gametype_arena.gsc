/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_arena.gsc
***********************************************/

main() {
  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  _id_131DC();
}

setup_callbacks() {
  if(_encstr_8F431F033E8D20B1DDCB708D3270CF09537A130B900DBA08F8E65DC88B762F677F::ispickuploadouts()) {
    level.bot_funcs["_encstr_AB45151102CF209FFA23072F5FC2E79096D19B286C265B"] = ::calloutmarkerping_playteamsoundfx;
    level.bot_funcs["_encstr_8E6C1675DAB2A1335DA3D1988F710B270A097E0F35AA43F8"] = ::calloutmarkerping_removevehiclecalloutonspecialconditions;
  }

  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::currentsolsign;
}

_id_131DC() {
  if(!_encstr_8F431F033E8D20B1DDCB708D3270CF09537A130B900DBA08F8E65DC88B762F677F::isnormalloadouts())
    level.bots_gametype_handles_class_choice = 1;

  while(!isDefined(level.arenaflag))
    waitframe();

  damage_multiplier();

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3)
      return;
  }

  var_0 = scripts\engine\utility::ter_op(level.objmodifier == 1, 3, 1);
  _encstr_8FB2269BC6E42DE01DDC5EDA389731DB3A37BCC4F6476EFA3B0BB6ACA3BC38CAF58CB7DA177637C6::setup_bot_dom(var_0, 3);
}

currentsolsign() {
  self notify("_encstr_844C1098DE3AF50B4EB2E6B0BEA31A2DB96D");
  self endon("_encstr_844C1098DE3AF50B4EB2E6B0BEA31A2DB96D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self.pers["_encstr_8E581958BA53EFB89309D4DB16078D27BAE25048126DCB90973CE3"]))
    self.pers["_encstr_8E581958BA53EFB89309D4DB16078D27BAE25048126DCB90973CE3"] = self.personality;

  wait 0.1;

  if(!_encstr_8F431F033E8D20B1DDCB708D3270CF09537A130B900DBA08F8E65DC88B762F677F::isnormalloadouts()) {
    if(self botgetdifficultysetting("_encstr_82711489D52B67451FF88AC190557A2740CF1C097512") && self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
      _encstr_81F82673C7905CCB357BEEF223A0CB95F88F57EA470862AF54D1C27ACBE3BBCF491F857E6D68AA17::data_pickup_logic(self getcurrentweapon().basename, self.pers["_encstr_8E581958BA53EFB89309D4DB16078D27BAE25048126DCB90973CE3"]);
  }

  self.select_woods_one_spawners = 0;

  for(;;) {
    if(isDefined(level.arenaflag) && level.arenaflag.visibleteam == "_encstr_9A19040BCDBC") {
      self notify("_encstr_8FFE0E33587C49D7A863062B184FD683");

      if(!scripts\mp\bots\bots_util::bot_is_capturing() || !self.select_woods_one_spawners)
        scripts\mp\bots\bots_strategy::bot_capture_zone(level.arenaflag.trigger.origin, level.arenaflag.nodes, level.arenaflag.trigger);

      self.select_woods_one_spawners = 1;
    } else {
      self[[self.personality_update_function]]();
      thread bot_dom_think();
    }

    wait 0.05;
  }
}

calloutmarkerping_playteamsoundfx() {
  self notify("_encstr_BEF81F651FE30808D8EC70A819ABC85D4A77D1CD874B6758EC495B61BE70603763");
  self endon("_encstr_BEF81F651FE30808D8EC70A819ABC85D4A77D1CD874B6758EC495B61BE70603763");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83";

  for(;;) {
    var_1 = 0;

    if(calloutmarkerping_islootquesttablet() || scripts\mp\bots\bots_util::damagestatedata(0.33)) {
      if(self[[level.bot_funcs["_encstr_8252168E297F97F00D3748CB8040537BE0831F5F11D0E6B7"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        var_2 = getEntArray("_encstr_AD580F5F2388E9EB57322E3069A1074090", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_2);

        if(var_3.size > 0) {
          var_4 = var_3[0];
          level.moderestrictsarenakillstreaks = var_4;
          calloutmarkerping_navigationcancelproximity(var_4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0) {
      var_5 = self hasweapon(var_0);
      var_6 = var_5 && self getammocount(var_0) == 0;

      if(var_6) {
        if(isDefined(self.going_for_knife)) {
          wait 5.0;
          continue;
        }

        var_7 = getEntArray("_encstr_8BB40EE803A7CB21EAAFAF12050245D1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_7);

        foreach(var_10 in var_8) {
          if(!isDefined(var_10)) {
            continue;
          }
          if(!isDefined(var_10.calculated_closest_point)) {
            var_11 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_B8D91C321703FF17891F78A2525B18637DC74BF027E6D2C1F94B8FC170A3", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var_10.origin, 32, self);

            if(isDefined(var_10)) {
              var_10.closest_point_on_grid = var_11;
              var_10.calculated_closest_point = 1;
            } else
              continue;
          }

          if(isDefined(var_10.closest_point_on_grid)) {
            self.going_for_knife = 1;
            calloutmarkerping_navigationcancelproximity(var_10);
          }
        }
      } else if(var_5)
        self.going_for_knife = undefined;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

calloutmarkerping_navigationcancelproximity(var_0) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_B608149BDA686C4938BE7FEA3BC3F35FAFDAC6EF8D53", var_0) == 0) {
    if(istrue(level._id_1343F)) {
      var_1 = self botfirstavailablegrenade("_encstr_B116071BCAD186858D");
      var_2 = self botfirstavailablegrenade("_encstr_99C209E34FC743616118AB");

      if(isDefined(var_1) && var_1.basename == "_encstr_BA410C6338E0D79EC39832198839") {
        var_3 = scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");
        var_4 = scripts\mp\equipment::getequipmentammo(var_3);

        if(var_1.basename == "_encstr_BA410C6338E0D79EC39832198839" && var_4 > 3)
          return;
      }

      if(isDefined(var_2) && var_2.basename == "_encstr_8183093B28FB2D83C69150") {
        var_3 = scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8");
        var_4 = scripts\mp\equipment::getequipmentammo(var_3);

        if(var_2.basename == "_encstr_8183093B28FB2D83C69150")
          return;
      }
    }

    var_5 = undefined;

    if(var_0.targetname == "_encstr_AD580F5F2388E9EB57322E3069A1074090") {
      var_6 = 1;
      var_7 = self getweaponslistprimaries();

      foreach(var_9 in var_7) {
        if(var_0.model == getweaponmodel(var_9))
          var_6 = 0;
      }

      if(var_6)
        var_5 = ::calloutmarkerping_ismunitionsbox;
    }

    var_11 = spawnStruct();
    var_11.object = var_0;
    var_11.script_goal_radius = 12;
    var_11.should_abort = level.bot_funcs["_encstr_8E6C1675DAB2A1335DA3D1988F710B270A097E0F35AA43F8"];
    var_11.action_thread = var_5;
    var_12 = undefined;
    var_13 = var_0.origin;

    if(isDefined(var_0.deafen_ai_near_pa_for_duration))
      var_13 = var_0.deafen_ai_near_pa_for_duration;

    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_B608149BDA686C4938BE7FEA3BC3F35FAFDAC6EF8D53", var_13, 100, var_11);
  }
}

calloutmarkerping_ismunitionsbox(var_0) {
  self botpressbutton("_encstr_AB19049D0FC0", 0.5);
  thread _id_13FC6();
}

_id_13FC6() {
  self notify("_encstr_839918EA1C23C2475984F647AE56C2C1BD9B9095D02C9D2D7B4E");
  self endon("_encstr_839918EA1C23C2475984F647AE56C2C1BD9B9095D02C9D2D7B4E");
  wait 2;

  if(self botgetdifficultysetting("_encstr_82711489D52B67451FF88AC190557A2740CF1C097512") && self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
    _encstr_81F82673C7905CCB357BEEF223A0CB95F88F57EA470862AF54D1C27ACBE3BBCF491F857E6D68AA17::data_pickup_logic(self getcurrentweapon().basename, self.pers["_encstr_8E581958BA53EFB89309D4DB16078D27BAE25048126DCB90973CE3"]);
}

calloutmarkerping_removevehiclecalloutonspecialconditions(var_0) {
  if(calloutmarkerping_islethalequipment() > 0) {
    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var_0.object)) {
      var_2 = var_0.object.classname;

      if(scripts\engine\utility::string_starts_with(var_2, "_encstr_B2010820C5337B67C8CF"))
        var_2 = getsubstr(var_2, 7);

      var_3 = scripts\mp\utility\weapon::getweapongroup(var_2);

      if(!bot_weapon_is_better_class(var_1, var_3))
        return 1;
    }
  }

  if(!isDefined(var_0.object))
    return 1;

  if(var_0.object.targetname == "_encstr_AD580F5F2388E9EB57322E3069A1074090") {
    foreach(var_5 in self.weaponlist) {
      if(var_5.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")
        return 0;
    }

    if(calloutmarkerping_islethalequipment() > 0)
      return 1;
  } else if(var_0.object.targetname == "_encstr_8BB40EE803A7CB21EAAFAF12050245D1") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return 1;
    }
  }

  return 0;
}

calloutmarkerping_islethalequipment() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_1 = self.weaponlist;
  else
    var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  if(var_1.size == 1 && var_1[0].basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")
    var_0 = 0;

  return var_0;
}

calloutmarkerping_islootquesttablet() {
  var_0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_0 = self.weaponlist;
  else
    var_0 = self getweaponslistprimaries();

  if(var_0.size == 1 && var_0[0].basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")
    return 1;

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0)
      return 0;

    if(self getweaponammostock(var_2) > 0)
      return 0;
  }

  return 1;
}

bot_rank_weapon_class(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_A5EB0D7BCFF9182842D76F51639AEE":
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
    case "_encstr_998911DD5916C17BCDD795F01CB17B6E5AB356":
    case "_encstr_82F10F832FFB4B67E0E9897260907E55FA":
      break;
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      var_1 = 1;
      break;
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      var_1 = 2;
      break;
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
    case "_encstr_A3710BEEACC2E0B737EB36B676":
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
      var_1 = 3;
      break;
  }

  return var_1;
}

bot_weapon_is_better_class(var_0, var_1) {
  var_2 = bot_rank_weapon_class(var_0);
  var_3 = bot_rank_weapon_class(var_1);
  return var_3 > var_2;
}

vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "_encstr_AFFF0C6E8FE899DDE6174B068510");

  if(!isDefined(level.arenaflag.nodes))
    level.arenaflag.nodes = [];

  level.arenaflag.nodes[level.arenaflag.nodes.size] = var_1;

  if(!isDefined(level.objectives["_encstr_B20703DFCF"].bottargets))
    level.objectives["_encstr_B20703DFCF"].bottargets = [];

  level.objectives["_encstr_B20703DFCF"].bottargets[level.objectives["_encstr_B20703DFCF"].bottargets.size] = var_1;
}

damage_multiplier() {
  if(level.mapname == "_encstr_AAD50ADAE0D7ADAF385ADC59") {
    var_0 = (22, 12, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-4, 1, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (0, -33, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (35, -23, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  }
}

bot_dom_think() {
  self notify("_encstr_8FFE0E33587C49D7A863062B184FD683");
  self endon("_encstr_8FFE0E33587C49D7A863062B184FD683");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);

  for(;;) {
    scripts\mp\bots\bots_util::bot_update_camp_assassin();
    var_0 = gettime();

    if(var_0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592");
    }

    if(var_0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision())
        self.new_goal_time = var_0 + 5000;
      else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var_0 + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD9914B9AC95469BFAB959DDEBCC632C3BF5D9B758D8", 1.0);
  }
}

should_delay_flag_decision() {
  if(self.force_new_goal)
    return 0;

  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  if(self.current_flag _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam() == self.team)
    return 0;

  var_0 = get_flag_capture_radius();

  if(isDefined(self.current_flag.trigger) && distancesquared(self.origin, self.current_flag.trigger.origin) < var_0 * 2 * (var_0 * 2)) {
    var_1 = get_ally_flags(self.team);

    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self.current_flag) && !bot_allowed_to_3_cap())
      return 0;

    return 1;
  }

  return 0;
}

get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

has_override_flag_targets() {
  var_0 = get_override_flag_targets();
  return var_0.size > 0;
}

flag_has_been_captured_before(var_0) {
  return !flag_has_never_been_captured(var_0);
}

flag_has_never_been_captured(var_0) {
  return var_0.firstcapture;
}

bot_choose_flag() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = get_override_flag_targets();

  if(var_3.size > 0)
    var_4 = var_3;
  else
    var_4 = level.objectives;

  foreach(var_0 in var_4) {
    if(var_0.objectivekey == "_encstr_B20703DFCF") {
      continue;
    }
    var_6 = var_0 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(flag_has_been_captured_before(var_0))
      var_7 = 0;

    if(var_6 != self.team) {
      var_1[var_1.size] = var_0;
      continue;
    }

    var_2[var_2.size] = var_0;
  }

  var_9 = undefined;

  if(var_2.size == 1) {
    if(!bot_should_defend_flag(var_2[0], 1))
      var_9 = 1;
    else
      var_9 = !bot_should_defend(0.34);
  } else
    return;

  if(var_9) {
    var_10 = var_1;

    if(var_10.size == 1)
      var_0 = var_10[0];
  } else {
    var_11 = var_2;

    foreach(var_13 in var_11) {
      if(bot_should_defend_flag(var_13, var_2.size)) {
        var_0 = var_13;
        break;
      }
    }
  }

  if(var_9)
    capture_flag(var_0);
  else
    defend_flag(var_0);
}

bot_allowed_to_3_cap() {
  return 1;
}

bot_should_defend(var_0) {
  if(randomfloat(1) < var_0)
    return 1;

  var_1 = level.bot_personality_type[self.personality];

  if(var_1 == "_encstr_88FA0B7271CF407FE86D0FEBE3")
    return 1;
  else if(var_1 == "_encstr_930B07BB1B6B3854FF")
    return 0;
}

capture_flag(var_0, var_1, var_2) {
  self.current_flag = var_0;

  if(isDefined(var_0.trigger)) {
    if(bot_dom_debug_should_protect_all()) {
      var_3["_encstr_A105137B6759274EB4C8B2AFECB78536D7A32F382B"] = var_1;
      var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
      scripts\mp\bots\bots_strategy::bot_protect_point(var_0.trigger.origin, get_flag_protect_radius(), var_3);
    } else {
      var_3["_encstr_A105137B6759274EB4C8B2AFECB78536D7A32F382B"] = var_1;
      var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
      scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.trigger.origin, var_0.nodes, var_0.trigger, var_3);
    }

    if(!isDefined(var_2) || !var_2)
      thread monitor_flag_status(var_0);
  }
}

defend_flag(var_0) {
  self.current_flag = var_0;

  if(isDefined(var_0.trigger)) {
    if(bot_dom_debug_should_capture_all()) {
      var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
      scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.trigger.origin, var_0.nodes, var_0.trigger, var_1);
    } else {
      var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
      var_1["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"] = var_0.nearest_node;
      scripts\mp\bots\bots_strategy::bot_protect_point(var_0.trigger.origin, get_flag_protect_radius(), var_1);
    }

    thread monitor_flag_status(var_0);
  }
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius))
    level.capture_radius = 158;

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(1000, var_1 / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "_encstr_8267076C10DBE8B6E0") && var_0 != "_encstr_8D7C0DF02FE3A055F2A9CEDEBD7B9B" && var_0 != "_encstr_ACB10CD3D712C70844B1E3415195" && var_0 != "_encstr_8CC614AFA733EA82D5BE6CA57961A80533B86897A391") {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = get_specific_flag_by_label(var_2);

    if(isDefined(var_3) && bot_allow_to_capture_flag(var_3)) {
      self botmemoryevent("_encstr_BD560CF2309FE383DE9D4645A122", undefined, var_3.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          var_4 = distancesquared(self.origin, var_3.trigger.origin) < 490000;
          var_5 = bot_is_protecting_flag(var_3);

          if(var_4 || var_5) {
            capture_flag(var_3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(var_0, "_encstr_AAE70838F27E43E327DC")) {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_6 = get_specific_flag_by_label(var_2);
    var_6.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(var_0, var_1);
}

bot_allow_to_capture_flag(var_0) {
  var_1 = get_override_flag_targets();

  if(var_1.size == 0)
    return 1;

  if(scripts\engine\utility::array_contains(var_1, var_0))
    return 1;

  return 0;
}

monitor_flag_status(var_0) {
  self notify("_encstr_A3A914059848D2D1C2564F88E28F1AD788F313637B1F");
  self endon("_encstr_A3A914059848D2D1C2564F88E28F1AD788F313637B1F");
  self endon("_encstr_8FFE0E33587C49D7A863062B184FD683");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = get_num_ally_flags(self.team);
  var_2 = get_flag_capture_radius() * get_flag_capture_radius();
  var_3 = get_flag_capture_radius() * 3 * (get_flag_capture_radius() * 3);
  var_4 = 1;

  while(var_4) {
    var_5 = 0;
    var_6 = var_0 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();
    var_7 = get_num_ally_flags(self.team);
    var_8 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(var_6 == self.team && var_0.claimteam == "_encstr_8BBA05185F8B99") {
        if(!bot_dom_debug_should_capture_all())
          var_5 = 1;
      }

      if(var_7 == 2 && var_6 != self.team && !bot_allowed_to_3_cap()) {
        if(isDefined(var_0.trigger) && distancesquared(self.origin, var_0.trigger.origin) > var_2)
          var_5 = 1;
      }

      foreach(var_10 in var_8) {
        if(isDefined(var_10.trigger) && var_10 != var_0 && bot_allow_to_capture_flag(var_10)) {
          if(distancesquared(self.origin, var_10.trigger.origin) < var_3)
            var_5 = 1;
        }
      }

      if(isDefined(var_0.trigger) && self istouching(var_0.trigger) && var_0.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, var_12) < squared(var_13)) {
            var_14 = self getnearestnode();

            if(isDefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0.nodes) {
                if(!nodesvisible(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
                  break;
                }
              }

              if(isDefined(var_15)) {
                self.defense_investigate_specific_point = var_15;
                self notify("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(var_6 != self.team) {
        if(!bot_dom_debug_should_protect_all())
          var_5 = 1;
      } else if(var_7 == 1 && var_1 > 1)
        var_5 = 1;
    }

    var_1 = var_7;

    if(var_5) {
      self.force_new_goal = 1;
      var_4 = 0;
      self notify("_encstr_AD9914B9AC95469BFAB959DDEBCC632C3BF5D9B758D8");
      continue;
    }

    var_19 = level scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_8A7D175CB1488CF9B0D0E043426FDD099F73FAE1F372F84BB3", 1 + randomfloatrange(0, 2));
    var_20 = isDefined(var_19) && var_19 == "_encstr_995408F398012F656821";

    if(!var_20) {
      var_21 = max((3 - self.strategy_level) * 1.0 + randomfloatrange(-0.5, 0.5), 0);
      wait(var_21);
    }
  }
}

bot_dom_get_node_chance(var_0) {
  if(var_0 == self.node_closest_to_defend_center)
    return 1.0;

  if(!isDefined(self.current_flag))
    return 1.0;

  var_1 = 0;
  var_2 = get_flag_label(self.current_flag);
  var_3 = get_ally_flags(self.team);

  foreach(var_5 in var_3) {
    if(var_5 != self.current_flag) {
      var_1 = var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_5));

      if(var_1) {
        var_6 = get_other_flag(self.current_flag, var_5);
        var_7 = var_6 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

        if(var_7 != self.team) {
          if(var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_6)))
            var_1 = 0;
        }
      }
    }
  }

  if(var_1)
    return 0.2;

  return 1.0;
}

get_flag_label(var_0) {
  var_1 = "_encstr_B40101";

  if(isDefined(var_0.teleport_zone))
    var_1 = var_1 + (var_0.teleport_zone + "_encstr_BA4C02DF");

  var_1 = var_1 + ("_encstr_8F7905C4EDE23F" + var_0.objectivekey);
  return var_1;
}

get_other_flag(var_0, var_1) {
  foreach(var_3 in level.objectives) {
    if(var_3 != var_0 && var_3 != var_1)
      return var_3;
  }
}

get_specific_flag_by_letter(var_0) {
  var_1 = "_encstr_BA4C02DF" + tolower(var_0);
  return get_specific_flag_by_label(var_1);
}

get_specific_flag_by_label(var_0) {
  foreach(var_2 in level.objectives) {
    if(var_2.objectivekey == var_0)
      return var_2;
  }
}

get_closest_flag(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.objectives) {
    var_5 = distancesquared(var_4.trigger.origin, var_0);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

get_num_allies_capturing_flag(var_0, var_1) {
  var_2 = 0;
  var_3 = get_flag_capture_radius();

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(var_5.team == self.team && var_5 != self && scripts\mp\utility\entity::isteamparticipant(var_5)) {
      if(isai(var_5)) {
        if(var_5 bot_is_capturing_flag(var_0))
          var_2++;

        continue;
      }

      if(!isDefined(var_1) || !var_1) {
        if(var_5 istouching(var_0))
          var_2++;
      }
    }
  }

  return var_2;
}

bot_is_capturing_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return bot_target_is_flag(var_0);
}

bot_is_protecting_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting())
    return 0;

  return bot_target_is_flag(var_0);
}

bot_target_is_flag(var_0) {
  return self.current_flag == var_0;
}

get_num_ally_flags(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    var_4 = var_3 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 == var_0)
      var_1++;
  }

  return var_1;
}

get_enemy_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 == scripts\engine\utility::get_enemy_team(var_0))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

get_ally_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 == var_0)
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

bot_should_defend_flag(var_0, var_1) {
  var_2 = get_max_num_defenders_wanted_per_flag(var_1);
  var_3 = get_players_defending_flag(var_0);
  return var_3.size < var_2;
}

get_max_num_defenders_wanted_per_flag(var_0) {
  var_1 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(var_0 == 1)
    return ceil(var_1 / 6);
  else
    return ceil(var_1 / 3);
}

get_players_defending_flag(var_0) {
  var_1 = get_flag_protect_radius();
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(var_4.team == self.team && var_4 != self && scripts\mp\utility\entity::isteamparticipant(var_4)) {
      if(isai(var_4)) {
        if(var_4 bot_is_protecting_flag(var_0))
          var_2 = scripts\engine\utility::array_add(var_2, var_4);

        continue;
      }

      var_5 = gettime() - var_0.last_time_secured[self.team];

      if(var_5 < 10000) {
        continue;
      }
      if(isDefined(var_0.trigger) && distancesquared(var_0.trigger.origin, var_4.origin) < var_1 * var_1)
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

bot_dom_debug_should_capture_all() {
  return 0;
}

bot_dom_debug_should_protect_all() {
  return 0;
}