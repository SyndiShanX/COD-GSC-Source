/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58298.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_A1790BD0BB7517785F6EB4BD6A"] = ::init;
}

init() {
  build_vehicle_drop_off_list();
  scripts\engine\utility::flag_init("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
  level._id_13D26 = 0;

  if(level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"] == 1021) {
    init_nuke_vault((1735, 1184.25, 40), (0, 108, -90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_8D360838D3CB51A8EEEF", "_encstr_AC8B49D30338E0BB7AC91558128771AA25A25FB7BA900E99C21B0826B9F069DF8E4B9BCBC62B63AA8AFD5B1DF030422BA7CFE3683BB93018A9EF2A9825EE7A0AD03DF473BAB703A107F2FA");
    level._id_13D26 = 1;
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_AA1C072756CC63ACF0") {
    init_nuke_vault((1735, 1184.25, 40), (0, 108, -90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_8D360838D3CB51A8EEEF", "_encstr_8601265F40FA5F03DBA04D4492FB2F7173EADE1B98CBCCEB2BC1D57E0D0F33E280F067DFB0C340A7");
    level._id_14533 = [2500, 2500, 4000, 4000];
    level._id_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_8897074E96339963AC") {
    init_nuke_vault((1737, 1180.25, 40), (0, 75, -90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_8D360838D3CB51A8EEEF", "_encstr_A78439A5DDE0F537E6FA9B31B28E58652616E436DE373B56D8DBDA386536C23759391385B1C2E6B1AC1959CC0B373A93ACD8BD58919585B1ED9DCC");
    level._id_14533 = [2500, 2500, 5500, 5500];
    level._id_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_8D5609DA3DA4A282035BED") {
    init_nuke_vault((25.807, -553.161, 301), (180, 225, 90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_8D360838D3CB51A8EEEF", "_encstr_93F33FF33FAAA693CAA95060B22453B90ED803FE9257897DE432C8388BFE1D31567A876E0B3B50051B9ED03093D327A8CFF21BE7208610658623E810EAEDEF413B");
    level._id_14533 = [5000, 6000, 7000, 8000];
    level._id_13938 = [2, 2, 2, 3];
    level.armsrace_c4_planter_super = 1000;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A59306426009CA07") {
    level._id_14533 = [2200, 4000, 6500, 7500];
    level._id_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 8.5;
    level.player_retry_thread = 0.4;
    thread _id_12A8F();
    thread script_model_spawn_and_use();
    thread _id_1378E();
  } else if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A69907D822C7D8F838") {
    init_nuke_vault((-82, 1250, -195), (0, 180, -90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_8D360838D3CB51A8EEEF", "_encstr_8B6745233B9346F09D39A6C20B37AD1526F122DB09CB5D46D271B7C2F3223E088732C7D24A93FB0D68A587C3B2B37266C6AE1E508F804043292AD86F4720820233382FF2C79070");
    level._id_14533 = [4100, 5100, 6100, 6100];
    level._id_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 1.5;
  }

  level.trial_infinite_reserve_ammo = 1;
  var_0 = getEntArray("_encstr_A13C12A3C2E4B39547FA31C9D5CD1AD6F6232BC6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    var_2.targetname = "_encstr_A3BA05E0735C50";
    var_2.target = "_encstr_A3BA05E0735C50";
  }

  while(!isDefined(level.struct_class_names))
    waitframe();

  weapon_xp_iw8_sn_awhiskey();
  level.course_targets = gettargetarray();
  level.movers = scripts\engine\utility::getStructArray("_encstr_8D6A0CDAEDECCA93EBCDD12C39D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_4 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A"];
  var_5 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A"];
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.nodes_set_children = [];
  level.current_shield_tagattach = [];
  level.current_steps = [];
  level._id_13D7C = [];
  level._id_13D7D = [];

  foreach(var_7 in var_4) {
    if(!isDefined(level._id_13D7C[var_7]))
      level._id_13D7C[var_7] = [];

    foreach(var_9 in var_5) {
      if(!isDefined(level._id_13D7C[var_7][var_9]))
        level._id_13D7C[var_7][var_9] = [];
    }
  }

  foreach(var_13 in level.course_targets) {
    var_7 = var_13.targetname[4];
    var_9 = var_13.targetname[5];
    level._id_13D7C[var_7][var_9][level._id_13D7C[var_7][var_9].size] = var_13;

    if(var_7 == "_encstr_AC4C024A")
      level._id_13D7D[level._id_13D7D.size] = var_13;
  }

  dialog_init();
  progression();
}

progression() {
  _tablethide::waittill_player_isDefined();

  foreach(var_1 in level.course_targets) {
    var_1.activated = 0;
    var_1 thread target_think();
  }

  if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A59306426009CA07")
    thread process_struct_angle_tilt();

  hud_init();

  for(;;) {
    trial_score_init();

    if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A69907D822C7D8F838")
      thread serverroomrewardspawn();

    level._id_13A6E = 0;
    _tablethide::trial_ui_set_wave(1, level._id_13D7C.size);
    course_start_wait();
    level._id_13D64 = 0;
    thread _id_12EFA();
    _tablethide::_id_13D88();
    _tablethide::_id_13D89(0);

    if(level._id_13D26) {
      hideconesifinfil();
      level._id_13D64 = 1;
    } else {
      _id_14523();
      thread targets_missed_calculate();
    }

    _tablethide::_id_13D89(1);
    score_calculate(1);

    foreach(var_7 in level.player.primaryinventory)
    level.player setweaponammoclip(var_7, weaponclipsize(var_7));

    _tablethide::trial_ui_waittill_retry();
  }
}

course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }
  var_0 = getEnt("_encstr_8D360838D3CB51A8EEEF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_0)) {
    while(!isDefined(var_0.spawned_weapon))
      waitframe();

    while(isDefined(var_0.spawned_weapon))
      waitframe();
  } else
    level waittill("_encstr_99AD06D3A5B1538B");

  level.trial_first_start = 1;
  level notify("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8DBC10D60DF5E6CD9683B293D737D1B0271D");
  wait 1;
}

hideconesifinfil() {
  level._id_13D2D = 0;
  level endon("_encstr_9AD711ECAEB8179537988AA278BF81DB109D44");
  level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1");
  level._id_13D6E = gettime();
  thread hidedangercircle();
  var_0 = int(level._id_13D7D.size * 0.35);
  level._id_13D7D _id_129FF(var_0);
  var_1 = 0;
  level._id_13D4F = 0;

  for(;;) {
    var_2 = scripts\engine\utility::array_randomize(level._id_13D7D);
    var_3 = var_2[0];

    foreach(var_3 in var_2) {
      if(!var_3.state_up && !var_3.flipping) {
        if(!var_3.iscivilian) {
          var_3.script_speed = randomfloatrange(48, 128);
          var_1 = 1;
          level._id_13D4F = min(level._id_13D4F + 100, 3000);
        } else if(var_1 == 1) {
          var_3.script_speed = 32;
          var_1 = 0;
        } else
          continue;

        var_3 thread hidedeathicon();
        break;
      }
    }

    if(!var_3.iscivilian)
      wait 1;
  }
}

hidedeathicon() {
  target_flip("_encstr_87070365F7");
  self endon("_encstr_AFEA0A96D9C02B3129A0A32A");
  var_0 = gettime();
  var_1 = max(5000 - level._id_13D4F, 2000);

  while(gettime() < var_0 + var_1)
    waitframe();

  thread _id_13A5F();
}

_id_14523() {
  foreach(var_5, var_1 in level._id_13D7C) {
    hud_inter_round_flow(int(var_5));
    _tablethide::trial_ui_set_wave(int(var_5), level._id_13D7C.size);

    foreach(var_4, var_3 in var_1)
    _id_1393F(var_5, var_4);
  }
}

_id_1393F(var_0, var_1) {
  var_2 = gettime();
  _tablethide::trial_ui_set_secondary_timer(var_2 + level._id_14533[int(var_0) - 1]);
  level._id_13D7C[var_0][var_1] _id_129FF(level._id_13938[int(var_1) - 1]);

  foreach(var_4 in level._id_13D7C[var_0][var_1])
  var_4 thread target_flip("_encstr_87070365F7");

  level notify("_encstr_A78D0ACD950FA3D77758CE56");

  while(gettime() < var_2 + level._id_14533[int(var_0) - 1])
    waitframe();

  foreach(var_4 in level._id_13D7C[var_0][var_1])
  var_4 thread target_flip("_encstr_9767056D0FBFA8");

  _tablethide::trial_ui_set_secondary_timer(-1);
  wait 2;
}

_id_129FF(var_0) {
  var_1 = ["_encstr_93DB2D5656F5B6B4D82D1D85E4F2AFCD86ED7BA35A733BEB4E85B93B56EB078D85D1CAAF8119EBCA9B95D6F2EB18C4", "_encstr_A3DB2D56B2EBDAD2C6D28E2C27F2FA9B34BD7BA3D27376D793B073762BFA07D80BE856F518C8F559E62BADCBEB8191", "_encstr_8FDB2D78E0F1ED612B33D0CEEB1BF7B3716740FB5B75A7118AA848FF7FD98761C8F8C0175307AFB91B6570FB81514B", "_encstr_9BDB2DAC2B7DD6D2C64B8E16E4E5FAB986EDDED1D2CDECBEE4C2B93B2BBE0E8DC2A356D78146EBAC7395ADE5AF06D0", "_encstr_99DB2D65CBF95DAF39385B32638B3F9218B717FC4BD867AFDED1F25AE9F0BB8DB839954F51C2A10F8849DAA3B69F66", "_encstr_ABDB2D6A9190F71C28832C018DB8A947A3484283F8D067D9B0FB3E0F4B61AA635F837AB96B96CF8F88EB2509274263"];
  var_2 = ["_encstr_959F2DE7BBC0BA0163704B160BF06F1323D7473B0BF0C2FF1859C59F81E9881A0F49171F87AB9BB1D0A03EA5FE6AF1", "_encstr_A29F2D562BF55B5AC6963A169C5E7D9BA1B77B1D4B73ECF5E458373BB2FA1C8D2C8EACEB6C5A6796C65A16B9FA8191", "_encstr_B19F2D59CABE5B4BD8A5D158C9CBF5CD347BB7D15A9BB37D4E58E6D92BF51CD8B0E8AC7D365A9D4BD8B42CB9AF6033"];
  var_3 = scripts\engine\utility::array_randomize(self);

  foreach(var_8, var_5 in var_3) {
    if(var_8 < var_0) {
      var_6 = scripts\engine\utility::random(var_2);
      var_5.plate setModel(var_6);
      var_5.iscivilian = 1;
      level.civilian_targets = scripts\engine\utility::array_add(level.civilian_targets, var_5);

      if(var_0 <= var_2.size)
        var_2 = scripts\engine\utility::array_remove(var_2, var_6);
    } else {
      if(var_1.size == 0)
        var_1 = ["_encstr_93DB2D5656F5B6B4D82D1D85E4F2AFCD86ED7BA35A733BEB4E85B93B56EB078D85D1CAAF8119EBCA9B95D6F2EB18C4", "_encstr_A3DB2D56B2EBDAD2C6D28E2C27F2FA9B34BD7BA3D27376D793B073762BFA07D80BE856F518C8F559E62BADCBEB8191", "_encstr_8FDB2D78E0F1ED612B33D0CEEB1BF7B3716740FB5B75A7118AA848FF7FD98761C8F8C0175307AFB91B6570FB81514B", "_encstr_9BDB2DAC2B7DD6D2C64B8E16E4E5FAB986EDDED1D2CDECBEE4C2B93B2BBE0E8DC2A356D78146EBAC7395ADE5AF06D0", "_encstr_99DB2D65CBF95DAF39385B32638B3F9218B717FC4BD867AFDED1F25AE9F0BB8DB839954F51C2A10F8849DAA3B69F66", "_encstr_ABDB2D6A9190F71C28832C018DB8A947A3484283F8D067D9B0FB3E0F4B61AA635F837AB96B96CF8F88EB2509274263"];

      var_7 = scripts\engine\utility::random(var_1);
      var_5.plate setModel(var_7);
      var_5.iscivilian = 0;
      level.enemy_targets = scripts\engine\utility::array_add(level.enemy_targets, var_5);
      var_1 = scripts\engine\utility::array_remove(var_1, var_7);
    }

    waitframe();
  }
}

target_think() {
  self.initial_up = anglestoup(self.angles);
  self.parts = getEntArray(self.script_linkname, "_encstr_818E0EB98D4EA5078ED7C64B37B6E8ED");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(var_1 in self.parts) {
    switch (var_1.script_noteworthy) {
      case "_encstr_AB270DF4CF33E72F9991639A58A167":
        self.plate = var_1;
        break;
      case "_encstr_81640BFBC970878AED6F4F0B63":
        self.arm = var_1;
        break;
      case "_encstr_970D0C6907A334A0E441D18972DD":
        self.base = var_1;
        break;
      case "_encstr_B4D60E3A164EB3B2E8EBBB432B958DCD":
        self.wheels = var_1;
        break;
      default:
        break;
    }

    var_1.target = "_encstr_A3BA05E0735C50";
    var_1.targetname = "_encstr_A3BA05E0735C50";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels))
    self.wheels linkTo(self.base);

  self.state_up = 0;
  self.flipping = 0;
  self.thermiteboltstuckto = self.angles;
  thread target_damage();
  self.activated = 0;
  waitframe();

  if(issubstr(self.script_noteworthy, "_encstr_ACC107AD988D31CD07"))
    thread moving_target_think();
}

gettargetarray() {
  var_0 = ["_encstr_ADEA101F347937E09B80F4F15B67A091577B", "_encstr_BDED0E55B8FD8276F1D9FBB7A8A9351B"];
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3[var_2] = scripts\engine\utility::getStructArray(var_0[var_2], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    foreach(var_5 in var_3[var_2]) {
      var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_5.origin);
      var_6.angles = var_5.angles;
      var_6.script_gameobjectname = var_5.script_gameobjectname;
      var_6.script_linkname = var_5.script_linkname;
      var_6.script_noteworthy = var_5.script_noteworthy;
      var_6.target = var_5.target;
      var_6.targetname = var_5.targetname;
      var_6.script_delay = var_5.script_delay;
    }
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = getEntArray(var_0[var_2], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  return scripts\engine\utility::array_combine_multiple(var_1);
}

target_damage() {
  for(;;) {
    self.activated = 0;
    self.spawn_infil_lbravo = 0;
    self.plate waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    level._id_13D77 = 1;
    self.plate setCanDamage(0);
    self.plate playSound("_encstr_A6441EE8E45A2C8DFACD33E1BEA3169CB356A37DC92B1CED9CE8D7D6ACD1C28D");

    if(self.iscivilian) {
      self.spawn_infil_lbravo = 1;
      self.activated = 1;
      level.player thread _tablethide::_id_13D4B(self, 0, 1, 0);
      level.player thread scripts\mp\rank::scoreeventpopup("_encstr_850616EBDD83225CD149448B206091FAE86F6F1779B92A0C");
      self playSound("_encstr_9B2017BDC63A5785BED74D9A778A753260F5CBEF2BF1D2F81B");
      _id_12EFE();
    } else {
      self.spawn_infil_lbravo = 1;
      level.player thread _tablethide::_id_13D4B(self, 1, 0, 0);
      self.activated = 1;
      thread score_event_target_hit();
      var_10 = self.plate gettagorigin("_encstr_A34D09138A0738D0D7E949");
      var_11 = distance(var_3, var_10);
      thread targets_missed_calculate();

      if(var_11 < level.showplacementsplashesandmusic) {
        level.nodes_set_children = level.nodes_set_children scripts\engine\utility::array_add(level.nodes_set_children, self);
        thread _id_12F02();
      }
    }

    if(!isDefined(level.targethitsinaframecount))
      level.targethitsinaframecount = 0;

    self.activated = 1;
    level.targethitsinaframecount++;

    if(isDefined(level.lasttargethitinaframe) && level.lasttargethitinaframe.iscivilian && !self.iscivilian && level.targethitsinaframecount > 1)
      level.shots_fired++;

    level.lasttargethitinaframe = self;
    level.shotsmissedcount = 0;
    level.last_hit_target = self;

    if(level.targethitsinaframecount > 1 && level.lasttargethitinaframe == self) {
      if(!level.lasttargethitinaframe.iscivilian && !level.last_hit_target.iscivilian) {
        level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_8F7B114E6D6211419A9FA89847A55E4F1A5545");
        thread score_event_collateral(level.targethitsinaframecount);
      }
    }

    var_12 = weaponfiretime(var_9);

    if(var_12 > 0.05)
      wait(var_12);
    else
      waittillframeend;

    thread _id_13A5F();
    waittillframeend;

    if(level.targethitsinaframecount > 1 && self.iscivilian)
      level.shots_fired++;

    level notify("_encstr_B82510B2B867C353B93EF1DFCD63F30EA110");
    level.targethitsinaframecount = 0;

    if(level._id_13D26) {
      self waittill("_encstr_AB0108E13559B0986B83");
      continue;
    }

    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
  }
}

_id_13A5F() {
  while(self.flipping)
    waitframe();

  if(!self.state_up) {
    return;
  }
  thread target_flip("_encstr_9767056D0FBFA8");
}

target_flip(var_0) {
  if(var_0 == "_encstr_87070365F7") {
    if(!level._id_13D26 && isDefined(self.script_delay))
      wait(self.script_delay);

    self.plate setCanDamage(1);

    if(self.state_up) {
      return;
    }
    self.state_up = 1;
    var_1 = 1;
    self.activated = 0;
    self notify("_encstr_AB0108E13559B0986B83");
  } else {
    if(!self.state_up) {
      return;
    }
    self.state_up = 0;
    var_1 = -1;
    self notify("_encstr_AFEA0A96D9C02B3129A0A32A");
  }

  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  switch (self.script_noteworthy) {
    case "_encstr_BDED0E55B8FD8276F1D9FBB7A8A9351B":
    case "_encstr_ADEA101F347937E09B80F4F15B67A091577B":
      var_3 = 90;
      var_4 = 180;
      var_2 = 0.15;
      var_5 = 0.15;
      break;
    default:
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "_encstr_ACC107AD988D31CD07"))
    waitframe();

  if(var_0 == "_encstr_87070365F7")
    self playsoundonmovingent("_encstr_AB551805A2AAFBB86FE710D86F7CD115928FFD183F5253632D83");

  if(self.initial_up[1] != 0)
    self rotateYaw(-1 * self.initial_up[1] * var_3 * var_1, var_2);
  else if(!self.state_up && !istrue(self.spawn_infil_lbravo)) {
    self rotateroll(self.initial_up[2] * var_4 * var_1, var_5);
    wait 0.4;
    self.plate setCanDamage(0);
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
  } else if(!self.state_up && isDefined(level.lasttargethitinaframe) && level.lasttargethitinaframe.spawn_infil_lbravo && !level._id_13D26) {
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
    self.plate setCanDamage(0);
    level.lasttargethitinaframe.spawn_infil_lbravo = 0;

    if(!level._id_13D26) {
      level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
      wait 6;
      self rotateroll(self.initial_up[2] * var_4 * var_1, var_5);
    } else {
      wait(var_2);
      wait 0.5;
      self.angles = self.thermiteboltstuckto;
    }
  } else {
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
    wait(level.player_retry_thread);
    waitframe();
    self rotateroll(self.initial_up[2] * var_4 * var_1, var_5);
  }

  if(var_0 == "_encstr_9767056D0FBFA8")
    self playsoundonmovingent("_encstr_B61F1A9390482F7117603BBBB1458922DFB7C5C91D48BBF093D547AE");

  wait(var_2);
  waitframe();
  self.flipping = 0;
}

moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "_encstr_A16007A921A23B85E3");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  thread moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.players[0].origin, self.origin) || !self.state_up)) {
      self notify("_encstr_A1C40C9E5C97238F6DCAF04BB287");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("_encstr_96061B104082C73A4E430AB35FEBE3D3E46DFB58304AD0FF616B3D08B2");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("_encstr_86891BD1935AB063EBCDCCC3AF1DB0273B591DBE5BDE3B59AF8DED7B07");
    } else if(!self.flipping && !self.moving && 90 < distance(level.players[0].origin, self.origin) && self.state_up)
      thread moving_target_mover();

    waitframe();
  }
}

moving_target_mover() {
  self endon("_encstr_A1C40C9E5C97238F6DCAF04BB287");
  self.moving = 1;
  self.dummy = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  childthread target_follow_dummy();
  self.dummy thread scripts\engine\utility::play_loop_sound_on_entity("_encstr_86891BD1935AB063EBCDCCC3AF1DB0273B591DBE5BDE3B59AF8DED7B07");
  self.plate playSound("_encstr_BA491CF465C8DE3B20FBFA23468D4752E0238C57C350A3C7C813D3BA8BE5");

  for(;;) {
    var_0 = self.mover_ends[self.moveforward];
    var_1 = distance(self.dummy.origin, var_0.origin);
    var_2 = var_1 / self.move_speed;
    var_2 = clamp(var_2, 0.05, 9999);
    var_3 = 0.5;
    var_3 = clamp(var_3, 0, var_2 / 2);
    self.dummy moveTo(var_0.origin, var_2, var_3, var_3);
    wait(var_2);
    self.moveforward = !self.moveforward;
  }
}

moving_target_reset() {
  for(;;) {
    level waittill("_encstr_93EF1C7B3880D17207869F126D39AB8BEE88AFFB68F906894F9FE74D5DC1");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

target_follow_dummy() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["_encstr_AF9B051E1D0B0C"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
    level.score_initialized_once = 1;
  }

  level.score["_encstr_BE7D0633C08849E2"] = 0;
  level.score["_encstr_AAAC09701B829B88093F5B"] = 0;
  level.score["_encstr_92640BE052DA87E183076BD304"] = 0;
  level.score["_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547"] = 0;
  level.score["_encstr_82DD09CFCB90B55651A6EB"] = 0;
  level.score["_encstr_82D10AB0A2AE3116CF60B82D"] = 0;
  level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] = 0;
  level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = 0;
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.nodes_set_children = [];
  level.enemies_missed = level.enemy_targets.size;
  level.enemies_killed = 0;
  level.civs_killed = 0;
  level.shots_fired = 0;
  level.course_accuracy = 0;
  level.headshot = 0;
  level.current_tablet = 0;
  level._id_13D2C = 0;
  level.current_tablet = 0;
  _tablethide::trial_ui_set_stat_and_bonus_score(1, "_encstr_82DD09CFCB90B55651A6EB", 100 * level.course_accuracy, level.score["_encstr_82DD09CFCB90B55651A6EB"]);
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "_encstr_82D10AB0A2AE3116CF60B82D", level.headshot, level.score["_encstr_82D10AB0A2AE3116CF60B82D"]);
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", level.civs_killed, -1 * level.score["_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547"]);

  if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A59306426009CA07")
    _tablethide::trial_ui_set_stat_and_bonus_score(4, "_encstr_995313C213307B82BFD17F2B33DEAAB5605EBCCC0B", level.current_tablet, 0);

  score_calculate();
}

