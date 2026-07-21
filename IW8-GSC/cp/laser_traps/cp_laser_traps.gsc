/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\laser_traps\cp_laser_traps.gsc
***********************************************/

stopinteract() {
  level.spawn_funcs = [];
  level.spawn_funcs["_encstr_9A8507BA4040188D08"] = [];
  level.spawn_funcs["_encstr_8E8405EA382B2A"] = [];
  level.spawn_funcs["_encstr_B848067B63177293"] = [];
  level.spawn_funcs["_encstr_A7A408B9CA5D1D4E2C63"] = [];
  level.team_specific_spawn_functions = [];
  level.team_specific_spawn_functions["_encstr_8E8405EA382B2A"] = ::spawn_team_axis;
  level.team_specific_spawn_functions["_encstr_9A8507BA4040188D08"] = ::spawn_team_allies;
  level.team_specific_spawn_functions["_encstr_B848067B63177293"] = ::spawn_team_team3;
  level.team_specific_spawn_functions["_encstr_A7A408B9CA5D1D4E2C63"] = ::spawn_team_neutral;
  level.default_goalradius = 2048;
  level.default_goalheight = 512;
  level.spawned_enemies = [];
  level.spawned_allies = [];
  level.spawnloopupdatefunc = ::_id_135C0;
  add_global_spawn_function("_encstr_9A8507BA4040188D08", ::avoidclosetodefenderflagspawn);
  add_global_spawn_function("_encstr_8E8405EA382B2A", ::_id_13DFA);
  add_global_spawn_function("_encstr_8E8405EA382B2A", scripts\mp\mp_agent_damage::stoppingpower_clearhcrdata);
}

avoidclosetodefenderflagspawn() {
  self.headicon = thread scripts\cp\utility::ent_createheadicon(self, 10, "_encstr_9A8507BA4040188D08", "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118", 0);
  setheadiconsnaptoedges(self.headicon, 2000);
  setheadiconmaxdistance(self.headicon, 25);
}

_id_13DFA() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.enemytargetmarkergroup))
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(self, var_2.enemytargetmarkergroup, 1);
  }
}

add_global_spawn_function(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["_encstr_B2BB0998FB35773B1FAFF0"] = var_1;
  var_5["_encstr_81D7070E2C93B0D613"] = var_2;
  var_5["_encstr_ADD707F0EB707381A5"] = var_3;
  var_5["_encstr_97D707ABD1FAFFA582"] = var_4;
  level.spawn_funcs[var_0][level.spawn_funcs[var_0].size] = var_5;
}

remove_global_spawn_function(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.spawn_funcs[var_0].size; var_3++) {
    if(level.spawn_funcs[var_0][var_3]["_encstr_B2BB0998FB35773B1FAFF0"] != var_1)
      var_2[var_2.size] = level.spawn_funcs[var_0][var_3];
  }

  level.spawn_funcs[var_0] = var_2;
}

exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.spawn_funcs))
    return 0;

  for(var_2 = 0; var_2 < level.spawn_funcs[var_0].size; var_2++) {
    if(level.spawn_funcs[var_0][var_2]["_encstr_B2BB0998FB35773B1FAFF0"] == var_1)
      return 1;
  }

  return 0;
}

remove_spawn_function(var_0) {
  if(!isDefined(self.spawn_functions))
    self.spawn_functions = [];

  var_1 = [];

  foreach(var_3 in self.spawn_functions) {
    if(var_3["_encstr_B2BB0998FB35773B1FAFF0"] == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.spawn_functions = var_1;
}

add_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self.spawn_functions))
    self.spawn_functions = [];

  foreach(var_7 in self.spawn_functions) {
    if(var_7["_encstr_B2BB0998FB35773B1FAFF0"] == var_0)
      return;
  }

  var_9 = [];
  var_9["_encstr_B2BB0998FB35773B1FAFF0"] = var_0;
  var_9["_encstr_81D7070E2C93B0D613"] = var_1;
  var_9["_encstr_ADD707F0EB707381A5"] = var_2;
  var_9["_encstr_97D707ABD1FAFFA582"] = var_3;
  var_9["_encstr_87D70783C22716D60D"] = var_4;
  var_9["_encstr_BDD707C10BC90BDAD4"] = var_5;
  self.spawn_functions[self.spawn_functions.size] = var_9;
}

