/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_382959d7794736cc.gsc
***********************************************/

_id_0636135391510B93() {
  level._id_A8DC22C62BA69B88 = [];
  level._id_A8DC22C62BA69B88["stealth_setup"] = ::_id_D885347117345399;
  level._id_A8DC22C62BA69B88["stealth_setupintro"] = ::_id_C5BF40738AC2D485;
  level._id_A8DC22C62BA69B88["stealth_setupfil"] = ::_id_D59D1F3B8510FF40;
  level._id_A8DC22C62BA69B88["stealth_setupsilo"] = ::_id_BD55C0FFCE36FB3C;
  level._id_A8DC22C62BA69B88["console_operator"] = ::_id_965C5096B36F2BBA;
  level._id_A8DC22C62BA69B88["platform"] = ::_id_1D306146107E0152;
  level._id_A8DC22C62BA69B88["reinforcement"] = ::_id_190D802D6F08F5CA;
  level._id_A8DC22C62BA69B88["riotsquad"] = ::_id_9571436F143AA16B;
  thread _id_FE683C90EAD4E88B();
}

_id_FE683C90EAD4E88B() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  wait 1;
  _id_512288CD4395E94E["spotted"]["gunshot"] = 6000;
  _id_512288CD4395E94E["hidden"]["gunshot"] = 6000;
  _id_512288CD4395E94E["spotted"]["gunshot_teammate"] = 6000;
  _id_512288CD4395E94E["hidden"]["gunshot_teammate"] = 6000;
  _id_512288CD4395E94E["hidden"]["footstep_walk"] = 150;
  _id_512288CD4395E94E["spotted"]["footstep_walk"] = 300;
  _id_512288CD4395E94E["hidden"]["footstep"] = 300;
  _id_512288CD4395E94E["spotted"]["footstep"] = 500;
  _id_512288CD4395E94E["hidden"]["footstep_sprint"] = 600;
  _id_512288CD4395E94E["spotted"]["footstep_sprint"] = 1600;
  scripts\stealth\manager::set_event_distances(_id_512288CD4395E94E);
}

_id_C5BF40738AC2D485(group_name, func) {
  self._id_894D1167ACE5B58C = 1;
  self.goalheight = 512;
  self.goalradius = 2048;

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 40000);
  self _meth_D493E7FE15E5EAF4("cp_hydro");
  thread scripts\cp\coop_stealth::_id_62AE6D951DA4B634("fil_intro");

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    return;
}

_id_D59D1F3B8510FF40(group_name, func) {
  self._id_894D1167ACE5B58C = 1;

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  thread _id_53AC3DFD44F1AB87();
  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 40000);
  self _meth_D493E7FE15E5EAF4("cp_hydro");
  thread scripts\cp\coop_stealth::_id_62AE6D951DA4B634("fil_intro");

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    return;
}

_id_BD55C0FFCE36FB3C(group_name, func) {
  self._id_894D1167ACE5B58C = 1;

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 40000);
  self _meth_D493E7FE15E5EAF4("cp_hydro");
  thread scripts\cp\coop_stealth::_id_62AE6D951DA4B634("silo_end");

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    return;
}

_id_D885347117345399(group_name, func) {
  self._id_894D1167ACE5B58C = 1;
  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);

  if(_id_18A73A64992DD07D::is_juggernaut_aitype()) {
    self.ballowexecutions = 1;
    return;
  }

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    return;
}

_id_190D802D6F08F5CA(group_name, func) {
  self endon("death");
  self._id_894D1167ACE5B58C = 1;
  wait 1;

  if(isDefined(self.spawnpoint.target)) {
    self.goalradius = 16;
    struct = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    self setgoalpos(struct.origin);
    scripts\engine\utility::waittill_any_timeout_1(7, "goal");
    self.goalradius = 2048;
  }

  for(;;) {
    foreach(player in level.players)
    self getenemyinfo(player);

    wait 3;
  }
}

_id_1D306146107E0152(group_name, func) {
  self endon("death");
  level waittill("stealth_broken");
  og = self.origin;

  for(;;) {
    self.goalradius = 64;
    self setgoalpos(og);
    wait 2;
  }
}

_id_965C5096B36F2BBA(group_name, func) {
  self endon("death");
  level endon("stealth_broken");
  self.goalradius = 16;
  _id_12A809FA23226C1F = scripts\engine\utility::getStructArray("console", "targetname");
  console = undefined;

  for(;;) {
    console = undefined;

    while(!isDefined(console)) {
      foreach(item in _id_12A809FA23226C1F) {
        if(istrue(item.used) || isDefined(self.console) && self.console == item) {
          continue;
        }
        console = item;
        item.used = 1;
        self.console = item;
        break;
      }

      wait 0.1;
    }

    self setgoalpos(console.origin);
    self waittill("goal");
    self orientmode("face angle", console.angles[1]);
    wait(randomintrange(15, 25));
    console.used = undefined;
  }
}

_id_9571436F143AA16B(group_name, func) {
  self endon("death");
  level waittill("stealth_broken");
  _id_0B425751F51B7240 = scripts\cp\cp_agent_utils::get_alive_enemies();
  ai = scripts\engine\utility::get_array_of_closest(self.origin, _id_0B425751F51B7240, undefined, 2, 256);

  if(ai.size < 2) {
    return;
  }
  level thread _id_E02EBB3647F59943(self, ai);
}

_id_C9A7AC016440B3C0(node) {
  wait 8;
  spawner = scripts\engine\utility::getStruct("boss_spawner", "targetname");
  _id_E2958F412A7425C0 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_cp_lmg_tier3_aq", spawner.origin, spawner.angles, "axis");

  if(getdvarint("dvar_F67AA65E52A29FAE", 1) != 0)
    _id_E2958F412A7425C0 _id_EC13B6381AA5562E();

  _id_E2958F412A7425C0.invulnerable = 1;
  _id_E2958F412A7425C0._id_976F32CE5275BAAA = 1;
  return _id_E2958F412A7425C0;
}

_id_EC13B6381AA5562E() {
  head = "head_sp_opforce_al_qatala_tier_2_3_1";
  body = "body_sp_opforce_al_qatala_tier_2_1_1";
  weapon = undefined;
  _id_23CBC7D1310C5FF3 = getDvar("dvar_FCDD975C9069B0F4", "ar1");

  switch (_id_23CBC7D1310C5FF3) {
    case "ar1":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike14");
      weapon = weapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer", "laser"]);
      weapon = weapon _meth_ 1 BD5B3BEF3D9A61(["stock_dm_light_p18_mike14", "mag_sn_large_p18", "fourx06"]);
      break;
    case "ar2":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
      weapon = weapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
      break;
    case "ar3":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
      weapon = weapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["hybrid", "silencer", "laser"]);
      weapon = weapon _meth_ 1 BD5B3BEF3D9A61(["grip_vertshort02", "bar_ar_short_p01_mike4"]);
      break;
    case "smg1":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
      weapon = weapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_large", "stock_sm_light", "silencer", "laser"]);
      break;
    case "smg2":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
      weapon = weapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno", "silencer", "laser"]);
      break;
    case "sh":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike1014");
      weapon = weapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["grip_angled", "ammo_12g_db_mike1014", "bolt_lgt_p12", "breacher_sh_01", "silencer", "laser"]);
      break;
    default:
      break;
  }

  if(isDefined(body))
    self setModel(body);

  if(isDefined(head)) {
    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach(head, "", 1);
    self.headmodel = head;
  }

  if(isDefined(weapon)) {
    _id_B003E2C45A4BF6F7 = undefined;
    weaponname = undefined;

    if(isDefined(self.weapon)) {
      self takeweapon(self.weapon);
      weaponname = getcompleteweaponname(self.weapon);

      if(isDefined(self.weaponinfo[weaponname])) {
        _id_B003E2C45A4BF6F7 = self.weaponinfo[weaponname].position;
        self.weaponinfo = scripts\engine\utility::array_remove_key(self.weaponinfo, weaponname);
      }
    }

    self.weapon = weapon;
    scripts\common\utility::initweapon(self.weapon);
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "weapon", weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;

    if(isDefined(self.a.weaponpos[_id_B003E2C45A4BF6F7])) {
      weaponname = getcompleteweaponname(self.weapon);
      self.weaponinfo[weaponname].position = _id_B003E2C45A4BF6F7;
      self.a.weaponpos[_id_B003E2C45A4BF6F7] = weapon;
    }
  }
}

_id_98EB92F08432317E(origin, radius) {
  _id_913576E1DC1762B5 = getentitylessscriptablearray(undefined, undefined, origin, radius);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_913576E1DC1762B5.size; _id_AC0E594AC96AA3A8++) {
    if(!_id_913576E1DC1762B5[_id_AC0E594AC96AA3A8] scriptableisdoor()) {
      continue;
    }
    foreach(player in level.players)
    _id_913576E1DC1762B5[_id_AC0E594AC96AA3A8] disablescriptableplayeruse(player);
  }
}

