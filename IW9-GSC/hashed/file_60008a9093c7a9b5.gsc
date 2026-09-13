/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_60008a9093c7a9b5.gsc
***********************************************/

_id_7624BFD29CC1CB18() {
  if(istrue(level._id_F84545F5D3D73BA9)) {
    return;
  }
  level._id_F84545F5D3D73BA9 = 1;
  register_spawn_modules();
  thread _id_A3C8AFFE1A1733F4();
  thread _id_BE6D92D20E2377A1();
  thread _id_648CA482C539FEA0();
}

register_spawn_modules() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("cp_raid1_boss1_create_script_completed");

  if(istrue(level._id_AE90EBDB0B867808)) {
    return;
  }
  level._id_AE90EBDB0B867808 = 1;
  _id_17E17F0C541451CC = ::_id_9FB88CB4C405C338;
  _id_FF33BBED1CB61238 = ::_id_5CADC7A34EA9883C;
  _id_0598913DFC460666 = ::_id_38F3602B37BE1258;
  _id_0A29223B463EC3EA = ::_id_F845480D763CE1A1;
  level._id_6EBF7FBB43F9F314 = ["bottom_closet_NE", "bottom_closet_SE", "bottom_closet_S", "bottom_closet_SW", "top_closet_N", "top_NE", "top_closet_SE", "top_closet_S", "top_closet_W", "top_NW", "backroom_closet", "backroom_closet_right"];

  foreach(spawn_group in level._id_6EBF7FBB43F9F314) {
    _id_18A73A64992DD07D::registerambientgroup(spawn_group, 0, _id_FF33BBED1CB61238, _id_17E17F0C541451CC, 0.1, undefined, _id_0A29223B463EC3EA, _id_0598913DFC460666);
    init_spawners(spawn_group);
  }

  _id_18A73A64992DD07D::registerambientgroup("breachroom_velikan", 1, 1, 1, 0.1, undefined, "breachroom_velikan");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("breachroom_velikan", ::_id_6CDAED77DC0BB24B);
  _id_18A73A64992DD07D::registerambientgroup("backroom_downstairs_adds", 3, 3, 3, 0.1, undefined, "backroom_downstairs_adds");
  _id_18A73A64992DD07D::registerambientgroup("final_boss_adds", 2, 2, 2, 0.1, undefined, "final_boss_adds");
  _id_18A73A64992DD07D::registerambientgroup("final_boss_juggs", 2, 2, 2, 0.1, undefined, "final_boss_juggs");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("final_boss_adds", ::_id_0F2673EB859E3F76);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("final_boss_juggs", ::_id_0F2673EB859E3F76);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_FAB499166EA67FE0();
  else
    _id_D2B3E48BFC92813E();

  _id_3D0EF4CC564F84DB = [scripts\cp\cp_spawning_util::set_recent_spawn_time_threshold_override, 5];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_6EBF7FBB43F9F314.size; _id_AC0E594AC96AA3A8++) {
    _id_18A73A64992DD07D::set_spawn_scoring_params_for_group(level._id_6EBF7FBB43F9F314[_id_AC0E594AC96AA3A8], undefined, 20000, 30000);
    scripts\cp\cp_spawning_util::register_module_init_func(level._id_6EBF7FBB43F9F314[_id_AC0E594AC96AA3A8], _id_3D0EF4CC564F84DB);
    _id_18A73A64992DD07D::register_module_ai_spawn_func(level._id_6EBF7FBB43F9F314[_id_AC0E594AC96AA3A8], ::_id_2444FD1EE191DACE);
  }
}

