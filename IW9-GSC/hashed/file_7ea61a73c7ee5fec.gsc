/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7ea61a73c7ee5fec.gsc
***********************************************/

_id_4199FA5F46D84613() {
  while(!isDefined(getEnt("disable_repulsors", "script_noteworthy")))
    wait 1;

  trigger = getEnt("disable_repulsors", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    break;
  }

  level.createrpgrepulsors = 0;
}

spawn_reinforcement_truck() {
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);

  if(level._id_6E5FF6CAE14C4081.size >= 3) {
    return;
  }
  _id_8C1B775CB466BA39 = scripts\engine\utility::getStructArray("reinforce_truck_pos", "targetname");
  _id_1D2F4E54D6EAA522 = [];

  foreach(player in level.players) {
    _id_5117F099DD2765E4 = scripts\engine\utility::get_array_of_closest(player.origin, _id_8C1B775CB466BA39, undefined, 1, undefined, 7000);

    if(_id_5117F099DD2765E4.size)
      _id_1D2F4E54D6EAA522[_id_1D2F4E54D6EAA522.size] = _id_5117F099DD2765E4[0];
  }

  if(!_id_1D2F4E54D6EAA522.size) {
    return;
  }
  _id_512D574A44967825 = scripts\engine\utility::random(_id_1D2F4E54D6EAA522);
  _id_995268E01F2939C9 = scripts\engine\utility::getStruct("reinforce_truck", "targetname");
  _id_995268E01F2939C9._id_14CDE247AC3313A4 = "tan_aq";
  _id_995268E01F2939C9.origin = _id_512D574A44967825.origin;
  _id_995268E01F2939C9.angles = _id_512D574A44967825.angles;
  truck = scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_995268E01F2939C9);
}

_id_9C14E3A04CD5B468() {
  level endon("stop_sending_reinforcements");
  ticks = 0;

  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  wait 15;

  for(;;) {
    wait 1;
    vehicle = _id_3A1D8DB6D92D73F8::_id_AEAB160D1452A77E();

    if(isDefined(vehicle)) {
      if(vehicle.health / vehicle.maxhealth < 0.45)
        level notify("vehicle_health", vehicle);

      ticks = 0;
      continue;
    }

    level._id_7DA5E47838B88E6C = scripts\engine\utility::array_removeundefined(level._id_7DA5E47838B88E6C);
    level._id_7DA5E47838B88E6C = scripts\engine\utility::array_removedead(level._id_7DA5E47838B88E6C);

    if(!isDefined(level.players) || level.players.size < 1) {
      continue;
    }
    _id_2786E18914900397 = undefined;

    foreach(player in level.players) {
      _id_2786E18914900397 = scripts\engine\utility::getclosest(player.origin, level._id_7DA5E47838B88E6C, 4500);

      if(isDefined(_id_2786E18914900397)) {
        break;
      }
    }

    level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
    level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
    level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_remove_duplicates(level._id_6E5FF6CAE14C4081);
    level notify("need_vehicle");

    if(level._id_6E5FF6CAE14C4081.size > 0 || isDefined(_id_2786E18914900397)) {
      if(isDefined(_id_2786E18914900397)) {
        if(ticks > 5)
          level notify("vehicle_nearby", _id_2786E18914900397);
      }

      ticks = 0;
      continue;
    }

    if(!istrue(level._id_113DEA3BB5A11805)) {
      ticks = 0;
      continue;
    }

    ticks++;

    if(ticks > 10) {
      spawn_reinforcement_truck();
      ticks = 0;
    }
  }
}

_id_CAEE85EBFEAB8BD1() {
  level endon("game_ended");

  for(;;) {
    level scripts\engine\utility::waittill_either("vehicle_leaving", "vehicle_flipped");
    thread spawn_reinforcement_truck();
  }
}

_id_82A14034C7D61307() {
  level endon("game_ended");

  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  for(;;) {
    waitframe();

    if(!level.players[0] sprintbuttonPressed() || !level.players[0] meleeButtonPressed()) {
      continue;
    }
    while(level.players[0] sprintbuttonPressed() && level.players[0] meleeButtonPressed())
      waitframe();

    truck = scripts\engine\utility::getStruct("reinforce_truck_special", "targetname");
    ai = scripts\engine\utility::getStructArray("ai_truck_reinforce_special", "targetname");
    level thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(truck, ai);
  }
}

_id_AF5F2033A9413E22(org) {
  _id_9DD14579A14C6B95 = getEntArray("trigger_rotatable_radius", "classname");

  foreach(trig in _id_9DD14579A14C6B95) {
    if(isDefined(trig.script_noteworthy) && trig.script_noteworthy == "start_samsites") {
      continue;
    }
    if(isDefined(trig.targetname) && trig.targetname == "escape_plane_trig") {
      continue;
    }
    if(trig.origin[1] >= org)
      trig delete();
  }
}

