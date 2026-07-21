/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_br.gsc
***********************************************/

main() {
  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootcallbacks())
    [[level.lootchopper_initcircleinfo]]();
  else {
    setup_callbacks();
    setup_bot_br();
  }
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_br_think;
}

setup_bot_br() {
  setdvarifuninitialized("_encstr_ADB51D1D13296B908EB478169E7FB88803FF89BFDBD321289F0EE029855B78", 0.25);
}

bot_br_think() {
  self notify("_encstr_9B320D96702C1FE6333F8B90900E3A");
  self endon("_encstr_9B320D96702C1FE6333F8B90900E3A");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = randomfloat(1) < getdvarfloat("_encstr_ADB51D1D13296B908EB478169E7FB88803FF89BFDBD321289F0EE029855B78", 0.0);
  thread brprewaitandspawnclientcleanup();
  self botsetflag("_encstr_AC050D3947F6E8038DB698B75BF160", 1);

  for(;;) {
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !scripts\mp\flags::gameflag("_encstr_A75411B7E0D72245126A426A8019D7B7FA7EEA")) {
      self.ignoreall = 0;
      wait 0.05;
      continue;
    }

    if(isDefined(self.br_infil_type)) {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !isDefined(self.steam_valve_think)) {
        self.ignoreall = 1;
        self botclearscriptgoal();
      }

      self botsetflag("_encstr_8D520FC2871706809DABBE37292CF7B892", 1);

      if((_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath() || var_0) && istrue(level.c130inbounds)) {
        var_1 = level.br_ac130.origin;
        var_2 = vectorNormalize(level.infilstruct.c130pathstruct.endpt - var_1);
        var_3 = (level.br_level.br_mapbounds[0][0] - var_1[0]) / var_2[0];
        var_4 = (level.br_level.br_mapbounds[0][1] - var_1[0]) / var_2[0];
        var_5 = (level.br_level.br_mapbounds[0][1] - var_1[1]) / var_2[1];
        var_6 = (level.br_level.br_mapbounds[1][1] - var_1[1]) / var_2[1];
        var_7 = [var_3, var_4, var_5, var_6];
        var_8 = -1;

        foreach(var_10 in var_7) {
          if(var_10 > 0) {
            if(var_8 < 0 || var_10 < var_8)
              var_8 = var_10;
          }
        }

        var_12 = var_1 + var_2 * var_8;
        var_13 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
        var_14 = var_8 / var_13;

        if(istrue(level.debug_interaction_status) && isDefined(level.infilstruct) && isDefined(level.infilstruct.c130pathstruct) && isDefined(level.infilstruct.c130pathstruct.neurotoxin_damage_monitor)) {
          var_15 = distance(level.infilstruct.c130pathstruct._id_1386E, level.infilstruct.c130pathstruct.neurotoxin_damage_monitor);
          var_14 = var_15 / var_13;
          var_16 = randomfloatrange(0.3, 0.6) * var_14;
        } else
          var_16 = randomfloatrange(0.1, 0.9) * var_14;

        wait(var_16);

        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())
          self notify("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82");
        else
          self notify("_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C");

        self.gulaguses = 1;

        if(getdvarint("_encstr_A3BB1443F642C906CA93F793EBA2D8C0D74F0B389EBF", 1) > 0)
          self.gulaguses = 0;

        self.vehicle_occupancy_monitorgameended = 1;

        while(isDefined(self.br_infil_type))
          wait 0.05;
      }

      wait 0.05;
      continue;
    }

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal()) {
      thread dangerzoneskipequipment();
      scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_91ED0AECABC60B3BEB95CD23");
      wait 3;
    } else
      self botclearscriptenemy();

    if(isDefined(level.br_circle) && isscriptabledefined()) {
      var_17 = undefined;
      var_18 = self bothasscriptgoal();

      if(var_18)
        var_17 = self botgetscriptgoal();

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        if((istrue(self isskydiving()) || istrue(self isparachuting())) && istrue(self.vehicle_occupancy_monitorgameended) && istrue(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())) {
          self botsetflag("_encstr_8D520FC2871706809DABBE37292CF7B892", 0);
          self botclearscriptgoal();
          deadpair();
        } else if(istrue(level.debug_interaction_status) && (istrue(self isskydiving()) || istrue(self isparachuting()))) {
          var_19 = getclosestpointonnavmesh(self.origin, self);
          var_20 = distance2dsquared(self.origin, var_19);
          var_21 = self botgetscriptgoalRadius();

          if(var_20 > var_21 * var_21) {
            self botsetflag("_encstr_8D520FC2871706809DABBE37292CF7B892", 0);
            var_22 = damageshield_time(self, var_19);
            self botlookatpoint(var_19, 0.05, "_encstr_A7300E08584D77DBA497CF3FC5432757");
            self botsetscriptmove(var_22[1], 0.05, 1);
            wait 0.05;
            continue;
          }
        }

        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !isDefined(self.steam_valve_think)) {
          self.ignoreall = 1;
          wait 1;
          continue;
        }

        var_23 = self botpathexists();
        var_24 = !var_18 || !var_23 || !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_17);

        if(var_18) {
          var_20 = distancesquared(self.origin, var_17);
          var_21 = self botgetscriptgoalRadius();
          var_25 = var_20 < var_21 * var_21;

          if(!var_25)
            self.lasttimereachedscriptgoal = undefined;
          else if(!isDefined(self.lasttimereachedscriptgoal))
            self.lasttimereachedscriptgoal = gettime();
        }

        var_26 = level.bot_personality_type[self.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3";

        if(isDefined(self.lasttimereachedscriptgoal)) {
          var_27 = 0;

          if(var_26)
            var_27 = 20000;

          var_24 = var_24 || gettime() - self.lasttimereachedscriptgoal >= var_27;
        }

        if(var_24) {
          var_28 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle();
          var_29 = self getclosestreachablepointonnavmesh(var_28);

          if(isDefined(var_29)) {
            self botsetscriptgoal(var_29, 1024, "_encstr_9ACC05B4156DF3", undefined, undefined, !var_26);
            self.lasttimereachedscriptgoal = gettime();
          }
        }
      }
    } else
      scripts\mp\bots\bots_personality::update_personality_default();

    wait 0.05;
  }
}