_id_D2B3E48BFC92813E() {
  _id_70989CF917B97159 = "ar_t1_aq";
  _id_222983CFBF7DB77F = "smg_t1_aq";
  _id_8752D118928DBF51 = "shotgun_t1_aq";
  _id_84BBC240F5607AD1 = "sniper_t1_aq";
  _id_151D6ACFB676F93D = "rpg_t1_aq";
  _id_5362BE84F14962F7 = "riotshield_t1_aq";
  _id_644071F90F781AF0 = "ar_t2_aq";
  _id_ED545BBC4669DEDC = "smg_t2_aq";
  _id_49336939CA41EA60 = "shotgun_t2_aq";
  _id_751E98863D3226AC = "sniper_t2_aq";
  _id_FAA794BC4FBFA5EE = "rpg_t2_aq";
  _id_E4ED6360E38240A6 = "riotshield_t2_aq";
  _id_56E062F906149BB7 = "ar_t3_aq";
  _id_28854BA91DF9181D = "smg_t3_aq";
  _id_DDFEAF298DB571CB = "shotgun_t3_aq";
  _id_E6C37FF62F38630F = "sniper_t3_aq";
  _id_1B5532A914C9DF23 = "rpg_t3_aq";
  _id_D872DDB148CE7A65 = "riotshield_t3_aq";
  _id_E21279FA90BDF012 = "jugg_aq";
  _id_2BF8DD8AC39471B3 = "boss_velikan";
  _id_5B42B85D821D822B("bottom_closet_NE", 1, [_id_644071F90F781AF0, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 0]);
  _id_5B42B85D821D822B("bottom_closet_SE", 1, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 1]);
  _id_5B42B85D821D822B("bottom_closet_S", 1, [_id_70989CF917B97159, _id_222983CFBF7DB77F], [0, 1]);
  _id_5B42B85D821D822B("bottom_closet_SW", 1, [_id_70989CF917B97159, _id_5362BE84F14962F7], [1, 1]);
  _id_5B42B85D821D822B("top_closet_S", 1, [_id_70989CF917B97159, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [0, 2, 0]);
  _id_5B42B85D821D822B("bottom_closet_NE", 2, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 0]);
  _id_5B42B85D821D822B("bottom_closet_SE", 2, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 1, 0]);
  _id_5B42B85D821D822B("bottom_closet_SW", 2, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 0]);
  _id_5B42B85D821D822B("top_closet_S", 2, [_id_70989CF917B97159, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [2, 2, 0]);
  _id_5B42B85D821D822B("bottom_closet_SE", 3, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [0, 1, 1]);
  _id_5B42B85D821D822B("bottom_closet_SW", 3, [_id_84BBC240F5607AD1, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [0, 1, 2]);
  _id_5B42B85D821D822B("top_closet_S", 3, [_id_70989CF917B97159, _id_ED545BBC4669DEDC, _id_DDFEAF298DB571CB], [0, 2, 0]);
  _id_5B42B85D821D822B("top_closet_N", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_151D6ACFB676F93D], [2, 2, 1]);
  _id_5B42B85D821D822B("top_NE", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_151D6ACFB676F93D], [2, 2, 1]);
  _id_5B42B85D821D822B("top_NW", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F], [1, 1]);
  _id_5B42B85D821D822B("top_closet_W", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F], [1, 1]);
  _id_5B42B85D821D822B("top_closet_S", 5, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC, _id_5362BE84F14962F7], [1, 1, 1]);
  _id_5B42B85D821D822B("bottom_closet_SE", 5, [_id_70989CF917B97159, _id_8752D118928DBF51, _id_ED545BBC4669DEDC], [1, 1, 1]);
  _id_5B42B85D821D822B("top_closet_N", 6, [_id_1B5532A914C9DF23], [1]);
  _id_5B42B85D821D822B("top_NE", 6, [_id_FAA794BC4FBFA5EE], [2]);
  _id_5B42B85D821D822B("top_NW", 6, [_id_FAA794BC4FBFA5EE], [2]);
  _id_5B42B85D821D822B("top_NE", 7, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_5362BE84F14962F7], [2, 1, 1]);
  _id_5B42B85D821D822B("top_NW", 7, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_FAA794BC4FBFA5EE], [1, 1, 0]);
  _id_5B42B85D821D822B("top_closet_SE", 8, [_id_E4ED6360E38240A6, _id_222983CFBF7DB77F, _id_28854BA91DF9181D], [1, 2, 1]);
  _id_5B42B85D821D822B("top_closet_W", 8, [_id_E4ED6360E38240A6, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [1, 2, 1]);
  _id_5B42B85D821D822B("backroom_closet", 9, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 1, 1]);
  _id_5B42B85D821D822B("backroom_closet_right", 9, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 1, 0]);
  _id_5B42B85D821D822B("top_NE", 9, [_id_E4ED6360E38240A6, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 0, 1]);
  _id_5B42B85D821D822B("backroom_closet", 10, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 1, 1]);
  _id_5B42B85D821D822B("backroom_closet_right", 10, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 1, 1]);
  _id_5B42B85D821D822B("top_NW", 10, [_id_E4ED6360E38240A6, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 1, 1]);
}

_id_FAB499166EA67FE0() {
  _id_70989CF917B97159 = "ar_t1_aq";
  _id_222983CFBF7DB77F = "smg_t1_aq";
  _id_8752D118928DBF51 = "shotgun_t1_aq";
  _id_84BBC240F5607AD1 = "sniper_t1_aq";
  _id_151D6ACFB676F93D = "rpg_t1_aq";
  _id_5362BE84F14962F7 = "riotshield_t1_aq";
  _id_644071F90F781AF0 = "ar_t2_aq";
  _id_ED545BBC4669DEDC = "smg_t2_aq";
  _id_49336939CA41EA60 = "shotgun_t2_aq";
  _id_751E98863D3226AC = "sniper_t2_aq";
  _id_FAA794BC4FBFA5EE = "rpg_t2_aq";
  _id_E4ED6360E38240A6 = "riotshield_t2_aq";
  _id_56E062F906149BB7 = "ar_t3_aq";
  _id_28854BA91DF9181D = "smg_t3_aq";
  _id_DDFEAF298DB571CB = "shotgun_t3_aq";
  _id_E6C37FF62F38630F = "sniper_t3_aq";
  _id_1B5532A914C9DF23 = "rpg_t3_aq";
  _id_D872DDB148CE7A65 = "riotshield_t3_aq";
  _id_E21279FA90BDF012 = "jugg_aq";
  _id_2BF8DD8AC39471B3 = "boss_velikan";
  _id_5B42B85D821D822B("bottom_closet_NE", 1, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [1, 1, 1]);
  _id_5B42B85D821D822B("bottom_closet_SE", 1, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 1]);
  _id_5B42B85D821D822B("bottom_closet_S", 1, [_id_70989CF917B97159, _id_ED545BBC4669DEDC], [0, 1]);
  _id_5B42B85D821D822B("bottom_closet_SW", 1, [_id_70989CF917B97159, _id_5362BE84F14962F7], [1, 1]);
  _id_5B42B85D821D822B("top_closet_S", 1, [_id_70989CF917B97159, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [0, 2, 0]);
  _id_5B42B85D821D822B("bottom_closet_NE", 2, [_id_56E062F906149BB7, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 0]);
  _id_5B42B85D821D822B("bottom_closet_SE", 2, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC, _id_8752D118928DBF51], [1, 1, 0]);
  _id_5B42B85D821D822B("bottom_closet_SW", 2, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 0, 0]);
  _id_5B42B85D821D822B("top_closet_S", 2, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [2, 2, 0]);
  _id_5B42B85D821D822B("bottom_closet_SE", 3, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [0, 1, 3]);
  _id_5B42B85D821D822B("bottom_closet_SW", 3, [_id_84BBC240F5607AD1, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [0, 1, 2]);
  _id_5B42B85D821D822B("top_closet_S", 3, [_id_70989CF917B97159, _id_ED545BBC4669DEDC, _id_DDFEAF298DB571CB], [0, 2, 1]);
  _id_5B42B85D821D822B("top_closet_N", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_151D6ACFB676F93D], [2, 2, 1]);
  _id_5B42B85D821D822B("top_NE", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F, _id_151D6ACFB676F93D], [2, 2, 1]);
  _id_5B42B85D821D822B("top_NW", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F], [1, 1]);
  _id_5B42B85D821D822B("top_closet_W", 4, [_id_70989CF917B97159, _id_222983CFBF7DB77F], [1, 1]);
  _id_5B42B85D821D822B("top_closet_S", 5, [_id_644071F90F781AF0, _id_ED545BBC4669DEDC, _id_5362BE84F14962F7], [1, 1, 2]);
  _id_5B42B85D821D822B("bottom_closet_SE", 5, [_id_70989CF917B97159, _id_8752D118928DBF51, _id_ED545BBC4669DEDC], [1, 1, 2]);
  _id_5B42B85D821D822B("top_closet_N", 6, [_id_2BF8DD8AC39471B3], [1]);
  _id_5B42B85D821D822B("top_NE", 7, [_id_D872DDB148CE7A65], [2]);
  _id_5B42B85D821D822B("top_NW", 7, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [0, 1, 1]);
  _id_5B42B85D821D822B("top_closet_SE", 8, [_id_D872DDB148CE7A65, _id_222983CFBF7DB77F, _id_8752D118928DBF51], [1, 2, 1]);
  _id_5B42B85D821D822B("top_closet_W", 8, [_id_D872DDB148CE7A65, _id_ED545BBC4669DEDC, _id_49336939CA41EA60], [1, 2, 1]);
  _id_5B42B85D821D822B("backroom_closet", 9, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 2, 1]);
  _id_5B42B85D821D822B("backroom_closet_right", 9, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 1, 1]);
  _id_5B42B85D821D822B("backroom_closet", 10, [_id_D872DDB148CE7A65, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 2, 1]);
  _id_5B42B85D821D822B("backroom_closet_right", 10, [_id_56E062F906149BB7, _id_28854BA91DF9181D, _id_49336939CA41EA60], [1, 2, 1]);
}