_id_36AF28FBA4058B8B(org) {
  _id_9DD14579A14C6B95 = getEntArray("trigger_rotatable_radius", "classname");

  foreach(trig in _id_9DD14579A14C6B95) {
    if(isDefined(trig.targetname) && trig.targetname == "escape_plane_trig") {
      continue;
    }
    if(distance2d(trig.origin, org.origin) < int(org.radius))
      trig delete();
  }
}

_id_4A3F0DF20443F4DA() {
  level.vehicle._id_4BD4E750E5A8E895 = scripts\cp\helicopter\cp_helicopter::_id_29D0C931FF7731CD;
  level.vehicle._id_9442D439C225C3FE = ::_id_2A3D0EB105242615;
  level._id_7A9F066F79BED633 = ::_id_EFC042CA6FA12227;
  level.should_do_damage_check_func = ::_id_71C1911E983F326D;
  level._id_D73F1DD12F69B96E = _id_4B51EFC61B1C7ECF::_id_C51B535A4296667C;
  level._id_187BFF90AA51742F = _id_4B51EFC61B1C7ECF::_id_B9FBA7B87112A435;
  level._id_FA3F2CEF70B746CF = _id_4B51EFC61B1C7ECF::_id_0D7D2395BA06CF65;
  _id_7B601622F34E4103("chase", ::_id_850BB68717681AED);
  _id_7B601622F34E4103("scripted_rooftop_rpg", _id_73B8B21BF4E3319E::_id_51139E209C5666F9);
  _id_7B601622F34E4103("truck_riders", ::_id_DAD8FA9E0AE125FC);
  _id_7B601622F34E4103("rooftop_enemy", ::_id_31F811E1E1930ED9);
  _id_7B601622F34E4103("hunter", ::_id_F8873C43F4F8FE83);
  _id_7B601622F34E4103("stealth_setup", ::_id_0423D0A8EC59ED32);
  _id_7B601622F34E4103("turretguy", ::_id_488BBEAC785E6187);
  _id_7B601622F34E4103("introcheckpoint", ::_id_C516B1414D88A9C2);
  _id_7B601622F34E4103("usephone", ::_id_3859167545BC065C);
  _id_7B601622F34E4103("conversation", ::_id_099C172B77DE2179);
  _id_7B601622F34E4103("wall_lean", ::_id_A377F8BBCB9A285E);
  _id_7B601622F34E4103("wall_lean_smoke", ::_id_1679603D3B058077);
  _id_7B601622F34E4103("sitting", ::_id_D967C0571B3EF50A);
  _id_7B601622F34E4103("sniper", ::_id_98933676776A4AA1);
  _id_7B601622F34E4103("playerinfo", ::_id_75DDBF3AE205F587);
  _id_7B601622F34E4103("heli_rider", ::_id_84CB94F7124C9DA4);
  _id_7B601622F34E4103("rushwhenalert", ::_id_072851E002A2925B);
}

_id_7B601622F34E4103(name, func) {
  if(!isDefined(level._id_A8DC22C62BA69B88))
    level._id_A8DC22C62BA69B88 = [];

  level._id_A8DC22C62BA69B88[name] = func;
}

_id_072851E002A2925B() {
  self endon("death");

  if(!isDefined(level._id_D0171628A971E82E))
    level._id_D0171628A971E82E = [];

  level._id_D0171628A971E82E[level._id_D0171628A971E82E.size] = self;
  self waittill("stealth_combat");

  foreach(player in level.players)
  self getenemyinfo(player);

  thread _id_EB085980B57F9999();
}

_id_75DDBF3AE205F587() {
  wait 0.5;

  foreach(player in level.players) {
    self aieventlistenerevent("combat", player, player.origin);
    self getenemyinfo(player);
  }
}

_id_98933676776A4AA1() {
  self endon("death");
  level endon("alertall");
  scripts\stealth\utility::set_stealth_func("should_hunt", ::_id_E62009C27BBB63B3);
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  wait(randomfloatrange(0.1, 7));
  _id_74B5B12BB6514385 = randomintrange(5, 15);
  interactions = ["idle_smoke", "idle_rub_hand", "idle_drinking", "idle_stretching"];
  thread _id_B2F403921EECA0EB();

  while(!istrue(level._id_203C1D3D4FFB5FB1)) {
    _id_D60D5319050E916C = randomintrange(45, 60);
    struct.script_delay = _id_D60D5319050E916C;
    self._blackboard.idlenode = struct;
    _id_F8D4ED108521E632 = _func_72066AA981916ECC(scripts\engine\utility::random(interactions), struct.origin, struct.angles);
    self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
    self._id_7B54E23EAA271E6B = _id_F8D4ED108521E632;
    wait(_id_D60D5319050E916C);
    self _meth_EA63241A4D3092C4();
    self._blackboard.idlenode = undefined;
    self._id_7B54E23EAA271E6B = undefined;
    _func_2A627FA5FD1CE263(_id_F8D4ED108521E632);
    wait(_id_74B5B12BB6514385);
  }

  _id_D20830929E93069F();
}