_id_E8BA0B0361B31FDC() {
  for(;;) {
    self waittill("trigger", ent);

    if(isPlayer(ent)) {
      continue;
    }
    _id_913576E1DC1762B5 = getentitylessscriptablearray(undefined, undefined, self.origin, self.struct.radius + 64);
    doors = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_913576E1DC1762B5.size; _id_AC0E594AC96AA3A8++) {
      if(!_id_913576E1DC1762B5[_id_AC0E594AC96AA3A8] scriptableisdoor()) {
        continue;
      }
      doors[doors.size] = _id_913576E1DC1762B5[_id_AC0E594AC96AA3A8];
    }

    wait 3;

    while(scripts\cp\utility::getentitiesinradius(self.origin, self.struct.radius + 64, undefined, doors, physics_createcontents(["physicscontents_characterproxy"])).size > 0)
      wait 0.05;

    foreach(door in doors) {
      door scriptabledoorclose();

      foreach(player in level.players)
      door disablescriptableplayeruse(player);
    }
  }
}

_id_930E175011A67462() {
  level._id_BB1520190DCADA5F = [];
  level._id_9B1BA1E5BC02B82F = [];
  _id_CB52E6B2C2E3DD1F();
  _id_CB52E5B2C2E3DAEC();
  _id_CB52E8B2C2E3E185();
  _id_CB52E7B2C2E3DF52();
  _id_0B27D4D5AF4F5753();
}

