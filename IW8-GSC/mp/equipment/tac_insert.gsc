/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\tac_insert.gsc
***********************************************/

tacinsert_init() {
  level._id_13A10 = [];
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::_id_13A0A);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    level thread _id_13A02();
}

_id_13A0A(var_0) {
  foreach(var_2 in level._id_13A10) {
    var_2 _id_13A0F(var_0);
    var_2 _id_13A0E(var_0);
  }
}

_id_13A02() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = level._id_13A10;
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(istrue(var_3.isdestroyed)) {
        continue;
      }
      if(!isDefined(var_3.owner)) {
        continue;
      }
      var_4 = distance2dsquared(var_3.origin, var_3.owner.origin);

      if(var_4 >= 144000000) {
        var_3.owner thread scripts\mp\hud_message::showsplash("_encstr_96701B6BB0D19F5215768F42DD4F9A6938404FCBC08E0C7A7F1857BEC6");
        var_3 tacinsert_destroy(undefined, 0);
      }

      var_1++;

      if(var_1 >= 5) {
        var_1 = 0;
        waitframe();
      }
    }

    waitframe();
  }
}

tacinsert_set(var_0, var_1) {
  thread _id_13A09();
}

tacinsert_unset(var_0, var_1) {
  self notify("_encstr_925B116240F9F99FC8287164B0B3A3B47350EA");
}

_id_13A09() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_925B116240F9F99FC8287164B0B3A3B47350EA");
  self.tispawnposition = [];

  for(;;) {
    tacinsert_updatespawnposition();
    var_0 = self getheldoffhand();
    var_1 = var_0.basename == "_encstr_B635099C3C8FEDFB88E9EB";
    var_2 = scripts\engine\utility::ter_op(var_1, 0.05, 1.0);
    scripts\engine\utility::_id_143B9(var_2, "_encstr_883711F0997028D145335138C3FA58461872C3");
  }
}

_id_13A08(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_925B116240F9F99FC8287164B0B3A3B47350EA");
  var_0 endon("_encstr_BE65113F85DD58E7402BDCE36FB99ABC90C31D");

  for(;;) {
    wait 1.0;
    var_0 _id_13683(self, 1);
  }
}

tacinsert_updatespawnposition() {
  var_0 = self.origin;
  var_1 = tacinsert_isvalidspawnposition(var_0);

  if(istrue(var_1))
    _id_13A01(var_0);
}

tacinsert_isvalidspawnposition(var_0) {
  var_1 = var_0 + (0, 0, 3);

  if(!canspawn(var_1))
    return 0;

  if(scripts\mp\outofbounds::istouchingoobtrigger())
    return 0;

  if(!self isonground())
    return 0;

  waitframe();

  if(!self isonground())
    return 0;

  return 1;
}

_id_13A01(var_0) {
  if(isDefined(self.tispawnposition[0]) && self.tispawnposition[0] == var_0) {
    return;
  }
  self.tispawnposition[1] = self.tispawnposition[0];
  self.tispawnposition[0] = var_0;
}

_id_13A07() {
  if(isDefined(self.tispawnposition)) {
    if(isDefined(self.tispawnposition[1]))
      return self.tispawnposition[1];
    else if(isDefined(self.tispawnposition[0]))
      return self.tispawnposition[0];
  }

  return undefined;
}

deletetacinsert() {
  tacinsert_destroy();
}