_id_0F2673EB859E3F76(group) {
  self endon("death");
  level endon("game_ended");
  _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

  for(;;) {
    _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

    if(distance2d(self.origin, _id_6D8E8725698EEFC2[0].origin) > 512)
      scripts\engine\utility::set_movement_speed(200);
    else
      scripts\engine\utility::set_movement_speed(100);

    if(isDefined(_id_6D8E8725698EEFC2[0]))
      self getenemyinfo(_id_6D8E8725698EEFC2[0]);

    wait 5;
  }
}

_id_6CDAED77DC0BB24B(group) {
  self endon("death");
  level endon("game_ended");
  goal = scripts\engine\utility::getStruct("breachroom_velikan_goal", "script_noteworthy");

  for(;;) {
    self.goalradius = 64;
    self.goalheight = 512;
    self setgoalpos(goal.origin);
    _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

    if(isDefined(_id_6D8E8725698EEFC2[0]))
      self getenemyinfo(_id_6D8E8725698EEFC2[0]);

    wait 10;
  }
}

_id_2444FD1EE191DACE(group) {
  if(isDefined(self.aitype)) {
    _id_4F2A0297830D644C = strtok(self.aitype, "_");

    switch (_id_4F2A0297830D644C[0]) {
      case "ar":
        break;
      case "smg":
        break;
      case "rpg":
        self setengagementmindist(1024, 1024);
        self setengagementmaxdist(2048, 2048);
        self _meth_9215CE6FC83759B9(2048);
        self.goalradius = 2500;
        self enabletraversals(0, "soldier");
        self allowedstances("stand");
        break;
      case "sniper":
        self setengagementmindist(1024, 1024);
        self setengagementmaxdist(2048, 2048);
        self _meth_9215CE6FC83759B9(2048);
        self.goalradius = 2500;
        self enabletraversals(0, "soldier");
        break;
      default:
        break;
    }
  }

  _id_51A5A63AC735F21F(group);
  _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);
  _id_F077ADF688122C36 = strtok(group.group_name, "_");

  if(_id_F077ADF688122C36[0] == "backroom") {
    return;
  }
  if(isDefined(_id_6D8E8725698EEFC2[0])) {
    self getenemyinfo(_id_6D8E8725698EEFC2[0]);

    if(_id_F077ADF688122C36[0] == "bottom" || _id_06F1F44ACF56C9FC() >= 3) {
      self.goalradius = 128;
      self setgoalentity(_id_6D8E8725698EEFC2[0]);
      thread _id_F6C54B101A5CB744();
    }
  }

  if(_id_F077ADF688122C36[0] == "top") {
    self.dropweapon = 0;

    if(_id_06F1F44ACF56C9FC() < 3) {
      thread _id_DFBBB49018B737C8();
      thread _id_CE8B99DA7B30AD60();
    } else if(self.enemy_group == "top_closet_SE")
      thread _id_A5D24CB2E4C122CB();

    thread _id_7906C2D3D743D331();
  }
}

_id_DFBBB49018B737C8() {
  level endon("game_ended");
  self endon("death");
  _id_B675F93741935039 = self.origin;
  wait 10;
  dist = distance2d(_id_B675F93741935039, self.origin);
  _id_5375B4F5A3664554 = 0;

  if(dist < 200) {
    _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

    if(isDefined(_id_6D8E8725698EEFC2[0])) {
      self getenemyinfo(_id_6D8E8725698EEFC2[0]);
      self setgoalentity(_id_6D8E8725698EEFC2[0]);
    }

    wait 5;

    if(_id_5375B4F5A3664554 >= 3) {
      self kill();
      return;
    } else {
      dist = distance2d(_id_B675F93741935039, self.origin);
      _id_5375B4F5A3664554++;
    }
  }
}

