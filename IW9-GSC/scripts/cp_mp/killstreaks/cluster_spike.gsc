/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\cluster_spike.gsc
*******************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cluster_spike", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cluster_spike", "init")]]();

  level _id_DDB866CC574674C0();
  level _id_1CEB81F4ABE9CC5E();
  level _id_9D6B4EC9F5809BC5();
  level _id_B7FE23EB11F96086();
  level _id_B7B736EB11AAC7DF();
}

_id_DDB866CC574674C0() {
  level._id_586A6D61ABD25D66 = [];
  level._id_C255EB9109A38F9F = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level._id_586A6D61ABD25D66[_id_FABF84450735DD93] = [];

  _id_F16AF5A8C61C30EE = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("cluster_spike", 1);
  _id_F16AF5A8C61C30EE.radius = 250;
  _id_F16AF5A8C61C30EE.triggercallback = ::_id_7FB05833DB79CF2D;
}

_id_1CEB81F4ABE9CC5E() {
  level._id_FF6EA90ECF04638B = "clusterSpike_placement";
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910(level._id_FF6EA90ECF04638B, ["sprint", "supersprint", "offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers"]);
}

_id_9D6B4EC9F5809BC5() {}

_id_B7FE23EB11F96086() {}

_id_B7B736EB11AAC7DF() {}

_id_BDE7FD6853600DA4(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread _id_736A390857671CAE(streakinfo);
}

_id_736A390857671CAE(streakinfo) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  result = scripts\engine\utility::waittill_any_return_2("cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }
  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

_id_EE88B06E55DD9CA3(streakinfo) {
  if(istrue(streakinfo._id_96EB72336F27BC9E)) {
    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](streakinfo);
  }
}

_id_BAFF78978772ECEC(streakinfo, weaponobj, projectile) {
  projectile thread _id_AE64D36F507ACA45(self, streakinfo, weaponobj);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.airdroptype, self.origin);

  streakinfo._id_96EB72336F27BC9E = 1;
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

_id_43FCF054875C96C5() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("cluster_spike", self);
  return _id_4D4DFA5C57455DF0(streakinfo);
}

_id_4D4DFA5C57455DF0(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  if(isDefined(level._id_FF6EA90ECF04638B))
    streakinfo._id_FB58A31C756DB4CC = level._id_FF6EA90ECF04638B;

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, makeweapon("cluster_spike_mp"), "grenade_fire", undefined, ::_id_BDE7FD6853600DA4, ::_id_BAFF78978772ECEC, undefined, ::_id_EE88B06E55DD9CA3);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "cluster_spike", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_cluster_spike", self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cluster_spike", "munitionUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("cluster_spike", "munitionUsed")]]();

  return 1;
}

_id_AE64D36F507ACA45(player, streakinfo, weaponobj) {
  level endon("game_ended");
  _id_EC07522D4A88F026 = _id_A868FA9DC357D535(player);

  if(isDefined(_id_EC07522D4A88F026)) {
    foreach(mine in _id_EC07522D4A88F026) {
      if(!isDefined(mine))
        level._id_586A6D61ABD25D66[self.team]["ownerID_" + self getxuid()] = scripts\engine\utility::array_removeundefined(level._id_586A6D61ABD25D66[self.team]["ownerID_" + self getxuid()]);

      mine thread _id_BC3D8C3958483B5F("destroy");
    }
  }

  _id_9B3DD3233F6F68A2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cluster_spike", "lifetimeOverride"))
    _id_9B3DD3233F6F68A2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("cluster_spike", "lifetimeOverride")]]();

  _id_CC8B9EF243E90347(self, weaponobj, streakinfo, player, _id_9B3DD3233F6F68A2, 1);
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  self waittill("missile_stuck");
  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(self.owner, self.team, 1200, "cluster_spike", self.origin);

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = self[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/BLOCKED_REFUND_KILLSTREAK");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");

      thread _id_B53E15638CE719B2(0);
      return;
    }
  }

  _id_2E48D17044BB4927 = 1;
  thread _id_31BE5250A8292B48();
  thread _id_BDDE9FCC527C241B(_id_2E48D17044BB4927);
}

