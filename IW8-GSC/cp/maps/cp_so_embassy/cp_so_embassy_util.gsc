/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_embassy\cp_so_embassy_util.gsc
********************************************************/

_id_11A9A(var_0, var_1) {
  if(!isDefined(self.origin)) {
    return;
  }
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_2 endon("_encstr_AD75063D571AE108");
  var_2.isusable = 1;
  var_2 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_2 sethintdisplayfov(360);
  var_2 setusefov(135);
  var_2 sethintdisplayrange(500);
  var_2 setuserange(80);
  var_2 sethintonobstruction("_encstr_BECC055CF3811A");
  var_2 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_2 sethintlockplayermovement(1);
  var_2 makeusable();

  if(isDefined(var_0))
    var_2 setHintString(var_0);

  if(isDefined(var_1))
    var_2.origin = var_2.origin + var_1;

  var_2.userate = 1;
  var_2.laststandfinisherdone = 4;
  var_2.curprogress = 0;
  var_2.usetime = 5;
  var_2.inuse = 0;
  var_2.playerusing = undefined;
  var_3 = undefined;
  return var_2;
}

supportboxmaxammo() {
  var_0 = [];
  var_1[0] = spawnStruct();
  var_1[0].origin = (-704.34, -373.008, 641.125);
  var_1[0].angles = (0, 55, 0);
  var_1[0].script_radius = 20000;
  var_1[0].script_index = 4;
  var_1[1] = spawnStruct();
  var_1[1].origin = (-128.34, -69.0081, 641.125);
  var_1[1].angles = (0, 255, 0);
  var_1[1].script_radius = 20000;
  var_1[1].script_index = 5;
  var_1[2] = spawnStruct();
  var_1[2].origin = (-851.508, -28.66, 641.125);
  var_1[2].angles = (0, 325, 0);
  var_1[2].script_radius = 20000;
  var_1[2].script_index = 6;
  var_1[3] = spawnStruct();
  var_1[3].origin = (199.66, 546.992, 641.125);
  var_1[3].angles = (0, 250, 0);
  var_1[3].script_radius = 20000;
  var_1[3].script_index = 7;

  if(level.players.size > 1) {
    var_1[4] = spawnStruct();
    var_1[4].origin = (-424.16, 1105.51, 641.125);
    var_1[4].angles = (0, 380, 0);
    var_1[4].script_radius = 20000;
    var_1[4].script_index = 8;
    var_1[5] = spawnStruct();
    var_1[5].origin = (731.992, -98.66, 641.125);
    var_1[5].angles = (0, 86, 0);
    var_1[5].script_radius = 20000;
    var_1[5].script_index = 9;
  }

  var_2 = scripts\engine\utility::getStructArray("_encstr_8C0123D82BECB2B1BEB18539B2E00BD8DA2CCEB27DD0B2C64BAF199CED83D7DC1D93BA1BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::array_combine(var_2, var_1);
  var_2 = scripts\cp\laser_traps\cp_laser_traps::can_play_ending(var_2);

  foreach(var_4 in var_2)
  var_4.origin = var_4.origin + (0, 0, 600);

  var_2[0].angles = (0, 128, 0);
  var_2[1].angles = (0, 0, 0);
  var_2[2].angles = (0, 353, 0);
  var_2[3].angles = (0, 66, 0);

  foreach(var_4 in var_2)
  var_4.should_take_damage_from_trigger_hurt = 0;

  level.minigun_right = var_2;
}

weapon_xp_iw8_sm_papa90(var_0) {
  for(;;) {
    var_1 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
    var_1 = scripts\engine\utility::array_removeundefined(var_1);

    if(!scripts\engine\utility::flag("_encstr_B23218933360AF87C7293AA23194A7E9D0B9091B43613717E160") && var_1.size >= var_0)
      scripts\engine\utility::flag_clear("_encstr_B23218933360AF87C7293AA23194A7E9D0B9091B43613717E160");

    if(scripts\engine\utility::flag("_encstr_B23218933360AF87C7293AA23194A7E9D0B9091B43613717E160") && var_1.size < var_0)
      scripts\engine\utility::flag_set("_encstr_B23218933360AF87C7293AA23194A7E9D0B9091B43613717E160");

    wait 2;
  }
}

weapon_xp_iw8_sm_augolf(var_0) {
  level endon("_encstr_847B13A0EB573B8F1A7E26A5D9033B818B57F8986F");
  level._id_12DB9 = var_0;
  var_1 = int(tablelookupbyrow("_encstr_B4EF3C6F67A60AE830E34DA67B120D427FDF9697E958D3BF4109D5EE71D85B9B781773EF97F8D96D88F1CEB22BD0AF7223B18BC7319E222150BB15BE4340", var_0, level.players.size));
  wait 2.0;

  if(!scripts\engine\utility::flag("_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074")) {
    scripts\engine\utility::flag_set("_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074");

    if(var_1 == 1)
      thread _id_12758("_encstr_88551871D8875DC31789032B6033B127B325F1137F7F8F8BAF80");
    else if(var_1 > 1)
      thread _id_12758("_encstr_88A02123F0EBB538EDEBBA9BB7C1F5582DC946C9DB38FA6BD5B13AD207C659EBAB9B59");

    scripts\engine\utility::delaythread(6, scripts\engine\utility::flag_clear, "_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074");
  }

  var_2 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var_2 = scripts\engine\utility::array_removeundefined(var_2);
  var_3 = squared(70);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    scripts\engine\utility::flag_waitopen("_encstr_B23218933360AF87C7293AA23194A7E9D0B9091B43613717E160");
    var_5 = play_players_see_informant_before_aipickup();
    var_6 = var_5.script_radius;
    var_7 = var_5.script_radius;
    var_8 = var_5.angles;
    var_9 = var_5.origin;
    var_9 = getclosestmatchingmasterlootnode(var_2, var_9, var_3);
    var_5.should_take_damage_from_trigger_hurt = 1;
    var_10 = tablelookupbyrow("_encstr_B4EF3C6F67A60AE830E34DA67B120D427FDF9697E958D3BF4109D5EE71D85B9B781773EF97F8D96D88F1CEB22BD0AF7223B18BC7319E222150BB15BE4340", level._id_12DB9, 5);
    var_10 = strtok(var_10, "_encstr_974C0246");
    var_11 = scripts\engine\utility::random(var_10);

    if(!isDefined(var_11)) {
      continue;
    }
    thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_6, var_7, var_8, var_9, var_11, ::weapon_xp_iw8_sm_mpapa7);
    wait 3.0;
  }
}