_id_CB52E6B2C2E3DD1F() {
  level._id_BB1520190DCADA5F["p0_0_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_0_1"] = ["smg_t1_aq", "smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq"];
  level._id_BB1520190DCADA5F["p0_1_0"] = ["smg_t1_aq", "smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_1_1"] = ["smg_t1_aq", "smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_2_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_2_1"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_2_2"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p0_3_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p0_3_1"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p0_3_2"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_4_0"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_4_1"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_4_2"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p0_4_3"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["p0_5_0"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p0_5_1"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t1_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p0_5_2"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "riotshield_t3_aq", "riotshield_t3_aq", "ar_t3_aq", "ar_t3_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p0_kill"] = ["shotgun_t3_aq", "shotgun_t3_aq", "shotgun_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t3_aq", "riotshield_t3_aq", "juggernaut"];
  _id_7FE30A00DB94335E = scripts\engine\utility::getStructArray("group0_area0", "targetname");
  _id_7FE30900DB94312B = scripts\engine\utility::getStructArray("group1_area0", "targetname");
  _id_7FE30800DB942EF8 = scripts\engine\utility::getStructArray("group2_area0", "targetname");
  _id_7FE30F00DB943E5D = scripts\engine\utility::getStructArray("group3_area0", "targetname");
  _id_7FE30E00DB943C2A = scripts\engine\utility::getStructArray("group4_area0", "targetname");
  level._id_9B1BA1E5BC02B82F["p0"] = [_id_7FE30A00DB94335E, _id_7FE30900DB94312B, _id_7FE30800DB942EF8, _id_7FE30F00DB943E5D, _id_7FE30E00DB943C2A];
}

_id_CB52E5B2C2E3DAEC() {
  level._id_BB1520190DCADA5F["p1_0_0"] = ["smg_t1_aq", "smg_t3_aq", "ar_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t1_aq", "smg_t3_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_0_1"] = ["smg_t3_aq", "smg_t3_aq", "ar_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t1_aq", "smg_t3_aq", "smg_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_1_0"] = ["smg_t3_aq", "smg_t3_aq", "ar_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t1_aq", "smg_t3_aq", "smg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p1_1_1"] = ["smg_t1_aq", "smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_2_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_2_1"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_2_2"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p1_3_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p1_3_1"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p1_3_2"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_4_0"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_4_1"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_4_2"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p1_4_3"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["p1_5_0"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p1_5_1"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t1_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p1_5_2"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "riotshield_t3_aq", "riotshield_t3_aq", "ar_t3_aq", "ar_t3_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p1_kill"] = ["shotgun_t3_aq", "shotgun_t3_aq", "shotgun_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t3_aq", "riotshield_t3_aq", "juggernaut"];
  _id_7FE30A00DB94335E = scripts\engine\utility::getStructArray("group1", "targetname");
  _id_7FE30900DB94312B = scripts\engine\utility::getStructArray("group2", "targetname");
  _id_7FE30800DB942EF8 = scripts\engine\utility::getStructArray("group3", "targetname");
  _id_7FE30F00DB943E5D = scripts\engine\utility::getStructArray("group0", "targetname");
  _id_7FE30E00DB943C2A = scripts\engine\utility::getStructArray("group5", "targetname");
  level._id_9B1BA1E5BC02B82F["p1"] = [_id_7FE30A00DB94335E, _id_7FE30900DB94312B, _id_7FE30800DB942EF8, _id_7FE30F00DB943E5D, _id_7FE30E00DB943C2A];
}

_id_CB52E8B2C2E3E185() {
  level._id_BB1520190DCADA5F["p2_0_0"] = ["smg_t1_aq", "smg_t3_aq", "ar_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t1_aq", "smg_t3_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_0_1"] = ["smg_t3_aq", "smg_t3_aq", "ar_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t1_aq", "smg_t3_aq", "smg_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_1_0"] = ["smg_t3_aq", "smg_t3_aq", "ar_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t1_aq", "smg_t3_aq", "smg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p2_1_1"] = ["smg_t1_aq", "smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_2_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_2_1"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "smg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_2_2"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p2_3_0"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p2_3_1"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "ar_t1_aq"];
  level._id_BB1520190DCADA5F["p2_3_2"] = ["smg_t1_aq", "smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_4_0"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_4_1"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_4_2"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t1_aq", "lmg_t1_aq"];
  level._id_BB1520190DCADA5F["p2_4_3"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t3_aq", "smg_t1_aq", "smg_t1_aq", "ar_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["p2_5_0"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p2_5_1"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "smg_t1_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t1_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p2_5_2"] = ["smg_t1_aq", "shotgun_t1_aq", "shotgun_t1_aq", "riotshield_t3_aq", "riotshield_t3_aq", "ar_t3_aq", "ar_t3_aq", "lmg_t1_aq", "lmg_t3_aq"];
  level._id_BB1520190DCADA5F["p2_kill"] = ["shotgun_t3_aq", "shotgun_t3_aq", "shotgun_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t3_aq", "riotshield_t3_aq", "juggernaut"];
  _id_7FE30A00DB94335E = scripts\engine\utility::getStructArray("p2_group0", "targetname");
  _id_7FE30900DB94312B = scripts\engine\utility::getStructArray("p2_group1", "targetname");
  _id_7FE30800DB942EF8 = scripts\engine\utility::getStructArray("p2_group2", "targetname");
  _id_7FE30F00DB943E5D = scripts\engine\utility::getStructArray("p2_group3", "targetname");
  _id_7FE30E00DB943C2A = scripts\engine\utility::getStructArray("p2_group5", "targetname");
  level._id_9B1BA1E5BC02B82F["p2"] = [_id_7FE30A00DB94335E, _id_7FE30900DB94312B, _id_7FE30800DB942EF8, _id_7FE30F00DB943E5D, _id_7FE30E00DB943C2A];
}

_id_CB52E7B2C2E3DF52() {
  level._id_BB1520190DCADA5F["p3_0_0"] = ["shotgun_t3_aq", "smg_t3_aq", "smg_t3_aq", "riotshield_t3_aq"];
  level._id_BB1520190DCADA5F["p3_0_1"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["p3_0_2"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "riotshield_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["p3_0_3"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["p3_kill"] = ["shotgun_t3_aq", "shotgun_t3_aq", "shotgun_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "riotshield_t3_aq", "riotshield_t3_aq", "juggernaut"];
  _id_7FE30A00DB94335E = scripts\engine\utility::getStructArray("cw_1", "targetname");
  _id_7FE30900DB94312B = scripts\engine\utility::getStructArray("cw_2", "targetname");
  _id_7FE30800DB942EF8 = scripts\engine\utility::getStructArray("cw_3", "targetname");
  _id_7FE30F00DB943E5D = scripts\engine\utility::getStructArray("cw_4", "targetname");
  level._id_9B1BA1E5BC02B82F["p3"] = [_id_7FE30A00DB94335E, _id_7FE30900DB94312B, _id_7FE30800DB942EF8, _id_7FE30F00DB943E5D];
}

_id_0B27D4D5AF4F5753() {
  level._id_BB1520190DCADA5F["saw_0_0"] = ["shotgun_t3_aq", "smg_t3_aq", "riotshield_t3_aq", "shotgun_t3_aq", "shotgun_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_1"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_2"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "riotshield_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_3"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_4"] = ["shotgun_t3_aq", "smg_t3_aq", "riotshield_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_5"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_6"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "riotshield_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_7"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_8"] = ["shotgun_t3_aq", "smg_t3_aq", "riotshield_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_9"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_10"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "riotshield_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_11"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_12"] = ["shotgun_t3_aq", "smg_t3_aq", "riotshield_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_13"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_14"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "riotshield_t3_aq", "ar_t3_aq"];
  level._id_BB1520190DCADA5F["saw_0_15"] = ["smg_t3_aq", "smg_t3_aq", "smg_t3_aq", "ar_t3_aq", "ar_t3_aq"];
  _id_7FE30A00DB94335E = scripts\engine\utility::getStructArray("cw_1", "targetname");
  _id_7FE30900DB94312B = scripts\engine\utility::getStructArray("cw_2", "targetname");
  _id_7FE30800DB942EF8 = scripts\engine\utility::getStructArray("cw_3", "targetname");
  _id_7FE30F00DB943E5D = scripts\engine\utility::getStructArray("cw_4", "targetname");
  level._id_9B1BA1E5BC02B82F["saw"] = [_id_7FE30A00DB94335E, _id_7FE30900DB94312B, _id_7FE30800DB942EF8, _id_7FE30F00DB943E5D];
}

_id_5F6DED7788739486(_id_F4145F44D6609FFB, _id_365A0918B795C6EC, repeat, _id_50EE435AACCE8F9F) {
  level endon(_id_365A0918B795C6EC);
  _id_E859D3E1172591F3 = level._id_9B1BA1E5BC02B82F[_id_F4145F44D6609FFB];
  _id_2648B8FC988ECD74 = 0;
  _id_99B99EC959F0D9DE = 0;
  _id_A2B11613E4C46ED8 = [];

  for(;;) {
    if(!isDefined(level._id_BB1520190DCADA5F[_id_F4145F44D6609FFB + "_" + _id_2648B8FC988ECD74 + "_" + _id_99B99EC959F0D9DE])) {
      _id_5456DF65B19CB198 = 0;
      scripts\engine\utility::flag_set("spawning_reinforcements");
      _id_1E4F8EF46EF6E31B(_id_A2B11613E4C46ED8, _id_F4145F44D6609FFB, _id_E859D3E1172591F3, _id_365A0918B795C6EC);
      scripts\engine\utility::flag_clear("spawning_reinforcements");

      while(scripts\cp\cp_agent_utils::get_alive_enemies().size >= 2) {
        if(scripts\cp\cp_agent_utils::get_alive_enemies().size < 4 && !_id_5456DF65B19CB198) {
          _id_395824552AD4CB06 = scripts\cp\cp_agent_utils::get_alive_enemies();

          foreach(enemy in _id_395824552AD4CB06) {
            if(enemy == level._id_E2958F412A7425C0) {
              continue;
            }
            enemy thread _id_9C0FBE62C1B9D660();
          }

          _id_5456DF65B19CB198 = 1;
        }

        wait 1;
      }

      if(!isDefined(_id_50EE435AACCE8F9F))
        _id_50EE435AACCE8F9F = getdvarint("dvar_17C3D98F31ECB424", 80);

      if(isDefined(level._id_5670BD24EC0EF4E4))
        _id_50EE435AACCE8F9F = level._id_5670BD24EC0EF4E4;

      wait(_id_50EE435AACCE8F9F);

      if(istrue(repeat))
        continue;
      else {
        _id_99B99EC959F0D9DE = 0;
        _id_2648B8FC988ECD74++;
        _id_A2B11613E4C46ED8 = [];

        if(!isDefined(level._id_BB1520190DCADA5F[_id_F4145F44D6609FFB + "_" + _id_2648B8FC988ECD74 + "_" + _id_99B99EC959F0D9DE])) {
          iprintlnbold("no more waves");
          return;
        }
      }
    }

    _id_A2B11613E4C46ED8 = scripts\engine\utility::array_combine(_id_A2B11613E4C46ED8, level._id_BB1520190DCADA5F[_id_F4145F44D6609FFB + "_" + _id_2648B8FC988ECD74 + "_" + _id_99B99EC959F0D9DE]);
    _id_99B99EC959F0D9DE++;
  }
}

_id_1E4F8EF46EF6E31B(_id_A2B11613E4C46ED8, _id_F4145F44D6609FFB, _id_E859D3E1172591F3, _id_365A0918B795C6EC) {
  level endon(_id_365A0918B795C6EC);
  _id_62EFCD976FE84759 = randomintrange(3, 5);

  if(getdvarint("dvar_471689334A84545B", 0) > 0 && getdvarint("dvar_46F37F334A5DF6A5", 0) > 0)
    _id_62EFCD976FE84759 = randomintrange(getdvarint("dvar_471689334A84545B", 0), getdvarint("dvar_46F37F334A5DF6A5", 0));

  _id_7FBB094B58C72141 = _id_A2B11613E4C46ED8.size;
  _id_499F09394EB8E0DD = 0;
  _id_91B79EDA2066363A = level._id_BB1520190DCADA5F[_id_F4145F44D6609FFB + "_0_0"].size + 1;
  _id_49C437E7F78B1AD4 = _id_91B79EDA2066363A - _id_62EFCD976FE84759 + 1;
  thread _id_68242F0E071E0D3E((2244, 8720, 141));
  wait(randomintrange(3, 6));
  _id_2648B8FC988ECD74 = 0;

  while(_id_499F09394EB8E0DD < _id_7FBB094B58C72141) {
    _id_AB49A090BDE5BE40 = scripts\cp\cp_agent_utils::get_alive_enemies().size;

    if(_id_AB49A090BDE5BE40 >= _id_91B79EDA2066363A) {
      wait 1;
      continue;
    }

    _id_2BF4B7422AA7DEB2 = 0;

    while(!_id_2BF4B7422AA7DEB2) {
      _id_A23E85387194C9F7 = _id_A2E001281732E3D1(_id_E859D3E1172591F3);
      _id_A23E85387194C9F7 = scripts\engine\utility::array_randomize(_id_A23E85387194C9F7);
      _id_3262E1F17DC59822 = [];

      foreach(group in _id_A23E85387194C9F7)
      _id_3262E1F17DC59822 = scripts\engine\utility::array_combine(_id_3262E1F17DC59822, group);

      spawngroup = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_62EFCD976FE84759; _id_AC0E594AC96AA3A8++) {
        spawngroup[_id_AC0E594AC96AA3A8] = _id_3262E1F17DC59822[_id_AC0E594AC96AA3A8];
        _id_A2B11613E4C46ED8 = scripts\engine\utility::array_remove_index(_id_A2B11613E4C46ED8, _id_AC0E594AC96AA3A8);
      }

      spawngroup = _id_46B1E1ADA0E5888C(spawngroup, _id_A2B11613E4C46ED8);

      if(!isDefined(spawngroup) || !spawngroup.size) {
        wait 1;
        continue;
      }

      scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(spawngroup, 1);
      _id_499F09394EB8E0DD = _id_499F09394EB8E0DD + spawngroup.size;
      wait 2;

      if(scripts\cp\cp_agent_utils::get_alive_enemies().size >= _id_91B79EDA2066363A)
        _id_2BF4B7422AA7DEB2 = 1;

      wait 0.05;
    }

    wait 1;
  }
}

_id_46B1E1ADA0E5888C(group, _id_42882F55470F9DDF) {
  foreach(index, enemy in group)
  enemy._id_87B421D7E94C6265 = _id_42882F55470F9DDF[index];

  return group;
}

_id_A2E001281732E3D1(_id_1A977EA95154CBA4) {
  _id_A23E85387194C9F7 = [];

  foreach(_id_70700B2C81A1F132 in _id_1A977EA95154CBA4) {
    if(!_id_70700B2C81A1F132.size) {
      continue;
    }
    _id_90EF0255AFE03D60 = scripts\cp\utility::getplayersinradius(_id_70700B2C81A1F132[0].origin, 512);

    if(!_id_90EF0255AFE03D60.size) {
      _id_A23E85387194C9F7[_id_A23E85387194C9F7.size] = _id_70700B2C81A1F132;
      continue;
    }

    _id_8D1FD50E1B3E5541 = 0;

    foreach(player in level.players) {
      if(abs(player.origin[2] - _id_70700B2C81A1F132[0].origin[2]) < 150)
        _id_8D1FD50E1B3E5541 = 1;
    }

    if(!_id_8D1FD50E1B3E5541) {
      _id_A23E85387194C9F7[_id_A23E85387194C9F7.size] = _id_70700B2C81A1F132;
      continue;
    }
  }

  return _id_A23E85387194C9F7;
}

_id_68242F0E071E0D3E(org) {
  if(!scripts\engine\utility::flag("p0_finished"))
    org = org + (12000, 0, 273);

  if(scripts\engine\utility::flag("p1_finished"))
    org = org + (-12000, 0, -70);

  if(!isDefined(level._id_DD7DE82CB1C47A2B))
    level._id_DD7DE82CB1C47A2B = spawn("script_origin", org);

  level._id_DD7DE82CB1C47A2B.origin = org;
  level._id_DD7DE82CB1C47A2B playLoopSound("milbase_alarm");
  wait 11;
  level._id_DD7DE82CB1C47A2B stoploopsound();
}

_id_BF7EFE18580291FC() {
  enemies = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(enemy in enemies) {
    if(enemy == level._id_E2958F412A7425C0) {
      continue;
    }
    enemy dodamage(enemy.health + 100, enemy.origin);
  }
}

_id_E02EBB3647F59943(shield, squad) {
  shield endon("death");
  wait 1;

  foreach(guy in squad) {
    guy.goalradius = 8;
    guy thread _id_F34886E6FB4C6E05(shield);
  }
}

_id_F34886E6FB4C6E05(_id_804C55379FAEAFC7) {
  self endon("death");
  self.combatmode = "no_cover";
  self.sprint = 1;
  scripts\common\utility::demeanor_override("sprint");

  if(!isDefined(_id_804C55379FAEAFC7.left_guy))
    _id_804C55379FAEAFC7.left_guy = self;
  else if(!isDefined(_id_804C55379FAEAFC7.right_guy))
    _id_804C55379FAEAFC7.right_guy = self;

  while(isalive(_id_804C55379FAEAFC7)) {
    if(!isalive(_id_804C55379FAEAFC7)) {
      break;
    }

    _id_B5F5BD03C0F386EF = anglesToForward(_id_804C55379FAEAFC7.angles) * -48;
    _id_46EF3E042B2E6565 = anglestoleft(_id_804C55379FAEAFC7.angles) * 24;
    _id_CDD53D78F51F6B97 = anglestoright(_id_804C55379FAEAFC7.angles) * 24;

    if(_id_804C55379FAEAFC7.left_guy == self)
      self setgoalpos(getclosestpointonnavmesh(_id_804C55379FAEAFC7.origin + _id_B5F5BD03C0F386EF + _id_46EF3E042B2E6565));
    else
      self setgoalpos(getclosestpointonnavmesh(_id_804C55379FAEAFC7.origin + _id_B5F5BD03C0F386EF + _id_CDD53D78F51F6B97));

    wait 0.25;
  }

  self.sprint = undefined;
  scripts\common\utility::clear_demeanor_override();
  self.combatmode = "cover";
  self.goalradius = 2048;

  foreach(_id_8B6D3988CED8664E in level.players)
  self getenemyinfo(_id_8B6D3988CED8664E);
}

_id_A266222D5842FAC3(_id_E21279FA90BDF012, squad) {
  _id_E21279FA90BDF012 endon("death");

  foreach(guy in squad) {
    guy.goalradius = 8;
    guy thread _id_CD3795C153264A9F(_id_E21279FA90BDF012);
  }
}

_id_D4224B8D78AA3E04(_id_E21279FA90BDF012) {
  _id_E21279FA90BDF012 endon("death");
  _id_371B4C2AB5861E62::_id_0036613FFB5EBE56(self);
}

_id_CD3795C153264A9F(_id_E21279FA90BDF012) {
  self endon("death");
  self.combatmode = "no_cover";
  self.sprint = 1;
  scripts\common\utility::demeanor_override("sprint");

  if(!isDefined(_id_E21279FA90BDF012.left_guy))
    _id_E21279FA90BDF012.left_guy = self;
  else if(!isDefined(_id_E21279FA90BDF012.right_guy))
    _id_E21279FA90BDF012.right_guy = self;
  else if(!isDefined(_id_E21279FA90BDF012._id_BA4B08272D762AB6)) {
    _id_E21279FA90BDF012._id_BA4B08272D762AB6 = self;
    thread _id_D4224B8D78AA3E04(_id_E21279FA90BDF012);
  }

  _id_377C3B45ABF67146 = spawnStruct();
  _id_377C5545ABF6AA74 = spawnStruct();
  _id_377C4545ABF68744 = spawnStruct();

  while(isalive(_id_E21279FA90BDF012)) {
    if(!isalive(_id_E21279FA90BDF012)) {
      break;
    }

    _id_B5F5BD03C0F386EF = anglesToForward(_id_E21279FA90BDF012.angles) * -48;
    _id_46EF3E042B2E6565 = anglestoleft(_id_E21279FA90BDF012.angles) * 24;
    _id_CDD53D78F51F6B97 = anglestoright(_id_E21279FA90BDF012.angles) * 24;
    _id_377C3B45ABF67146.origin = getclosestpointonnavmesh(_id_E21279FA90BDF012.origin + _id_B5F5BD03C0F386EF + _id_46EF3E042B2E6565);
    _id_377C5545ABF6AA74.origin = getclosestpointonnavmesh(_id_E21279FA90BDF012.origin + _id_B5F5BD03C0F386EF + _id_CDD53D78F51F6B97);
    _id_377C4545ABF68744.origin = getclosestpointonnavmesh(_id_E21279FA90BDF012.origin + _id_B5F5BD03C0F386EF);
    _id_114AB88507847C50 = scripts\engine\utility::getclosest(self.origin, [_id_377C3B45ABF67146, _id_377C5545ABF6AA74, _id_377C4545ABF68744]);
    self setgoalpos(_id_114AB88507847C50.origin);
    wait 0.25;
  }

  self.sprint = undefined;
  scripts\common\utility::clear_demeanor_override();
  self.combatmode = "cover";
  self.goalradius = 2048;

  foreach(_id_8B6D3988CED8664E in level.players)
  self getenemyinfo(_id_8B6D3988CED8664E);
}

_id_9C0FBE62C1B9D660() {
  self endon("death");
  self endon("stop_hunting");
  player = scripts\engine\utility::random(level.players);

  for(;;) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(_id_4A27F44F23590C6F in level.players) {
        if(istrue(_id_4A27F44F23590C6F.inlaststand)) {
          continue;
        }
        player = _id_4A27F44F23590C6F;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    foreach(_id_8B6D3988CED8664E in level.players)
    self getenemyinfo(_id_8B6D3988CED8664E);

    org = player.origin;
    wait 3;
  }
}

_id_5BFBD6454C40219F() {
  if(!scripts\engine\utility::flag_exist("manualoverride"))
    scripts\engine\utility::flag_init("manualoverride");

  _id_FC002B5825EA4617 = scripts\engine\utility::getStruct("crane_interact_right", "targetname");
  _id_FC002B5825EA4617.button = scripts\cp\utility::createhintobject(_id_FC002B5825EA4617.origin, "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/USE_CRANE", undefined, "duration_none", "show", 128, 65, 72, 45);
  _id_FC002B5825EA4617.button _id_66344994F6CA11D6(&"CP_RAID1_BOSS1/OVERRIDE_REQUIRED", "manualoverride", &"CP_RAID1_BOSS1/USE_CRANE");
  _id_69D90A2478D44F73 = getEntArray("crane_arm_right", "targetname");
  _id_FC002B5825EA4617._id_08B709D0C529477A = _id_69D90A2478D44F73[0];

  foreach(index, part in _id_69D90A2478D44F73) {
    if(index == 0) {
      continue;
    }
    part linkTo(_id_FC002B5825EA4617._id_08B709D0C529477A);
  }

  _id_FC002B5825EA4617._id_08B709D0C529477A.ladder = getEntArray("crane_arm_right_ladder", "targetname");

  foreach(ladder in _id_FC002B5825EA4617._id_08B709D0C529477A.ladder)
  ladder linkTo(_id_FC002B5825EA4617._id_08B709D0C529477A);

  _id_FC002B5825EA4617._id_08B709D0C529477A thread _id_01B673381A16A0CB();
  _id_FC002B5825EA4617 thread _id_C1F9FF84E5C32E96();
  level._id_4E0EBF343157CC3D = _id_FC002B5825EA4617;
}

_id_C1F9FF84E5C32E96() {
  _id_431D7A8AB1FDDFDC = 0;
  _id_70D40E44FF8588E6 = -1250;
  _id_70D42844FF85C214 = 50;
  _id_3F2C16F98573B9B0 = "idle";
  dir = "none";

  for(;;) {
    self.button waittill("trigger", ent);

    if(!ent scripts\cp\utility::is_valid_player() || !ent isonground() || ent isjumping() || ent getstance() == "prone") {
      continue;
    }
    if(ent getstance() != "stand")
      ent setstance("stand", 1, 1);

    self.button _meth_DFB78B3E724AD620(0);
    level notify("started_using_crane_controls", ent);
    ent._id_BD0DA10D4E08DF86 = 1;
    level thread _id_558A9A418B2D3405::_id_D9A8B633F287833C(ent, getEnt("crane_console", "targetname"));
    ent scripts\cp\utility::hint_prompt("move_crane", 1);
    _id_58724E69CA657D63 = 0;

    while(ent useButtonPressed())
      waitframe();

    wait 1;

    while(ent scripts\cp\utility::is_valid_player() && !ent useButtonPressed() && _id_58724E69CA657D63 > -0.5 && !istrue(ent._id_BF7A269C23B01A56) && !ent isjumping() && ent getstance() == "stand") {
      _id_F619FE4A4E1D4868 = ent getnormalizedmovement();
      _id_58724D69CA657B30 = _id_F619FE4A4E1D4868[1];
      _id_58724E69CA657D63 = _id_F619FE4A4E1D4868[0];

      if(_id_58724D69CA657B30 < -0.3) {
        if(_id_431D7A8AB1FDDFDC <= _id_70D40E44FF8588E6) {
          _id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0);
          _id_3F2C16F98573B9B0 = "idle";
          wait 0.05;
          continue;
        }

        if(dir != "left" && _id_3F2C16F98573B9B0 != "idle") {
          _id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0);
          _id_3F2C16F98573B9B0 = "idle";
          wait 0.5;
        }

        if(_id_3F2C16F98573B9B0 == "idle") {
          self._id_08B709D0C529477A playSound("crane_inuse_start");
          _id_3F2C16F98573B9B0 = "started";
        } else if(_id_3F2C16F98573B9B0 == "started") {
          self._id_08B709D0C529477A playLoopSound("crane_inuse_lp");
          _id_3F2C16F98573B9B0 = "moving";
        }

        dir = "left";
        self._id_08B709D0C529477A _meth_431D6E8AB1FDC578(-5, 0.2);
        _id_431D7A8AB1FDDFDC = _id_431D7A8AB1FDDFDC + -5;
      } else if(_id_58724D69CA657B30 > 0.3) {
        if(_id_431D7A8AB1FDDFDC >= _id_70D42844FF85C214) {
          _id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0);
          _id_3F2C16F98573B9B0 = "idle";
          wait 0.05;
          continue;
        }

        if(dir != "right" && _id_3F2C16F98573B9B0 != "idle") {
          _id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0);
          _id_3F2C16F98573B9B0 = "idle";
          wait 0.5;
        }

        if(_id_3F2C16F98573B9B0 == "idle") {
          self._id_08B709D0C529477A playSound("crane_inuse_start");
          _id_3F2C16F98573B9B0 = "started";
        } else if(_id_3F2C16F98573B9B0 == "started") {
          self._id_08B709D0C529477A playLoopSound("crane_inuse_lp");
          _id_3F2C16F98573B9B0 = "moving";
        }

        dir = "right";
        self._id_08B709D0C529477A _meth_431D6E8AB1FDC578(5, 0.2);
        _id_431D7A8AB1FDDFDC = _id_431D7A8AB1FDDFDC + 5;
      } else {
        _id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0);
        _id_3F2C16F98573B9B0 = "idle";
      }

      wait 0.2;
    }

    ent._id_BD0DA10D4E08DF86 = undefined;
    _id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0);
    _id_3F2C16F98573B9B0 = "idle";
    ent scripts\cp\utility::hint_prompt("move_crane", 0);
    ent _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("crane");
    wait 1;
    self.button _meth_DFB78B3E724AD620(1);
  }
}