_id_CC8B9EF243E90347(_id_A051766A1EC54371, weaponobj, streakinfo, owner, _id_9B3DD3233F6F68A2, _id_4DCC736354EB9C7E) {
  level._id_C255EB9109A38F9F++;
  _id_A051766A1EC54371.owner = owner;
  _id_A051766A1EC54371.team = owner.team;
  _id_A051766A1EC54371.ownerid = "ownerID_" + owner getxuid();
  _id_A051766A1EC54371._id_3ECC59AE19D41B04 = _id_A051766A1EC54371.ownerid + "_" + level._id_C255EB9109A38F9F;
  _id_A051766A1EC54371._id_4DCC736354EB9C7E = istrue(_id_4DCC736354EB9C7E);
  _id_A051766A1EC54371.weapon_name = weaponobj.basename;
  _id_A051766A1EC54371.equipmentref = "cluster_spike";
  _id_A051766A1EC54371.weapon_object = weaponobj;
  _id_A051766A1EC54371.health = 99999;
  _id_A051766A1EC54371.maxhealth = 75;
  _id_A051766A1EC54371.lifetime = 120;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cluster_spike", "attachXRays"))
    _id_A051766A1EC54371 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("cluster_spike", "attachXRays")]](_id_A051766A1EC54371);

  if(isDefined(_id_9B3DD3233F6F68A2))
    _id_A051766A1EC54371.lifetime = _id_9B3DD3233F6F68A2;

  _id_A051766A1EC54371.streakinfo = streakinfo;
  _id_A051766A1EC54371.damagetaken = 0;
  _id_A051766A1EC54371 setentityowner(owner);
  _id_A051766A1EC54371 setotherent(owner);
  _id_A051766A1EC54371 setCanDamage(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    _id_A051766A1EC54371[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Ground", owner);

  _id_A051766A1EC54371 _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_7558C2019A377BD9);
  _id_A051766A1EC54371 scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_4D7B7570DDAB816D);
  _id_A051766A1EC54371 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_CAE5C83763020435);
  _id_A051766A1EC54371 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_1D0735B9C8B14634);
  _id_A051766A1EC54371 _id_49197CD063A740EA(::_id_9537AB94DAB9A1C0);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(_id_A051766A1EC54371);
  }

  if(!isDefined(level._id_586A6D61ABD25D66[_id_A051766A1EC54371.team][_id_A051766A1EC54371.ownerid]))
    level._id_586A6D61ABD25D66[_id_A051766A1EC54371.team][_id_A051766A1EC54371.ownerid] = [];

  level._id_586A6D61ABD25D66[_id_A051766A1EC54371.team][_id_A051766A1EC54371.ownerid][level._id_586A6D61ABD25D66[_id_A051766A1EC54371.team][_id_A051766A1EC54371.ownerid].size] = _id_A051766A1EC54371;
  _id_A051766A1EC54371 thread _id_FD6A27936D8258F4();
}

_id_4D7B7570DDAB816D(data) {
  if(isDefined(self) && !istrue(self._id_3621873DCCBDE4B5) || getdvarint("dvar_58254C61DE76BFFE", 0)) {
    self.isdisabled = 1;
    self setscriptablepartstate("empd", "active", 0);
  }
}

_id_CAE5C83763020435(data) {
  if(isDefined(self) && !istrue(self._id_3621873DCCBDE4B5) || getdvarint("dvar_58254C61DE76BFFE", 0))
    data.attacker thread _id_098B53A7358927D9::_id_E800498086E36C29("stat_D6C7EAE0F9540805");
}

_id_1D0735B9C8B14634(data) {
  if(isDefined(self) || !istrue(self._id_3621873DCCBDE4B5)) {
    self.isdisabled = undefined;
    self setscriptablepartstate("empd", "neutral", 0);
  }
}

