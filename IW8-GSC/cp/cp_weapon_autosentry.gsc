/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_weapon_autosentry.gsc
***********************************************/

init() {
  level._effect["_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"] = loadfx("_encstr_8BD02E489AE05F69B762A58845F3D89F0CA21018D33A73E14F8B981C26BB9E77773990B87AD2A1393F94A896353FC013");
  level._effect["_encstr_A716129F78982C7B93C83768475162C401417F1B"] = loadfx("_encstr_8E372AFD761072B6BFDB5908321B5898ECC4416F0CFA788F8723182BAA53383005339FCB98A2F8C09FBAE810");
  level._effect["_encstr_AB82109309907B327807B3A50F80BF8F4903"] = loadfx("_encstr_A11831EC333C7936DB27ACE5AD075E6DB4C6B1CD1DE495B05BB9799DCCE1D79BD9F5C816D60BCECAF54CD8166CB56EADEDDACA");
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"] = spawnStruct();
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].health = 999999;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].maxhealth = 300;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].burstmin = 5;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].burstmax = 10;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].pausemin = 0.15;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].pausemax = 0.25;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].sentrymodeon = "_encstr_9B1807D39B48FD93A3";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].timeout = 90.0;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].spinuptime = 1.0;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].overheattime = 15.0;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].cooldowntime = 0.2;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].fxtime = 0.3;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].weaponinfo = "_encstr_8BFF1A72E8D3FFF5899FE5E67908F8CF09E03A7A11B59BE1EADF15E0";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].modelbase = "_encstr_9B01171FFD20C82DEE6ED3F7FD7CE063E1573889F308E780E0";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].modelplacement = "_encstr_9B01171FFD20C82DEE6ED3F7FD7CE063E1573889F308E780E0";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].modelplacementfailed = "_encstr_A6D51FBBB258C1ED737D6E2BB91D2797EB8D340B2DDC765D9BBE7B26D4D7C95991";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].modeldestroyed = "_encstr_99AE21B0D8EAC8AF20F19393B2BB32B830902309AB4584100B1E60333F439812435FF1";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].hintstring = &"_encstr_A73417893937933E93A306168961BB5D2FD1CE7701F69491C2";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].headicon = 1;
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].vodestroyed = "_encstr_B465111B2BF53BEB32B8746D467B230523E8F2";
  level.sentrysettings["_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67"].issentient = 0;
}

test_ammo_crate(var_0) {
  var_0 thread watch_dpad();
  var_0 notify("_encstr_A13E0A73CAEEAFC1F6BBB2C9", "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67");
  scripts\cp\utility::set_crafted_inventory_item("_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67", ::give_crafted_sentry, var_0);
}

test_crafted_sentry(var_0) {
  var_0 thread watch_dpad();
  var_0 notify("_encstr_A13E0A73CAEEAFC1F6BBB2C9", "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67");
  scripts\cp\utility::set_crafted_inventory_item("_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67", ::give_crafted_sentry, var_0);
}

give_crafted_sentry(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("_encstr_A13E0A73CAEEAFC1F6BBB2C9", "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67");
  scripts\cp\utility::set_crafted_inventory_item("_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67", ::give_crafted_sentry, var_1);
}

watch_dpad() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A1F0E932BD6EDB3B2AF9B5937479C97");
  self notify("_encstr_AF3213D3968133BB1FB8939AA0C7B3E7DBF6504D2E");
  self endon("_encstr_AF3213D3968133BB1FB8939AA0C7B3E7DBF6504D2E");
  self notifyonplayercommand("_encstr_82430F72B539A4808DF3A10F85263922E8", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AD("_encstr_82430F72B539A4808DF3A10F85263922E8", "_encstr_BA8A1207EA368DDE5DA3AFB05B6BDBC64E2C1DB2");

    if(!isDefined(var_0)) {
      continue;
    }
    if(istrue(self.iscarrying)) {
      continue;
    }
    if(istrue(self.linked_to_coaster)) {
      continue;
    }
    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    switch (var_0) {
      case "_encstr_82430F72B539A4808DF3A10F85263922E8":
        thread givesentry("_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67");
        break;
      case "_encstr_BA8A1207EA368DDE5DA3AFB05B6BDBC64E2C1DB2":
        var_1 = scripts\cp\cp_deployablebox::createboxforplayer("_encstr_992E0C97A7734F7BF29B66D945D0", self.origin + (0, 5, 5), self);
        var_2 = spawnStruct();
        var_2.linkparent = self;

        if(isDefined(var_2.linkparent) && isDefined(var_2.linkparent.model) && var_2.linkparent.model != "_encstr_B40101") {
          var_1.origin = var_2.linkparent.origin;
          var_3 = var_2.linkparent getlinkedparent();

          if(isDefined(var_3))
            var_2.linkparent = var_3;
          else
            var_2.linkparent = undefined;
        }

        var_2.deathoverridecallback = scripts\cp\cp_deployablebox::override_box_moving_platform_death;
        var_1.moving_platform = var_2.linkparent;
        var_1 setotherent(self);
        waitframe();
        var_1 thread scripts\cp\cp_deployablebox::box_setactive(undefined, undefined, undefined);

        if(isDefined(var_1) && var_1 scripts\cp\utility::touchingbadtrigger())
          var_1 notify("_encstr_AD75063D571AE108");

        break;
    }
  }
}