play_players_see_informant_before_aipickup() {
  var_0 = level.minigun_right[randomintrange(0, 4)];

  foreach(var_2 in level.minigun_right) {
    if(istrue(var_2.should_take_damage_from_trigger_hurt)) {
      continue;
    }
    var_0 = var_2;
  }

  return var_0;
}

getclosestmatchingmasterlootnode(var_0, var_1, var_2) {
  for(;;) {
    var_3 = 1;

    foreach(var_5 in var_0) {
      if(!isDefined(var_5) || distance2dsquared(var_5.origin, var_1) > var_2) {
        continue;
      }
      var_3 = 0;
      break;
    }

    if(var_3) {
      break;
    } else
      var_1 = var_1 + (60, 0, 0);
  }

  return var_1;
}

weapon_xp_iw8_sm_mpapa7(var_0, var_1, var_2) {
  var_3 = sortbydistance(level.minigun_right, var_1);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();

  if(!isDefined(var_3[0])) {
    return;
  }
  if(getcost(var_4, var_1)) {
    return;
  }
  var_3[0].should_take_damage_from_trigger_hurt = 0;
}

getcost(var_0, var_1) {
  var_2 = squared(300);

  foreach(var_4 in var_0) {
    if(distance2dsquared(var_1, var_4.origin) <= var_2)
      return 1;
  }

  return 0;
}