_id_D001C02FD9CC3556() {
  _id_CDA855D9D2FE2CB7 = getEntArray("interact_chair", "targetname");
  chair = scripts\engine\utility::getclosest(self.origin, _id_CDA855D9D2FE2CB7, 256);

  if(!isDefined(chair)) {
    return;
  }
  chair movez(-150, 0.1);
  wait 10;
  chair movez(150, 0.1);
}

_id_099C172B77DE2179() {
  self endon("death");
  level endon("alertall");
  self endon("stealth_investigate");
  self endon("stealth_hunt");
  wait 5;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  wait(randomfloatrange(0.1, 7));
  _id_74B5B12BB6514385 = randomintrange(5, 15);
  interactions = ["idle_smoke", "idle_cellphone", "idle_press_check", "idle_rub_hand", "idle_drinking", "idle_radio", "idle_stretching"];
  thread _id_B2F403921EECA0EB();

  while(!istrue(level._id_203C1D3D4FFB5FB1)) {
    _id_D60D5319050E916C = randomintrange(60, 75);
    struct.script_delay = _id_D60D5319050E916C;
    self._blackboard.idlenode = struct;
    _id_F8D4ED108521E632 = _func_72066AA981916ECC(scripts\engine\utility::random(interactions), struct.origin, struct.angles);
    self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
    self._id_7B54E23EAA271E6B = _id_F8D4ED108521E632;
    wait(_id_D60D5319050E916C);
    self _meth_EA63241A4D3092C4();
    self._id_7B54E23EAA271E6B = undefined;
    self._blackboard.idlenode = undefined;
    _func_2A627FA5FD1CE263(_id_F8D4ED108521E632);
    wait(_id_74B5B12BB6514385);
  }

  _id_D20830929E93069F();
}

_id_A377F8BBCB9A285E() {
  self endon("death");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("intro_interaction_lean", "targetname");
  struct = scripts\engine\utility::getclosest(self.origin, _id_9E4E1482CB40C9C5);
  self forceteleport(struct.origin, struct.angles);
  thread _id_FDE005D9FD87EFBB("idle_wall_lean", struct, undefined, 1);
}

_id_1679603D3B058077() {
  level endon("alertall");
  self endon("death");
  self endon("stealth_investigate");
  self endon("stealth_hunt");
  wait(randomfloatrange(0, 3));
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("intro_interaction_lean", "targetname");
  struct = scripts\engine\utility::getclosest(self.origin, _id_9E4E1482CB40C9C5);
  self forceteleport(struct.origin, struct.angles);
  _id_74B5B12BB6514385 = 0;
  interactions = ["idle_wall_lean", "idle_smoke", "idle_stretching", "idle_wall_lean", "idle_press_check", "idle_rub_hand", "idle_wall_lean"];
  thread _id_B2F403921EECA0EB();

  while(!istrue(level._id_203C1D3D4FFB5FB1)) {
    _id_D60D5319050E916C = randomintrange(45, 60);
    struct.script_delay = _id_D60D5319050E916C;
    self._blackboard.idlenode = struct;
    _id_F8D4ED108521E632 = _func_72066AA981916ECC(scripts\engine\utility::random(interactions), struct.origin, struct.angles);
    self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
    self._id_7B54E23EAA271E6B = _id_F8D4ED108521E632;
    wait(_id_D60D5319050E916C);
    self _meth_EA63241A4D3092C4();
    self._blackboard.idlenode = undefined;
    self._id_7B54E23EAA271E6B = undefined;
    _func_2A627FA5FD1CE263(_id_F8D4ED108521E632);
    wait(_id_74B5B12BB6514385);
  }

  _id_D20830929E93069F();
}

_id_D967C0571B3EF50A() {
  self endon("death");
  thread _id_D001C02FD9CC3556();
  wait 0.5;
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("interact_sitting", "targetname");
  struct = scripts\engine\utility::getclosest(self.origin, _id_9E4E1482CB40C9C5);
  self forceteleport(struct.origin, struct.angles);
  thread _id_FDE005D9FD87EFBB("idle_sitting_phone", struct, undefined, 1);
}

_id_3859167545BC065C() {
  self endon("death");

  if(randomint(100) > 50)
    thread _id_FDE005D9FD87EFBB("idle_radio", undefined, undefined, 1);
  else
    thread _id_FDE005D9FD87EFBB("idle_cellphone", undefined, undefined, 1);
}