givesentry(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.last_sentry = var_0;
  scripts\cp\utility::clearlowermessage("_encstr_81730F371869D78B4F2CC73AAF6952BE53");
  var_1 = createsentryforplayer(var_0, self);
  self.itemtype = var_0;
  scripts\cp\utility::remove_player_perks();
  self.carriedsentry = var_1;
  var_2 = setcarryingsentry(var_1, 1);
  self.carriedsentry = undefined;
  thread scripts\cp\utility::wait_restore_player_perk();
  self.iscarrying = 0;

  if(isDefined(var_1))
    return 1;
  else
    return 0;
}

setcarryingsentry(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 sentry_setcarried(self, var_1);
  scripts\common\utility::allow_weapon(0);
  self notifyonplayercommand("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  self notifyonplayercommand("_encstr_83E71347076236A0FC41F30935CC5073295B33C5CB", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_B2BD14B0BA3577190B9F7E7DB633A30BD1336808C24B", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  self notifyonplayercommand("_encstr_AD28138AFAF8A7A7596F1381B083AD03663A9DD798", "_encstr_9A5C0E7471AFC0EA624018717863626F");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
    self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
    self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
  }

  for(;;) {
    var_2 = scripts\engine\utility::_id_143B1("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA", "_encstr_83E71347076236A0FC41F30935CC5073295B33C5CB", "_encstr_B2BD14B0BA3577190B9F7E7DB633A30BD1336808C24B", "_encstr_AD28138AFAF8A7A7596F1381B083AD03663A9DD798", "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003", "_encstr_88E60E81D22801BF13B062A8CBEBB31F");

    if(!isDefined(var_0)) {
      scripts\common\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_2))
      var_2 = "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003";

    if(var_2 == "_encstr_88E60E81D22801BF13B062A8CBEBB31F" || var_2 == "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003" || var_2 == "_encstr_83E71347076236A0FC41F30935CC5073295B33C5CB" || var_2 == "_encstr_B2BD14B0BA3577190B9F7E7DB633A30BD1336808C24B" || var_2 == "_encstr_AD28138AFAF8A7A7596F1381B083AD03663A9DD798") {
      if(!var_1 && (var_2 == "_encstr_88E60E81D22801BF13B062A8CBEBB31F" || var_2 == "_encstr_83E71347076236A0FC41F30935CC5073295B33C5CB" || var_2 == "_encstr_B2BD14B0BA3577190B9F7E7DB633A30BD1336808C24B" || var_2 == "_encstr_AD28138AFAF8A7A7596F1381B083AD03663A9DD798")) {
        continue;
      }
      self.bgivensentry = 0;
      scripts\common\utility::allow_weapon(1);
      var_0 sentry_setcancelled();

      if(var_2 != "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003") {} else if(var_1)
        scripts\cp\utility::remove_crafted_item_from_inventory(self);

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    if(var_1) {
      self notify("_encstr_8A1F0E932BD6EDB3B2AF9B5937479C97");
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    var_0 sentry_setplaced();
    scripts\common\utility::allow_weapon(1);
    return 1;
  }
}

createsentryforplayer(var_0, var_1) {
  var_2 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_1.origin, level.sentrysettings[var_0].weaponinfo);
  var_2.angles = var_1.angles;
  var_2.name = "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67";
  var_2 sentry_initsentry(var_0, var_1);
  return var_2;
}