_id_7558C2019A377BD9(data) {
  if(istrue(self._id_3621873DCCBDE4B5))
    return 0;

  if(isDefined(data.attacker))
    self setentityowner(data.attacker);

  thread _id_BC3D8C3958483B5F("explode");
}

_id_B89726DBBC1C74F6() {
  thread _id_BC3D8C3958483B5F("destroy");
}

_id_BC3D8C3958483B5F(_id_8F7DDE4490939B87) {
  if(istrue(self._id_3621873DCCBDE4B5)) {
    return;
  }
  self notify("explode_cluster_spike");
  self._id_3621873DCCBDE4B5 = 1;

  if(isDefined(self.owner))
    self setentityowner(self.owner);

  self clearscriptabledamageowner();
  self setscriptablepartstate(_id_8F7DDE4490939B87, "on", 0);
  thread _id_B53E15638CE719B2(1);
}

_id_B53E15638CE719B2(_id_4FAC8B8CE36E09F1) {
  level endon("game_ended");
  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(isDefined(self.owner)) {
    if(!istrue(self.recordedgameendstats)) {
      _id_72420303B4CDEB66 = _id_A868FA9DC357D535(self.owner);

      if(_id_72420303B4CDEB66.size == 1)
        thread _id_E01D9B3577538A73(0.3);
    }
  }

  if(isDefined(self.headiconid))
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);

  _id_AF89C60A5EFC79B0 = self.team;
  _id_DE04C74E0C2B2F65 = self.ownerid;
  level._id_586A6D61ABD25D66[_id_AF89C60A5EFC79B0][_id_DE04C74E0C2B2F65] = scripts\engine\utility::array_remove(level._id_586A6D61ABD25D66[_id_AF89C60A5EFC79B0][_id_DE04C74E0C2B2F65], self);
  level notify("removed_" + self._id_3ECC59AE19D41B04);
  wait 1;

  if(isDefined(self))
    self delete();
}

_id_E01D9B3577538A73(delay) {
  level endon("game_ended");
  self.owner endon("disconnect");
  wait(delay);
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

_id_723AA6329B751BC7(victim, inflictor, objweapon, meansofdeath, damage) {
  if(!isDefined(inflictor))
    return damage;

  if(meansofdeath != "MOD_EXPLOSIVE")
    return damage;

  if(!isDefined(objweapon))
    return damage;

  if(isnullweapon(objweapon))
    return damage;

  if(objweapon.basename != "cluster_spike_mp" && objweapon.basename != "cluster_spike_proj_mp")
    return damage;

  if(isDefined(victim) && isPlayer(victim)) {
    _id_12C56D891BFE7EBF = victim.maxhealth * 0.5;
    currenthealth = victim.health;

    if(currenthealth >= _id_12C56D891BFE7EBF && damage >= _id_12C56D891BFE7EBF) {
      if(damage >= currenthealth)
        damage = victim.maxhealth - 1;
    }
  }

  return damage;
}

_id_A868FA9DC357D535(owner) {
  return level._id_586A6D61ABD25D66[owner.team]["ownerID_" + owner getxuid()];
}

_id_31BE5250A8292B48() {
  self endon("explode_cluster_spike");
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

_id_76424B83E8ECCB98() {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread _id_BC3D8C3958483B5F("destroy");
}

_id_61AD64F233F8040A() {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  wait(self.lifetime);
  thread _id_BC3D8C3958483B5F("explode");
}

_id_FD6A27936D8258F4() {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  _id_AF89C60A5EFC79B0 = self.team;
  _id_DE04C74E0C2B2F65 = self.ownerid;
  _id_3ECC59AE19D41B04 = self._id_3ECC59AE19D41B04;
  thread _id_2F8D16EBD367C6E7(_id_3ECC59AE19D41B04);
  _id_9B932CAC8B93D4E0 = self.lifetime + 5;
  result = level scripts\engine\utility::waittill_any_timeout_1(_id_9B932CAC8B93D4E0, "removed_" + _id_3ECC59AE19D41B04);

  if(!isDefined(self))
    level._id_586A6D61ABD25D66[_id_AF89C60A5EFC79B0][_id_DE04C74E0C2B2F65] = scripts\engine\utility::array_removeundefined(level._id_586A6D61ABD25D66[_id_AF89C60A5EFC79B0][_id_DE04C74E0C2B2F65]);
  else
    _id_B53E15638CE719B2(0);

  level notify("removed_" + _id_3ECC59AE19D41B04);
}

_id_2F8D16EBD367C6E7(_id_3ECC59AE19D41B04) {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + _id_3ECC59AE19D41B04);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    waitframe();
  }

  level notify("removed_" + _id_3ECC59AE19D41B04);
}