score_event_target_hit() {
  if(istrue(level._id_13D64)) {
    return;
  }
  level.score["_encstr_92640BE052DA87E183076BD304"] = level.score["_encstr_92640BE052DA87E183076BD304"] + 100;
  level.player thread scripts\mp\rank::scorepointspopup(100);
  level.enemies_killed++;

  if(level._id_13D26)
    thread hidedangercircle();

  score_calculate();
}

_id_12EFE() {
  if(istrue(level._id_13D64)) {
    return;
  }
  if(!level.civilian_targets.size) {
    return;
  }
  level notify("_encstr_AC0C087F11DB17383353");
  level.civs_killed++;
  level.score["_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547"] = level.score["_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547"] + 200;
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", level.civs_killed, -1 * level.score["_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547"]);
}

_id_12F02() {
  if(istrue(level._id_13D64)) {
    return;
  }
  level endon("_encstr_B8D80D131723B292AB2759B2975BA0");

  if(!level.enemy_targets.size) {
    return;
  }
  level.player thread scripts\mp\rank::scoreeventpopup("_encstr_848909BBD3A7526348E8E3");
  level.player thread scripts\mp\rank::scorepointspopup(50);
  level notify("_encstr_848909BBD3A7526348E8E3");
  level.headshot = 0;

  foreach(var_1 in level.nodes_set_children)
  level.headshot++;

  level.score["_encstr_82D10AB0A2AE3116CF60B82D"] = level.score["_encstr_82D10AB0A2AE3116CF60B82D"] + 50;
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "_encstr_82D10AB0A2AE3116CF60B82D", level.headshot, 0);
}