deadpair() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.ignoreall = 1;
  self.lategame_buytimer_set = damagestate();
  var_0 = gettime() + randomfloatrange(5, 10) * 1000;
  var_1 = 0;

  while(istrue(self isskydiving()) || istrue(self isparachuting())) {
    if(level.br_circle.circleindex > 0 && istrue(level.group_unset_jugg_standstill) && !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(self.lategame_buytimer_set))
      self.lategame_buytimer_set = damagestate();

    var_2 = damageshield_time(self, self.lategame_buytimer_set);
    var_3 = 1;
    self botlookatpoint(self.lategame_buytimer_set, 0.05, "_encstr_A7300E08584D77DBA497CF3FC5432757");
    self botsetscriptmove(var_2[1], 0.05, var_3);

    if(gettime() > var_0 && !var_1) {
      self botpressbutton("_encstr_84DD05D205AA0B", 1);
      var_1 = 1;
    }

    wait 0.05;
  }

  self.steam_valve_think = 1;
  self botlookatpoint(undefined);
  self.ignoreall = 0;
  dangerzoneids();
}

damagestate(var_0) {
  if(!isDefined(level.playerplunderpickupcallback) || level.playerplunderpickupcallback.size < 1) {
    level.playerplunderpickupcallback = puhostagerestoreweapon();
    level.playerplunderpickupcallback = scripts\engine\utility::array_randomize(level.playerplunderpickupcallback);
  }

  if(isDefined(level.br_circle) && isscriptabledefined()) {
    var_1 = scripts\engine\utility::random(level.playerplunderpickupcallback);

    if(isDefined(var_1)) {
      var_2 = var_1.origin;
      level.playerplunderpickupcallback = scripts\engine\utility::array_remove(level.playerplunderpickupcallback, var_1);
    } else
      var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle();

    return getclosestpointonnavmesh(var_2, self);
  }

  return undefined;
}