weapon_xp_iw8_sm_beta(var_0, var_1, var_2) {
  if(!scripts\engine\utility::flag("_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074")) {
    scripts\engine\utility::flag_set("_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074");

    if(var_1 == 1)
      thread _id_12758("_encstr_88551871D8875DC31789032B6033B127B325F1137F7F8F8BAF80");
    else if(var_1 > 1)
      thread _id_12758("_encstr_88A02123F0EBB538EDEBBA9BB7C1F5582DC946C9DB38FA6BD5B13AD207C659EBAB9B59");

    scripts\engine\utility::delaythread(6, scripts\engine\utility::flag_clear, "_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074");
  }

  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var_4 = squared(70);

  for(var_5 = 0; var_5 < var_1; var_5++) {
    if(!isDefined(var_2))
      var_2 = var_5;

    var_6 = level.minigun_right[var_2];

    if(!isDefined(var_6))
      var_6 = level.minigun_right[0];

    var_7 = var_6.script_radius;
    var_8 = var_6.script_radius;
    var_9 = var_6.angles;
    var_10 = var_6.origin;

    if(istrue(var_6.should_take_damage_from_trigger_hurt))
      var_10 = getclosestmatchingmasterlootnode(var_3, var_10, var_4);

    var_6.should_take_damage_from_trigger_hurt = 1;

    if(var_0 == "_encstr_B20D1473D82347A5014072161B6829B2DB58FB9120D3")
      thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_7, var_8, var_9, var_10, undefined, ::weapon_xp_iw8_sm_mpapa5);
    else
      thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_7, var_8, var_9, var_10, var_0, ::weapon_xp_iw8_sm_mpapa7);

    wait 3.0;
  }
}

weapon_xp_iw8_sm_mpapa5(var_0, var_1, var_2) {
  wait 0.1;
  var_3 = scripts\cp\cp_weapon::buildweapon("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0", ["_encstr_BEE308C2D9C177A398E1", "_encstr_85031263731B1AE49B8DB738567D6B4B6D2B6691"]);
  var_4 = createheadicon(var_3);
  var_5 = spawn("_encstr_B2010820C5337B67C8CF" + var_4, var_1 + (0, 0, 20));
  var_5 physicslaunchserveritem(var_5.origin, (0, 0, 1250));
  thread start_end_breach_fx(var_5, var_0);
}

get_drop_location(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, (0, 0, 90));
  var_1 show();
  var_1 linkTo(var_0);
  wait 0.15;
  var_1.origin = var_0.origin;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AB090F9D991E7DEC36F6DDAFE6A34B8DDA"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1 delete();
}

start_end_breach_fx(var_0, var_1) {
  thread scripts\cp\cp_outline_utility::outlineenableforall(var_0, "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099", "_encstr_BE8F0A272F9B2BE97268AE8B");
  var_0 itemweaponsetammo(6, 6);
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1 thread scripts\mp\trials\trial_pitcher::firemanager();
}