_id_6E8D060EFAAAF391(_id_3F2C16F98573B9B0) {
  if(_id_3F2C16F98573B9B0 != "idle") {
    self._id_08B709D0C529477A stoploopsound();
    self._id_08B709D0C529477A playSound("crane_inuse_stop");
  }
}

_id_01B673381A16A0CB() {
  level endon("game_ended");
  self endon("death");
  ladder = self.ladder[0];
  _id_D88F5B485280717A = ladder.origin + rotatevector((0, 26, 155), ladder.angles);
  _id_3D3A9FAC6D590D9A = spawn("script_model", ladder.origin);
  _id_3D3A9FAC6D590D9A.angles = ladder.origin;
  _id_3D3A9FAC6D590D9A setModel("tag_origin");
  _id_3D3A9FAC6D590D9A.origin = _id_D88F5B485280717A;
  _id_3D3A9FAC6D590D9A linkTo(ladder);
  _id_3619F00A65FF1269 = 40;
  _id_3D3A9FAC6D590D9A makeusable();
  _id_3D3A9FAC6D590D9A setHintString(&"CP_RAID1_BOSS1/LADDER_USE");
  _id_3D3A9FAC6D590D9A setCursorHint("HINT_BUTTON");
  _id_3D3A9FAC6D590D9A sethinticon("hud_icon_mantle_ladder");
  _id_3D3A9FAC6D590D9A sethintdisplayrange(_id_3619F00A65FF1269);
  _id_3D3A9FAC6D590D9A sethintdisplayfov(60);
  _id_3D3A9FAC6D590D9A setuserange(_id_3619F00A65FF1269);
  _id_3D3A9FAC6D590D9A setusefov(50);
  _id_3D3A9FAC6D590D9A sethintonobstruction("show");
  _id_3D3A9FAC6D590D9A setuseholdduration("duration_short");

  for(;;) {
    _id_3D3A9FAC6D590D9A waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      player setOrigin(_id_3D3A9FAC6D590D9A.origin, 0);
      player setplayerangles((0, 90, 0));
    }
  }
}