array_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0)
  var_7 thread add_spawn_function(var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_targetname(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_noteworthy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

array_spawn_targetname(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  return can_spawn_extras(var_3, var_1, var_2);
}

array_spawn_noteworthy(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  return can_spawn_extras(var_3, var_1, var_2);
}

can_spawn_extras(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 10;

  var_4 = [];
  var_5 = 0;

  foreach(var_7 in var_0) {
    var_7.count = 1;

    if(isDefined(var_7.classname) && getsubstr(var_7.classname, 7, 10) == "_encstr_9B1904D69B88") {
      var_8 = var_7 scripts\common\utility::spawn_vehicle();

      if(isDefined(var_8.target) && !isDefined(var_8.script_moveoverride))
        var_8 thread scripts\common\vehicle_paths::gopath();

      var_4[var_4.size] = var_8;
    } else {
      var_8 = var_7 spawn_ai();

      if(!var_2) {}

      var_4[var_4.size] = var_8;
    }

    if(var_5 < var_0.size - 1)
      wait(1 / var_3);

    var_5++;
  }

  if(!var_2) {}

  return var_4;
}

spawn_ai(var_0) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("_encstr_AD75063D571AE108");
    wait(self.script_delay_spawn);
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 1;
  var_5 = _id_134F1(self.script_type, self.origin, self.angles, var_2, var_3);

  if(isalive(var_5)) {
    if(isDefined(var_0) && var_0 && isalive(var_5))
      var_5 scripts\common\ai::magic_bullet_shield();
  }

  return var_5;
}

put_headicon_on_tv_station_boss() {
  var_0 = getaiarray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

pushpointoutofkothattractions() {
  var_0 = put_headicon_on_tv_station_boss();
  return var_0.size;
}

_id_134F1(var_0, var_1, var_2, var_3, var_4) {
  if(pushpointoutofkothattractions() >= level._id_11B51)
    return undefined;

  var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_0, var_1, var_2);

  if(isDefined(var_5)) {
    var_5 _id_134E8();
    var_5 scripts\cp\stealth\manager::spawn_think(self);
    var_5 thread scripts\cp\stealth\manager::run_spawn_functions(self.spawn_functions);

    if(var_5.unittype != "_encstr_83E8094727E333E8F9CE50") {
      var_5 thread scripts\cp\cp_battlechatter_ai::addtosystem();
      var_5 thread scripts\cp\cp_squadmanager::addtosquad();
    }
  }

  return var_5;
}

_id_134E8() {
  if(isDefined(self.team)) {
    if(self.team == "_encstr_8E8405EA382B2A")
      level.spawned_enemies[level.spawned_enemies.size] = self;
    else if(self.team == "_encstr_9A8507BA4040188D08")
      level.spawned_allies[level.spawned_allies.size] = self;
  }
}

_id_135C0(var_0, var_1) {
  if(self.team == "_encstr_8E8405EA382B2A")
    level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);
  else if(self.team == "_encstr_9A8507BA4040188D08")
    level.spawned_allies = scripts\engine\utility::array_remove(level.spawned_allies, self);
}

spawn_team_allies() {
  self.usechokepoints = 0;
}

spawn_team_axis() {
  if(isDefined(self.script_combatmode))
    self.combatmode = self.script_combatmode;
}

spawn_team_team3() {
  spawn_team_axis();
}

spawn_team_neutral() {}

ks_pointstowin() {
  self.nocorpse = 1;
  self.diequietly = 1;
  self kill();
}

go_to_node(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = scripts\cp\stealth\manager::get_target_goals(self.target);

    if(var_0.size == 0) {
      self notify("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3");
      return;
    }
  } else if(!isarray(var_0))
    var_0 = [var_0];

  scripts\cp\stealth\manager::go_to_node_internal(var_0, var_1, var_2);
}

get_least_used_from_array(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1.used_time))
    var_1.used_time = 0;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.used_time))
      var_3.used_time = 0;

    if(var_3.used_time < var_1.used_time)
      var_1 = var_3;
  }

  var_1.used_time = gettime();
  return var_1;
}

disable_long_death() {
  self.a.disablelongdeath = 1;
}

enable_long_death() {
  self.a.disablelongdeath = 0;
}

set_goal_pos(var_0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(var_0);
}

set_goal_ent(var_0) {
  set_goal_pos(var_0.origin);
  self.last_set_goalent = var_0;

  if(isstruct(var_0) && !isDefined(var_0.type))
    var_0.type = "_encstr_91D8076ED193D5B11D";
}

set_goal_volume() {
  self endon("_encstr_AD75063D571AE108");
  waittillframeend;

  if(isDefined(self.team) && self.team == "_encstr_9A8507BA4040188D08")
    self.fixednode = 0;

  var_0 = level.goalvolumes[self.script_goalvolume];

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = undefined;

    if(isDefined(var_1)) {
      var_4 = var_1;
      set_goal_node(var_4);
    } else if(isDefined(var_2)) {
      var_4 = var_2;
      set_goal_pos(var_4.origin);
    } else if(isDefined(var_3)) {
      var_4 = var_3;
      set_goal_pos(var_4.origin);
    }

    if(isDefined(var_4.radius) && var_4.radius != 0)
      self.goalradius = var_4.radius;

    if(isDefined(var_4.goalheight) && var_4.goalheight != 0)
      self.goalheight = var_4.goalheight;
  }

  if(isDefined(self.target))
    self setgoalvolume(var_0);
  else
    self setgoalvolumeauto(var_0, var_0 get_cover_volume_forward());
}

set_goal_node(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var_0);
}

disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw))
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  else
    return undefined;
}

set_moveplaybackrate(var_0, var_1) {
  self notify("_encstr_B8881513891D577548D52538895038FBCFE12A8B91F577");
  self endon("_encstr_B8881513891D577548D52538895038FBCFE12A8B91F577");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_1)) {
    var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    var_3 = var_0 - var_2;
    var_4 = 0.05;
    var_5 = var_1 / var_4;

    for(var_6 = var_3 / var_5; abs(var_0 - var_2) > abs(var_6 * 1.1); var_2 = scripts\asm\asm::asm_getmoveplaybackrate()) {
      scripts\asm\asm::asm_setmoveplaybackrate(var_2 + var_6);
      wait(var_4);
    }
  }

  scripts\asm\asm::asm_setmoveplaybackrate(var_0);
}

teamanchoredwidgetinstances() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_84530DBFC7426F200EB1037B26FFE0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = strtok(var_2.weaponinfo, "_encstr_BE4C0295");
    var_4 = var_3[0];
    var_5 = scripts\engine\utility::array_remove(var_3, var_4);
    var_6 = scripts\cp\cp_weapon::buildweapon(var_4, var_5);
    var_7 = "_encstr_B2010820C5337B67C8CF" + var_4;
    var_8 = scripts\cp\utility::array_merge(var_6.attachments, var_5);

    foreach(var_10 in var_8)
    var_7 = var_7 + ("_encstr_BE4C0295" + var_10);

    var_12 = spawn(var_7, var_2.origin, 1);
    var_12.angles = var_2.angles;
    var_12 _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::setscriptammo(var_4, var_2);
  }
}