_id_12EFA() {
  level endon("_encstr_B8D80D131723B292AB2759B2975BA0");
  level.shots_fired = 0;

  for(;;) {
    level.player scripts\engine\utility::_id_143A6("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_81D812992CB5567D7756C20EDECDFACC964ECA8C", "_encstr_9B620D8F0DC07577C551F16A3826BF");
    level.shots_fired++;
    waittillframeend;

    if(istrue(level._id_13D77)) {
      level waittill("_encstr_B82510B2B867C353B93EF1DFCD63F30EA110");
      level._id_13D77 = 0;
    }

    if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A59306426009CA07")
      level.course_accuracy = (level.enemy_targets.size + level.current_steps.size - level.enemies_missed) / max(1, level.shots_fired);
    else if(level._id_13D26) {
      if(istrue(level._id_13D64)) {
        continue;
      }
      level.course_accuracy = level.enemies_killed / max(1, level.shots_fired);
    } else
      level.course_accuracy = (level.enemy_targets.size - level.enemies_missed) / max(1, level.shots_fired);

    var_0 = level.course_accuracy * level.armsrace_c4_planter_super;
    level.score["_encstr_82DD09CFCB90B55651A6EB"] = var_0 % 1300;
    _tablethide::trial_ui_set_stat_and_bonus_score(1, "_encstr_82DD09CFCB90B55651A6EB", 100 * level.course_accuracy, level.score["_encstr_82DD09CFCB90B55651A6EB"]);
  }
}