_id_FB3D88B9443DD19C() {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(isDefined(level.teambased) && isPlayer(attacker) && attacker.team == self.team && attacker != self.owner) {
      continue;
    }
    self.wasdamaged = 1;
    _id_702BFC08FABD86CB = damage;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage"))
      _id_702BFC08FABD86CB = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, smeansofdeath, damage, self.maxhealth, 1, 1, 1, 1, 1);

    if(isPlayer(attacker)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
        attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](attacker, objweapon, self, smeansofdeath, _id_702BFC08FABD86CB);

    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
        attacker.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
    }

    self.damagetaken = self.damagetaken + _id_702BFC08FABD86CB;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(self.currenthealth <= 0) {
      if(isDefined(objweapon) && (objweapon.basename == "cluster_spike_mp" || objweapon.basename == "cluster_spike_proj_mp")) {
        _id_72420303B4CDEB66 = _id_A868FA9DC357D535(self.owner);
        _id_5AD3FCA00533F5B2 = 0.25;

        foreach(mine in _id_72420303B4CDEB66) {
          if(!isDefined(mine)) {
            continue;
          }
          if(mine == self) {
            continue;
          }
          if(istrue(mine._id_5F06E12FC0F29EF4))
            _id_5AD3FCA00533F5B2 = _id_5AD3FCA00533F5B2 + randomfloatrange(0.25, 0.35);
        }

        self._id_5F06E12FC0F29EF4 = 1;
        wait(_id_5AD3FCA00533F5B2);
      }

      thread _id_BC3D8C3958483B5F("explode");
    }
  }
}

_id_31EDD36326BADA17(_id_632C2D9D36540B99) {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  _id_0BBF877AF13A55C2 = "on";

  if(istrue(self._id_4DCC736354EB9C7E))
    _id_0BBF877AF13A55C2 = "on_main";

  self setscriptablepartstate("arm", _id_0BBF877AF13A55C2, 0);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 10, undefined, undefined, undefined, undefined, 1);
  thread _id_76424B83E8ECCB98();
  thread _id_61AD64F233F8040A();
  thread _id_FB3D88B9443DD19C();

  for(;;) {
    self waittill("trigger_grenade", _id_F9B008542CD70A05);

    if(istrue(self.isdisabled)) {
      continue;
    }
    self setscriptablepartstate("trigger", "on", 0);

    if(!istrue(_id_632C2D9D36540B99))
      wait 0.35;

    foreach(ent in _id_F9B008542CD70A05) {
      if(!isDefined(ent) || !isDefined(ent.classname)) {
        continue;
      }
      if(ent.classname == "script_vehicle") {
        _id_747605E7F0F10E41 = 1;

        if(ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }
        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
          continue;
        }
        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
        break;
      }

      if(ent.classname == "agent" || ent.classname == "player") {
        if(!isPlayer(ent) && !isagent(ent)) {
          continue;
        }
        if(isDefined(ent.vehicle)) {
          continue;
        }
        if(!ent scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        _id_94D34A6FFA8CD741();
        break;
      }
    }
  }
}