_id_134ED(var_0, var_1, var_2) {
  while(scripts\engine\utility::flag("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6"))
    wait 0.1;

  scripts\engine\utility::flag_set("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  wait 0.5;
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = [];

  if(!isDefined(var_3) || var_3.size < 1) {
    return;
  }
  if(isDefined(var_2))
    var_3 = sortbydistance(var_3, var_2);

  if(!isDefined(var_1))
    var_1 = _id_130A1();

  var_5 = 0;

  for(var_6 = 0; var_6 < var_1; var_6++) {
    if(var_5 >= var_3.size - 1) {
      var_5 = 0;
      var_3 = scripts\engine\utility::array_reverse(var_3);
    }

    while(scripts\engine\utility::flag("_encstr_BAD117F9794B88BD77D2D09BDB4760B869C34153F7F51070AF") || getaiarray("_encstr_8E8405EA382B2A").size >= _id_130A1() || getaiarray().size > 37)
      wait 0.2;

    var_7 = var_3[var_5] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

    if(!isDefined(var_7)) {
      continue;
    }
    var_8 = level.players;
    var_9 = [];

    foreach(var_11 in var_8) {
      if(var_11 getdefaultstreamhinttimeoutms())
        var_9[var_9.size] = var_11;
    }

    var_8 = scripts\engine\utility::array_remove_array(var_8, var_9);
    var_11 = scripts\engine\utility::random(var_8);

    if(isDefined(var_11))
      var_7 getenemyinfo(var_11);

    var_7.goalheight = 30;
    var_7 scripts\engine\utility::set_movement_speed(300);
    var_4[var_4.size] = var_7;

    if(isDefined(var_3[var_5].count))
      var_3[var_5].count++;

    if(scripts\engine\utility::is_equal(var_7.team, "_encstr_8E8405EA382B2A"))
      var_7 setthreatbiasgroup("_encstr_8E8405EA382B2A");

    var_5++;

    if(!isDefined(var_3[var_5]) || var_4.size >= var_1) {
      break;
    }

    wait 0.1;
  }

  wait 0.5;
  scripts\engine\utility::flag_clear("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  return var_4;
}

_id_134F0(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1) || getaiarray().size > 40) {
    return;
  }
  var_2 = var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
  var_2 scripts\engine\utility::set_movement_speed(300);
  var_2.goalheight = 30;

  if(isDefined(var_1.count))
    var_1.count++;

  if(isDefined(var_2) && scripts\engine\utility::is_equal(var_2.team, "_encstr_8E8405EA382B2A"))
    var_2 setthreatbiasgroup("_encstr_8E8405EA382B2A");

  waitframe();
  return var_2;
}

_id_1352B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_5 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_0, var_1, var_2, var_4, var_3);
  var_5 scripts\engine\utility::set_movement_speed(300);
  var_5.goalheight = 30;
  waitframe();
  return var_5;
}

_id_1352C(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in var_1) {
    var_7 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_0, var_6[0], var_6[1], var_3, var_2);
    var_7 scripts\engine\utility::set_movement_speed(300);
    var_7.goalheight = 30;
    var_4[var_4.size] = var_7;
    waitframe();
  }

  return var_4;
}

set_start_pos(var_0) {
  foreach(var_2 in level.players)
  level thread scripts\cp\utility::teleportplayertoteamstructs(var_2, var_0);
}