targets_missed_calculate() {
  level.enemies_missed = 0;

  foreach(var_1 in level.enemy_targets) {
    if(!var_1.activated)
      level.enemies_missed++;
  }
}

score_event_collateral(var_0) {
  var_1 = 50 * (var_0 - 1);
  level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] = level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] + var_1;

  switch (var_0) {
    case 3:
      var_2 = "_encstr_8C27181B13EBE77D91B717EC5198833F8EE912117B3EBF322093";
      break;
    case 4:
      var_2 = "_encstr_8ADB16A3C9B42CD8AF36DB8D362CD1CA93168DAFE2BA0B91";
      break;
    default:
      var_2 = "_encstr_88DC11600BA99161417610A98D9A69D91ADF28";
      break;
  }

  level.player thread scripts\mp\rank::scoreeventpopup(var_2);
  level.player thread scripts\mp\rank::scorepointspopup(var_1);
}

score_calculate(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.score["_encstr_AAAC09701B829B88093F5B"] = level.score["_encstr_92640BE052DA87E183076BD304"] + level.score["_encstr_82D10AB0A2AE3116CF60B82D"] + level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] + level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"];
  level.score["_encstr_818B0D3195CCBD27ACD7477B3A16D8"] = level.score["_encstr_AAAC09701B829B88093F5B"] + level.score["_encstr_82DD09CFCB90B55651A6EB"] - level.score["_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547"];
  level.score["_encstr_BE7D0633C08849E2"] = clamp(level.score["_encstr_818B0D3195CCBD27ACD7477B3A16D8"], 0, 999999);
  _tablethide::trial_ui_set_subscore(level.score["_encstr_AAAC09701B829B88093F5B"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    wait 1;
    _tablethide::trial_ui_set_main_score(level.score["_encstr_BE7D0633C08849E2"]);

    if(level.score["_encstr_AF9B051E1D0B0C"] < level.score["_encstr_BE7D0633C08849E2"]) {
      level.score["_encstr_AF9B051E1D0B0C"] = level.score["_encstr_BE7D0633C08849E2"];
      _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_82DD09CFCB90B55651A6EB"] = level.course_accuracy;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_ABDA07EA10868F1F68"] = level.enemies_missed;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"] = level.civs_killed;
    }

    hud_set_reward_tier(1);
    level notify("_encstr_B8D80D131723B292AB2759B2975BA0");

    if(istrue(level._id_13D6C))
      wait 5;

    thread _tablethide::trial_ui_open_results_screen();
  }
}