_id_E458190349EE6968() {
  scripts\engine\utility::flag_init("shutdown1_pressed");
  scripts\engine\utility::flag_init("shutdown2_pressed");
  scripts\engine\utility::flag_init("p0_finished");
  scripts\engine\utility::flag_init("p1_finished");
  scripts\engine\utility::flag_init("p2_finished");
  scripts\engine\utility::flag_init("valve_left_turned");
  scripts\engine\utility::flag_init("valve_right_turned");
  scripts\engine\utility::flag_init("p0_primer");
  scripts\engine\utility::flag_init("valve_left_p0_turned");
  scripts\engine\utility::flag_init("valve_right_p0_turned");
  scripts\engine\utility::flag_init("pump1_pressed");
  scripts\engine\utility::flag_init("pump2_pressed");
  scripts\engine\utility::flag_init("bay_flooded");
  scripts\engine\utility::flag_init("spawning_reinforcements");
  scripts\engine\utility::flag_init("cranes_unlocked");
}

_id_2220614448CCF940() {
  offset = 0;
  _func_AC735EEE7BC507F6(offset);
  scripts\engine\utility::flag_wait("bay_flooded");

  while(offset < 8) {
    offset = offset + 1;
    _func_AC735EEE7BC507F6(offset);
    wait 0.05;
  }

  while(offset < 40) {
    offset = offset + 0.05;
    _func_AC735EEE7BC507F6(offset);
    wait 0.05;
  }

  scripts\engine\utility::flag_wait("p1_finished");

  while(offset < 126) {
    offset = offset + 0.0625;
    _func_AC735EEE7BC507F6(offset);
    wait 0.05;
  }

  level notify("vo_water_raise_done");
}

_id_F04AAF4BF1C3FB20(offset) {
  _func_AC735EEE7BC507F6(offset);
}

_id_AC901BAA09661D94(str, _id_269E4014FDBF1216) {
  sound = "text_box_new";

  foreach(player in level.players) {
    if(istrue(_id_269E4014FDBF1216)) {
      if(player != self)
        continue;
    }

    player playlocalsound(sound);
    player sethudtutorialmessage(str, 1);
  }

  wait 3;

  foreach(player in level.players) {
    if(istrue(_id_269E4014FDBF1216)) {
      if(player != self)
        continue;
    }

    player clearhudtutorialmessage();
  }
}

_id_07DF365D859CDC1E() {
  if(!isDefined(level._id_DB7BB73A753C01D7))
    return 0;

  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("door_check", "targetname");
  _id_E849208B6D29DEAF = scripts\engine\utility::getclosest(self.origin, _id_9E4E1482CB40C9C5, 300);

  if(!isDefined(_id_E849208B6D29DEAF))
    return 0;

  ignoreents = scripts\engine\utility::array_combine(level.players, [self]);
  trace = scripts\engine\trace::ray_trace(_id_E849208B6D29DEAF.origin, _id_E849208B6D29DEAF.origin + anglesToForward(_id_E849208B6D29DEAF.angles) * 100, ignoreents);

  if(isDefined(trace["entity"]) && isDefined(trace["entity"].targetname) && (trace["entity"].targetname == "script_toolbox_clip" || trace["entity"].targetname == "script_toolbox")) {
    if(istrue(self._id_233D382A9996DE04) || istrue(self._id_18D12C4028C20617) && istrue(self._id_2E523BBC651A297A)) {
      self notify("unblocked");
      self.blocked = undefined;
      self moveTo(self.openpos, 0.5);
      return 1;
    }

    if(!istrue(self.blocked)) {
      self.blocked = 1;
      thread _id_78E1633832A5128D();
    }

    return 1;
  }

  self notify("unblocked");

  if(istrue(self.blocked)) {
    self playSound("cp_buddy_door_close");
    self moveTo(self.closedpos, 0.5);
    self.blocked = undefined;
  }

  return 0;
}