_id_124A6() {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::givedefaultloadout();
  var_0 = "_encstr_977F0EB4EE70AF9BDAF5B5831683589B";
  var_1 = ["_encstr_A30D0BF0D3D00F8868421252CF", "_encstr_82340FE8432B93D6C2B1FADDCADC1D81C4", "_encstr_95060BECE4D2C1B073D93893BD", "_encstr_97C10FB1E13321530ABA30A002E72F787F", "_encstr_B1A008D8DEDA1C9BDA9D", "_encstr_84490E5BEA3DA763ACB65636CA2B0C26", "_encstr_8A490E5BABA79E8D95D6CA63B2B26023", "_encstr_866B0998E4C2B6596ED6EC", "_encstr_9706140EB49B8E7B8DD927D2E06089D7DA1C581CB0DC"];
  var_2 = "_encstr_B8F911CBC79FB0B846F998109C35D27D813771";
  var_3[0] = scripts\cp\cp_weapon::buildweapon(var_0, var_1, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_3[1] = scripts\cp\cp_weapon::buildweapon(var_2, ["_encstr_846F128EA159E4DA2C1B8CD64E7DEEB2B93A8162", "_encstr_B87B0D413AB3D5FB9AAD7BC759E74B"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);

  foreach(var_5 in var_3) {
    self giveweapon(var_5);
    self givemaxammo(var_5);
  }

  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];

  thread scripts\cp\cp_powers::givepower("_encstr_81580B52FF3F7F3D195A6A61A7", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("_encstr_B81D0C38EDBB56C9F599B12CDC34", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
  thread hostagetemppistol();
  level.hostdamagefactorlow++;
  self setthreatbiasgroup("_encstr_9775086022BE1B413B8B");
}

hostagetemppistol() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self._id_14389 = 1;
  waitframe();
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_1.alignx = "_encstr_A5AD056A019C63";
  var_1.aligny = "_encstr_AC190479FF92";
  var_1.sort = 1;
  var_1.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.alpha = 1;
  var_1.foreground = 1;
  var_1.lowresbackground = 1;
  var_2 = 1;
  precacherumble("_encstr_ABC013C6077DBB1A59CA36B9EDDC7D9C576B2636B2");
  precacherumble("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  var_3 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self playerlinkTo(var_3, undefined, 0, 90, 90, 90, 90);
  thread vehicle_preventplayercollisiondamagefortimeafterexitinternal();
  self disableweapons();
  scripts\engine\utility::flag_wait("_encstr_B457128F6887433F83FFC9E9287313EB579B1097");
  thread persistantgametypeteamassign();
  wait 8;
  scripts\engine\utility::flag_set("_encstr_A2A3086439CBF1DF3C8A");
  var_1 fadeovertime(var_2);
  var_1.alpha = 0.0;
  completepayloadpunish(1, 1);
  self unlink();
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
  self enableweapons();
  wait 2;

  if(isDefined(var_1))
    var_1 destroy();

  var_3 delete();
}

vehicle_preventplayercollisiondamagefortimeafterexitinternal() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);

  while(!scripts\engine\utility::flag("_encstr_A2A3086439CBF1DF3C8A")) {
    if(isDefined(self calloutmarkerping_entityzoffset("_encstr_AA5B0CE53B662BDC495081EAC891")) && !self calloutmarkerping_entityzoffset("_encstr_AA5B0CE53B662BDC495081EAC891"))
      self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);

    if(isDefined(self calloutmarkerping_entityzoffset("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38")) && !self calloutmarkerping_entityzoffset("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38"))
      self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);

    waitframe();
  }
}

persistantgametypeteamassign() {
  wait 5;
  self playSound("_encstr_AA231B493A77B098C1AF9B8DD76BDEB8DF17B1C3A3A298CF5A5FD989A3");
  self playrumblelooponentity("_encstr_ABC013C6077DBB1A59CA36B9EDDC7D9C576B2636B2");
  wait 3;
  self stoprumble("_encstr_ABC013C6077DBB1A59CA36B9EDDC7D9C576B2636B2");
  waitframe();
  self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
}

completepayloadpunish(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3)) {
    return;
  }
  var_3.movespeedscale = 0;
  var_3 setmovespeedscale(0);

  if(!isDefined(var_3.movespeedscale))
    var_3.movespeedscale = 1.0;

  var_4 = ::movespeed_get_func;
  var_5 = ::movespeed_set_func;
  var_3 thread player_speed_proc(var_0, var_1, var_4, var_5, "_encstr_85D015B358912E02F7F98DC3D5977BED39807F4FD8689D", var_2);
}

player_speed_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify(var_4);
  self endon(var_4);
  var_6 = [[var_2]](var_5);
  var_7 = var_0;

  if(isDefined(var_1) && var_1 > 0) {
    var_8 = var_7 - var_6;
    var_9 = 0.05;
    var_10 = var_1 / var_9;
    var_11 = var_8 / var_10;

    while(abs(var_7 - var_6) > abs(var_11 * 1.1)) {
      var_6 = var_6 + var_11;
      [[var_3]](var_6, var_5);
      wait(var_9);
    }
  }

  [[var_3]](var_7, var_5);
}

movespeed_get_func(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var_0]))
    return 1;

  return self.movespeedscales[var_0];
}

movespeed_set_func(var_0, var_1) {
  var_2 = 1.0;

  if(!isDefined(var_1))
    var_1 = "_encstr_8B1608EC43B8D647A113";

  self.movespeedscales[var_1] = var_0;

  foreach(var_4, var_0 in self.movespeedscales) {
    if(var_0 == 1)
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var_4);

    var_2 = var_2 * var_0;
  }

  self.movespeedscale = var_2;
  self setmovespeedscale(self.movespeedscale);
}

_id_1247B(var_0) {}

rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.ondebugstartfunc))
      [[var_1.ondebugstartfunc]](var_1);

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
  }
}

onplayerspawneddevguisetup(var_0) {
  var_1 = var_0.name;
  var_2 = undefined;

  foreach(var_5, var_4 in level.players) {
    if(var_4 == var_0) {
      var_2 = int(var_5);
      break;
    }
  }

  if(isDefined(var_2))
    var_0 thread setupdevguientries(var_0, var_1, var_2);
}

setupdevguientries(var_0, var_1, var_2) {}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  wait 0.2;
}

wait_for_strike_init_complete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD")) {
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    var_0 = getDvar("_encstr_A70910FF7B8AE9B6DB23D098BA9FE0C0E5D5");
    var_1 = undefined;

    switch (var_0) {
      case "_encstr_91CC11D3C3F9EA1AC8BE04606377DA1C3FF361":
        break;
      default:
        break;
    }
  }
}

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

onplayerconnect(var_0) {}

interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration))
        self.interaction_trigger setuseholdduration(var_1.useduration);

      break;
  }
}

laser_control_station_use_monitor() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("_encstr_A95E0E1AB28D2DC6F6831D59277DC22D", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1) {
    if(var_3.targetname == "_encstr_9732142582D669C4EF8A012B2038AA40915893E96ACF")
      var_0[var_0.size] = var_3;
  }

  scripts\engine\utility::deletestructarray_ref(var_0);
}

_id_134EB(var_0, var_1, var_2) {
  var_3 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_0, var_1.origin, var_1.angles);

  if(!isDefined(var_2))
    var_2 = 0;

  var_3.script_startingposition = var_2;
  var_1 scripts\common\vehicle_aianim::guy_enter(var_3);
  return var_3;
}

propchange(var_0) {
  var_1[1] = 0;
  var_1[2] = 7;
  var_1[3] = 14;
  var_1[4] = 18;
  var_2 = var_0 + var_1[level.players.size];
  var_3 = _id_130A1();

  if(var_2 >= var_3)
    var_2 = var_3 - 1;

  return var_2;
}

_id_130A1() {
  var_0[1] = 0;
  var_0[2] = 8;
  var_0[3] = 14;
  var_0[4] = 20;
  var_1 = 14 + var_0[level.players.size];
  return var_1;
}

c130_drop(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) <= var_1 * var_1)
      return 1;
  }

  return 0;
}

c130_door_badplace_id(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_0) <= var_1 * var_1)
      return 1;
  }

  return 0;
}

brevent1playerthink(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_0) > var_1 * var_1)
      return 0;
  }

  return 1;
}

brevent1playervalid(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distance2dsquared(var_4.origin, var_0) > var_1 * var_1 || var_4.origin[2] > var_2)
      return 0;
  }

  return 1;
}

_id_12758(var_0) {
  if(!isDefined(level._id_121A7))
    level._id_121A7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  level._id_121A7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level._id_121A7 playSound(var_0);
  wait(var_1);
}

brenableagents(var_0, var_1, var_2) {
  var_3 = 1;

  if(!isDefined(var_1) || var_1 == "_encstr_814C02A2")
    var_3 = 0;

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(var_6.origin[var_3] > var_0)
        var_4++;
    }

    if(var_4 >= level.players.size) {
      break;
    }

    wait 0.5;
  }

  scripts\engine\utility::flag_set(var_2);
}

getdefaultstreamhinttimeoutms() {
  return self.inlaststand;
}

_id_1238D(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    wait 0.5;

    if(getaiarrayinradius(var_0, 80).size > 0) {
      badplace_cylinder("_encstr_9ACF14F5186FF2C156600357684982CBCB21F16F70B1", 5, var_0, var_1, var_2, var_3);

      if(isDefined(var_4) && var_3 != var_4)
        badplace_cylinder("_encstr_9ACF14F5186FF2C156600357684982CBCB21F16F70B1", 5, var_0, var_1, var_2, var_4);

      wait 5;
    }
  }
}