hidedangercircle() {
  level notify("_encstr_858F0C97DDFFB59FE968D16387DB");
  level endon("_encstr_858F0C97DDFFB59FE968D16387DB");

  if(istrue(level._id_13D2D)) {
    return;
  }
  waitframe();
  var_0 = hideassassinationtargethud();
  level._id_13D2C++;
  _tablethide::_id_13D8C(var_0);
  _tablethide::_id_13D8B(max(level._id_13D2C, 1));
  var_1 = gettime();

  while(gettime() < var_1 + var_0)
    waitframe();

  wait 0.25;
  level notify("_encstr_9AD711ECAEB8179537988AA278BF81DB109D44");
  level._id_13D2D = 1;
  _tablethide::_id_13D8B(0);

  foreach(var_3 in level._id_13D7D)
  var_3 thread _id_13A5F();
}

hideassassinationtargethud() {
  var_0 = gettime() - level._id_13D6E;
  var_1 = int(var_0 / 10);
  var_2 = level.civs_killed * 750;
  var_3 = clamp(7500 - var_1 - var_2, 1250, 7500);

  if(level.player isreloading() || level.player getcurrentweaponclipammo() == 0)
    var_3 = max(var_3, 1750);

  return var_3;
}

hud_init() {
  level._id_13A6E = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = 0;
  _tablethide::trial_ui_set_subscore(0);
  _tablethide::trial_ui_set_wave(1, level._id_13D7C.size);
  _tablethide::trial_ui_set_reward_tier_preview(0);
  _tablethide::trial_ui_set_objective_icon_index(1);
}