_id_139AA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_10.angles = var_1;

  if(isDefined(var_3))
    var_10 setModel(var_3);
  else
    var_10 setModel("_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782");

  _id_139A9(var_10);
  thread _id_139AC(var_10, var_2, var_8);
  thread _id_139AB(var_10, var_4, var_5, var_6, var_7, var_9);
  return var_10;
}

_id_139A9(var_0) {
  var_0 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_0 sethintdisplayrange(256);
  var_0 setuserange(84);
  var_0 setusefov(180);
  var_0 sethintdisplayfov(180);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 sethintrequiresholding(0);
  var_0 setusepriority(0);
  var_0 makeusable();
}

_id_139AC(var_0, var_1, var_2) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_3 = 0;

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(!isPlayer(var_4)) {
      continue;
    }
    thread[[var_1]](var_0, var_4);

    if(_id_139A8(var_0.model)) {
      var_0 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_8A2D0E8F70CFA38920473FEBDF4D2AA9", 0);
      wait(_id_139A7());
      var_0 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ADC90F81F59F684509BBD7AFDB3295A02D", 0);
      wait(_id_139A6());
    }

    var_3++;

    if(isDefined(var_2) && var_3 >= var_2)
      var_0 delete();
  }
}

_id_139A8(var_0) {
  if(var_0 == "_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782")
    return 1;

  if(var_0 == "_encstr_8F4D21A043BED8132ADF100CF5517F23F0B318C09352F0F901867119CB9AB3CB41B798")
    return 1;

  if(var_0 == "_encstr_8D37213817EA59A9EEEB89D0D70723AB333AA03EEBC20FB2F707B8E0FB5F7B2BBBE726")
    return 1;

  return 0;
}

_id_139AB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(!isDefined(var_5))
    var_5 = &"_encstr_91461CBF6F6871B16C9578EB27DB639B1358D99BC18C6FD3A0E3A716B16B";

  var_0 setHintString(var_1);
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  _id_139A9(var_6);
  var_6 setHintString(var_5);
  var_0.headiconid = scripts\cp\utility::ent_createheadicon(var_0, 15, "_encstr_9A8507BA4040188D08", var_2, 1);
  setheadiconsnaptoedges(var_0.headiconid, 1500);
  setheadiconmaxdistance(var_0.headiconid, 15);
  var_7 = var_0 getentitynumber();
  var_8 = 0.1;

  for(;;) {
    foreach(var_10 in level.players) {
      if(!isDefined(var_10._id_139B4))
        var_10._id_139B4 = [];

      if(scripts\cp\cp_endgame::gamealreadyended()) {
        foreach(var_10 in level.players) {
          removeteamfromheadiconmask(var_0.headiconid, var_10);
          return 1;
        }
      }

      var_13 = !isDefined(var_10._id_139B4[var_7]) || !var_10._id_139B4[var_7];
      var_14 = !isDefined(var_10._id_139B4[var_7]) || var_10._id_139B4[var_7];

      if(var_13 && [[var_4]](var_10)) {
        var_10 notify("_encstr_8B431AFB63F7130D4809B79227C0D9CF1FB95213C9D84B85B83B858A" + var_7);
        removeteamfromheadiconmask(var_0.headiconid, var_10);
        var_0 disableplayeruse(var_10);
        childthread _id_139A5(var_10, var_0, var_6, var_7);
        var_10._id_139B4[var_0 getentitynumber()] = 1;
        continue;
      }

      if(var_14 && ![[var_4]](var_10)) {
        var_10 notify("_encstr_8B431AFB63F7130D4809B79227C0D9CF1FB95213C9D84B85B83B858A" + var_7);
        addteamtoheadiconmask(var_0.headiconid, var_10);
        var_0 enableplayeruse(var_10);
        var_6 disableplayeruse(var_10);
        var_10._id_139B4[var_0 getentitynumber()] = 0;
      }
    }

    wait(var_8);
  }
}

_id_139A5(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_8B431AFB63F7130D4809B79227C0D9CF1FB95213C9D84B85B83B858A" + var_3);
  wait 2.0;
  var_2 enableplayeruse(var_0);
}

brplayerhudoutlineforteammatesupdate(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::brpreplayerdamaged, "_encstr_8F4D21A043BED8132ADF100CF5517F23F0B318C09352F0F901867119CB9AB3CB41B798", &"_encstr_A99D1E687AE9287D86A4A08C2A52273AF228A6A6E9F51A92A0A88AD7A882B451", "_encstr_AD6E13B11CF51B27C2E895AF4BC6DB37F585D6B5BD", "_encstr_966D17373856A3E30BF58F0953370A66FE2887F7288E0ADA69", ::_id_124B0);
}

brpreplayerdamaged(var_0, var_1) {
  var_2 = var_1 getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(var_4) == "_encstr_A5450BC280BF4B604068C33187") {
      continue;
    }
    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_4)) {
      continue;
    }
    var_1 givemaxammo(var_4);
  }

  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

handle_leads_collected_hideiconbuilding(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::handle_no_ammo_mun, "_encstr_8D37213817EA59A9EEEB89D0D70723AB333AA03EEBC20FB2F707B8E0FB5F7B2BBBE726", &"_encstr_A2D817689E3D287D0D2550912A29398E798626A05653D34A2A", "_encstr_B82E1C8BE3FA0798D317D06107F9D3A3630DF5373BE1C760B927C0E8B305", "_encstr_B17820C827E1D94AC9C588C06202231C7B21E56A3BF722C951CBE8C8AB90B97B3053", ::handle_just_keep_moving);
}