_id_CE8B99DA7B30AD60() {
  level endon("game_ended");
  self endon("death");
  _id_B675F93741935039 = self.origin;
  scripts\engine\utility::flag_wait("p2_finished");
  wait 1;
  dist = distance2d(_id_B675F93741935039, self.origin);

  if(dist < 200) {
    self kill();
    return;
  }

  for(;;) {
    _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

    if(isDefined(_id_6D8E8725698EEFC2[0])) {
      self getenemyinfo(_id_6D8E8725698EEFC2[0]);
      self setgoalentity(_id_6D8E8725698EEFC2[0]);
    }

    wait 10;
  }
}

_id_7906C2D3D743D331() {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::flag_wait("sub_door_3_cut");
  thread _id_A5D24CB2E4C122CB();
}

_id_A5D24CB2E4C122CB() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_6D8E8725698EEFC2 = sortbydistance(level.players, self.origin);

    if(isDefined(_id_6D8E8725698EEFC2[0])) {
      self getenemyinfo(_id_6D8E8725698EEFC2[0]);
      self setgoalentity(_id_6D8E8725698EEFC2[0]);
    }

    wait 7;
  }
}

_id_558806AFF7283125(player) {
  self endon("death");
  wait 5;
  self setgoalentity(player);
}

_id_648CA482C539FEA0() {
  level endon("game_ended");

  if(getdvarint("dvar_CA0F7A9EAE7CD4CC", 0) <= 0) {
    return;
  }
  _id_3F30F9BB65C6FC8C = _id_18AF78602B67B70C::_id_050326CC21187D35("test_wave_spawn", &"CP_RAID1_BOSS1/TEST_WAVE", "button_on");
  _id_76FA1A36ED9896E1 = _id_18AF78602B67B70C::_id_050326CC21187D35("test_tier_advance", &"CP_RAID1_BOSS1/LOOP_TIERS", "button_on");
  thread _id_06B4BE1C8079DBD1(_id_3F30F9BB65C6FC8C);
  thread _id_7633B4AB7CF120DE(_id_76FA1A36ED9896E1);
}

_id_7633B4AB7CF120DE(button) {
  level endon("game_ended");

  if(!isDefined(level._id_60A319552223FF52))
    level._id_60A319552223FF52 = 1;

  for(;;) {
    button _meth_DFB78B3E724AD620(1);
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);

    if(_id_7272ECCC685AED84() >= level._id_60A319552223FF52) {
      _id_DEF39566388E3795();
      iprintlnbold("wave tier 1");
    } else {
      _id_ECAD8DE71AA9FEFE();
      iprintlnbold("wave tier " + _id_7272ECCC685AED84());
    }

    wait 0.4;
  }
}

_id_06B4BE1C8079DBD1(button) {
  level endon("game_ended");

  for(;;) {
    button _meth_DFB78B3E724AD620(1);
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);
    _id_0EA9CEC839586465();
    wait 1;
  }
}

_id_38F3602B37BE1258(_id_F8E5E3AA5762A8E7) {
  level endon("game_ended");

  if(!isDefined(level.module_call_counter))
    level.module_call_counter = [];

  if(!isDefined(level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]))
    level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name] = 1;
  else
    level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]++;

  if(_id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7)) {
    _id_A75E674C355F4772 = _id_F8E5E3AA5762A8E7 _id_402C8788F9691DCD(_id_F8E5E3AA5762A8E7.group_name, level.module_call_counter[_id_F8E5E3AA5762A8E7.group_name]);
    _id_F8E5E3AA5762A8E7 create_ai_type_override(_id_A75E674C355F4772[0], _id_A75E674C355F4772[1]);
  }
}