hud_set_reward_tier(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    var_1 = level.score["_encstr_AF9B051E1D0B0C"];
  else
    var_1 = level.score["_encstr_AAAC09701B829B88093F5B"];

  if(var_1 >= level.trial["_encstr_966C066BF011B2F7"])
    var_2 = 3;
  else if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
    var_3 = level.trial["_encstr_966C066BF011B2F7"] - level.trial["_encstr_876C06B1FF0A66F2"];
    var_4 = var_1 - level.trial["_encstr_876C06B1FF0A66F2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
    var_3 = level.trial["_encstr_876C06B1FF0A66F2"] - level.trial["_encstr_816C069599555DA7"];
    var_4 = var_1 - level.trial["_encstr_816C069599555DA7"];
    var_2 = 1 + var_4 / var_3;
  } else
    var_2 = var_1 / level.trial["_encstr_816C069599555DA7"];

  if(var_0) {
    _tablethide::trial_ui_set_reward_tier(var_2);

    if(var_1 >= level.trial["_encstr_966C066BF011B2F7"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_6]);
      return;
    }

    if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"][var_6]);
      return;
    }

    if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"][var_6]);
      return;
    }

    var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
    var_6 = randomint(var_5);
    level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_6]);
    return;
    return;
    return;
  } else
    _tablethide::trial_ui_set_reward_tier_preview(var_2);
}