_id_78E1633832A5128D() {
  self endon("unblocked");
  self endon("opening");

  while(istrue(self.blocked)) {
    level notify("two_man_door_move", "close");
    self playSound("cp_buddy_door_close");
    thread _id_2817029CF18B85BA();
    self moveTo(self._id_BA5410B92C5C60BB, 0.5);
    self waittill("movedone");
    earthquake(0.2, 1, self.origin, 450);
    playrumbleonposition("grenade_rumble", self.origin);
    wait 5;
    level notify("two_man_door_move", "open");
    self playSound("cp_buddy_door_open");
    self moveTo(self.openpos, 1);
    wait 3;
  }
}

_id_2817029CF18B85BA() {
  self endon("movedone");

  for(;;) {
    foreach(player in level.players) {
      if(player istouching(self))
        player dodamage(player.health + 1000, player getEye() + (0, 0, 20), self, self, "MOD_CRUSH");
    }

    waitframe();
  }
}

_id_148E44373E8EE372() {
  self endon("disconnect");
  level endon("game_ended");
  _id_E7FA907F5D08718E = getEnt("area1_elec_trigger", "targetname").origin;
  earthquake(0.15, 5, _id_E7FA907F5D08718E, 10000);
  _id_57C9708EDC7500B9 = gettime() + 2000;

  if(scripts\engine\utility::flag("p1_finished")) {
    playsoundatpos((15000, 9528, 241), "evt_raid3_main_pump_active_atmo");
    playsoundatpos((15972, 9176, 263), "evt_raid3_main_pump_active_pipe");
    playsoundatpos((15047, 8765, 226), "evt_raid3_main_pump_active_water");
  } else {
    playsoundatpos((15000, 9528, 241), "evt_raid3_secondary_pump_active_atmo");
    playsoundatpos((14832, 9533, 241), "evt_raid3_secondary_pump_active_pipe_01");
    playsoundatpos((15221, 9521, 241), "evt_raid3_secondary_pump_active_pipe_02");
  }

  while(gettime() < _id_57C9708EDC7500B9) {
    foreach(player in level.players) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      player playRumbleOnEntity(scripts\engine\utility::random(["damage_heavy", "damage_light", "grenade_rumble"]));
      waitframe();
    }

    wait 0.1;
  }
}

_id_64FCFB5CB3654CBD(_id_4B3B70184EBD0AFA) {
  self _meth_DFB78B3E724AD620(0);
  self sethintinoperable(_id_4B3B70184EBD0AFA);
  wait 0.25;
  self _meth_DFB78B3E724AD620(1);
}

_id_BF11D3FD19E18ABE() {
  level._id_D3B90C28E1C7DBBF = 1;
  _id_DB1C9BA21F529D03 = scripts\engine\utility::getStructArray("weapon_wall", "targetname");

  foreach(struct in _id_DB1C9BA21F529D03) {
    if(istrue(struct._id_0948C921601932E3)) {
      continue;
    }
    struct._id_0948C921601932E3 = 1;
    _id_E27137570124CFCB = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(struct.weaponinfo);
    _id_6CC2126273AA22B3 = undefined;

    switch (struct.weaponinfo) {
      case "iw9_dm_mike14_mp":
        _id_6CC2126273AA22B3 = ["silencer", "fourxtherm01"];
        break;
      case "iw9_sm_beta_mp":
        _id_6CC2126273AA22B3 = ["silencer", "reflex04"];
        break;
      case "iw9_pi_golf17_mp":
        _id_6CC2126273AA22B3 = ["silencer", "reddot"];
        break;
      case "iw9_br_schotel_mp":
        _id_6CC2126273AA22B3 = ["grip_vert02"];
        break;
      case "iw9_sn_mromeo_mp":
        _id_6CC2126273AA22B3 = ["silencer_sn_01"];
        break;
    }

    if(isDefined(_id_6CC2126273AA22B3))
      _id_E27137570124CFCB = _id_E27137570124CFCB _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(_id_6CC2126273AA22B3);

    struct _id_9655BF427A5ABDB8(_id_E27137570124CFCB);
  }

  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");

  if(isDefined(_id_D5ECF70A4D407B43))
    _id_18AF78602B67B70C::level_offhand_spawn(_id_D5ECF70A4D407B43);
}

_id_9655BF427A5ABDB8(objweapon) {
  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_AEC66C8D309A2AFA = 0;
  _id_5D9B5B689A1846C8 = undefined;

  if(istrue(objweapon.hasalternate)) {
    _id_5D9B5B689A1846C8 = objweapon getaltweapon();
    _id_AEC66C8D309A2AFA = weaponclipsize(_id_5D9B5B689A1846C8);
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon), weaponclipsize(objweapon), 1);
  } else
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));

  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 sethintdisplayfov(85);
  _id_B8F5AC23CE0DFDE3 setusefov(60);
  return _id_B8F5AC23CE0DFDE3;
}

_id_66344994F6CA11D6(_id_6EADA805D456922F, flagname, _id_F4D3F8CF1C5FAD70, dvar) {
  level endon("game_ended");
  self setHintString(_id_6EADA805D456922F);
  _id_64FCFB5CB3654CBD(1);

  for(;;) {
    if(scripts\engine\utility::flag(flagname)) {
      break;
    }

    _id_9FA895F4959EFA2D = 0;

    if(isDefined(dvar)) {
      if(dvar == "skip_bilgepumps") {
        if(getdvarint("dvar_695A0867F31C373C", 0) > 0)
          _id_9FA895F4959EFA2D = 1;
      }

      if(_id_9FA895F4959EFA2D) {
        break;
      }
    }

    waitframe();
  }

  self setHintString(_id_F4D3F8CF1C5FAD70);
  _id_64FCFB5CB3654CBD(0);
}

_id_D68D0E8E5202A02A(_id_5159F960A67ED33B) {
  _id_74A4D5AD8CC54EDE = getEntArray("catwalk_a_brush", "targetname");
  _id_C3DFE564264D578F = getEntArray("catwalk_a_model", "targetname");
  _id_B330891CBC775442 = getEntArray("catwalk_b_brush", "targetname");
  _id_A10C3EC6E14382B3 = getEntArray("catwalk_b_model", "targetname");
  _id_FC1A5C47819DA5F6 = getEnt("catwalk_nav_blocker", "targetname");

  if(_id_5159F960A67ED33B == "pristine") {
    _id_FC1A5C47819DA5F6 connectpaths();

    if(!isDefined(_id_FC1A5C47819DA5F6.ogorigin))
      _id_FC1A5C47819DA5F6.ogorigin = _id_FC1A5C47819DA5F6.origin;

    _id_FC1A5C47819DA5F6.origin = _id_FC1A5C47819DA5F6.origin + (0, 0, 200);

    foreach(brush in _id_74A4D5AD8CC54EDE)
    brush show();

    foreach(model in _id_C3DFE564264D578F)
    model show();

    foreach(brush in _id_B330891CBC775442)
    brush hide();

    foreach(model in _id_A10C3EC6E14382B3)
    model hide();
  } else {
    if(isDefined(_id_FC1A5C47819DA5F6.ogorigin))
      _id_FC1A5C47819DA5F6.origin = _id_FC1A5C47819DA5F6.ogorigin;

    _id_FC1A5C47819DA5F6 disconnectPaths();

    foreach(brush in _id_74A4D5AD8CC54EDE)
    brush hide();

    foreach(model in _id_C3DFE564264D578F)
    model hide();

    foreach(brush in _id_B330891CBC775442)
    brush show();

    foreach(model in _id_A10C3EC6E14382B3)
    model show();
  }
}

_id_7C64BFFF3489F163() {
  if(istrue(level._id_799DB029A3A873E4)) {
    return;
  }
  _id_E822437A761248C5 = getEntArray("substation_spawn_door", "targetname");
  clips = getEntArray("substation_spawn_door_clip", "targetname");

  foreach(door in _id_E822437A761248C5) {
    door.clip = scripts\engine\utility::getclosest(door.origin, clips);
    door.clip linkTo(door);
    door thread _id_456D9C96750FC4CB();
  }

  level._id_799DB029A3A873E4 = 1;
}