handle_no_ammo_mun(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_8E910FA7E764B78317A2C973305A28B33B", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

handle_just_keep_moving(var_0) {
  return _id_12470(var_0, "_encstr_8E910FA7E764B78317A2C973305A28B33B");
}

binoculars_getpendingtime(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::binoculars_giveassistpoints, "_encstr_B14719D86A6911694FBC78EC813B93E1C1327860A1BCAB03DF8857", &"_encstr_8BB01A8628D79A9EBE1925C9823115F282941AB4AA14BED4A894A94D", "_encstr_AAF018CB10333114D335F0D84083E3516F1880D84319EB4918A7", "_encstr_913B1C506D7B77D13275E5EFA78FCBAB7B37A2D063EF680BC8DA613DF597", ::binoculars_getpendingendtime);
}

binoculars_giveassistpoints(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_820F114AE740032B7F8680CAD930B1D239F212", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

binoculars_getpendingendtime(var_0) {
  return _id_12470(var_0, "_encstr_820F114AE740032B7F8680CAD930B1D239F212");
}

_id_11CB8(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::_id_11CBA, "_encstr_8D37213817EA59A9EEEB89D0D70723AB333AA03EEBC20FB2F707B8E0FB5F7B2BBBE726", &"_encstr_A55E16E9F42559160F5AAF34740FFCCF85881119788B2F0F", "_encstr_AAE91BE0F3BF17803FD78868B51F4B23E2DA30587B99BB983BCF8D789E", "_encstr_A2D91F0DEA91AFA58DF69BD7B22ED5D283DAB2371DD75BED63DB1DF6D9EB932B32", ::_id_11CB7);
}

_id_11CBA(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_87CB0E0B177C92B2411875BD7030E71B", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

_id_11CB7(var_0) {
  return _id_12470(var_0, "_encstr_87CB0E0B177C92B2411875BD7030E71B");
}

playerplunderlosedepositcallback(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::playerplunderpickup, "_encstr_8D37213817EA59A9EEEB89D0D70723AB333AA03EEBC20FB2F707B8E0FB5F7B2BBBE726", &"_encstr_A65013BF77E5B180270135DD4927D0D115966533E7", "_encstr_8384181CBDC1F97979609B5718133DC281D92715A50FA2AAC138", "_encstr_B42C1C6BA31838A3E33728DEE2A013E3D33530BACCA723221F7061E60167", ::playerplunderlosedeposit);
}

playerplunderpickup(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_81580B52FF3F7F3D195A6A61A7", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

playerplunderlosedeposit(var_0) {
  return _id_12470(var_0, "_encstr_81580B52FF3F7F3D195A6A61A7");
}

focus_fire_outline_enabled(var_0, var_1, var_2) {
  return _id_139AA(var_0, var_1, ::fogenabled, "_encstr_8D37213817EA59A9EEEB89D0D70723AB333AA03EEBC20FB2F707B8E0FB5F7B2BBBE726", &"_encstr_BDCD1AA245AA920A5354722AD742A472A2A9BC41941AD2AA41BE8643", "_encstr_A5DD16865D19F55A1BB7B9FA955CAE2D386BB2B9E8F58D43", "_encstr_B22B1A60733F972DBF5708E8359FCBA3625AB0D8FB1927737752857D", ::focus_fire_is_activated);
}

fogenabled(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_8D7C09102FE7216D71A66D", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

focus_fire_is_activated(var_0) {
  return _id_12470(var_0, "_encstr_8D7C09102FE7216D71A66D");
}

player_limitedammo(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::player_max_exposure_time, "_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782", &"_encstr_930714FF37A5F1C06741759D09671011D5569973B3DC", "_encstr_99501904B3384782BED7BB873B5F8BB94018FF0D0B89068A87C7AB", "_encstr_92E31D947BAB2E495E2F6827155ADBB7FB0F779E0111AED139F3B87986E59F", ::player_latespawn_safehouse);
}

player_max_exposure_time(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_B81D0C38EDBB56C9F599B12CDC34", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

player_latespawn_safehouse(var_0) {
  return _id_12470(var_0, "_encstr_B81D0C38EDBB56C9F599B12CDC34");
}

_id_13433(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::_id_13434, "_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782", &"_encstr_A2FE1BB8C745D7E2918B464447B9BD3F6F3FE0800F38B72AF975415CBB", "_encstr_879B1CA9AF3AD0C8EB555876FFC11073D3573BDDC3D18E38016AE3A865AC", "_encstr_B2B52020DB25D91C3388AAE107500B9C600D823D3B110B92281312919A93C9732904", ::_id_13432);
}

_id_13434(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

_id_13432(var_0) {
  return _id_12470(var_0, "_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895");
}

plunderfxondropthreashold(var_0, var_1) {
  return _id_139AA(var_0, var_1, ::plunderinstanceid, "_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782", &"_encstr_969E0E5415AA9282A954C98A97740A35", "_encstr_961D173B534AB7286347801177A96313B3FD25B06B919F115B", "_encstr_961D173B534AB7286347801177A96313B3FD25B06B919F115B", ::plunderforextract);
}

plunderinstanceid(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 2);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

plunderforextract(var_0) {
  return _id_12470(var_0, "_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F");
}

trial_active_fob(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 = "_encstr_BD4A16EA0194176E907FA4B13940353BA81337C1A86FFFE5";

  if(isDefined(var_1))
    var_3.angles = var_1;
  else
    var_3.angles = (0, 0, 0);

  var_3 setModel(var_4);
  var_3 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_3 setHintString(&"_encstr_97761EF9E1314F048FB9D8A3491F2C6FED68099108DE09BCDFB258AB6613F5E1");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(45);
  var_3 setuserange(100);
  var_3 setusefov(40);
  var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  var_3 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_3 setusepriority(1);
  var_3 makeusable();
  thread trial_end_flares(var_3, var_2);
  return var_3;
}

trial_end_flares(var_0, var_1) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    thread[[var_1]](var_2, var_0);
    var_2 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
    break;
  }

  var_0 makeunusable();
  var_0 delete();
}