_id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7) {
  tier = _id_7272ECCC685AED84();

  if(isDefined(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name]) && isDefined(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return 1;
  else
    return 0;
}

_id_402C8788F9691DCD(_id_CA8D3101C7736449, counter) {
  aitypes = [];
  weights = [];

  if(isDefined(counter) && isDefined(_id_CA8D3101C7736449) && _id_0CD68A61419FD07A(self)) {
    data = get_wave_data(self);
    aitypes = data.aitypes;
    weights = data.aitype_counts;
    return [aitypes, weights];
  }

  return [aitypes, weights];
}

create_ai_type_override(aitypes, weights) {
  if(!isDefined(self.aitype_override)) {
    self.aitype_override = [];
    self.aitype_override_weights = [];
    self.aitype_override_cumulative_weight = 0;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < aitypes.size; _id_AC0E594AC96AA3A8++) {
    self.aitype_override[self.aitype_override.size] = aitypes[_id_AC0E594AC96AA3A8];
    weight = _id_18A73A64992DD07D::define_var_if_undefined(weights[_id_AC0E594AC96AA3A8], 10);
    self.aitype_override_weights[self.aitype_override_weights.size] = weight;
    self.aitype_override_cumulative_weight = self.aitype_override_cumulative_weight + weight;
  }
}

_id_9FB88CB4C405C338(_id_F8E5E3AA5762A8E7) {
  tier = _id_7272ECCC685AED84();
  keys = getarraykeys(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name]);
  _id_222049A1CD0DEC46 = keys[keys.size - 1];
  tier = int(min(_id_222049A1CD0DEC46, tier));

  if(!isDefined(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return 0;
  else {
    _id_8A52520CE1A05C16 = getaiarray("axis").size - 1;
    _id_350FC69B17797361 = level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier].total_spawns;

    if(_id_8A52520CE1A05C16 + _id_350FC69B17797361 >= 20)
      return 0;
    else
      return _id_350FC69B17797361;
  }
}

_id_5CADC7A34EA9883C(_id_F8E5E3AA5762A8E7) {
  tier = _id_7272ECCC685AED84();
  keys = getarraykeys(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name]);
  _id_222049A1CD0DEC46 = keys[keys.size - 1];
  tier = int(min(_id_222049A1CD0DEC46, tier));

  if(!isDefined(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return 0;
  else
    return level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier].max_spawns;
}

init_spawners(groupname) {
  _id_8A0DA49670997C6D = scripts\engine\utility::getStructArray(groupname, "targetname");

  if(!isDefined(level._id_38E50D27B7AA5E9D))
    level._id_38E50D27B7AA5E9D = [];

  if(!isDefined(level._id_38E50D27B7AA5E9D[groupname]))
    level._id_38E50D27B7AA5E9D[groupname] = [];

  foreach(spawner in _id_8A0DA49670997C6D) {
    if(!isDefined(spawner.target)) {
      spawner._id_C8F0C14DD34F6B9C = spawnStruct();
      spawner._id_C8F0C14DD34F6B9C.origin = spawner.origin;

      if(!isDefined(spawner._id_C8F0C14DD34F6B9C.spawners))
        spawner._id_C8F0C14DD34F6B9C.spawners = [spawner];
    } else {
      _id_C8F0C14DD34F6B9C = scripts\engine\utility::getStruct(spawner.target, "targetname");
      spawner._id_C8F0C14DD34F6B9C = _id_C8F0C14DD34F6B9C;

      if(!isDefined(_id_C8F0C14DD34F6B9C.spawners))
        _id_C8F0C14DD34F6B9C.spawners = [];

      _id_C8F0C14DD34F6B9C.spawners[_id_C8F0C14DD34F6B9C.spawners.size] = spawner;
    }

    if(!scripts\engine\utility::array_contains(level._id_38E50D27B7AA5E9D[groupname], spawner._id_C8F0C14DD34F6B9C))
      level._id_38E50D27B7AA5E9D[groupname][level._id_38E50D27B7AA5E9D[groupname].size] = spawner._id_C8F0C14DD34F6B9C;
  }
}

_id_C0DB8DDB89E44BCE(destinations, _id_4351410D12107DF3, spawner_number) {
  _id_3DFDCC5DC839943F = [];
  _id_0BDB45DB038A3899 = sortbydistance(destinations, _id_4351410D12107DF3);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawner_number; _id_AC0E594AC96AA3A8++) {
    _id_C972C06FF2A6EB8F = _id_AC0E594AC96AA3A8;

    if(_id_AC0E594AC96AA3A8 >= _id_0BDB45DB038A3899.size)
      _id_C972C06FF2A6EB8F = 0;

    foreach(spawner in _id_0BDB45DB038A3899[_id_C972C06FF2A6EB8F].spawners) {
      _id_3DFDCC5DC839943F[_id_3DFDCC5DC839943F.size] = spawner;

      if(_id_3DFDCC5DC839943F.size == spawner_number)
        return _id_3DFDCC5DC839943F;
    }
  }

  return _id_3DFDCC5DC839943F;
}

_id_F845480D763CE1A1(_id_F8E5E3AA5762A8E7) {
  _id_259CBB4537DFC975 = _id_9FB88CB4C405C338(_id_F8E5E3AA5762A8E7);
  _id_3DFDCC5DC839943F = [];

  if(isDefined(level._id_38E50D27B7AA5E9D[_id_F8E5E3AA5762A8E7.group_name])) {
    targetplayer = scripts\engine\utility::random(level.players);
    destinations = level._id_38E50D27B7AA5E9D[_id_F8E5E3AA5762A8E7.group_name];

    if(!isDefined(targetplayer) || (!isDefined(_id_259CBB4537DFC975) || _id_259CBB4537DFC975 <= 0))
      _id_3DFDCC5DC839943F = [];
    else
      _id_3DFDCC5DC839943F = _id_C0DB8DDB89E44BCE(destinations, targetplayer.origin, _id_259CBB4537DFC975);
  } else {
    spawners = scripts\engine\utility::getStructArray(_id_F8E5E3AA5762A8E7.group_name, "targetname");
    spawners = scripts\engine\utility::array_randomize(spawners);

    if(spawners.size <= _id_259CBB4537DFC975)
      return spawners;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_259CBB4537DFC975; _id_AC0E594AC96AA3A8++)
      _id_3DFDCC5DC839943F[_id_3DFDCC5DC839943F.size] = spawners[_id_AC0E594AC96AA3A8];
  }

  return _id_3DFDCC5DC839943F;
}

get_wave_data(_id_F8E5E3AA5762A8E7) {
  tier = _id_7272ECCC685AED84();

  if(!isDefined(level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier]))
    return undefined;
  else
    return level._id_2967BC8E60D11904[_id_F8E5E3AA5762A8E7.group_name][tier];
}

_id_DEF39566388E3795() {
  level._id_9CF87F99923F3D4D = 1;
}

_id_FF738464CD835568(_id_4023BE37E4783071) {
  if(!isDefined(level._id_60A319552223FF52))
    level._id_60A319552223FF52 = 1;

  level._id_9CF87F99923F3D4D = _id_4023BE37E4783071;

  if(level._id_9CF87F99923F3D4D > level._id_60A319552223FF52)
    level._id_9CF87F99923F3D4D = level._id_60A319552223FF52;

  if(level._id_9CF87F99923F3D4D < 1)
    level._id_9CF87F99923F3D4D = 1;
}

_id_ECAD8DE71AA9FEFE() {
  if(!isDefined(level._id_60A319552223FF52))
    level._id_60A319552223FF52 = 1;

  if(!isDefined(level._id_9CF87F99923F3D4D))
    level._id_9CF87F99923F3D4D = 1;

  level._id_9CF87F99923F3D4D++;

  if(level._id_9CF87F99923F3D4D > level._id_60A319552223FF52)
    level._id_9CF87F99923F3D4D = level._id_60A319552223FF52;
}

_id_7272ECCC685AED84() {
  if(!isDefined(level._id_9CF87F99923F3D4D))
    level._id_9CF87F99923F3D4D = 1;

  return level._id_9CF87F99923F3D4D;
}