_id_71C1911E983F326D(eattacker, idamage, smeansofdeath, sweapon, shitloc, victim) {
  if(isDefined(sweapon) && sweapon.basename == "iw8_la_rpapa7_fakefire")
    return 0;

  return 1;
}

_id_0423D0A8EC59ED32(group_name, func) {
  self._id_894D1167ACE5B58C = 1;

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
    return;
  }
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  thread scripts\cp\coop_stealth::_id_F09D803BBBE62E92("intro_guys");
  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self _meth_D493E7FE15E5EAF4("cp_esc");
  thread scripts\cp\coop_stealth::_id_62AE6D951DA4B634("intro_guys");

  if(_id_18A73A64992DD07D::is_juggernaut_aitype()) {
    self.ballowexecutions = 1;
    return;
  }
}

_id_FDE005D9FD87EFBB(name, struct, delay, repeat) {
  self endon("death");

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
  }

  if(istrue(repeat))
    struct._id_803F2BF203326F29 = 1;

  if(isDefined(delay))
    struct.script_delay = delay;

  self._blackboard.idlenode = struct;
  _id_F8D4ED108521E632 = _func_72066AA981916ECC(name, struct.origin, struct.angles);
  self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
  self._id_7B54E23EAA271E6B = _id_F8D4ED108521E632;
  thread _id_B2F403921EECA0EB();
  scripts\engine\utility::waittill_any_3("stealth_investigate", "stealth_hunt", "stealth_combat");
  self._blackboard.idlenode = undefined;
  self _meth_EA63241A4D3092C4();
  self._id_7B54E23EAA271E6B = undefined;
  self.goalradius = 2048;
  _func_2A627FA5FD1CE263(_id_F8D4ED108521E632);

  foreach(player in level.players)
  self getenemyinfo(player);
}

_id_B2F403921EECA0EB() {
  self endon("interactionDeleted");
  scripts\engine\utility::waittill_any_4("death", "stealth_investigate", "stealth_hunt", "stealth_combat");

  if(isDefined(self._id_7B54E23EAA271E6B))
    _func_2A627FA5FD1CE263(self._id_7B54E23EAA271E6B);
}

_id_D20830929E93069F() {
  if(isDefined(self._id_7B54E23EAA271E6B)) {
    self _meth_EA63241A4D3092C4();
    self._blackboard.idlenode = undefined;
    _func_2A627FA5FD1CE263(self._id_7B54E23EAA271E6B);
    self._id_7B54E23EAA271E6B = undefined;
  }
}

_id_E31F5F7D7B4A72A7(_id_D60D5319050E916C, _id_74B5B12BB6514385) {
  self endon("death");
  level endon("alertall");
  self endon("stealth_hunt");
  self endon("stealth_investigate");
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.script_delay = _id_D60D5319050E916C;

  while(!istrue(level._id_203C1D3D4FFB5FB1)) {
    _id_F8D4ED108521E632 = _func_72066AA981916ECC("idle_smoke", struct.origin, struct.angles);
    self._blackboard.idlenode = struct;
    self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
    thread _id_B2F403921EECA0EB();
    self._id_7B54E23EAA271E6B = _id_F8D4ED108521E632;
    wait(_id_D60D5319050E916C);
    self notify("interactionDeleted");
    self _meth_EA63241A4D3092C4();
    _func_2A627FA5FD1CE263(_id_F8D4ED108521E632);
    self._id_7B54E23EAA271E6B = undefined;
    self._blackboard.idlenode = undefined;
    wait(_id_74B5B12BB6514385);
  }

  _id_D20830929E93069F();
}

_id_F8873C43F4F8FE83(guy) {
  self endon("death");

  foreach(player in level.players)
  self getenemyinfo(player);

  wait 45;
  thread _id_EB085980B57F9999();
}

_id_EB085980B57F9999() {
  self endon("death");
  self notify("hunt");
  self endon("hunt");
  self.goalradius = 512;
  self.maxsightdistsqrd = squared(8000);
  self _meth_9215CE6FC83759B9(8000);

  for(;;) {
    wait 1;

    if(!self isnearanyplayer(4000)) {
      self.nocorpse = 1;
      self dodamage(1000, self.origin);
      return;
    }

    _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(_id_C729D49D406ACED8)) {
      continue;
    }
    self setgoalpos(_id_C729D49D406ACED8.origin);
  }
}

_id_EFC042CA6FA12227() {
  self.death_info_func = ::_id_EBABA90983D0E534;
  self._id_4B3EDA62DD53F00B = 1;

  if(istrue(level.forced_aitype_armored))
    scripts\cp\cp_relics::_id_FA6EA7F830D64C9C();
}

