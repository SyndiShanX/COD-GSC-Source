/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58264.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8F770E0752D834A2F69B9BAF8F16EA67", ::_id_13E28, undefined, ::_id_13E0F);
  init_fx();
}

init_fx() {
  level._effect["_encstr_B6671CCECCE1AFAC870763F6CDD2B32BF598DE77F5CA0F0736DE9B2DDBDC"] = loadfx("_encstr_856C30EC99C3CBD2EEC15E77B20BE0F2AF950F838DBD97CE330FBEACE1838DDBFAAC871C36BDDC2D9D56BE31EDEE5C9D9987");
}

_id_13E28(var_0) {
  var_1 = self;
  var_2 = var_1 _id_13E29(var_0);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");
  }

  return var_2;
}

_id_13E0F() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8F770E0752D834A2F69B9BAF8F16EA67", self);
  var_0._id_133CE = 1;
  return _id_13E29(var_0, 1);
}

get_actor_stance() {
  if(self hasweapon("_encstr_A2C219E404B131BBCD290B06C0FA70CAC79E6CDBE5AD8AE74ED013"))
    return 0;

  if(self isonladder())
    return 0;

  if(self ismantling())
    return 0;

  if(!scripts\common\utility::is_weapon_switch_allowed())
    return 0;

  if(scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  if(istrue(self.usingascender))
    return 0;

  return 1;
}

_id_13E29(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!get_actor_stance())
    return 0;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  var_2 = laststandrevivedecayscale();

  if(!istrue(var_2))
    return var_2;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_B47106834B35B9CF" + var_0.streakname, self);

  return 1;
}

laststandrevivedecayscale() {
  scripts\common\utility::brjugg_droponplayerdeath(0, "_encstr_8F770E0752D834A2F69B9BAF8F16EA67");
  thread move_arena_startspawns();
  var_0 = scripts\mp\utility\weapon::getweaponrootname("_encstr_A2C219E404B131BBCD290B06C0FA70CAC79E6CDBE5AD8AE74ED013");
  var_1 = scripts\mp\class::fixcollision(var_0, undefined, undefined, -1, undefined, undefined, 0);
  self.chopper_boss_combat = 1;

  if(self hasweapon(var_1))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  self giveweapon(var_1);

  if(isDefined(self.spawnx1stashlootcache) && self.spawnx1stashlootcache) {
    self setweaponammoclip(var_1, 1);
    self setweaponammostock(var_1, self.spawnx1stashlootcache - 1);
    self.spawnx1stashlootcache = undefined;
  } else {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
    self setweaponammostock(var_1, weaponstartammo(var_1, 0));
  }

  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1);
  scripts\mp\weapons::fixupplayerweapons(self, var_0);
  self.spawnx1stashlootcache = self getammocount(var_1);
  self notify("_encstr_BEFF1703B0DAA00877226309691B30C0B905B3AB5902884573");
  thread _id_144F9(var_1, "_encstr_88A80D134FDE4B2FA8A7CBBF2B45DD");
  thread _id_144F9(var_1, "_encstr_B8E20FBB59851CF6E6AF91E4DBC107B232");
  thread _id_14495(var_1);
  thread _id_144FB(var_1);
  thread _id_144F2(var_1);
  thread _id_14490(var_1);
  return 1;
}

move_arena_startspawns() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.3;

  if(isDefined(self))
    scripts\common\utility::brjugg_droponplayerdeath(1, "_encstr_8F770E0752D834A2F69B9BAF8F16EA67");
}

_id_144F9(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B47B09BFB05BEB4F9647E0");

  for(;;) {
    self waittill(var_1, var_2);

    if(var_2 == var_0)
      _id_138FB(var_0);

    waitframe();
  }
}

_id_14495(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88AD22120B5D4B4FC9E9DB8B2F531C2D3DCF4EADA3B783DB502AB5D8198381601331E223");
  self waittill("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");
  self notify("_encstr_B47B09BFB05BEB4F9647E0");
  thread handletrex();
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_0);
  thread mlgpoint();
}