tacinsert_used(var_0) {
  var_0 delete();
  var_1 = _id_13A07();

  if(!isDefined(var_1)) {
    scripts\mp\hud_message::showerrormessage("_encstr_8EA51B0CA11EB59146CF1B1D2B3FF17D370805D4E8C7CD29AAE413FF25");
    thread _id_13A0C();
    return 0;
  }

  var_2 = distancesquared(self.origin, var_1);

  if(var_2 >= 14400) {
    scripts\mp\hud_message::showerrormessage("_encstr_8EA51B0CA11EB59146CF1B1D2B3FF17D370805D4E8C7CD29AAE413FF25");
    thread _id_13A0C();
    return 0;
  }

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    scripts\mp\hud_message::showerrormessage("_encstr_8EA51B0CA11EB59146CF1B1D2B3FF17D370805D4E8C7CD29AAE413FF25");
    thread _id_13A0C();
    return 0;
  }

  var_3 = var_1 + (0, 0, 16);
  var_4 = var_1 + (0, 0, -16);

  if(!_id_13A03(var_0, var_3, var_4)) {
    scripts\mp\hud_message::showerrormessage("_encstr_8EA51B0CA11EB59146CF1B1D2B3FF17D370805D4E8C7CD29AAE413FF25");
    thread _id_13A0C();
    return 0;
  }

  _id_13681(0, 0, 1);
  var_5 = [];
  var_5[0] = self;
  var_6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  var_7 = scripts\engine\trace::ray_trace_detail(var_3, var_4, var_5, var_6, 0);

  if(var_7["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A") {
    waitframe();
    var_8 = 14;
    var_7 = scripts\engine\trace::sphere_trace(var_3, var_4, var_8, var_5, var_6, 0);
  }

  if(var_7["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A") {
    scripts\mp\hud_message::showerrormessage("_encstr_8EA51B0CA11EB59146CF1B1D2B3FF17D370805D4E8C7CD29AAE413FF25");
    thread _id_13A0C();
    return 0;
  }

  var_9 = var_7["_encstr_820E07FAE8780B3A4C"];
  var_10 = var_7["_encstr_BD260953AA97E3F014279D"] + var_9 * (0, 0, 0.5);
  var_11 = anglesToForward(self.angles);
  var_12 = -1 * var_9;
  var_13 = scripts\engine\utility::flatten_vector(var_11, var_9);
  var_14 = vectorcross(var_13, var_12);
  var_15 = axistoangles(var_12, var_14, var_13);
  var_16 = self.angles;
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10);
  var_17.angles = var_15;
  var_17.team = self.team;
  var_17.owner = self;
  var_17 scripts\cp_mp\ent_manager::registerspawn(3, ::deletetacinsert);
  var_17 setModel("_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5");
  var_17 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_930B07BB1B6B3854FF", 0);
  var_17.issuper = isDefined(self.super) && self.super.staticdata.weapon == "_encstr_B635099C3C8FEDFB88E9EB";
  var_17.superid = level.superglobals.staticsuperdata["_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1"].id;
  var_17 thread tacinsert_setupandwaitfordeath(self);
  var_17 thread _id_13A04();
  var_17 setotherent(self);
  var_17.weapon_name = "_encstr_86EE1373632E69F1E0E3DFE2FB911473F3F7B78FED";
  var_18 = var_7["_encstr_850E077B0BF30318B9"];

  if(isDefined(var_18) && (_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_18) || _encstr_B61624E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247681AABB108A76E69176AD678FCF23A::triggereliminatedoverlay(var_18))) {
    var_17 linkTo(var_18);
    var_19 = getdvarint("_encstr_B6D228E3C83519438B10CCD11676371D9F407B0BC1F3CDDBC0E0A7F7B7F8DF23ED78C312596D068B38DD", 1);

    if(var_19)
      var_17 thread _id_13A08(self);
  }

  var_17 scripts\mp\sentientpoolmanager::registersentient("_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D", self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_88250F5BF383F1AD5F99E06B4D3F41EBC0");
  scripts\mp\weapons::onequipmentplanted(var_17, "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A", ::tacinsert_destroy);
  var_20 = scripts\mp\utility\game::getgametype() == "_encstr_A54F06D32A2F0498";
  thread scripts\mp\weapons::monitordisownedequipment(self, var_17, var_20);
  var_17 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::tacinsert_empapplied);
  _id_13684(var_1, var_16, var_17, 1);
  var_21 = var_17 getentitynumber();
  level._id_13A10[var_21] = var_17;

  if(var_17.issuper && isDefined(level._id_13A06))
    self[[level._id_13A06]]();

  return 1;
}

tacinsert_setupandwaitfordeath(var_0) {
  self.headicon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0);
  thread tacinsert_damagelistener(var_0);
  thread _id_13A05(var_0);

  if(!self.issuper)
    thread _id_13A0B(var_0);
}

tacinsert_damagelistener(var_0) {
  scripts\mp\damage::monitordamage(10, "_encstr_A2FB098A2035874AB0F358", ::tacinsert_modifydamage, ::tacinsert_handledeathdamage, 1);
}