_id_84CB94F7124C9DA4() {
  self endon("death");
  self.dropweapon = 0;
  self._id_AD799295A6692B29 = 1;
  self._id_0D932F46857D6D61 = undefined;
}

_id_505AD627A91D8597() {
  self endon("death");
  self.dropweapon = 0;
  self._id_AD799295A6692B29 = 1;
  self._id_0D932F46857D6D61 = undefined;

  for(;;) {
    foreach(player in level.players)
    self getenemyinfo(player);

    self.maxsightdistsqrd = squared(8000);
    self _meth_9215CE6FC83759B9(8000);
    self.ignoreall = 0;
    wait 1;
  }
}

_id_EBABA90983D0E534(_id_235B82B232762671) {
  if(_id_235B82B232762671.smeansofdeath == "MOD_CRUSH") {
    num = randomintrange(1, 7);

    if(!soundexists("generic_death_enemy_" + num)) {
      return;
    }
    playsoundatpos(self.origin, "generic_death_enemy_" + num);
  }
}

_id_DAD8FA9E0AE125FC() {
  self endon("death");
  _id_2ECBBB599E54928C = getdvarint("dvar_2FC11AE062E8AD0C", 2000);
  self.maxsightdistsqrd = squared(_id_2ECBBB599E54928C);
  self _meth_9215CE6FC83759B9(_id_2ECBBB599E54928C);
  self.dropweapon = 0;
  self._id_AD799295A6692B29 = 1;
  self waittill("unload");
  self.dropweapon = 1;
  self._id_AD799295A6692B29 = 0;
}

_id_31F811E1E1930ED9() {
  self endon("death");
  _id_D43D6364668556C7 = squared(4000);

  for(;;) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) > _id_D43D6364668556C7) {
        continue;
      }
      _id_B16FE075D78158C7 = self getEye() + (0, 0, 12);
      is_looking_at = player worldpointinreticle_circle(_id_B16FE075D78158C7, 70, 300);
      _id_A49FE39FE684C761 = sighttracepassed(self getEye() + (0, 0, 30), player getEye(), 0, self);

      if(is_looking_at && _id_A49FE39FE684C761)
        level notify("rooftopenemy", player);
    }

    wait 0.1;
  }
}

_id_488BBEAC785E6187() {
  self endon("death");
  wait 1;
  self.goalradius = 24;
  self.ignoreall = 1;
  self.demeanoroverride = "combat";
  self setgoalnode(level._id_E959C6E734621D0F.covernode);
  self waittill("goal");
  level._id_E959C6E734621D0F._id_2C5E84C1F846661B = self;
  level._id_E959C6E734621D0F scripts\common\ai::ai_operate_turret(self, level._id_E959C6E734621D0F);
  self._id_FE3B2F26B45598BA = _id_678ADBED602DA5EB::_id_BA8597CB7C12D254;
  self.turret = level._id_E959C6E734621D0F;
  self enabletraversals(0);
  self.goalheight = 64;
  level._id_E959C6E734621D0F thread[[level.turretsettings[level._id_E959C6E734621D0F.turrettype]._id_7E1467DC63368749]]();
  level._id_E959C6E734621D0F thread _id_678ADBED602DA5EB::_id_F3A3BBA54AA3A0A2(self);
  thread _id_4B51EFC61B1C7ECF::_id_CCD7A6907F25864A();
  thread _id_678ADBED602DA5EB::_id_200CFD3D04D2510F(level._id_E959C6E734621D0F);
}

_id_C516B1414D88A9C2() {
  level endon("alertall");
  self endon("death");
  self endon("stealth_combat");
  scripts\stealth\utility::set_stealth_func("should_hunt", ::_id_E62009C27BBB63B3);
  level waittill("return_to_station");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("intro_checkpoint_return", "targetname");

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(!isDefined(struct.taken)) {
      struct.taken = 1;
      self setgoalpos(struct.origin);
      self waittill("goal");
      scripts\stealth\utility::set_stealth_func("should_hunt", undefined);
      _id_47C6F46248073368(struct);
      thread _id_475D14C77FE1BF66();
      return;
    }
  }
}

_id_E62009C27BBB63B3() {
  return 0;
}

_id_475D14C77FE1BF66() {
  self endon("death");
  level waittill("alertall");
  self _meth_EA63241A4D3092C4();

  if(isDefined(self.interactid))
    _func_2A627FA5FD1CE263(self.interactid);

  self.goalradius = 2048;

  foreach(player in level.players)
  self getenemyinfo(player);
}

_id_47C6F46248073368(struct) {
  interactions = ["idle_smoke", "idle_drinking"];
  interaction = scripts\engine\utility::random(interactions);

  if(interaction == "idle_smoke")
    thread _id_E31F5F7D7B4A72A7(60, 45);
  else {
    struct = spawnStruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    struct.script_delay = 30;
    _id_F8D4ED108521E632 = _func_72066AA981916ECC(interaction, self.origin, self.angles);
    self.interactid = _id_F8D4ED108521E632;
    self._blackboard.idlenode = struct;
    self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
    self._id_7B54E23EAA271E6B = _id_F8D4ED108521E632;
    thread _id_B2F403921EECA0EB();
  }
}