get_driver_interaction_hint_string(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_3;
  var_7 = var_6 + (0, 0, -8000);
  var_8 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_9 = physics_raycast(var_6, var_7, var_8, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_9) && var_9.size > 0)
    var_10 = var_9[0]["_encstr_BD260953AA97E3F014279D"];
  else
    var_10 = var_3;

  var_11 = var_3 + -1 * anglesToForward(var_2) * var_0;
  var_12 = var_3 + anglesToForward(var_2) * var_1;
  var_13 = scripts\cp_mp\killstreaks\airdrop::createheli(undefined, "_encstr_9A8507BA4040188D08", var_11, var_2, 0);
  var_13 scripts\common\vehicle::godon();
  var_13 setCanDamage(0);
  var_13 vehicle_setspeed(200, 100);
  var_13 setmaxpitchroll(15, 15);
  var_14 = get_enter_leave_station_time(var_11, var_2);
  var_15 = get_ending_struct(var_14);
  var_16 = get_emp_effect_duration(var_14);
  var_15 linkTo(var_14);
  var_16 linkTo(var_14);
  var_14 linkTo(var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (16, 0, -156), (0, 0, 0));
  var_13 setvehgoalpos(var_3, 1);
  wait 2;
  var_13 setyawspeed(40, 20, 20, 0.3);
  var_13 waittill("_encstr_8B7205D9ED5958");
  wait 0.25;
  thread get_evade_start_structs_in_front(var_14, var_15, var_16, var_4, var_5);
  wait 0.5;
  var_13 vehicle_setspeed(150, 50);
  var_13 setvehgoalpos(var_12, 1);
  var_13 waittill("_encstr_8B7205D9ED5958");
  var_13 thread scripts\cp_mp\killstreaks\airdrop::destroyheli();
}

get_evade_start_structs_in_front(var_0, var_1, var_2, var_3, var_4) {
  var_0 unlink();
  var_0 physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_5 = var_0 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_5, (0, 0, -1));
  var_0 physics_registerforcollisioncallback();
  get_explosion_alias(var_0);
  var_0 physicsstopserver();
  var_0 physics_unregisterforcollisioncallback();
  thread get_end_ang(var_0, var_1, var_2, var_3, var_4);
}

get_explosion_alias(var_0) {
  wait 1;
  var_1 = gettime() + 10000;

  while(gettime() < var_1) {
    var_2 = var_0 physics_getbodyid(0);
    var_3 = physics_getbodylinvel(var_2);

    if(lengthsquared(var_3) <= 0.5) {
      break;
    }

    waitframe();
  }
}

get_end_ang(var_0, var_1, var_2, var_3, var_4) {
  var_5 = createnavobstaclebybounds(var_0.origin, (30, 10, 64), var_0.angles);
  var_6 = var_0 scripts\cp\utility::killstreak_createobjective("_encstr_ABC919966CDB73F5DAD237A5B55883AF8DC2C9590E85C6B5B0ECAC", "_encstr_9A8507BA4040188D08", 1, 1, 0);
  var_7 = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_7, "_encstr_8AAF25786B27FF68C73F60F068E751414112F8A0123A1143B759FAC8E31FFB1BF21A30107A577B");
  addclienttoheadiconmask(var_7, -7);
  setheadiconmaxdistance(var_7, 0);
  setheadiconsnaptoedges(var_7, 6250);
  setheadiconowner(var_7, undefined);
  setheadiconzoffset(var_7, 1);
  hideheadiconfromplayersinmask(var_7);
  var_0.headicon = var_7;
  var_0 playSound("_encstr_BD5C1BF7C0AE2B5AB5E5897ADFBF32F17180C77FF0615F82F3070EB6BD");
  var_0 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_0 sethintdisplayrange(256);
  var_0 setuserange(100);
  var_0 setusefov(180);
  var_0 sethintdisplayfov(180);
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 setusepriority(0);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 sethinttag("_encstr_BA300854E318F1FF9699");
  var_0 makeusable();
  var_0 setHintString(&"_encstr_84621F6383AC13CAB1815810A15731FBE498E4F318152306E901E1F9A94F7CC77F");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_8);

    if(!isPlayer(var_8)) {
      continue;
    }
    if(_id_124D0(var_8)) {
      thread logevent_givecpweaponxp(var_8, &"_encstr_978915C5A9D7863155D53B15DFA209F80371DEED4133C9", 3.0);
      continue;
    }

    if(isDefined(var_3))
      _id_124A5(var_8, var_3);

    if(isDefined(var_4))
      thread[[var_4]](var_8, var_0.origin, var_3);

    break;
  }

  var_9 = (0, 0, -44);
  var_2 unlink();
  var_2.origin = var_2.origin + var_9;
  var_0 unlink();
  var_0.origin = var_0.origin + var_9;
  var_1 unlink();
  var_0 makeunusable();
  setheadiconimage(var_7);
  var_0.headicon = undefined;
  var_1 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_95EB0866891B23FB85B3", 0);
  var_1 setscriptablepartstate("_encstr_95EB0866891B23FB85B3", "_encstr_99AD06D3A5B1538B", 0);
  objective_state(var_6, "_encstr_8267056410C669");
  scripts\cp\utility::nonobjective_returnobjectiveid(var_6);
  wait 2.0;
  destroynavobstacle(var_5);
  var_2 delete();
  var_1 delete();
  var_0 delete();
}