puhostagerestoreweapon() {
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  return scripts\engine\utility::get_array_of_closest(var_1, level.deactivate_station, undefined, undefined, var_0);
}

damageshield_time(var_0, var_1) {
  var_2 = vectorNormalize(var_1 - var_0.origin);
  return vectortoangles(var_2);
}

damageskipburndown(var_0, var_1) {
  return distance(var_0.origin, var_1);
}

dangernotifyresetforplayer() {
  if(!isDefined(level.currentsol))
    level.currentsol = ["_encstr_AFD81196BB83FADCDA7D0785832C9C817DAD83", "_encstr_A1AF15733C88381B0A0E8743929044085DAF9A1DBF905B", "_encstr_AAF517CFBB423116C23988C22020A00CCC5EC01B3E96EA7F68", "_encstr_A3A3125AEEE0FA366B7DAD9DDB63663368D7B538", "_encstr_93DB17967783AFB9DCEBDAA5D8DE9CE0F5AD8359DC1B7B0EAC", "_encstr_B2611B28F4B28733A8E60E77A33A51ADC163BEFD7968B040D51288D796", "_encstr_AC1B1643E780713E378959C312E77970E145F95F993EA80C", "_encstr_83AC16DB6C60D9632807B5C24AD808E43EE5B33F18B267DA", "_encstr_A99E1C2DBB07AF85E4BE33C2365AB60BF5AD38954E563363B2F0DA5ADCD2", "_encstr_86DE1796BBE0AFC24EFA6DD2637B866699FAB638B21636DE76", "_encstr_83181FEBE76A17B7F227DBC7C039C635030D57051B3BE2E898F9F1DADB1B884B82", "_encstr_B8F616CBC79FB04045F9B8101D319A7C813771F737F260D0"];

  var_0 = scripts\engine\utility::random(level.currentsol);

  switch (var_0) {
    case "_encstr_A1AF15733C88381B0A0E8743929044085DAF9A1DBF905B":
      if(!isDefined(level.deathnoise))
        level.deathnoise = 0;

      level.deathnoise++;

      if(level.deathnoise >= 1)
        level.currentsol = scripts\engine\utility::array_remove(level.currentsol, "_encstr_A1AF15733C88381B0A0E8743929044085DAF9A1DBF905B");

      break;
    case "_encstr_93DB17967783AFB9DCEBDAA5D8DE9CE0F5AD8359DC1B7B0EAC":
      if(!isDefined(level.deavtivate_destructible_cinderblock))
        level.deavtivate_destructible_cinderblock = 0;

      level.deavtivate_destructible_cinderblock++;

      if(level.deavtivate_destructible_cinderblock >= 1)
        level.currentsol = scripts\engine\utility::array_remove(level.currentsol, "_encstr_93DB17967783AFB9DCEBDAA5D8DE9CE0F5AD8359DC1B7B0EAC");

      break;
  }

  var_1 = [[level.fnbuildweapon]]([[level.fngetweaponrootname]](var_0), [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponclipsize(var_1));
  self switchtoweapon("_encstr_8BBA05185F8B99");
}

dangerzoneids() {
  self switchtoweapon("_encstr_8BBA05185F8B99");
  var_0 = propdeductchange();

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = riskspawn_getspawnlocations();
  }

  var_0.claimed = 1;
  var_1 = level.bot_personality_type[self.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3";
  self botsetscriptgoal(self getclosestreachablepointonnavmesh(var_0.origin), 256, "_encstr_AF2206AF7DE90BA7", undefined, undefined, !var_1);
  scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0.claimed = undefined;

  if(!istrue(self.inlaststand))
    dangernotifyresetforplayer();

  currenttime();
}

propdeductchange() {
  var_0 = propdeductclonechange();
  var_0 = sortbydistance(var_0, self.origin);
  var_1 = project_to_line_seg(var_0);

  if(!isDefined(var_1))
    var_1 = progression_speed(var_0);

  return var_1;
}

propdeductclonechange() {
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_2 = scripts\engine\utility::get_array_of_closest(var_1, level.damage_feedback_watch, undefined, undefined, var_0);
  return var_2;
}

project_to_line_seg(var_0) {
  foreach(var_2 in var_0) {
    if(!istrue(var_2.claimed))
      return var_2;
  }

  return undefined;
}

progression_speed(var_0) {
  return scripts\engine\utility::getclosest(self.origin, var_0);
}

mine_caves_breakable_gate_individual() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;)
    wait 0.05;
}