_id_5D288DFC06117CBA(data) {
  if(isDefined(self.owner))
    level notify("vehicledamage", self.owner);
}

_id_850BB68717681AED() {
  scripts\cp\cp_outofbounds::enableoobimmunity(self);
  self._id_F4E9A19962A09084 = 1;
  self vehicle_settopspeedforward(45);
  thread _id_0F3B4A4783EDE654::_id_F4D3D0EDD18649CB();
  scripts\cp\helicopter\cp_helicopter::_id_D025DD1F241613D6(self);
  self setscriptablepartstate("lights", "on");
}

_id_2A3D0EB105242615(veh) {
  veh._id_F24CC3BEEF01650C = ::_id_5D288DFC06117CBA;
  veh._id_CF1E271394C5DC95 = 850;
  veh.health = 2250;
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_remove(level._id_6E5FF6CAE14C4081, veh);

  if(scripts\cp\cp_outofbounds::isoobimmune(veh))
    scripts\cp\cp_outofbounds::disableoobimmunity(veh);

  badplace = createnavbadplacebyent(self);
  thread _id_3AA166DEA837994C(badplace);

  if(isDefined(veh._id_393832BCEC3AFD03)) {
    foreach(guy in veh._id_393832BCEC3AFD03) {
      if(istrue(level._id_835E60CE3246564F)) {
        guy thread _id_9FD255B59CD4F616();
        continue;
      }

      guy thread _id_EB085980B57F9999();
    }
  }

  level._id_7DA5E47838B88E6C = scripts\engine\utility::array_add(level._id_7DA5E47838B88E6C, veh);
  veh _id_AFE4A3E47FA50141();
  veh thread _id_75D3BE3B6CDECBC7();
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
  level._id_7DA5E47838B88E6C = scripts\engine\utility::array_removeundefined(level._id_7DA5E47838B88E6C);
}

_id_75D3BE3B6CDECBC7() {
  wait 0.1;
  self notify("stop_chasing");
}

_id_3AA166DEA837994C(badplace) {
  level endon("game_ended");
  self endon("death");
  origin = self.origin;

  while(isDefined(self) && distancesquared(self.origin, origin) < squared(200))
    wait 1;

  destroynavobstacle(badplace);
}

_id_10FBBCF3D0D12043() {
  level endon("game_ended");
  level._id_7DA5E47838B88E6C = [];
  level._id_6E5FF6CAE14C4081 = [];
  _id_CCFF4E530F283DDB = scripts\engine\utility::getStruct("player_cargo_truck", "targetname");
  _id_212A4E198C1ABCA0 = scripts\engine\utility::getStructArray("player_techo_rebel", "targetname");

  foreach(_id_2AE12E935ED3F093 in _id_212A4E198C1ABCA0) {
    _id_B1673F16AB572566 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo", _id_2AE12E935ED3F093);

    if(!isDefined(_id_B1673F16AB572566)) {
      continue;
    }
    waitframe();
    _id_B1673F16AB572566 setscriptablepartstate("lights", "on");
    _id_B1673F16AB572566.maxhealth = int(_id_B1673F16AB572566.health * 2);
    _id_B1673F16AB572566.health = _id_B1673F16AB572566.maxhealth;
    _id_B1673F16AB572566._id_1AB6B61153087915 = ::_id_5D288DFC06117CBA;
    _id_B1673F16AB572566._id_CF1E271394C5DC95 = 1200;
    _id_B1673F16AB572566 _id_AFE4A3E47FA50141();
    level._id_7DA5E47838B88E6C[level._id_7DA5E47838B88E6C.size] = _id_B1673F16AB572566;
  }

  _id_C308CB8D7344FBE2 = scripts\engine\utility::getStructArray("player_hatchback", "targetname");
  _id_63C52E9A0B4E9192 = ["default", "green", "blue", "black", "red", "silver", "tan"];

  foreach(_id_026BFF2F8A6F86E5 in _id_C308CB8D7344FBE2) {
    _id_026BFF2F8A6F86E5._id_14CDE247AC3313A4 = scripts\engine\utility::random(_id_63C52E9A0B4E9192);

    if(_id_026BFF2F8A6F86E5._id_14CDE247AC3313A4 == "default")
      _id_026BFF2F8A6F86E5._id_14CDE247AC3313A4 = undefined;

    _id_962163E80313DB34 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_sedan_hatchback_1985", _id_026BFF2F8A6F86E5);

    if(!isDefined(_id_962163E80313DB34)) {
      continue;
    }
    _id_962163E80313DB34.maxhealth = int(_id_962163E80313DB34.health * 2);
    _id_962163E80313DB34.health = _id_962163E80313DB34.maxhealth;
    _id_962163E80313DB34._id_1AB6B61153087915 = ::_id_5D288DFC06117CBA;
    _id_962163E80313DB34._id_CF1E271394C5DC95 = 1200;
    level._id_7DA5E47838B88E6C[level._id_7DA5E47838B88E6C.size] = _id_962163E80313DB34;
    _id_962163E80313DB34 _id_AFE4A3E47FA50141();
  }

  _id_CCFF4E530F283DDB._id_14CDE247AC3313A4 = "green";
  cargo_truck = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", _id_CCFF4E530F283DDB);
  cargo_truck.maxhealth = int(cargo_truck.health * 2);
  cargo_truck.health = cargo_truck.maxhealth;
  cargo_truck._id_1AB6B61153087915 = ::_id_5D288DFC06117CBA;
  cargo_truck._id_CF1E271394C5DC95 = 800;
  cargo_truck scripts\cp\utility::make_entity_sentient_cp("allies");
  cargo_truck _id_BC942C6686DD4E43();
  level._id_7DA5E47838B88E6C[level._id_7DA5E47838B88E6C.size] = cargo_truck;
  level.cargo_truck = cargo_truck;
  level.cargo_truck _id_AFE4A3E47FA50141();
  thread _id_3A1D8DB6D92D73F8::_id_1421B6AF12212243();
}