sentry_initsentry(var_0, var_1) {
  self.sentrytype = var_0;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[self.sentrytype].modelbase);
  self.shouldsplash = 1;
  self setCanDamage(1);

  switch (var_0) {
    case "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67":
    default:
      self maketurretinoperable();
      self setleftarc(100);
      self setrightarc(100);
      self setbottomarc(90);
      self settoparc(60);
      self setconvergencetime(0.3, "_encstr_BD6506F36A2B46B0");
      self setconvergencetime(0.3, "_encstr_AF1904C7E3A4");
      self setconvergenceheightpercent(0.65);
      self setdefaultdroppitch(-89.0);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(var_1);
  thread sentry_handledeath(var_1);
  thread scripts\cp\utility::item_timeout(undefined, level.sentrysettings[self.sentrytype].timeout);
  thread sentry_handleuse();
  thread sentry_attacktargets();
  thread sentry_beepsounds();
}

sentry_handledeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);
  sentry_setinactive();
  self setdefaultdroppitch(40);

  if(isDefined(self.carriedby))
    self setsentrycarrier(undefined);

  self setsentryowner(undefined);
  self playSound("_encstr_86630F6EACB91DC92FFAAC1E1C8DBD8CAC");

  if(isDefined(self))
    thread sentry_deleteturret();
}

sentry_deleteturret() {
  self notify("_encstr_8C79155A3555CBE2BA61333FD011BC825FD5A39226FB03");
  self endon("_encstr_8C79155A3555CBE2BA61333FD011BC825FD5A39226FB03");

  if(isDefined(self.inuseby)) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("_encstr_990D093256B156D1B4B93B");
    self useby(self.inuseby);
    wait 1.0;
  } else {
    wait 1.5;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self, "_encstr_8E300878E04AE8B18198");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
    self playSound("_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
    wait 0.1;
    self notify("_encstr_990D093256B156D1B4B93B");
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self))
    self delete();
}

sentry_handleuse() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(var_0.iscarrying)) {
      continue;
    }
    var_0 setcarryingsentry(self, 0);
  }
}

sentry_setowner(var_0) {
  var_0.current_sentry = self;
  self.owner = var_0;
  self setsentryowner(self.owner);
  self.team = self.owner.team;
  self setturretteam(self.team);
  thread scripts\cp\utility::item_handleownerdisconnect("_encstr_9A1113D05DF5399A60EE5B83F065AC89E8F88D4593");
}

sentry_setplaced() {
  if(!istrue(self.firsttimeplace)) {
    self.owner scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("_encstr_9B1807D39B48FD93A3"));
    self.owner.bgivensentry = 0;
    var_0 = "_encstr_9B1807D39B48FD93A3";
    var_1 = level.crafting_table_data[var_0].metal;
    var_2 = 0;

    if(self.owner scripts\cp\cp_persistence::try_take_player_currency(var_1)) {}

    foreach(var_4 in level.players)
    var_4 thread scripts\cp\cp_hud_message::showsplash("_encstr_82CC0AE8F3211F51BB7C36AB", undefined, self.owner);

    self.firsttimeplace = 1;
    self.owner notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_9B1807D39B48FD93A3");
  }

  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getmode() == "_encstr_849007B268BD03DFD8")
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);

  self setsentrycarrier(undefined);
  sentry_makesolid();
  self.carriedby forceusehintoff();
  self.carriedby = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;

    if(level.sentrysettings[self.sentrytype].issentient)
      scripts\cp\utility::make_entity_sentient_cp(self.owner.team);

    self.owner notify("_encstr_86680B9BCAEEF5DCACE68E932F", self);
  }

  sentry_setactive();
  self playSound("_encstr_931A11C275C203937A69DC3F0D89CB65633853");
  self laseron();
  self notify("_encstr_B8B00782A191CB07D9");
}

sentry_setcancelled() {
  self.carriedby forceusehintoff();

  if(isDefined(self.owner))
    self.owner.iscarrying = 0;

  self delete();
}

sentry_setcarried(var_0, var_1) {
  self setModel(level.sentrysettings[self.sentrytype].modelplacement);
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self laseroff();
  sentry_makenotsolid();
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread updatesentryplacement(self, var_1);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  self freeentitysentient();
  self setdefaultdroppitch(-89.0);
  sentry_setinactive();
  self notify("_encstr_A93B084AF782F0DA4A04");
}

updatesentryplacement(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B8B00782A191CB07D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.canbeplaced = 1;
  var_2 = -1;

  for(;;) {
    var_0.canbeplaced = can_place_sentry(var_0);

    if(var_0.canbeplaced != var_2) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelplacement);

        if(!var_1)
          self forceusehinton(&"_encstr_B1C5161A7A9E41F5A19250C82A28249815A97914980A688A");
        else
          self forceusehinton(&"_encstr_8B6D2121501FBBC76329296881D18541AD5790B9B11D0B034E91110C090FE35015990D");
      } else {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelplacementfailed);
        self forceusehinton(&"_encstr_BE261DEB37D1BACF16F7D0A85F7FE3E529B70F73C321F547A54EB910C5A637");
      }
    }

    var_2 = var_0.canbeplaced;
    wait 0.05;
  }
}