_id_5B42B85D821D822B(_id_CA8D3101C7736449, _id_8822C7A362F70DC9, aitypes, aitype_counts) {
  if(!isDefined(level._id_60A319552223FF52) || level._id_60A319552223FF52 < _id_8822C7A362F70DC9)
    level._id_60A319552223FF52 = _id_8822C7A362F70DC9;

  if(!isDefined(level._id_2967BC8E60D11904))
    level._id_2967BC8E60D11904 = [];

  if(!isDefined(level._id_2967BC8E60D11904[_id_CA8D3101C7736449]))
    level._id_2967BC8E60D11904[_id_CA8D3101C7736449] = [];

  if(!isDefined(level._id_2967BC8E60D11904[_id_CA8D3101C7736449][_id_8822C7A362F70DC9]))
    level._id_2967BC8E60D11904[_id_CA8D3101C7736449][_id_8822C7A362F70DC9] = spawnStruct();

  struct = level._id_2967BC8E60D11904[_id_CA8D3101C7736449][_id_8822C7A362F70DC9];
  struct.aitypes = aitypes;
  struct.aitype_counts = aitype_counts;
  struct.total_spawns = scripts\engine\utility::array_sum(aitype_counts);
  struct.max_spawns = struct.total_spawns;
  level._id_2967BC8E60D11904[_id_CA8D3101C7736449][_id_8822C7A362F70DC9] = struct;
}

_id_06F1F44ACF56C9FC() {
  _id_8A8EF17688ACD050 = scripts\cp\cp_objectives::is_objective_active("boss1_p3");
  _id_CD2BA8C9A19DF791 = scripts\cp\cp_objectives::is_objective_active("boss1_p2");
  _id_FE8D75DD9133FA97 = scripts\cp\cp_objectives::is_objective_active("boss1_p1");
  _id_00E5FB579CE5C61E = scripts\cp\cp_objectives::is_objective_active("boss1_p0");

  if(istrue(_id_8A8EF17688ACD050))
    return 3;

  if(istrue(_id_CD2BA8C9A19DF791))
    return 2;

  if(istrue(_id_FE8D75DD9133FA97))
    return 1;

  return 0;
}

_id_17DACC47A0D86FAB() {
  if(getdvarint("dvar_CA0F7A9EAE7CD4CC", 0) > 0) {
    return;
  }
  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_0830FD1D9F38AEC4 = _id_06F1F44ACF56C9FC();
  _id_C022E525EE54E83D = [];

  switch (_id_0830FD1D9F38AEC4) {
    case 1:
    default:
      _id_C022E525EE54E83D = [1, 2, 3];
      break;
    case 2:
      _id_C022E525EE54E83D = [4, 5, 6];
      break;
    case 3:
      if(scripts\engine\utility::flag("sub_door_3_cut"))
        _id_C022E525EE54E83D = [9, 10];
      else
        _id_C022E525EE54E83D = [7, 8];

      break;
  }

  _id_1F6EEF52622A36E9 = scripts\engine\utility::random(_id_C022E525EE54E83D);
  _id_FF738464CD835568(_id_1F6EEF52622A36E9);
  level thread _id_599F7FAC1840A189();
}

_id_0EA9CEC839586465() {
  level endon("game_ended");
  level endon("stop_boss_ambient_spawning");
  level notify("single_debug_boss_ambient_spawning");
  level endon("single_debug_boss_ambient_spawning");

  for(;;) {
    level thread _id_599F7FAC1840A189();

    if(getdvarint("dvar_0319ECBFFC274838", 0) < 1)
      return;
    else
      _id_FC3B274A006AAB2A();
  }
}

_id_9087E9EF731F305C() {
  level endon("game_ended");
  level endon("stop_boss_spawns");
  level notify("single_monitor_boss_combat_ai_spawns");
  level endon("single_monitor_boss_combat_ai_spawns");
  scripts\engine\utility::flag_wait("subarea_ready");
  wait 2;

  if(_id_06F1F44ACF56C9FC() <= 2)
    level thread _id_5FC259446A4DAD7C();

  level thread _id_382959D7794736CC::_id_88733CF2A8AD17EB();
  level thread _id_9F837421EB195521();
  level thread _id_4BA66EA37BAF87D2();

  if(isDefined(level._id_D92FC0A030677D28) || istrue(level._id_18525BF7CFF43F59))
    wait 20;

  for(;;) {
    level thread _id_17DACC47A0D86FAB();
    _id_FC3B274A006AAB2A();
  }
}

_id_FC3B274A006AAB2A() {
  level endon("game_ended");
  level endon("skip_current_wave_cd");
  starttime = gettime();
  waittime = 100;
  _id_4032C389B54F3E06 = _id_06F1F44ACF56C9FC();

  if(_id_4032C389B54F3E06 >= 3) {
    if(!scripts\engine\utility::flag("sub_door_3_cut"))
      waittime = 15;
    else
      waittime = 20;
  } else if(_id_4032C389B54F3E06 == 2) {
    if(!scripts\engine\utility::flag("manualoverride"))
      waittime = 5;
    else
      waittime = 40;
  }

  endtime = starttime + waittime * 1000;
  _id_A7F7B67D7E1B261A = _id_C28079EEA2948F1F();
  wait(waittime * _id_A7F7B67D7E1B261A);
  _id_8A52520CE1A05C16 = getaiarray("axis").size - 1;
  _id_D53F6ED6B32030A8();

  while(istrue(level._id_3647C17AC837CD0C))
    wait 1;
}