_id_BC942C6686DD4E43() {
  objweapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_la_gromeo_mp");
  _id_1CDDE5644733A935 = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + _id_1CDDE5644733A935, self.origin, 1);
  _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 linkTo(self, "tag_origin", (-75, 42, 35), (0, 0, 0));
  _id_DCD1F982ED315ACA = spawn("script_model", self.origin);
  _id_DCD1F982ED315ACA setModel("ee_military_van_weapon_rack");
  _id_DCD1F982ED315ACA linkTo(self, "tag_origin", (-75, 42, 32), (0, -90, 0));
  thread scripts\engine\utility::delete_on_death(_id_DCD1F982ED315ACA);
  thread scripts\engine\utility::delete_on_death(_id_B8F5AC23CE0DFDE3);
}

_id_21DCD2A775A0726C() {
  _id_04F0D37A2C48544F = scripts\engine\utility::getStructArray("suv_spawner", "targetname");
  _id_206A75E2490AA94D = scripts\engine\utility::getStructArray("cargo_truck_spawner", "targetname");
  _id_D7B6C1733E8273D3 = scripts\engine\utility::getStructArray("pickup_2014_spawn", "targetname");
  _id_B31FE5261412573F = scripts\engine\utility::getStructArray("armored_truck_spawner", "targetname");
  _id_5E00EAB4074D00D9 = ["default", "green", "blue", "black", "red"];

  foreach(spawner in _id_04F0D37A2C48544F) {
    spawner._id_14CDE247AC3313A4 = scripts\engine\utility::random(_id_5E00EAB4074D00D9);

    if(spawner._id_14CDE247AC3313A4 == "default")
      spawner._id_14CDE247AC3313A4 = undefined;

    _id_BE66F9030B258BED = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawner);
    _id_BE66F9030B258BED._id_1AB6B61153087915 = ::_id_5D288DFC06117CBA;

    if(!isDefined(_id_BE66F9030B258BED)) {
      continue;
    }
    level._id_7DA5E47838B88E6C[level._id_7DA5E47838B88E6C.size] = _id_BE66F9030B258BED;
    _id_BE66F9030B258BED _id_AFE4A3E47FA50141();
    waitframe();
  }

  foreach(index, spawner in _id_206A75E2490AA94D) {
    cargo_truck = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawner);
    wait 0.25;
    cargo_truck.maxhealth = int(cargo_truck.health * 2);
    cargo_truck.health = cargo_truck.maxhealth;
    cargo_truck._id_1AB6B61153087915 = ::_id_5D288DFC06117CBA;
    cargo_truck._id_CF1E271394C5DC95 = 850;

    if(!isDefined(cargo_truck)) {
      continue;
    }
    level._id_7DA5E47838B88E6C[level._id_7DA5E47838B88E6C.size] = cargo_truck;

    if(isDefined(spawner._id_3E90559F2EF41445))
      cargo_truck thread _id_BC942C6686DD4E43();

    waitframe();
    cargo_truck _id_AFE4A3E47FA50141();
  }

  foreach(spawner in _id_D7B6C1733E8273D3) {
    truck = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_pickup_2014", spawner);

    if(!isDefined(truck)) {
      continue;
    }
    truck setscriptablepartstate("tag_light_front_left", "on");
    truck setscriptablepartstate("tag_light_front_right", "on");
    truck setscriptablepartstate("tag_light_back_left", "on");
    truck setscriptablepartstate("tag_light_back_right", "on");
    waitframe();
    truck _id_AFE4A3E47FA50141();
  }

  foreach(spawner in _id_B31FE5261412573F) {
    truck = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", spawner);

    if(!isDefined(truck)) {
      continue;
    }
    truck.maxhealth = int(truck.health * 2);
    truck.health = truck.maxhealth;
    truck._id_1AB6B61153087915 = ::_id_5D288DFC06117CBA;
    truck setscriptablepartstate("lights", "on");
    truck._id_CF1E271394C5DC95 = 850;
    level._id_7DA5E47838B88E6C[level._id_7DA5E47838B88E6C.size] = truck;
    truck _id_AFE4A3E47FA50141();
    waitframe();
  }
}