hud_inter_round_flow(var_0) {
  _tablethide::trial_ui_freeze_secondary_timer(1);
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_A24C06879F945FA6" + var_0 + "_encstr_B4810709B378B9F3F5");
  level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_8BBA05185F8B99");
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  _tablethide::trial_ui_set_wave(int(var_0), level._id_13D7C.size);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1");
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_86EF191741304AC70883DF27F97801927187B7976F5872BE18EB55";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_86EF191741304AC70883DF27F97801927187B7976F5872BE18EB55";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_97BC10B586FADCB95AC1594EFA373A5827C0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_ADBC10E0C06953EE04B8A1DB51C3712A631F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_81BC10D2681703AD2C7BA818614241990BE2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_AABC1008D281BF90C718DD4EDF471B63328F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_AD0110D643FACDCD2D1C5939BEC956D19CE5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81960D633820CB5FE501C3ABE83DD3"] = "_encstr_8DBC10D60DF5E6CD9683B293D737D1B0271D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81600E3A28A8908AEE6F07577B9692F0"] = "_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F7B114E6D6211419A9FA89847A55E4F1A5545"] = "_encstr_BABD13D6A1D79BCD968359C9AF3BDEDEC89B0DED1D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B781032D823F39DB3F9ABC7886B49C9A36F"] = "_encstr_921B12C7D8A14B152260B55A07029BA8DBE3D34A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82D311B99B96C1594EAFA3272FAFC23B8596E6"] = "_encstr_AD0110D643FACDCD2D1C5939BEC956D19CE5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92A80A7F70BFE3E17370CD7B"] = "_encstr_8CA4186298BEC0C11677F83B34B0C06CC227575E2A713F58E7A1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AC60D1BA7D0E24F3566A3DB89966B"] = "_encstr_ADDC1D83288138E0874391996AABA768E5AF3F15AA79E837EFA92BA30233E5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD"] = "_encstr_85B01C6D3BC95DD99EC18F87C1CEE284B8266536D0711672FC879BAF3765";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB"] = "_encstr_A2F217BFCB99DCD816A668230AD38018F2732B37AF7293A835";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF441079205DE317CF69485362FEEBF78B8B"] = "_encstr_BE211D450F08A8B702197D191C528FB3A1D777AEE8A7E3A33B818BA37B0220";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5AF0A4B1B1833FAFE9187E3"] = "_encstr_A39B17C39B89B2189A9ED0EE50BA65B01FF7EB21522B921A33";
  thread light_tank_monitordriverturretprojectilefire();
  thread dialog_kill_watcher();
  thread light_tank_monitorgunnerturretfire();
  thread levelonlaststandfunc();
}

init_nuke_vault(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);

  if(isDefined(var_1))
    var_5.angles = var_1;

  if(isDefined(var_2))
    var_5.script_gameobjectname = var_2;
  else
    var_5.script_gameobjectname = "_encstr_8CA606F38878410D";

  if(isDefined(var_3))
    var_5.script_noteworthy = var_3;

  var_5.targetname = "_encstr_811F0DF09B396191B1E3859F3AEACD";
  var_5.script_parameters = var_4;
  return var_5;
}

weapon_xp_iw8_sn_awhiskey() {
  level._id_12D3A = getEntArray("_encstr_965306392D3336B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12382 = getEntArray("_encstr_8E4708C12DE8D834AC27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 0.05;

  if(level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"] == 1002) {
    foreach(var_1 in level._id_12D3A)
    var_1 setlightintensity(1);

    foreach(var_1 in level._id_12382)
    var_1 setlightintensity(0);
  } else {
    foreach(var_1 in level._id_12D3A)
    var_1 setlightintensity(0);

    foreach(var_1 in level._id_12382)
    var_1 setlightintensity(0);
  }
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D34;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_82DD09CFCB90B55651A6EB"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_ABDA07EA10868F1F68"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"] = 0;
  }
}

_id_13D34() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B");
  var_3 = float(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_82DD09CFCB90B55651A6EB"]);
  var_4 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_ABDA07EA10868F1F68"]);
  var_5 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"]);
  level.player dlog_recordplayerevent("_encstr_A6B42523D058DF490BFC974DE557B37220109B4750B01D83411DDB8758DF7B260BE0077BD8A95A", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_82FB06EB26785BD7", var_2, "_encstr_82DD09CFCB90B55651A6EB", var_3, "_encstr_ABDA07EA10868F1F68", var_4, "_encstr_A7980A6E84BB0B58B94FB020", var_5]);
}

_id_12A90(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1]))
    var_2.progress[var_1] = 0;

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(var_4 < var_5)
    var_2.progress[var_1] = var_2.progress[var_1] + 0.333333;
  else
    var_2.progress[var_1] = 0;

  if(var_2.progress[var_1] >= 1) {
    var_0 scripts\mp\equipment::incrementequipmentslotammo(var_1, 1);
    var_2.progress[var_1] = 0;
    var_2.recharged[var_1] = 1;
  }
}

_id_12A8F() {
  while(!isalive(level.player))
    waitframe();

  for(;;) {
    while(isalive(level.player)) {
      _id_12A91(level.player);
      wait 0.1;
    }

    waitframe();
  }
}