currenttime() {
  var_0 = level.bot_personality_type[self.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3";
  var_1 = 0;

  for(;;) {
    var_2 = riskspawn_debugdvar();
    var_1 = deactivate_gas_trap_trigger() || istrue(level.group_unset_jugg_standstill);

    if(var_1)
      var_2 = riskspawn_getspawnlocations();

    if(isDefined(var_2)) {
      var_3 = damagethisround();

      if(istrue(level.debug_jugg_health) && isDefined(var_3) && !var_1) {
        thread _id_13FA7();
        self getenemyinfo(var_3);

        if(self botgetpersonality() != "_encstr_BD560C63E89DE9BFF81D7747ADC0")
          scripts\mp\bots\bots_util::bot_set_personality("_encstr_BD560C63E89DE9BFF81D7747ADC0");

        if(self bothasscriptgoal())
          self botclearscriptgoal();

        if(!isDefined(self._id_12487)) {
          self botsetscriptenemy(var_3);
          self._id_12487 = var_3;
        }
      } else {
        self._id_12487 = undefined;
        self notify("_encstr_839E10E7D11D3A5C08F6CD95EED895F2ED19");

        if(self bothasscriptgoal())
          self botclearscriptgoal();

        self botclearscriptenemy();

        if(var_1)
          self botsetscriptgoal(var_2, 128, "_encstr_99CC09DA9020C4ECD149AD", undefined, undefined, 0);
        else
          self botsetscriptgoal(var_2, 400, "_encstr_AF2206AF7DE90BA7", undefined, undefined, 0);

        if(istrue(var_1))
          var_1 = 0;

        thread _id_121FA();
        var_4 = scripts\engine\utility::waittill_any_ents_return(self, "_encstr_8B7205D9ED5958", self, "_encstr_B69E0962C3200ECBBF9B9A", level, "_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD", self, "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B", self, "_encstr_B8B20D822784C089DBE9FD529FABBC");

        if(isDefined(var_4) && (var_4 != "_encstr_B69E0962C3200ECBBF9B9A" && var_4 != "_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD" && var_4 != "_encstr_B8B20D822784C089DBE9FD529FABBC" && var_4 != "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B")) {
          var_5 = gettime() + randomintrange(3, 8) * 1000;

          while(gettime() < var_5) {
            if(deactivate_gas_trap_trigger()) {
              self._id_12487 = undefined;
              self notify("_encstr_839E10E7D11D3A5C08F6CD95EED895F2ED19");
              break;
            }

            wait 0.1;
          }
        }
      }
    }

    wait 1;
  }
}

_id_121FA() {
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8B7205D9ED5958");
  self endon("_encstr_B69E0962C3200ECBBF9B9A");
  level endon("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD");
  wait 15;
  self notify("_encstr_B8B20D822784C089DBE9FD529FABBC");
}

dangerzoneskipequipment() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.bot_personality_type[self.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3";
  self._id_12487 = undefined;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self botclearscriptgoal();

  while(!istrue(self.gulagarena))
    wait 1;

  self.ignoreme = 0;
  self.ignoreall = 0;
  scripts\mp\bots\bots_util::bot_set_personality("_encstr_BD560C63E89DE9BFF81D7747ADC0");

  for(;;) {
    var_1 = self.arena;

    foreach(var_3 in var_1.arenaplayers) {
      if(var_3 == self) {
        continue;
      }
      if(istrue(var_1.overtime) && isDefined(var_1.managevehiclehealthui) && isDefined(var_1.managevehiclehealthui.arenaflag) && isDefined(var_1.managevehiclehealthui.arenaflag.flagmodel)) {
        self botsetscriptgoal(var_1.managevehiclehealthui.arenaflag.flagmodel.origin, 64, "_encstr_9A2B0A12F03587575B7BBEA5");
        self botclearscriptenemy();
        continue;
      }

      self getenemyinfo(var_3);
      self botsetscriptgoal(self getclosestreachablepointonnavmesh(var_3.origin), 256, "_encstr_AF2206AF7DE90BA7");
      self botsetscriptenemy(var_3);
    }

    wait 3;
  }
}

brprewaitandspawnclientcleanup() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 = self getweaponslistprimaries();

    if(var_0.size == 1 && var_0[0].basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") {
      wait 1;
      continue;
    }

    foreach(var_2 in var_0) {
      if(self getweaponammostock(var_2) < weaponclipsize(var_2))
        self setweaponammostock(var_2, weaponclipsize(var_2));
    }

    wait 0.1;
  }
}