_id_CB5B7569FB75C56D() {
  _id_E7C98993E5B3B019 = gettime() + randomintrange(500, 2000);

  for(;;) {
    wait 0.1;

    if(getdvarint("dvar_BF36E93F1E74A067", 1) < 1) {
      continue;
    }
    playervehicle = undefined;

    foreach(player in level.players) {
      if(isDefined(player.vehicle)) {
        playervehicle = player.vehicle;
        continue;
      }
    }

    if(!isDefined(playervehicle)) {
      continue;
    }
    if(playervehicle vehicle_getspeed() < 10) {
      continue;
    }
    foreach(player in level.players) {
      if(isDefined(player.vehicle)) {
        continue;
      }
      if(!player istouching(playervehicle)) {
        continue;
      }
      if(gettime() > _id_E7C98993E5B3B019) {
        player earthquakeforplayer(randomfloatrange(0.12, 0.18), 1, player.origin, 256);
        _id_E7C98993E5B3B019 = gettime() + randomintrange(500, 2000);
        continue;
      }

      player earthquakeforplayer(0.06, 0.5, player.origin, 256);
    }
  }
}

_id_033C0CF13AB46538() {
  level._id_DA571AA94AD22CE7 = scripts\engine\utility::getStructArray("vehicleUnloadPoint", "targetname");
  level._id_89BD9FE81E7A5877 = [];

  foreach(point in level._id_DA571AA94AD22CE7)
  point._id_3D0EB27CDE95D306 = scripts\engine\utility::getStructArray(point.target, "targetname");
}

_id_F7A95F0080A7221B() {
  scripts\cp\intel\cp_intel::_id_4F08AFA61F734625();
}

_id_9FD255B59CD4F616() {
  self endon("death");
  _id_DFB47E50EE853783 = scripts\engine\utility::getStructArray("final_guy_pos", "targetname");
  _id_09B8C5CD15FEFEF8 = undefined;

  foreach(struct in _id_DFB47E50EE853783) {
    if(!isDefined(struct.taken) && !isDefined(_id_09B8C5CD15FEFEF8)) {
      struct.taken = 1;
      _id_09B8C5CD15FEFEF8 = struct;
      break;
    }
  }

  if(!isDefined(_id_09B8C5CD15FEFEF8)) {
    return;
  }
  self setgoalpos(_id_09B8C5CD15FEFEF8.origin, 16);
  return;
}

_id_AFE4A3E47FA50141() {
  self vehicle_settopspeedforward(30);
  self vehicle_settopspeedreverse(20);
}

_id_3688C7D73F659480() {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_864197DF48AC9F87 = squared(10000);
  _id_26C57CBA304AB56D = [];

  foreach(enemy in enemies) {
    if(isDefined(enemy.vehicle)) {
      continue;
    }
    _id_66C5AC8B40881636 = 1;

    foreach(player in level.players) {
      if(distance2dsquared(enemy.origin, player.origin) < _id_864197DF48AC9F87)
        _id_66C5AC8B40881636 = 0;
    }

    if(_id_66C5AC8B40881636) {
      enemy suicide();
      continue;
    }

    _id_26C57CBA304AB56D[_id_26C57CBA304AB56D.size] = enemy;
  }

  scripts\engine\utility::array_thread(_id_26C57CBA304AB56D, ::_id_7726E29A41C55CB3);
}

_id_7726E29A41C55CB3() {
  self endon("death");
  self endon("game_ended");
  _id_864197DF48AC9F87 = squared(10000);

  for(;;) {
    _id_66C5AC8B40881636 = 1;

    foreach(player in level.players) {
      if(distance2dsquared(self.origin, player.origin) < _id_864197DF48AC9F87)
        _id_66C5AC8B40881636 = 0;
    }

    if(_id_66C5AC8B40881636)
      self suicide();

    wait 1;
  }
}