_id_D53F6ED6B32030A8() {
  level endon("game_ended");
  _id_2DBC7C5305828A30 = getaiarray("axis");
  _id_A492DC0A27A878DB = 999;
  _id_23D5856690CCBE88 = ["bottom_closet_NE", "bottom_closet_SE", "bottom_closet_S", "bottom_closet_SW", "top_closet_N", "top_NE", "top_closet_SE", "top_closet_S", "top_closet_W", "top_NW", "backroom_closet", "backroom_closet_right"];

  while(_id_A492DC0A27A878DB > 2) {
    _id_2DBC7C5305828A30 = getaiarray("axis");
    _id_A492DC0A27A878DB = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2DBC7C5305828A30.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_2DBC7C5305828A30[_id_AC0E594AC96AA3A8].aitype) && _id_2DBC7C5305828A30[_id_AC0E594AC96AA3A8].aitype == "boss_velikan") {
        waitframe();
        continue;
      }

      if(isalive(_id_2DBC7C5305828A30[_id_AC0E594AC96AA3A8]) && isDefined(_id_2DBC7C5305828A30[_id_AC0E594AC96AA3A8].enemy_group) && scripts\engine\utility::array_contains(_id_23D5856690CCBE88, _id_2DBC7C5305828A30[_id_AC0E594AC96AA3A8].enemy_group))
        _id_A492DC0A27A878DB++;
    }

    wait 2;
  }
}

_id_9F837421EB195521() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait_either("sub_door_2_cut", "sub_door_1_cut");
  _id_18A73A64992DD07D::run_spawn_module("backroom_downstairs_adds");
}

_id_5FC259446A4DAD7C() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("manualoverride");
  level waittill("started_using_crane_controls", player);
  _id_18A73A64992DD07D::run_spawn_module("breachroom_velikan");
}

_id_4BA66EA37BAF87D2() {
  level endon("game_ended");
  _id_18219177DE29A3A1 = _id_06F1F44ACF56C9FC();
  level._id_3647C17AC837CD0C = 0;
  scripts\engine\utility::flag_wait("bay_flooded");
  waitframe();
  scripts\engine\utility::flag_wait("p1_finished");
  waitframe();
  level._id_3647C17AC837CD0C = 1;
  scripts\engine\utility::flag_wait("manualoverride");
  waitframe();
  level._id_3647C17AC837CD0C = 0;
  waitframe();
  scripts\engine\utility::flag_wait("p2_finished");
  level._id_3647C17AC837CD0C = 1;
  level scripts\engine\utility::waittill_any_timeout_2(30, "saw_pickup_created", "saw_pickup_interact");
  level._id_3647C17AC837CD0C = 0;
  scripts\engine\utility::flag_wait("sub_door_3_cut");
  level notify("skip_current_wave_cd");
}

_id_192E12B39CD61190() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  _id_421681406E479DAF = scripts\engine\utility::getStruct("final_door_marker", "targetname");
  objectiveindex = scripts\cp\cp_objectives::requestworldid("boss1_final_door");
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_RAID1_BOSS1/CHASE_BOSS");
  objective_position(objectiveindex, _id_421681406E479DAF.origin + (0, 0, 20));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 0);
  level waittill("all_players_near_boss_exit");
  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid("boss1_final_door");
}

_id_A3C8AFFE1A1733F4() {
  level._id_8CDBCA2BCA083DD8 = [];
  level._id_8CDBCA2BCA083DD8["0"] = gettime();
  level._id_8CDBCA2BCA083DD8["0_1"] = 0;
  level._id_8CDBCA2BCA083DD8["1_2"] = 0;
  level._id_8CDBCA2BCA083DD8["2_3"] = 0;
  level thread _id_AF7D97650336C82F("0_1", "bay_flooded");
  level thread _id_AF7D97650336C82F("1_2", "p1_finished");
  level thread _id_AF7D97650336C82F("2_3", "p2_finished");
}

_id_AF7D97650336C82F(index, _id_AC3C804F26AA1413) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(_id_AC3C804F26AA1413);
  level._id_8CDBCA2BCA083DD8[index] = gettime();

  if(isDefined(level._id_D92FC0A030677D28)) {
    if(level._id_D92FC0A030677D28 == 1 && index == "0_1")
      level._id_8CDBCA2BCA083DD8["0"] = level._id_8CDBCA2BCA083DD8["0_1"] - 400000;

    if(level._id_D92FC0A030677D28 == 2 && index == "1_2")
      level._id_8CDBCA2BCA083DD8["0_1"] = level._id_8CDBCA2BCA083DD8["1_2"] - 500000;

    if(level._id_D92FC0A030677D28 == 3 && index == "1_3")
      level._id_8CDBCA2BCA083DD8["1_2"] = level._id_8CDBCA2BCA083DD8["2_3"] - 500000;
  }
}

_id_C28079EEA2948F1F() {
  _id_9E9F72050A6C93BA = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  _id_1779C5543CBEB11B = _id_06F1F44ACF56C9FC();

  if(_id_1779C5543CBEB11B == 3)
    return 1;

  _id_171AC810F2AEE64B = 600000;
  _id_3C485CC9EC491D09 = 120000;
  _id_CE7430240C14A1FB = 0.7;
  _id_D164D0678DECEA21 = undefined;
  _id_08E3D13127086DDA = undefined;

  switch (_id_1779C5543CBEB11B) {
    case 1:
    default:
      _id_CE7430240C14A1FB = 0.8;
      _id_D164D0678DECEA21 = level._id_8CDBCA2BCA083DD8["0"];
      _id_08E3D13127086DDA = level._id_8CDBCA2BCA083DD8["0_1"];
      break;
    case 2:
      _id_CE7430240C14A1FB = 0.7;
      _id_D164D0678DECEA21 = level._id_8CDBCA2BCA083DD8["0_1"];
      _id_08E3D13127086DDA = level._id_8CDBCA2BCA083DD8["1_2"];
      break;
  }

  if(isDefined(_id_D164D0678DECEA21) && isDefined(_id_08E3D13127086DDA)) {
    if(_id_D164D0678DECEA21 == 0 || _id_08E3D13127086DDA == 0)
      return 1;

    _id_FBD43DA47D8CECDF = _id_08E3D13127086DDA - _id_D164D0678DECEA21;
    _id_FBD43DA47D8CECDF = clamp(_id_FBD43DA47D8CECDF, _id_3C485CC9EC491D09, _id_171AC810F2AEE64B);
    _id_6C8D21B2E54B2478 = _id_FBD43DA47D8CECDF / _id_171AC810F2AEE64B;
    _id_6C8D21B2E54B2478 = max(_id_CE7430240C14A1FB, _id_6C8D21B2E54B2478);
    return _id_6C8D21B2E54B2478;
  } else
    return 1;
}