get_enter_leave_station_time(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = var_1;
  var_2 setModel("_encstr_99861EB55AC6A5A32C9CE5BED88593AC1C0B36B6583BB2FA81137D23BA6B6B5E");
  var_2 setnodeploy(1);
  var_2 setCanDamage(0);
  var_2 makeunusable();
  var_2.targetname = "_encstr_8F180CCB17EB37825B883A9240BB";
  return var_2;
}

get_drone_target_loc() {
  return getEntArray("_encstr_8F180CCB17EB37825B883A9240BB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

get_ending_struct(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("_encstr_9BBA2105BB0834A3C7331379F92F63EF4013839BC3287F47574389F2E373776538E121");
  var_1 setnodeploy(1);
  var_1 setCanDamage(0);
  var_1 makeunusable();
  var_1 linkTo(var_0);
  return var_1;
}

get_emp_effect_duration(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 dontinterpolate();
  var_1.angles = var_0.angles;
  var_2 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 clonebrushmodeltoscriptmodel(var_2);
  var_1 linkTo(var_0);
  return var_1;
}

_id_124A5(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_0);

  if(isDefined(var_2)) {
    var_3 = var_2;
    var_0 scripts\cp\cp_munitions::give_munition_to_slot(var_1, var_3);
  } else
    var_0 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
}

_id_124AF(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weapontype(var_3) == "_encstr_A5450BC280BF4B604068C33187") {
      continue;
    }
    var_4 = var_0 getweaponammostock(var_3);

    if(var_4 < weaponmaxammo(var_3))
      return 0;

    var_5 = var_0 getweaponammoclip(var_3);

    if(var_5 < weaponclipsize(var_3))
      return 0;
  }

  return 1;
}

_id_124B0(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weapontype(var_3) == "_encstr_A5450BC280BF4B604068C33187") {
      continue;
    }
    var_4 = var_0 getweaponammostock(var_3);

    if(var_4 < weaponmaxammo(var_3))
      return 0;
  }

  return 1;
}

can_play_ending(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    foreach(var_4 in var_0) {
      if(scripts\engine\utility::is_equal(var_4.script_index, var_2))
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  var_6 = scripts\engine\utility::array_remove_array(var_0, var_1);
  var_1 = scripts\cp\utility::array_merge(var_1, var_6);
  return var_1;
}

_id_12F55(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;

  if(isDefined(var_1))
    var_2.angles = var_1;

  level.struct[level.struct.size] = var_2;
  return var_2;
}

_id_12F56(var_0) {
  if(!isDefined(level.checkpoint_player_spawns))
    level.checkpoint_player_spawns = 0;
  else
    level.checkpoint_player_spawns++;

  var_1 = "_encstr_B45C0B018BC0BD27553B2BB203" + level.checkpoint_player_spawns;
  self.target = var_1;
  var_0.targetname = var_1;
}

_id_12486(var_0) {
  var_0.ability_invulnerable = 1;
}

_id_12484(var_0) {
  var_0.ability_invulnerable = undefined;
}

print_spawner_score_for_factor() {
  return self.baseaccuracy;
}

set_baseaccuracy(var_0) {
  self.baseaccuracy = var_0;
}

_id_143A1() {
  while(pushpointoutofkothattractions() > 0)
    waitframe();
}

logevent_downed(var_0, var_1) {
  foreach(var_3 in level.players)
  thread logevent_givecpweaponxp(var_3, var_0, var_1);
}

logevent_givecpweaponxp(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 sethudtutorialmessage(var_1);
  wait(var_2);
  var_0 clearhudtutorialmessage();
}

_id_124D0(var_0) {
  var_1 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(!isDefined(var_0.munition_slots)) {
      continue;
    }
    if(!isDefined(var_0.munition_slots[var_3])) {
      continue;
    }
    if(var_0 scripts\cp\loot_system::is_empty_or_none(var_3)) {
      continue;
    }
    var_2++;
  }

  return var_1 == var_2;
}