tacinsert_modifydamage(var_0) {
  var_1 = var_0.objweapon;
  var_2 = var_0.meansofdeath;
  return scripts\mp\damage::handlemeleedamage(var_1, var_2);
}

tacinsert_handledeathdamage(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && var_1 != self.owner)
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8ADE0D9C40CF7303B881023803C711", undefined, undefined, self.origin);

  thread tacinsert_destroy(var_1, 1);
}

_id_13A0B(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_12357 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self._id_12357 makeusable();
  self._id_12357 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self._id_12357 setHintString(&"_encstr_A233132BF3419FB19416C430CAA1E95A595B97916F");
  self._id_12357 linkTo(self);

  foreach(var_2 in level.players)
  _id_13A0F(var_2);

  for(;;) {
    self._id_12357 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_2 playSound("_encstr_81AB1D61BC027FE33BE8AB72C013DDC780A8E3E556D337AFF90BD38A3949D3");
    var_2 scripts\mp\equipment::giveequipment("_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A", "_encstr_AC8F0AE74163F85AAA380AD8");
    thread tacinsert_destroy(var_0, 0, 0, 1);
  }
}

_id_13A0F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self) || !isDefined(self._id_12357)) {
    return;
  }
  if(istrue(self.isdestroyed)) {
    return;
  }
  var_1 = isDefined(self.owner) && var_0 == self.owner;

  if(var_1)
    self._id_12357 enableplayeruse(var_0);
  else
    self._id_12357 disableplayeruse(var_0);
}

tacinsert_destroy(var_0, var_1, var_2, var_3) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  self.isdestroyed = 1;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;

  if(isDefined(self.owner)) {
    if(istrue(var_2)) {
      thread _id_13A00();
      self.owner scripts\mp\utility\stats::incpersstat("_encstr_AADE18CB1E2BE8FB62DFB9FBCB4B3593D4F450CD0A8008ACCA8F", 1);
      self.owner scripts\mp\supers::hide_plunderboxes("_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1");
      self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1", 1, var_0, var_1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 1, istrue(var_1));
    } else {
      self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1", 0, var_0, var_1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 0, istrue(var_1));
    }

    if(!istrue(var_2) && !istrue(var_3))
      self.owner thread _id_13A0D();

    self.owner.setspawnpoint = undefined;
  }

  self makeunusable();

  if(isDefined(self._id_12357))
    self._id_12357 delete();

  self notify("_encstr_AD75063D571AE108");

  if(!istrue(self._id_133E3))
    self setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(istrue(var_1)) {
    self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
    self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  }

  thread tacinsert_delayeddelete();
}

_id_13A0D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 0;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isinkillcam()) {
    var_0 = 1;
    waitframe();
  }

  if(var_0)
    wait 0.3;

  scripts\mp\damagefeedback::hudicontype("_encstr_A92A14EB473F6A6E6B20DBCBD9A15D73B966B5203D69");
}

_id_13A00() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  var_0 = self.owner;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 1.5;
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_AC97163C4F70C93B80E3E86DE3BF561B8150BF236FC8D09A");
}

_id_13A04() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread tacinsert_destroy(undefined, 0, 0, 1);
}

tacinsert_delayeddelete() {
  wait 1;
  var_0 = self getentitynumber();
  var_1 = self.killcament;
  var_2 = self.trigger;
  scripts\mp\weapons::cleanupequipment(var_0, var_1, var_2);
  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

_id_13A05(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self makeusable();
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setHintString(&"_encstr_99E91411EF212940940333788CC999D931A796F7B1F7");

  foreach(var_2 in level.players)
  _id_13A0E(var_2);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_2 notify("_encstr_83C4148C2B9BA34EEDCBB2C8F52D73CDCA4E1DB4B7CD", var_0);
    var_2 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    tacinsert_givepointsfordeath(var_2);
    thread tacinsert_destroy(var_2, 1);
  }
}

_id_13A0E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isdestroyed)) {
    return;
  }
  var_1 = scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0);

  if(var_1)
    self enableplayeruse(var_0);
  else
    self disableplayeruse(var_0);
}