_id_144FB(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B47B09BFB05BEB4F9647E0");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);

    if(self hasweapon(var_0) && var_1 != var_0) {
      if(var_1.basename == "_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73") {
        self.debug_printcode = self.lastdroppableweaponobj;
        scripts\mp\weapons::_id_1316B(var_0);
      } else if(!self isonladder() && !(var_1.ismelee && self ismeleeing()))
        _id_138FB(var_0);

      continue;
    }

    if(var_1 == var_0 && isDefined(self.debug_printcode)) {
      scripts\mp\weapons::_id_1316B(self.debug_printcode);
      self.debug_printcode = undefined;
    }
  }
}

_id_144F2(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B47B09BFB05BEB4F9647E0");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");

    if(!self hasweapon(var_0)) {
      self notify("_encstr_88AD22120B5D4B4FC9E9DB8B2F531C2D3DCF4EADA3B783DB502AB5D8198381601331E223");
      thread handletrex();
      return;
    }

    self.spawnx1stashlootcache = self getammocount(var_0);

    if(self.spawnx1stashlootcache == 0) {
      self.spawnx1stashlootcache = undefined;
      thread handletrex();
      thread _id_144EE(var_0);
      self notify("_encstr_88AD22120B5D4B4FC9E9DB8B2F531C2D3DCF4EADA3B783DB502AB5D8198381601331E223");
      self notify("_encstr_B47B09BFB05BEB4F9647E0");
    }

    waitframe();
  }
}

_id_144EE(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);
  self takeweapon(var_0);
}

_id_14490(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A39616DFEB0736E89BDAB9A9303B59B0172FEE0BF12AF27B");

  for(;;) {
    self waittill("_encstr_8C81147B587894AAE9A8974C26CF731F6030ABFF9013", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_5 == var_0) {
      var_10 = vectortoangles(var_3);
      var_11 = anglesToForward(var_10);
      var_12 = anglestoright(var_10);
      var_13 = anglestoup(var_10);
      var_14 = playFX(scripts\engine\utility::getfx("_encstr_B6671CCECCE1AFAC870763F6CDD2B32BF598DE77F5CA0F0736DE9B2DDBDC"), var_7, var_11, var_13);
      var_14 unmarkkeyframedmover(1);
      playsoundatpos(var_7, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
      earthquake(0.45, 0.7, var_7, 800);
      playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_7);
      physicsexplosionsphere(var_7, 800, 0, 1);
    }
  }
}

handletrex() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BEFF1703B0DAA00877226309691B30C0B905B3AB5902884573");
  self endon("_encstr_A39616DFEB0736E89BDAB9A9303B59B0172FEE0BF12AF27B");
  self.chopper_boss_combat = 0;
  wait 6;
  self notify("_encstr_A39616DFEB0736E89BDAB9A9303B59B0172FEE0BF12AF27B");
}

_id_138FB(var_0) {
  self takeweapon(var_0);

  if(isDefined(self.spawnx1stashlootcache) && self.spawnx1stashlootcache != 0) {
    self notify("_encstr_88AD22120B5D4B4FC9E9DB8B2F531C2D3DCF4EADA3B783DB502AB5D8198381601331E223");
    playerorigin();
  }

  thread handletrex();
  self notify("_encstr_B47B09BFB05BEB4F9647E0");
}

mlgpoint() {
  var_0 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, self.origin, self.angles, self);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_8DCA2045F2657BC0A399087092FB8690BA7DCB2FB78FC3972B7203785BB7A8F815C7", var_1);
}

playerorigin() {
  var_0 = level.gametype == "_encstr_B607038AAB";

  if(var_0)
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar("_encstr_8F770E0752D834A2F69B9BAF8F16EA67", 1, 0);
  else {
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    scripts\mp\killstreaks\killstreaks::awardkillstreak("_encstr_8F770E0752D834A2F69B9BAF8F16EA67", "_encstr_8261067B1D34AC27");
  }
}