_id_456D9C96750FC4CB() {
  level endon("game_ended");

  for(;;) {
    enemies = scripts\cp\cp_agent_utils::get_alive_enemies();

    if(!enemies.size) {
      wait 1;
      continue;
    }

    _id_426EE900EFB1862C = scripts\engine\utility::getclosest(self.origin, enemies, 100);

    if(!isDefined(_id_426EE900EFB1862C)) {
      waitframe();
      continue;
    }

    dir = vectorNormalize((_id_426EE900EFB1862C.origin - self.origin) * (1, 1, 0));
    _id_3A3002B6CA1FC40D = vectordot(dir, anglesToForward(self.angles));

    if(_id_3A3002B6CA1FC40D > 0) {
      self rotateYaw(-120, 0.6);
      self playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
      return;
    }

    wait 1;
  }
}

_id_0C735D60735EDA5F() {
  self endon("death");
  thread _id_9D291774C6674A30();
  thread _id_126989877E9C2139();
  waitframe();

  if(!isDefined(level._id_20A3C60BA9434F71))
    level._id_20A3C60BA9434F71 = 0;

  _id_5AAED8B796BA6879 = getEnt("silo_flashlight", "targetname");
  _id_04B1F6D15C5FFCBF = getEnt("fil_flashlight", "targetname");

  if(!isDefined(_id_5AAED8B796BA6879) && !isDefined(_id_04B1F6D15C5FFCBF)) {
    return;
  }
  for(;;) {
    foreach(player in level.players) {
      if(player istouching(_id_5AAED8B796BA6879) || player istouching(_id_04B1F6D15C5FFCBF))
        touching = 1;
      else
        touching = 0;

      if(!touching) {
        if(istrue(player._id_4AAD4F06D972E6B2))
          player _id_435C3F85A3D06576::toggle_flashlight(0);

        continue;
      }

      if((!istrue(player._id_4AAD4F06D972E6B2) || !isDefined(player._id_4AAD4F06D972E6B2)) && !istrue(level._id_20A3C60BA9434F71))
        player _id_435C3F85A3D06576::toggle_flashlight(1);

      if(istrue(player._id_4AAD4F06D972E6B2) && istrue(level._id_20A3C60BA9434F71))
        player _id_435C3F85A3D06576::toggle_flashlight(0);
    }

    waitframe();
  }
}

_id_E97CB398476590D1() {
  foreach(player in level.players)
  player _id_435C3F85A3D06576::toggle_flashlight(0);
}

_id_9D291774C6674A30() {
  level._effect["1st_person_flashlight"] = level._effect["1st_person_flashlight_default"];
  level._effect["3rd_person_flashlight"] = level._effect["3rd_person_flashlight_default"];
}

_id_BA5E5C5EBE8BF57B() {
  level waittill("player_near_fil");
  level._effect["1st_person_flashlight"] = level._effect["1st_person_flashlight_highbeam"];
  level._effect["3rd_person_flashlight"] = level._effect["1st_person_flashlight_highbeam"];

  foreach(player in level.players)
  player _id_435C3F85A3D06576::_id_41C3302121BE1A40();
}

_id_126989877E9C2139() {
  foreach(player in level.players)
  player thread _id_3374D995448B4D1F();
}

_id_3374D995448B4D1F() {
  _id_C062DA88DC99985B = 0;

  for(;;) {
    scripts\engine\utility::waittill_any_return_4("pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete");

    if(self.prevweaponobj.basename == "iw9_me_riotshield_mp") {
      _id_C062DA88DC99985B = 1;

      if(scripts\engine\utility::flag("flashlight_high"))
        level._effect["1st_person_flashlight"] = level._effect["1st_person_flashlight_highbeam_shield"];
      else
        level._effect["1st_person_flashlight"] = level._effect["1st_person_flashlight_shield"];

      level._effect["3rd_person_flashlight"] = level._effect["3rd_person_flashlight_shield"];
      _id_435C3F85A3D06576::_id_41C3302121BE1A40();
      continue;
    }

    if(_id_C062DA88DC99985B == 1) {
      if(scripts\engine\utility::flag("flashlight_high"))
        level._effect["1st_person_flashlight"] = level._effect["1st_person_flashlight_highbeam"];
      else
        level._effect["1st_person_flashlight"] = level._effect["1st_person_flashlight_default"];

      level._effect["3rd_person_flashlight"] = level._effect["3rd_person_flashlight_default"];
      level.player _id_435C3F85A3D06576::_id_41C3302121BE1A40();
      _id_C062DA88DC99985B = 0;
    }
  }
}

_id_9EFDF9D69B3E813C() {
  level._id_168F04BC9AFCFAAC = 1;

  if(istrue(level._id_8233EFB6BCD75204)) {
    return;
  }
  door = getEnt("toolbox_door", "targetname");
  doorclip = getEnt("toolbox_door_clip", "targetname");
  doorclip linkTo(door);
  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("toolbox_door_button", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "electrical_cell_door_button_red", 72, 256, "duration_none", "hide", undefined, "electrical_cell_door_button_green");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "electrical_cell_door_button_red", 72, 256, "duration_none", "hide", undefined, "electrical_cell_door_button_green");
  door._id_CDFF6CE3D4D73F68 = 1;
  door._id_A85B0AF305EEDD88 = 1;
  door._id_F14FE08CFB8BEE65 = ::_id_07DF365D859CDC1E;
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(door, 1, 0, 1);
  level._id_8233EFB6BCD75204 = 1;
  door._id_BCBE2E310C02E89B = 1;
  wait 2;
  door._id_7432D0D0FA70617C notify("trigger", level.players[0]);
  wait 2;
  level._id_168F04BC9AFCFAAC = 0;
  door._id_BCBE2E310C02E89B = 0;
}

_id_53AC3DFD44F1AB87() {
  self endon("death");
  self.ignoreall = 1;
  level waittill("player_near_fil");
  self.ignoreall = 0;
}

_id_887438C3B4B194B6(closed, pos) {
  _id_4F6FF34F222B0271 = getentitylessscriptablearray("scriptable_scriptable_construction_doors_metal_b_02_mp", "classname", pos, 128);
  _id_4F6FF04F222AFBD8 = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_orange_double_l", "classname", pos, 64);
  _id_4F6FF14F222AFE0B = getentitylessscriptablearray("scriptable_scriptable_door_wood_ornate_01_orange_double_r", "classname", pos, 64);
  _id_4F6FF64F222B090A = getentitylessscriptablearray("scriptable_scriptable_door_metal_04_flat_painted_clean_mp", "classname", pos, 64);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF14F222AFE0B);
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, _id_4F6FF64F222B090A);

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor()) {
      if(closed) {
        timeout = 0;
        _id_26BAEFB3804B52C3 scriptabledoorclose();

        while(!_id_26BAEFB3804B52C3 scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
        continue;
      }

      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);
      _id_26BAEFB3804B52C3 scriptabledooropen("away", pos);
    }
  }
}

_id_A0E2527CF709959D() {
  foreach(trap in level.tripwires.traps) {
    if(isDefined(trap))
      trap setCanDamage(0);
  }
}

_id_B6CD3626C14C131E() {
  level endon("game_ended");
  _id_9E4E1482CB40C9C5 = undefined;

  while(!isDefined(_id_9E4E1482CB40C9C5) || _id_9E4E1482CB40C9C5.size == 0) {
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("struct_dogtag_relocate", "targetname");
    wait 3;
  }

  level._id_B6CD3626C14C131E = _id_9E4E1482CB40C9C5;
}

_id_EB03E98032508EDD() {
  level endon("game_ended");
  level.force_respawn_location = ::_id_44EDE03655F5EB3B;
  level.enter_spectator_func = ::_id_23F5653B000F221F;
}

_id_44EDE03655F5EB3B(downed_player) {
  if(istrue(downed_player._id_BE7F4ACCCA2B999E)) {
    _id_4C2A5BC6ECA4173A = scripts\engine\utility::getStruct("boss_ee_dogtag_relocate", "targetname");
    downed_player._id_BE7F4ACCCA2B999E = undefined;
    return _id_4C2A5BC6ECA4173A;
  } else {
    _id_28D4A609D75FADF2 = spawnStruct();
    _id_28D4A609D75FADF2.origin = downed_player.origin;
    _id_28D4A609D75FADF2.angles = (0, 0, 0);
    return _id_28D4A609D75FADF2;
  }
}