_id_6360197CFE54C18E(_id_2E48D17044BB4927) {
  _id_51099435AFE9D978 = self.owner;
  _id_51099435AFE9D978 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    _id_51099435AFE9D978 waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(!isDefined(objweapon) || objweapon.basename != "cluster_spike_proj_mp") {
      continue;
    }
    _id_9B3DD3233F6F68A2 = undefined;

    if(!istrue(_id_2E48D17044BB4927))
      _id_9B3DD3233F6F68A2 = 1;

    _id_CC8B9EF243E90347(grenade, objweapon, self.streakinfo, self.owner, _id_9B3DD3233F6F68A2);
    grenade thread _id_DAFF421C657D09CA(_id_2E48D17044BB4927);
    break;
  }
}

_id_DAFF421C657D09CA(_id_F92DD6CE11A58204) {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);

  if(istrue(_id_F92DD6CE11A58204))
    self waittill("missile_stuck");

  thread _id_31EDD36326BADA17();
}

_id_BDDE9FCC527C241B(_id_2E48D17044BB4927) {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  thread _id_E328684112FE03C5(_id_2E48D17044BB4927);
  _id_632C2D9D36540B99 = 0;

  if(!istrue(_id_2E48D17044BB4927))
    _id_632C2D9D36540B99 = 1;

  self waittill("released_sub_projectiles");
  thread _id_31EDD36326BADA17(_id_632C2D9D36540B99);
}

_id_E328684112FE03C5(_id_2E48D17044BB4927) {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self._id_3ECC59AE19D41B04);
  fusetime = 150;

  if(!istrue(_id_2E48D17044BB4927))
    self waittill("trigger_sub_projectiles");
  else
    wait 0.75;

  self setscriptablepartstate("release", "on", 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_C177861566D2AE10 = "0" + (_id_AC0E594AC96AA3A8 + 1);
    _id_F8CE69608B17B7CC = self gettagorigin("j_disc_" + _id_C177861566D2AE10);
    _id_60FD2AF6CAF85A21 = vectorNormalize(_id_F8CE69608B17B7CC - self.origin);
    _id_6EE5FB06719473E2 = _id_F8CE69608B17B7CC + _id_60FD2AF6CAF85A21 * 2;
    _id_CC7D1FABF80C7DF5 = _id_F8CE69608B17B7CC + anglestoup(self.angles) * 200 + _id_60FD2AF6CAF85A21 * 300;
    _id_7331D469160F6A41 = _id_CC7D1FABF80C7DF5 - _id_F8CE69608B17B7CC;

    if(isDefined(self) && isDefined(self.owner)) {
      thread _id_6360197CFE54C18E(_id_2E48D17044BB4927);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "_launchGrenade"))
        self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "_launchGrenade")]]("cluster_spike_proj_mp", _id_6EE5FB06719473E2, _id_7331D469160F6A41, fusetime);
    }

    wait 0.05;
  }

  self notify("released_sub_projectiles");
}

_id_94D34A6FFA8CD741() {
  thread _id_BC3D8C3958483B5F("explode");
}

_id_7FB05833DB79CF2D(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("explode_cluster_spike");
  self._id_3621873DCCBDE4B5 = 1;
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("explode", "on", 0);
  wait 0.2;
  mine thread _id_0FF273DE0F0971AD(vehicle);
}

_id_0FF273DE0F0971AD(vehicle) {
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("explode", "off", 0);
  thread _id_B53E15638CE719B2(1);

  if(!isDefined(vehicle)) {
    return;
  }
  vehicle dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object);
  ignoredamageid = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "non_player_add_ignore_damage_signature"))
    ignoredamageid = vehicle[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "non_player_add_ignore_damage_signature")]](self.owner, self.weapon_object, self, "MOD_EXPLOSIVE");

  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "non_player_remove_ignore_damage_signature")) {
    if(isDefined(vehicle) && isDefined(ignoredamageid))
      vehicle[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "non_player_remove_ignore_damage_signature")]](ignoredamageid);
  }
}

_id_60DFACE26506153E(weaponref) {
  return weaponref == "cluster_spike_proj_mp" || weaponref == "cluster_spike_mp";
}

_id_9537AB94DAB9A1C0() {
  thread _id_BC3D8C3958483B5F("destroy");
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}