_id_12A91(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  _id_12A90(var_0, "_encstr_BA7F0830B3A7859B60B0");
  _id_12A90(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  _id_12A92(var_0);
}

_id_12A92(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["_encstr_BA7F0830B3A7859B60B0"]))
      var_1 = var_4.progress["_encstr_BA7F0830B3A7859B60B0"];

    if(isDefined(var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"]))
      var_2 = var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"];

    foreach(var_7, var_6 in var_4.recharged) {
      if(var_7 == "_encstr_BA7F0830B3A7859B60B0") {
        var_3 = var_3 + 1;
        var_0 playlocalsound("_encstr_B229132D8BA1C2F7DEE3824AE8202BFF1011B18C17");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }

      if(var_7 == "_encstr_AC8F0AE74163F85AAA380AD8") {
        var_3 = var_3 + 2;
        var_0 playlocalsound("_encstr_871E14BB5357CB959B58BF8748F65C22877504B6CF49");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }
    }
  }

  var_0 setclientomnvar("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", var_1);
  var_0 setclientomnvar("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", var_2);
  var_0 setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", var_3);
}

script_model_spawn_and_use() {
  level waittill("_encstr_99AD06D3A5B1538B");

  for(;;) {
    if(!isalive(level.player)) {
      while(!isalive(level.player))
        waitframe();

      var_0 = "_encstr_BA7F0830B3A7859B60B0";
      level.player scripts\mp\equipment::giveequipment("_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381", var_0);
    }

    waitframe();
  }
}

_id_1378E() {
  var_0 = getEnt("_encstr_86AD129D27B2732C32CA7DC47B0FAF6D37A599AC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 setHintString(&"_encstr_BA1A23BD935F841417387748FF3F18C1191FD20B60C711092107D1EEFB85319C16A0DE19FD");
  var_0 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(120);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 makeusable();
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  level notify("_encstr_99AD06D3A5B1538B");
  level.player scripts\mp\equipment::giveequipment("_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381", "_encstr_BA7F0830B3A7859B60B0");
  level.player playSound("_encstr_AC7E11C0DBA7DDEECB79A6AA5DF3D685CA7248");
  var_0 makeunusable();
}

process_struct_angle_tilt() {
  level.current_tablet = [];
  level.current_shield_tagattach = getEntArray("_encstr_8FA30D750F520D209FDBE19B078D50", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.current_shield_tagattach.size <= 0) {
    return;
  }
  level.explosion = loadfx("_encstr_A9EB4493B42B1821C7A047D1DADF888863A12288C9299F9A183833FE6B38DB39D8B3AF2AF52759BFF9EA5F23F8A753612965F2B78FA1480347AF92C15050CE6B91837076ABFB");

  foreach(var_1 in level.current_shield_tagattach) {
    var_1._id_11E37 = 1;
    var_1 hide();
  }

  for(;;) {
    foreach(var_1 in level.current_shield_tagattach) {
      if(istrue(var_1._id_11E37)) {
        var_1._id_11E37 = 0;
        var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
        var_4 setModel(var_1.model);
        var_4.angles = var_1.angles;
        var_4.script_noteworthy = var_1.script_noteworthy;
        var_4.isbonus = 1;
        var_4 thread current_spawner(var_1);
        var_4 setCanDamage(1);
      }
    }

    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
    wait 5;
  }
}

current_spawner(var_0) {
  level endon("_encstr_92640BE052DA87E183076BD304");

  for(;;) {
    self.activated = 0;
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    level.player thread scripts\mp\rank::scorepointspopup(int(self.script_noteworthy));
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_92A80A7F70BFE3E17370CD7B");
    playFXOnTag(level.explosion, self, "_encstr_A2B40B8A283A7DD3254A1D4A27");
    waitframe();
    self.activated = 1;
    self hide();
    level.current_tablet++;
    thread current_struct();
    self setCanDamage(0);
    var_0._id_11E37 = 1;
    self delete();
    return;
  }
}

current_struct() {
  level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] + int(self.script_noteworthy);
  _tablethide::trial_ui_set_stat_and_bonus_score(4, "_encstr_995313C213307B82BFD17F2B33DEAAB5605EBCCC0B", level.current_tablet, 0);
  score_calculate();
}

dialog_kill_watcher() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

  for(;;) {
    level waittill("_encstr_848909BBD3A7526348E8E3");

    if(level.light_tank_initdamage) {
      level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_A5AF0A4B1B1833FAFE9187E3");
      level.light_tank_initdamage = 0;
    }

    waitframe();
  }
}

light_tank_monitordriverturretprojectilefire() {
  level.light_tank_initdamage = 1;

  for(;;) {
    level waittill("_encstr_848909BBD3A7526348E8E3");
    wait 7;
    level.light_tank_initdamage = 1;
  }
}

levelonlaststandfunc() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

  for(;;) {
    level waittill("_encstr_AC0C087F11DB17383353");

    if(level.light_tank_initomnvars) {
      level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB");
      level.light_tank_initomnvars = 0;
    }

    waitframe();
  }
}

light_tank_monitorgunnerturretfire() {
  level.light_tank_initomnvars = 1;

  for(;;) {
    level waittill("_encstr_AC0C087F11DB17383353");
    wait 7;
    level.light_tank_initomnvars = 1;
  }
}

serverroomrewardspawn() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_AC120FDF5D902547F561218A29DC6FDEB0", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = 1;

  for(;;) {
    level waittill("_encstr_A78D0ACD950FA3D77758CE56");

    foreach(var_3 in var_0) {
      if(var_3.script_index == scripts\engine\utility::string(var_1)) {
        if(isDefined(var_3.script_delay))
          wait(var_3.script_delay);

        magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_3.origin, (0, 0, -1), 0.05);
      }
    }

    var_1++;
  }

  level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
  var_1 = 0;
}