_id_23F5653B000F221F(downed_player) {
  downed_player endon("disconnect");
  _id_8FEE1FC9FC7B3D73 = getEnt("water_tunnels_to_boss", "script_noteworthy");
  _id_4C2A5BC6ECA4173A = downed_player.origin;

  if(isDefined(_id_8FEE1FC9FC7B3D73) && ispointinvolume(downed_player.origin, _id_8FEE1FC9FC7B3D73)) {
    _id_4C2A5BC6ECA4173A = scripts\engine\utility::getStruct("boss_ee_dogtag_relocate", "targetname").origin;
    downed_player._id_BE7F4ACCCA2B999E = 1;
  }

  dogtag = spawn("script_model", _id_4C2A5BC6ECA4173A + (0, 0, 40));
  dogtag _id_0AFB7E332AEE4BF2::_id_C919AFEBF9FE06C4();
  dogtag hudoutlineenable("outline_nodepth_white");
  downed_player.respawn_forcespawnorigin = _id_4C2A5BC6ECA4173A;

  if(isDefined(downed_player.angles))
    downed_player.respawn_forcespawnangles = downed_player.angles;
  else
    downed_player.respawn_forcespawnangles = (0, 0, 0);

  downed_player.dogtag = dogtag;
  downed_player.dogtag.owner = downed_player;
  _id_0AFB7E332AEE4BF2::makereviveicon(dogtag, downed_player, (1, 0, 0));
  dogtag thread _id_0AFB7E332AEE4BF2::revivetriggerthink(downed_player.team);
  dogtag thread _id_0AFB7E332AEE4BF2::endreviveonownerdeathordisconnect();
}

_id_27B3C857D63DC910(ent, marker) {
  if(ent.moving_platform tagexists("tag_origin")) {
    ent.origin = marker.location;
    ent linkTo(ent.moving_platform, "tag_origin", ent.moving_platform_offset, ent.moving_platform_angles_offset);
  }
}

_id_A0D3C7111B497557() {
  self endon("death");
  level endon("game_ended");
  childthread _id_587D94D96C6FE3A8();

  for(;;) {
    self waittill("start_audio");

    while(istrue(self._id_FEAF5D8BE6377441)) {
      self playSound("evt_raid3_pump_valve_start");
      self playLoopSound("evt_raid3_pump_valve_turn_lp");
      msg = scripts\engine\utility::waittill_any_return_2("stop_audio", "reached_max");

      if(isDefined(msg) && msg == "reached_max") {
        self stoploopsound();
        self playSound("evt_raid3_pump_valve_stop");
        self playLoopSound("evt_raid3_pump_valve_pressure_lp");
        self waittill("stop_audio");
      } else {
        self stoploopsound();
        self playSound("evt_raid3_pump_valve_stop");
      }

      self waittill("start_audio");
    }

    self stoploopsound();
    self playSound("evt_raid3_pump_valve_stop");
  }
}

_id_587D94D96C6FE3A8() {
  for(;;) {
    self waittill("start_depaudio");
    self playSound("evt_raid3_pump_valve_start");
    self playLoopSound("evt_raid3_pump_valve_reset_lp");
    self waittill("stop_depaudio");
    self stoploopsound();
    self playSound("evt_raid3_pump_valve_stop");
  }
}

_id_AB240E7CFE63075D(use_struct, _id_830905E5C2645826, _id_89FCEB49BA5D7862, _id_C5D3D8FF129F88BA) {
  level endon("game_ended");
  level endon(_id_830905E5C2645826);
  dist = scripts\engine\utility::ter_op(isDefined(_id_89FCEB49BA5D7862), _id_89FCEB49BA5D7862, 120);
  _id_B5A9B9C0EEB065DE = squared(dist);

  for(;;) {
    count = _id_275CA86EF7F61634(use_struct.origin, _id_B5A9B9C0EEB065DE);

    if(isDefined(_id_C5D3D8FF129F88BA))
      _id_C5D3D8FF129F88BA sethintstringparams(count);

    if(count == level.players.size) {
      level notify(_id_830905E5C2645826);
      return;
    }

    wait 1;
  }
}

_id_275CA86EF7F61634(origin, _id_A9B6B677F6D0A010) {
  count = 0;

  foreach(player in level.players) {
    _id_8BE1C88B2070BFD8 = abs(player.origin[2] - origin[2]);

    if(distancesquared(player.origin, origin) <= _id_A9B6B677F6D0A010 && _id_8BE1C88B2070BFD8 < 50)
      count++;
  }

  return count;
}

_id_92233BCD56EA95C5(_id_92C4DE821390F609, _id_43BAFB58FE4EE161, _id_89FCEB49BA5D7862) {
  level endon("game_ended");
  doors = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  use_struct = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");

  if(isDefined(doors) && isDefined(use_struct)) {
    _id_18AF78602B67B70C::_id_887438C3B4B194B6(1, use_struct.origin);
    _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(use_struct.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/3MANDOOR", undefined, "duration_short", "show", 200, 300, 64, 40, undefined);
    _id_830905E5C2645826 = _id_92C4DE821390F609 + "_door_open";
    childthread _id_18AF78602B67B70C::_id_F6BC7D593D54CFEC(_id_C5D3D8FF129F88BA, _id_830905E5C2645826);
    childthread _id_AB240E7CFE63075D(use_struct, _id_830905E5C2645826, _id_89FCEB49BA5D7862, _id_C5D3D8FF129F88BA);
    waitframe();
    _id_C5D3D8FF129F88BA sethintstringparams(0);
    level waittill(_id_830905E5C2645826);

    if(istrue(_id_43BAFB58FE4EE161))
      scripts\engine\utility::flag_set(_id_830905E5C2645826);

    _id_C5D3D8FF129F88BA delete();

    if(soundexists("emb_garage_open_start"))
      doors[0] playSound("emb_garage_open_start");

    if(soundexists("emb_garage_open_lp"))
      doors[0] playLoopSound("emb_garage_open_lp");

    wait 1;

    if(soundexists("emb_garage_open_stop"))
      doors[0] playSound("emb_garage_open_stop");

    wait 0.25;

    if(soundexists("emb_garage_open_lp"))
      doors[0] stoploopsound();

    wait 0.25;
    _id_18AF78602B67B70C::_id_887438C3B4B194B6(0, use_struct.origin);

    foreach(door in doors)
    door delete();
  }
}

_id_A5A34903B136C045(_id_92C4DE821390F609, _id_43BAFB58FE4EE161, _id_89FCEB49BA5D7862) {
  level endon("game_ended");
  doors = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  use_struct = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");

  if(isDefined(use_struct)) {
    _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(use_struct.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/3MANDOOR", undefined, "duration_short", "show", 200, 300, 64, 40, undefined);
    _id_830905E5C2645826 = _id_92C4DE821390F609 + "_door_open";
    childthread _id_18AF78602B67B70C::_id_F6BC7D593D54CFEC(_id_C5D3D8FF129F88BA, _id_830905E5C2645826);
    childthread _id_AB240E7CFE63075D(use_struct, _id_830905E5C2645826, _id_89FCEB49BA5D7862, _id_C5D3D8FF129F88BA);
    waitframe();
    _id_C5D3D8FF129F88BA sethintstringparams(0);
    level waittill(_id_830905E5C2645826);

    if(istrue(_id_43BAFB58FE4EE161))
      scripts\engine\utility::flag_set(_id_830905E5C2645826);

    _id_C5D3D8FF129F88BA delete();
    _id_1FC06BF514F2782A = use_struct scripts\engine\utility::spawn_tag_origin();

    if(soundexists("iw9_door_metal_glass_peek_open"))
      _id_1FC06BF514F2782A playSound("iw9_door_metal_glass_peek_open");

    if(soundexists("iw9_door_metal_glass_peek_open"))
      _id_1FC06BF514F2782A playLoopSound("iw9_door_metal_glass_peek_open");

    wait 1;

    if(soundexists("emb_garage_open_stop"))
      doors[0] playSound("emb_garage_open_stop");

    wait 0.25;

    if(soundexists("emb_garage_open_lp"))
      doors[0] stoploopsound();

    wait 0.25;
    door = getEnt("vent_exit_door", "targetname");
    ents = door scripts\engine\utility::get_linked_ents();
    ents[0] linkTo(door);
    door rotateYaw(-90, 0.5);

    foreach(door in doors)
    door delete();

    wait 2;
    _id_1FC06BF514F2782A delete();
  }
}

_id_88733CF2A8AD17EB() {
  level endon("game_ended");

  while(!isDefined(level._id_E2958F412A7425C0))
    wait 1;

  _id_E2958F412A7425C0 = level._id_E2958F412A7425C0;
  _id_E2958F412A7425C0 endon("death");
  scripts\engine\utility::flag_wait("sub_door_3_cut");
  objectiveindex = scripts\cp\cp_objectives::requestworldid("boss1_chase_obj");
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_RAID1_BOSS1/AQ_LTNT");
  objective_onentity(objectiveindex, _id_E2958F412A7425C0);
  objective_setzoffset(objectiveindex, 90);
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 0);
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid("boss1_chase_obj");
}