_id_AD0FA74D1A12F415() {
  enemies = getaiarray("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < enemies.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(enemies[_id_AC0E594AC96AA3A8]) && isDefined(enemies[_id_AC0E594AC96AA3A8].aitype) && enemies[_id_AC0E594AC96AA3A8].aitype == "boss_velikan")
      return 1;
  }

  return 0;
}

_id_599F7FAC1840A189() {
  level endon("game_ended");
  _id_26B0E4F14D4C062E = level._id_6EBF7FBB43F9F314;

  foreach(_id_F564CE57BB79FF69 in _id_26B0E4F14D4C062E) {
    _id_18A73A64992DD07D::stop_module_by_groupname(_id_F564CE57BB79FF69);
    waitframe();
    _id_F8E5E3AA5762A8E7 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_F564CE57BB79FF69);

    if(_id_208CCC1EF938EFD3(_id_F564CE57BB79FF69) && _id_0CD68A61419FD07A(_id_F8E5E3AA5762A8E7)) {
      level notify("boss1_ai_group_spawned", _id_F564CE57BB79FF69);
      _id_18A73A64992DD07D::run_spawn_module(_id_F564CE57BB79FF69);
    }
  }
}

_id_F6C54B101A5CB744() {
  self endon("death");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("p1_finished");
  destination = scripts\engine\utility::getStruct("crane_controls_room_marker", "script_noteworthy");
  self setgoalpos(destination.origin, 128);
}

_id_208CCC1EF938EFD3(_id_F564CE57BB79FF69) {
  if(scripts\engine\utility::flag("p1_finished")) {
    _id_F077ADF688122C36 = strtok(_id_F564CE57BB79FF69, "_");

    if(_id_F077ADF688122C36[0] == "bottom")
      return 0;
  }

  return 1;
}

_id_51A5A63AC735F21F(group) {
  _id_046ED662485EA221(self);
}

_id_046ED662485EA221(agent) {
  if(istrue(agent._id_102A9D2CF99AB325)) {
    return;
  }
  agent._id_65771500F49956C1 = 1;
  agent._id_102A9D2CF99AB325 = 1;
  agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_CD6A3A50F09688B9 = ::_id_6950EC92C0AB0545;
}

_id_6950EC92C0AB0545(agent, attacker) {
  agent detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_65771500F49956C1 = 0;
  _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082(agent, attacker);
}

_id_BE6D92D20E2377A1() {
  level endon("game_ended");

  if(istrue(level._id_2138005B50EF74DA)) {
    return;
  }
  level._id_2138005B50EF74DA = 1;
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("boss_dmr_weapon", "script_noteworthy");
  _id_335FCF144EAD102F = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_short_p05+grip_angled05+arscope_therm01+mag_sn_xlarge_p05+pgrip_p05+rec_scromeo+stock_ar_p05_scromeo");
  sweapon = getcompleteweaponname(_id_335FCF144EAD102F);

  foreach(struct in _id_9E4E1482CB40C9C5) {
    _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, struct.origin, 17);
    _id_B8F5AC23CE0DFDE3.angles = struct.angles;
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(_id_335FCF144EAD102F), weaponstartammo(_id_335FCF144EAD102F));
    _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(_id_335FCF144EAD102F), weaponstartammo(_id_335FCF144EAD102F));
    _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(_id_335FCF144EAD102F);
  }

  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("boss_pistol_weapon", "script_noteworthy");
  _id_335FCF144EAD102F = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  sweapon = getcompleteweaponname(_id_335FCF144EAD102F);

  foreach(struct in _id_9E4E1482CB40C9C5) {
    _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, struct.origin, 17);
    _id_B8F5AC23CE0DFDE3.angles = struct.angles;
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(_id_335FCF144EAD102F), weaponstartammo(_id_335FCF144EAD102F));
    _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(_id_335FCF144EAD102F), weaponstartammo(_id_335FCF144EAD102F));
    _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(_id_335FCF144EAD102F);
  }

  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("boss1_offhand_struct", "targetname");
  _id_18AF78602B67B70C::level_offhand_spawn(_id_D5ECF70A4D407B43);
}

_id_7BED63E134C9AE06(_id_335FCF144EAD102F) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player)) {
      if(isDefined(_id_335FCF144EAD102F)) {
        player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(_id_335FCF144EAD102F);
        continue;
      }

      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(self);
    }
  }
}

_id_D3CB8E66A665F324(_id_96AB835F044DC1E7) {
  if(!isDefined(_id_96AB835F044DC1E7))
    _id_96AB835F044DC1E7 = 0;

  _id_EB7C66EFC0D3AB70 = ["bottom_closet_NE", "bottom_closet_SE", "bottom_closet_S", "bottom_closet_SW", "top_closet_N", "top_NE", "top_closet_SE", "top_closet_S", "top_closet_W", "top_NW", "backroom_closet", "backroom_closet_right", "final_boss_adds"];
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(enemy in _id_FC9AC45209F959BB) {
    if(istrue(_id_96AB835F044DC1E7)) {
      if(isDefined(enemy.enemy_group) && scripts\engine\utility::array_contains(_id_EB7C66EFC0D3AB70, enemy.enemy_group))
        continue;
    }

    enemy kill();
  }
}

_id_33694E6EE38B809F() {
  level notify("stop_boss_spawns");

  if(getdvarint("dvar_F0F10B52A800D290", 0) > 0) {
    return;
  }
  _id_18A73A64992DD07D::run_spawn_module("final_boss_juggs");
}