damagethisround() {
  if(isDefined(level._id_12488) && gettime() <= level._id_12488)
    return undefined;

  var_0 = quickdropplaySound();

  if(!isDefined(var_0))
    return undefined;

  return var_0;
}

debug_jugg_maze() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2)) {
      continue;
    }
    if(var_2 data_pickup_logic_new())
      var_0++;
  }

  return var_0;
}

data_pickup_logic_new() {
  return isDefined(self._id_12487);
}

quickdropplaySound() {
  var_0 = get_player();
  var_1 = squared(3000);

  if(istrue(self.inlaststand) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
    return undefined;

  if(!isDefined(var_0) || istrue(var_0.inlaststand) || !isalive(var_0) || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
    return undefined;

  if(deactivate_gas_trap_trigger())
    return undefined;

  var_2 = prematchrandomloadout();

  if(var_2 >= 3) {
    if(distancesquared(var_0.origin, self.origin) > var_1)
      return undefined;

    var_3 = debug_jugg_maze();

    if(data_pickup_logic_new())
      return var_0;

    if(var_3 >= 1)
      return undefined;

    return var_0;
  } else
    return var_0;
}

get_player() {
  foreach(var_1 in level.players) {
    if(!isbot(var_1))
      return var_1;
  }
}

_id_13FA7() {
  self notify("_encstr_839E10E7D11D3A5C08F6CD95EED895F2ED19");
  self endon("_encstr_839E10E7D11D3A5C08F6CD95EED895F2ED19");
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self._id_12487 = undefined;
  level._id_12488 = gettime() + 7;
}

deactivate_gas_trap_trigger() {
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

  if(istrue(level.group_unset_jugg_standstill)) {
    var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
    return 0;

  if(!isalive(self) || self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    return 0;

  return !scripts\engine\utility::updatescrapassistdata(self.origin, var_0, var_1);
}

riskspawn_debugobjective(var_0) {
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle();

  if(!isDefined(var_0))
    var_0 = 1000;

  if(distance2d(self.origin, var_1) > var_0) {
    var_2 = vectortoangles(var_1 - self.origin);
    var_3 = anglesToForward(var_2);
    var_1 = self.origin + var_3 * var_0;
  }

  return self getclosestreachablepointonnavmesh(var_1);
}

riskspawn_getspawnlocations() {
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0, var_1, 0.75, 0.9, 1, 1);
  return self getclosestreachablepointonnavmesh(var_2);
}

riskspawn_debugdvar() {
  var_0 = gettime() + 5000;

  while(gettime() < var_0) {
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(self.origin, 750, 0.6, 1, 1, 1);
    var_2 = self getclosestreachablepointonnavmesh(var_1);

    if(updateprematchloadoutarray(var_2))
      return var_2;

    wait 0.05;
  }

  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle();
  return self getclosestreachablepointonnavmesh(var_3);
}

updateprematchloadoutarray(var_0) {
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  return scripts\engine\utility::updatescrapassistdata(var_0, var_1, var_2);
}

prematchrandomloadout() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) || !isalive(var_2) || var_2.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
      continue;
    }
    var_0++;
  }

  return var_0;
}

debug_freight_lift(var_0) {
  var_1 = level.teamdata[var_0.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

  if(scripts\engine\utility::array_contains(var_1, self))
    return 1;

  return 0;
}