tacinsert_empapplied(var_0) {
  var_1 = var_0.attacker;
  tacinsert_givepointsfordeath(var_1);

  if(isDefined(self.owner) && var_0.attacker != self.owner)
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8ADE0D9C40CF7303B881023803C711", undefined, undefined, self.origin);

  thread tacinsert_destroy(var_1, 1);
}

tacinsert_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\killstreaks\killstreaks::givescorefordestroyedtacinsert();
    var_0 thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8ADE0D9C40CF7303B881023803C711", undefined, undefined, self.origin);
  }
}

_id_13A03(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = self;
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);
  var_6 = scripts\engine\trace::sphere_trace(var_1, var_2, 20, var_4, var_5, 1);

  if(isDefined(var_6)) {
    if(isDefined(var_6["_encstr_AA1C0886968EA32FE056"]) && var_6["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
      var_7 = var_6["_encstr_8BCA0C2BFD504F333E6D7513637B"];

      if(isDefined(var_7) && var_7 != "_encstr_9B0C0EE65DE4991DE53856AFB97BE6B2") {
        var_7 = var_6["_encstr_8BCA0C2BFD504F333E6D7513637B"];

        if(var_7 == "_encstr_ABFE140A7B40B68B7B212FCF67A982FBE0864216F02B")
          var_3 = 0;
      }

      var_8 = var_6["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_8)) {
        if(var_8 scripts\cp_mp\vehicles\vehicle::isvehicle() && !_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_8))
          var_3 = 0;

        var_9 = getdvarint("_encstr_B6D228E3C83519438B10CCD11676371D9F407B0BC1F3CDDBC0E0A7F7B7F8DF23ED78C312596D068B38DD", 1);

        if(!var_9 && (_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_8) || _encstr_B61624E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247681AABB108A76E69176AD678FCF23A::triggereliminatedoverlay(var_8)))
          var_3 = 0;

        if(isDefined(var_8.classname)) {
          switch (var_8.classname) {
            case "_encstr_8C8D08671D451291C849":
            case "_encstr_97710C6B2DCD1BAF3AD54E4E598E":
              var_3 = 0;
              break;
            case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
              if(isDefined(var_8.crate))
                var_3 = 0;

              break;
          }
        }
      }
    }
  }

  return istrue(var_3);
}

_id_13A0C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_A76C169BD827AF3AB036FAA5E63795C9477DC956CC57DC19", 1);

  if(var_0 == 0) {
    return;
  }
  if(istrue(level.unset_relic_laststandmelee)) {
    if(level.infectedtactical == "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A")
      scripts\mp\equipment::giveequipment(level.infectedtactical, "_encstr_AC8F0AE74163F85AAA380AD8");

    var_1 = scripts\engine\utility::_id_143B9(5, "_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");

    if(isDefined(var_1) && var_1 == "_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E") {
      thread scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
      return;
    }
  } else {
    self waittill("_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");
    thread scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  }
}

_id_13684(var_0, var_1, var_2, var_3) {
  _id_13681();
  var_4 = undefined;

  if(isDefined(var_2))
    var_4 = var_2;
  else
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);

  var_4.playerspawnpos = var_0;
  var_4.playerspawnangles = var_1;
  var_4.notti = !istrue(var_3);
  var_4.issuper = isDefined(var_2) && istrue(var_2.issuper);
  self.setspawnpoint = var_4;
}

_id_13681(var_0, var_1, var_2) {
  if(isDefined(self.setspawnpoint)) {
    if(istrue(self.setspawnpoint.notti))
      self.setspawnpoint delete();
    else
      self.setspawnpoint tacinsert_destroy(undefined, var_0, var_1, var_2);
  }
}

_id_13683(var_0, var_1) {
  if(!isDefined(var_0)) {
    self notify("_encstr_BE65113F85DD58E7402BDCE36FB99ABC90C31D");
    return;
  }

  var_2 = var_0;
  var_2.playerspawnpos = var_0.origin;
  var_2.playerspawnangles = var_0.angles;
  var_2.notti = !istrue(var_1);
  var_2.issuper = isDefined(var_0) && istrue(var_0.issuper);
  self.setspawnpoint = var_2;
}