can_place_sentry(var_0) {
  var_1 = self canplayerplacesentry();
  var_0.origin = var_1["_encstr_97FE07DE392D76D2CD"];
  var_0.angles = var_1["_encstr_A7610758E6CED8569B"];

  if(scripts\cp\utility::ent_is_near_equipment(var_0))
    return 0;

  return self isonground() && var_1["_encstr_9B7C07725D17A39473"] && abs(var_0.origin[2] - self.origin[2]) < 10;
}

sentry_setactive() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setHintString(level.sentrysettings[self.sentrytype].hintstring);
  self makeusable();
  self setusefov(120);
  self setuserange(96);

  switch (self.sentrytype) {
    case "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67":
      addtoturretlist(self getentitynumber());
      break;
  }
}

sentry_setinactive() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
  removefromturretlist();
}

sentry_makesolid() {
  self solid();
}

sentry_makenotsolid() {
  self notsolid();
}

addtoturretlist(var_0) {
  if(!scripts\engine\utility::array_contains(level.turrets, self)) {
    level.turrets = scripts\engine\utility::array_add_safe(level.turrets, self);

    if(level.turrets.size > 4) {
      if(isDefined(level.turrets[0]))
        level.turrets[0] notify("_encstr_AD75063D571AE108");
    }
  } else {}
}

removefromturretlist() {
  level.turrets = scripts\engine\utility::array_remove(level.turrets, self);
}

sentry_attacktargets() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F", "_encstr_A36A07BB6038639701");

    if(self isfiringturret()) {
      thread sentry_burstfirestart();
      continue;
    }

    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_targetlocksound() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_93961CC233AAC90D5A06F84B20EF4D3A235AF561F1E57826CAA7FD1F2543");
  wait 0.19;
  self playSound("_encstr_93961CC233AAC90D5A06F84B20EF4D3A235AF561F1E57826CAA7FD1F2543");
  wait 0.19;
  self playSound("_encstr_93961CC233AAC90D5A06F84B20EF4D3A235AF561F1E57826CAA7FD1F2543");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      self shootturret("_encstr_A14F0AE336178944BA076F41");
      self notify("_encstr_8FCA0D31D5D8C656E8BE664B4E2B19");
      self.heatlevel = self.heatlevel + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

sentry_burstfirestop() {
  self notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
}

turret_shotmonitor(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_913A1090E16F51DD23796783228188930353");
  var_1 = weaponfiretime(level.sentrysettings[var_0.sentrytype].weaponinfo);

  for(;;) {
    var_0 waittill("_encstr_BDBA0C4757C927CA477DCC5A4EAC");
    var_0 getturretowner() notify("_encstr_BDBA0C4757C927CA477DCC5A4EAC");
    var_0.heatlevel = var_0.heatlevel + var_1;
    var_0.cooldownwaittime = var_1;
  }
}

sentry_heatmonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1)
      wait(var_0);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67":
          playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
          break;
        default:
          break;
      }

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - 0.1);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    var_1 = self.heatlevel;
    wait 0.05;
  }
}

turret_heatmonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = level.sentrysettings[self.sentrytype].overheattime;

  for(;;) {
    if(self.heatlevel > var_0) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "_encstr_96730A1FE06EFCDB75AEC7BB":
          playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
          break;
        default:
          break;
      }

      while(self.heatlevel)
        wait 0.1;

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    wait 0.05;
  }
}

turret_coolmonitor() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
    }

    wait 0.05;
  }
}

playheatfx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");
  self endon("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"), self, "_encstr_A14F0AE336178944BA076F41");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

playsmokefx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
    wait 0.4;
  }
}

sentry_beepsounds() {
  self notify("_encstr_AA5112C3FA08BCC648DFBD8AA7A91167AB7547D8");
  self endon("_encstr_AA5112C3FA08BCC648DFBD8AA7A91167AB7547D8");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  }
}

remove_sentry_for_player(var_0) {
  var_0 notify("_encstr_8A1F0E932BD6EDB3B2AF9B5937479C97");
  var_0 notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");

  if(isDefined(var_0.current_sentry)) {
    level.turrets = scripts\engine\utility::array_remove(level.turrets, var_0.current_sentry);
    var_0 forceusehintoff();
    var_0.iscarrying = 0;
    var_0.current_sentry delete();
  }
}