_id_12470(var_0, var_1) {
  return isDefined(var_0.powers) && isDefined(var_0.powers[var_1]) && var_0.powers[var_1].charges == var_0.powers[var_1].maxcharges;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

_id_124E9(var_0, var_1) {
  var_0.animname = var_1;
  var_2 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_2 hide();
  var_2.animname = var_1;
  var_2 useanimtree(#animtree);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  return var_2;
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

_id_139A7() {
  return getanimlength(%_encstr_83071A433061EBC3B7693FB39956AA28B9D9BACDAB808439B7411FCB);
}

#using_animtree("_encstr_B40101");

_id_139A6() {
  return getanimlength(%_encstr_8E521BB7095677EB512852BB304DA5938EE43A579DD893391FA05AA350);
}

_id_13067() {
  level.autoassignlowteamconsistent = gettime();
}

init_minigun_lifetime_shot_count(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawncovernode(var_1, var_3, "_encstr_845E066177577837", 0, var_0, undefined, var_4);
  var_8 = undefined;

  if(isDefined(var_5)) {
    var_8 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_5);
    var_8.angles = var_3;
  }

  var_9 = spawncovernode(var_1, var_3, "_encstr_961804BD954A", 0, var_0 + "_encstr_BD4305AF56CD91", var_0, var_4);

  if(isDefined(var_6))
    var_7.animation = var_6;

  var_7.usagecost = 15;
  createnavlink("_encstr_85710AE8C90B9DCAE49BCAF5" + var_4, var_1, var_2, var_7, "_encstr_958C08CDDBD8325A959C");
  var_7 _id_1363C(var_9, var_8);
  return var_7;
}

_id_1363C(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  scripts\asm\asm::calculate_traverse_data(var_1.origin, var_0.origin);

  if(isDefined(self.parentname))
    scripts\asm\asm::store_original_traverse_data();

  if(isent(var_1))
    var_1 delete();
  else
    scripts\engine\utility::deletestruct_ref(var_1);
}

_id_14309() {
  if(!isDefined(self._id_1430C))
    self._id_1430C = [];
}

_id_1430A(var_0) {
  _id_14309();
  self._id_1430C[var_0] = undefined;
}

_id_1430B(var_0, var_1) {
  if(isDefined(self._id_1430C[var_0])) {
    return;
  }
  self._id_1430C[var_0] = var_1;
}

_id_1430D() {
  level._id_14312 = [];
}

_id_1430E(var_0, var_1) {
  if(isDefined(level._id_14312[var_0])) {
    return;
  }
  foreach(var_3 in level.players)
  var_3 _id_1430A(var_0);

  level._id_14312[var_0] = 1;
  level thread _id_1430F(var_0, var_1);
}

_id_1430F(var_0, var_1) {
  var_2 = 0;
  var_3 = gettime() + var_1 * 1000;
  var_4 = -1;
  var_5 = -1;
  var_6 = -1;
  waitframe();

  while(gettime() < var_3) {
    if(level.gameended) {
      var_2 = 0;
      break;
    }

    var_7 = int((var_3 - gettime()) * 0.001);

    if(var_7 != var_5) {
      var_5 = var_7;
      _id_14311(var_7);
    }

    foreach(var_9 in level.players) {
      if(!isDefined(var_9._id_1430C))
        var_9 _id_1430A(var_0);
    }

    var_11 = 0;

    foreach(var_9 in level.players) {
      if(!isDefined(var_9._id_1430C))
        var_9 _id_1430A(var_0);

      if(istrue(var_9._id_1430C[var_0]))
        var_11++;
    }

    if(var_11 != var_4 || var_6 != level.players.size + 1) {
      var_4 = var_11;
      var_6 = level.players.size;
      _id_14310(var_11, var_6);
    }

    if(var_11 == level.players.size) {
      var_2 = 1;
      break;
    }

    waitframe();
  }

  if(level.gameended)
    var_2 = 0;

  level._id_14312[var_0] = undefined;
  _id_14311(0);
  _id_14310(0, 0);

  foreach(var_9 in level.players)
  var_9 _id_1430A("_encstr_85F206A6C7DB7DBA");

  if(var_2)
    scripts\cp\cp_endgame::restart_map(0);
}

_id_14311(var_0) {
  setomnvar("_encstr_AB7A105D93CEFBC5F1383B93604FFB7F600D", var_0);
}

_id_14310(var_0, var_1) {
  setomnvar("_encstr_B874174DAC011DED9C774018079FBB718AD0CD56C3BAD18963", var_0);
  setomnvar("_encstr_AC101727117F3ED80917C08AE8202051FE9AE7ED98F52B50CC", var_1);
}

little_bird_mg_cp_ondeathrespawncallback() {
  if(!istrue(level.nojip)) {
    level.nojip = 1;
    setnojipscore(1, 1);
    setnojiptime(1, 1);
  }
}

_id_13542(var_0, var_1, var_2) {
  var_3 = magicgrenademanual("_encstr_ACC40CC1F8A321601715CFBFE0EA", var_0 + (0, 0, 10), (0, 0, 10));
  var_3 childthread _id_123B2(var_0, var_1, var_2);
  return var_3;
}

_id_123B2(var_0, var_1, var_2) {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.angles = var_1;
  self.owner = spawnStruct();
  self.owner.angles = var_1;
  self.owner.team = "_encstr_8E8405EA382B2A";
  self.team = "_encstr_8E8405EA382B2A";
  var_3 = self.owner;
  thread scripts\cp\cp_equipment::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread minedamagemonitor();
  thread scripts\cp\cp_claymore::claymore_explodeonnotify();
  thread scripts\cp\cp_claymore::claymore_destroyonemp();
  self setscriptablepartstate("_encstr_A24E069389FFAA3C", "_encstr_930B07BB1B6B3854FF", 0);
  wait 0.1;
  self enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_930B07BB1B6B3854FF", 0);
  thread intermissionspawnorigin(var_0);
  thread next_subway_track_hurt_time(var_2);
}

intermissionspawnorigin(var_0) {
  var_1 = var_0 + (0, 0, 50) + anglesToForward(self.angles) * 95;
  var_2 = var_0 + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("_encstr_AD75063D571AE108");
  var_3 = getaiarray("_encstr_8E8405EA382B2A")[0];
  radiusdamage(var_2, 30, 1000, 200, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB");
  radiusdamage(var_1, 100, 1000, 20, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB");
}

minedamagemonitor() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self endon("_encstr_AD75063D571AE108");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  self notify("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");

  if(isDefined(var_4) && (issubstr(var_4, "_encstr_911B0C7DA090E9A7F799FD50DD48") || issubstr(var_4, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")))
    self.waschained = 1;

  if(isDefined(var_8) && var_8 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isDefined(var_0))
    self.damagedby = var_0;

  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_0);
}

next_subway_track_hurt_time(var_0) {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  var_1 = physics_createcontents(["_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52"]);

  for(;;) {
    var_2 = level.players;
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoup(self.angles);
    var_5 = self.origin + var_4 * 0;
    var_6 = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(var_8 in level.dynamicladders)
      var_6[var_6.size] = var_8.ents[0];
    }

    if(istrue(var_0))
      var_2 = scripts\engine\utility::array_combine(var_2, getaiarray("_encstr_9A8507BA4040188D08"));

    foreach(var_11 in var_2) {
      if(!isDefined(var_11)) {
        continue;
      }
      if(isPlayer(var_11) && scripts\cp\cp_laststand::player_in_laststand(var_11) || isagent(var_11) && !isalive(var_11)) {
        continue;
      }
      if(lengthsquared(var_11 getentityvelocity()) < 10) {
        continue;
      }
      if(distance2dsquared(var_11.origin, self.origin) > 50625) {
        continue;
      }
      var_12 = var_11 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");
      var_13 = [var_12];
      var_14 = var_5 - var_12;

      if(vectordot(var_14, (0, 0, 1)) >= 0)
        var_13[var_13.size] = var_11 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
      else
        var_13[var_13.size] = var_11.origin;

      foreach(var_16 in var_13) {
        var_14 = var_16 - self.origin;
        var_17 = vectordot(var_14, var_3);

        if(var_17 > 192 || var_17 < 20) {
          continue;
        }
        var_18 = vectordot(var_14, var_4);

        if(abs(var_18) > 32) {
          continue;
        }
        var_19 = vectorNormalize(var_14);
        var_20 = vectordot(var_19, var_3);

        if(var_20 < 0.86602) {
          continue;
        }
        var_21 = physics_raycast(var_5, var_16, var_1, var_6, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

        if(isDefined(var_21) && var_21.size > 0) {
          continue;
        }
        thread scripts\cp\cp_claymore::claymore_trigger(var_11);
      }
    }

    wait 0.05;
  }
}

_id_131F6() {
  initnightvisionheadoverrides();
}

initnightvisionheadoverrides() {
  if(!_encstr_868025B3E9BE2F92307F8FCB51C21F576941BB9B139D8F9D7061C7C3237063BF0C79B276596E77::allow_nvg()) {
    return;
  }
  level.nvgheadoverrides = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 5);
    var_2 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 17);
    var_3 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 16);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    if(var_2 != "_encstr_B40101")
      level.nvgheadoverrides[var_1]["_encstr_87070365F7"] = var_2;

    if(var_3 != "_encstr_B40101")
      level.nvgheadoverrides[var_1]["_encstr_9767056D0FBFA8"] = var_3;

    var_0++;
  }

  level.nvgheadoverrides["_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_AFB023862B2C8CBEDAE0FAB20BCDD1CA39E6EB99B49CB2D1CA85D6AFAC0BB9D1F55827F566"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_8652241227682C9780830EB20A2F3817F86DE1DA93E8A235E25F4D1151267B9B7F5D9EC9B7D2"]["_encstr_9767056D0FBFA8"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_8652241227682C9780830EB20A2F3817F86DE1DA93E8A235E25F4D1151267B9B7F5D9EC9B7D2"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
}

mountain_three_death_func() {
  if(istrue(self.inspawncamera))
    scripts\engine\utility::_id_143A5("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_867E0DE2A9B51FDB1027D3DC7328DB");

  while(!isDefined(self.operatorcustomization))
    waitframe();

  thread scripts\cp\equipment\nvg::runnvg();
  self nightvisionviewon(1);
}

_id_1437A(var_0, var_1) {
  level notify("_encstr_BE5B1E6E3F19B2031FC3B2E167606092CFDFF848C8F833B8480B3B116BF39540");

  if(!isDefined(var_0))
    var_0 = 30;

  var_2 = getdvarint("_encstr_87B60BC4DC439930C8178D957F");
  var_3 = 1;
  var_4 = 0;
  var_5 = undefined;

  if(!istrue(var_1))
    var_5 = _id_11B41();

  while(var_0 > -1) {
    if(level.hostdamagefactorlow >= var_2) {
      if(!var_4 && var_0 > 5) {
        var_4 = 1;
        var_0 = 5;
      }
    }

    foreach(var_7 in level.players) {
      var_7 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
      var_7 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_0);
    }

    wait 1;
    var_0--;
  }

  scripts\engine\utility::flag_set("_encstr_AB8C1A73A8E8C7952085050B99819B3729019B39115BBB4CB0913D14");

  foreach(var_7 in level.players) {
    var_7 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
    var_7 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
  }

  if(!istrue(var_1)) {
    var_5 fadeovertime(var_3);
    var_5.alpha = 0;
    var_5 scripts\engine\utility::delaycall(var_3, ::destroy);
  }

  scripts\cp\cp_hostmigration::waittillhostmigrationdone();
  level notify("_encstr_B8C41F5BE77F236B886F5763EA3A913F7845FA235A38F778FF52DB7588A7F3D722");
}

_id_11B41() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 20;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  return var_0;
}

_id_13F98() {
  for(;;) {
    wait 1;

    if(isDefined(self.favoriteenemy)) {
      self getenemyinfo(self.favoriteenemy);
      self setgoalpos(self.favoriteenemy.origin);
      continue;
    }

    if(isDefined(self.enemy)) {
      self getenemyinfo(self.enemy);
      self setgoalpos(self.enemy.origin);
      continue;
    }

    var_0 = vehicle_damage_setvehiclehitdamagedataforweapon();

    if(!isDefined(var_0)) {
      continue;
    }
    self getenemyinfo(var_0);
    self setgoalpos(var_0.origin);
  }
}

vehicle_damage_setvehiclehitdamagedataforweapon() {
  var_0 = undefined;

  if(isDefined(self.attacker)) {
    var_0 = self.attacker;
    self.attacker = undefined;
  } else
    var_0 = vehicle_damage_setvehiclehitdamagedata(self.origin);

  return var_0;
}

vehicle_damage_setvehiclehitdamagedata(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3) || var_3.inlaststand) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_3 = scripts\engine\utility::getclosest(var_0, var_1);
  return var_3;
}