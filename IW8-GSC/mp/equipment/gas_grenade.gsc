/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\gas_grenade.gsc
***********************************************/

gas_used(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\mp\utility\print::printgameaction("_encstr_92A61139C21F6C589FAE7B79CD9608BFFF1B90", var_0.owner);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);
  thread gas_watchexplode(var_0);
  var_0 detonate();
}

gas_watchexplode(var_0) {
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 = var_0.owner;
  var_0 waittill("_encstr_860808CB78E2984063BA", var_2);
  thread gas_createtrigger(var_2, var_1);
}

gas_onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 1;

  if(var_0.attacker == var_0.victim) {
    if(distancesquared(var_0.point, var_0.victim.origin) > 30625)
      return 0;
  } else {
    var_0.attacker scripts\mp\damage::combatrecordtacticalstat("_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F");
    var_0.attacker scripts\mp\utility\stats::incpersstat("_encstr_81C008CE0B6E214BD1B9", 1);

    if(var_0.victim scripts\mp\utility\perk::_hasperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D"))
      var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("_encstr_8D760DB8F77343CF62BEB7E3D01013", undefined, undefined, undefined, 1);
  }

  var_0.victim thread gas_applycough(var_0.attacker, 1);
  return 1;
}

gas_clear(var_0) {
  gas_clearspeedredux(var_0);
  gas_clearblur(var_0);
  gas_clearcough(var_0);

  if(isDefined(self.gastriggerstouching)) {
    foreach(var_2 in self.gastriggerstouching) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_2.playersintrigger[self getentitynumber()] = undefined;
    }
  }

  self.gastriggerstouching = undefined;
}

gas_createtrigger(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 7;

  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0 + (0, 0, int(-57.75 * var_3)), 0, int(256 * var_3), int(175 * var_3));
  var_4 scripts\cp_mp\ent_manager::registerspawn(1, ::sweepgas);
  var_5 = plunder_fiftypercent_music(var_0, var_3);

  if(isDefined(var_5))
    var_4 thread plunder_allowrepositoryuse(var_5, var_2);

  var_4 endon("_encstr_AD75063D571AE108");
  var_4.owner = var_1;

  if(isDefined(var_1))
    var_4.team = var_1.team;

  var_4.playersintrigger = [];
  var_4 thread gas_watchtriggerenter();
  var_4 thread gas_watchtriggerexit();
  wait(var_2);
  var_4 thread gas_destroytrigger();
}

plunder_fiftypercent_music(var_0, var_1) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
    return;
  }
  var_2 = createnavbadplacebybounds(var_0, (256 * var_1, 256 * var_1, 175 * var_1), (0, 0, 0));
  return var_2;
}

plunder_allowrepositoryuse(var_0, var_1) {
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8A490E5973475A8EE546CA63B23ACA46", var_1);
  destroynavobstacle(var_0);
}

sweepgas() {
  thread gas_destroytrigger();
}

gas_destroytrigger() {
  foreach(var_1 in self.playersintrigger) {
    if(!isDefined(var_1)) {
      continue;
    }
    self.playersintrigger[var_1 getentitynumber()] = undefined;
    var_1 thread gas_onexittrigger(self getentitynumber());
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

gas_onentertrigger(var_0) {
  if(!isDefined(self.gastriggerstouching))
    self.gastriggerstouching = [];

  var_1 = var_0 getentitynumber();
  self.gastriggerstouching[var_1] = var_0;
  self.lastgastouchtime = gettime();

  if(istrue(self.start_death_from_above_sequence))
    return var_1;

  if(self.gastriggerstouching.size >= 1) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }

  if(self.gastriggerstouching.size == 1) {
    thread gas_applycough(var_0.owner, 0);
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  }

  return var_1;
}

gas_onexittrigger(var_0) {
  if(!isDefined(self.gastriggerstouching)) {
    return;
  }
  self.gastriggerstouching[var_0] = undefined;
  self.lastgastouchtime = gettime();

  if(self.gastriggerstouching.size == 0) {
    thread gas_removespeedredux();
    thread gas_removeblur();
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
    self notify("_encstr_83C20BEC0B9BFAAC0F4B3ACA46");
  }
}

gas_watchtriggerenter() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(istrue(var_0.plunderlimit)) {
      continue;
    }
    if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.playersintrigger[var_0 getentitynumber()])) {
      continue;
    }
    if(level.teambased) {
      if(isDefined(self.owner) && isDefined(self.owner.team) && isDefined(var_0.team)) {
        if(var_0 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(var_0, self.owner))
          continue;
      } else if(isDefined(self.team) && scripts\mp\utility\player::isfriendly(self.team, var_0))
        continue;
    }

    self.playersintrigger[var_0 getentitynumber()] = var_0;
    var_0 thread gas_onentertrigger(self);
  }
}

gas_watchtriggerexit() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2, var_1 in self.playersintrigger) {
      if(!isDefined(var_1)) {
        self.playersintrigger[var_2] = undefined;
        continue;
      }

      if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_1 istouching(self)) {
        continue;
      }
      self.playersintrigger[var_1 getentitynumber()] = undefined;
      var_1 thread gas_onexittrigger(self getentitynumber());
    }

    waitframe();
  }
}

gas_applycough(var_0, var_1) {
  var_2 = scripts\mp\utility\perk::_hasperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D");
  var_3 = isDefined(var_0) && self == var_0;

  if(!var_3 && var_2) {
    return;
  }
  if(istrue(self.plunderlimit)) {
    return;
  }
  var_4 = 0;

  if(istrue(var_1)) {
    var_4 = 1;

    if(var_3)
      var_4 = 0;
  }

  if(!istrue(self.gascoughinprogress) || istrue(var_1))
    thread gas_queuecough(var_4);
}

gas_queuecough(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B6D10D9B037EB36365685937DB1DE57B386");
  self endon("_encstr_83C20BEC0B9BFAAC0F4B3ACA46");
  self notify("_encstr_8503103B0B9BD7E2AB95BAB2F58D7BABEC43");
  self endon("_encstr_8503103B0B9BD7E2AB95BAB2F58D7BABEC43");
  var_1 = gettime() + 1000;

  while(gas_coughisblocked())
    waitframe();

  if(var_0 && gettime() > var_1)
    var_0 = 0;

  var_2 = getdvarint("_encstr_8C191C2FF8ABB7BA134DA41AAEC773573001E3BB50C3D2E329E52A5E05E7", 1) == 1;

  if(var_2)
    thread gas_begincoughing(var_0);
  else {
    self endon("_encstr_AC791348F70386AD3287E378910AEF8B7FABB09847");
    self.gascoughinprogress = 1;

    if(var_0) {
      self playgestureviewmodel("_encstr_865816731B477F51DD7F51A30FF1CBB77A82E08EF54BC7F8");
      wait 3.33;
    } else {
      self playgestureviewmodel("_encstr_86AE1BA09BE04F196F73A8357DA763F71E63996872CB67B0AF84482057");
      wait 1.833;
    }

    self.gascoughinprogress = undefined;
  }
}

gas_begincoughing(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B6D10D9B037EB36365685937DB1DE57B386");
  self notify("_encstr_AC791348F70386AD3287E378910AEF8B7FABB09847");
  self endon("_encstr_AC791348F70386AD3287E378910AEF8B7FABB09847");

  if(!nullweapon(self getheldoffhand()))
    childthread gas_takeheldoffhand();

  self.gascoughinprogress = 1;

  if(self hasweapon(getcompleteweaponname("_encstr_A9DF13D2A84749177835EFE8D8E0C78F9998D9CA88")))
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A9DF13D2A84749177835EFE8D8E0C78F9998D9CA88");

  if(self hasweapon(getcompleteweaponname("_encstr_B13313F2779B9FC9EF4829601628BF79E833D120A9")))
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_B13313F2779B9FC9EF4829601628BF79E833D120A9");

  var_1 = scripts\engine\utility::ter_op(istrue(var_0), getcompleteweaponname("_encstr_B13313F2779B9FC9EF4829601628BF79E833D120A9"), getcompleteweaponname("_encstr_A9DF13D2A84749177835EFE8D8E0C78F9998D9CA88"));
  var_2 = scripts\engine\utility::ter_op(istrue(var_0), 3.33, 1.833);
  self giveandfireoffhand(var_1);
  childthread gas_monitorcoughweaponfired(var_1);
  childthread gas_monitorcoughweapontaken(var_1);
  childthread gas_monitorcoughduration(var_2);
  scripts\engine\utility::_id_143A6("_encstr_8EB8154F277F69C348AB2F1B7961B9E32FC89F44168B12", "_encstr_877F1524CEA32FE1E7574030370579A9CAB535BF24BA05", "_encstr_AF12121832FA97418F4D8C73148F2BB3631AE0D8");

  if(self hasweapon(var_1))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  self.gascoughinprogress = undefined;
}

gas_removecough(var_0) {
  self notify("_encstr_8503103B0B9BD7E2AB95BAB2F58D7BABEC43");
  self notify("_encstr_AC791348F70386AD3287E378910AEF8B7FABB09847");
  self.gascoughinprogress = undefined;

  if(!istrue(var_0)) {
    if(isDefined(self.gastakenweaponobj))
      gas_restoreheldoffhand();
  }
}

gas_clearcough(var_0) {
  self notify("_encstr_8503103B0B9BD7E2AB95BAB2F58D7BABEC43");
  self notify("_encstr_AC791348F70386AD3287E378910AEF8B7FABB09847");
  self.gascoughinprogress = undefined;

  if(!istrue(var_0)) {
    var_1 = getdvarint("_encstr_8C191C2FF8ABB7BA134DA41AAEC773573001E3BB50C3D2E329E52A5E05E7", 1) == 1;

    if(var_1) {
      if(self hasweapon(getcompleteweaponname("_encstr_A9DF13D2A84749177835EFE8D8E0C78F9998D9CA88")))
        scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A9DF13D2A84749177835EFE8D8E0C78F9998D9CA88");

      if(self hasweapon(getcompleteweaponname("_encstr_B13313F2779B9FC9EF4829601628BF79E833D120A9")))
        scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_B13313F2779B9FC9EF4829601628BF79E833D120A9");

      if(isDefined(self.gastakenweaponobj))
        gas_restoreheldoffhand();
    } else {
      self stopgestureviewmodel("_encstr_865816731B477F51DD7F51A30FF1CBB77A82E08EF54BC7F8");
      self stopgestureviewmodel("_encstr_86AE1BA09BE04F196F73A8357DA763F71E63996872CB67B0AF84482057");
    }
  }
}

gas_monitorcoughweaponfired(var_0) {
  self endon("_encstr_877F1524CEA32FE1E7574030370579A9CAB535BF24BA05");
  self endon("_encstr_AF12121832FA97418F4D8C73148F2BB3631AE0D8");

  for(;;) {
    self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_1);

    if(isnullweapon(var_1, var_0)) {
      break;
    }
  }

  self notify("_encstr_8EB8154F277F69C348AB2F1B7961B9E32FC89F44168B12");
}

gas_monitorcoughweapontaken(var_0) {
  self endon("_encstr_8EB8154F277F69C348AB2F1B7961B9E32FC89F44168B12");
  self endon("_encstr_AF12121832FA97418F4D8C73148F2BB3631AE0D8");

  while(self hasweapon(var_0))
    waitframe();

  self notify("_encstr_877F1524CEA32FE1E7574030370579A9CAB535BF24BA05");
}

gas_monitorcoughduration(var_0) {
  self endon("_encstr_877F1524CEA32FE1E7574030370579A9CAB535BF24BA05");
  self endon("_encstr_8EB8154F277F69C348AB2F1B7961B9E32FC89F44168B12");
  wait(var_0);
  self notify("_encstr_AF12121832FA97418F4D8C73148F2BB3631AE0D8");
}

gas_takeheldoffhand() {
  if(isDefined(self.gastakenweaponobj))
    gas_restoreheldoffhand();

  self endon("_encstr_ABDB174A11863FDA60B72C0F8D586C1FA12940A219D37F9523");
  self.gastakenweaponobj = self getheldoffhand();
  var_0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(var_0) && scripts\mp\equipment::hasequipment(var_0)) {
    self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(var_0);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  var_1 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(var_1)) {
    var_2 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var_2) && var_2 == var_1) {
      self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
      waitframe();
      thread gas_restoreheldoffhand();
    }
  }

  var_3 = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(var_3) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
  waitframe();
  thread gas_restoreheldoffhand();
}

gas_restoreheldoffhand() {
  self notify("_encstr_ABDB174A11863FDA60B72C0F8D586C1FA12940A219D37F9523");
  var_0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(var_0) && scripts\mp\equipment::hasequipment(var_0)) {
    if(scripts\mp\equipment::hasequipment(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      var_1 = scripts\mp\equipment::findequipmentslot(var_0);

      if(var_1 == "_encstr_BA7F0830B3A7859B60B0")
        self assignweaponoffhandprimary(self.gastakenweaponobj);
      else if(var_1 == "_encstr_AC8F0AE74163F85AAA380AD8")
        self assignweaponoffhandsecondary(self.gastakenweaponobj);

      scripts\mp\equipment::setequipmentammo(var_0, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  var_2 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(var_2)) {
    var_3 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var_3) && var_3 == var_2) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self assignweaponoffhandspecial(self.gastakenweaponobj);
      self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  var_4 = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(var_4) {
    if(isDefined(self.gestureweapon) && self.gestureweapon == self.gastakenweaponobj.basename) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self.gastakenweaponobj = undefined;
    }

    return;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
  self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
  self.gastakenweaponobj = undefined;
  self.gastakenweaponammo = undefined;
}

gas_applyspeedredux() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_81AF118946CFF9352720F016E88FA029C3E939");
  self endon("_encstr_81AF118946CFF9352720F016E88FA029C3E939");

  if(isDefined(self.gasspeedmod)) {
    if(self.gasspeedmod < -0.15) {
      if(scripts\mp\utility\perk::_hasperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D")) {
        self.gasspeedmod = -0.15;
        scripts\mp\weapons::updatemovespeedscale();
        return;
      }

      if(isDefined(self.gastriggerstouching)) {
        foreach(var_1 in self.gastriggerstouching) {
          if(isDefined(var_1) && isDefined(var_1.owner) && var_1.owner == self) {
            self.gasspeedmod = -0.15;
            scripts\mp\weapons::updatemovespeedscale();
            return;
          }
        }
      }
    }
  } else
    self.gasspeedmod = 0;

  var_3 = -0.35;

  if(scripts\mp\utility\perk::_hasperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D"))
    var_3 = -0.15;
  else if(isDefined(self.gastriggerstouching)) {
    foreach(var_1 in self.gastriggerstouching) {
      if(isDefined(var_1) && isDefined(var_1.owner) && var_1.owner == self)
        var_3 = -0.15;
    }
  }

  gas_modifyspeed(var_3);
  self.gasspeedmod = var_3;
  scripts\mp\weapons::updatemovespeedscale();
}

gas_removespeedredux() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_81AF118946CFF9352720F016E88FA029C3E939");
  self endon("_encstr_81AF118946CFF9352720F016E88FA029C3E939");

  if(!isDefined(self.gasspeedmod)) {
    return;
  }
  gas_modifyspeed(0);
  self.gasspeedmod = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

gas_modifyspeed(var_0) {
  var_1 = 0;

  while(var_1 <= 0.65) {
    var_1 = var_1 + 0.05;
    self.gasspeedmod = scripts\engine\math::lerp(self.gasspeedmod, var_0, min(1, var_1 / 0.65));
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.05;
  }
}

gas_clearspeedredux(var_0) {
  self notify("_encstr_81AF118946CFF9352720F016E88FA029C3E939");
  self.gasspeedmod = undefined;

  if(!istrue(var_0))
    scripts\mp\weapons::updatemovespeedscale();
}

gas_applyblur() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_B228103F9BC089D7D0E1E21AAA2013BD1825");
  self endon("_encstr_B228103F9BC089D7D0E1E21AAA2013BD1825");
  var_0 = "_encstr_A79B156C86EB6739A25FB0B023CD7641D22E5CEB91E2C1";

  if(scripts\mp\utility\perk::_hasperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D"))
    var_0 = "_encstr_B11215D9C2CDF59D4E567358322BFA1BB43B43E8BE5B07";
  else if(isDefined(self.gastriggerstouching)) {
    foreach(var_2 in self.gastriggerstouching) {
      if(isDefined(var_2) && isDefined(var_2.owner) && var_2.owner == self)
        var_0 = "_encstr_B11215D9C2CDF59D4E567358322BFA1BB43B43E8BE5B07";
    }
  }

  for(;;) {
    scripts\cp_mp\utility\shellshock_utility::_shellshock(var_0, "_encstr_9B1804C793EB", 0.5, 0);
    wait 0.2;
  }
}

gas_removeblur() {
  self notify("_encstr_B228103F9BC089D7D0E1E21AAA2013BD1825");
}

gas_clearblur(var_0) {
  self notify("_encstr_B228103F9BC089D7D0E1E21AAA2013BD1825");

  if(!istrue(var_0))
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
}

gas_shouldtakeheldoffhand() {
  switch (self getheldoffhand().basename) {
    case "_encstr_8AA60F93A370283EF983D3F9AFA3902028":
      return 0;
    default:
      return 1;
  }

  return 0;
}

gas_coughisblocked() {
  if(!scripts\common\utility::is_cough_gesture_allowed())
    return 1;

  if(!scripts\common\utility::is_offhand_weapons_allowed())
    return 1;

  if(!nullweapon(self getheldoffhand()) && !gas_shouldtakeheldoffhand())
    return 1;

  return 0;
}

gas_isintrigger() {
  if(!isDefined(self.gastriggerstouching))
    return 0;

  if(self.gastriggerstouching.size == 0)
    return 0;

  return 1;
}

gas_updateplayereffects() {
  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    gas_clear();
    return;
  }

  if(gas_isintrigger()) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }
}

gas_getblurinterruptdelayms(var_0) {
  return 200.0;
}

plunder_playerspawnedcallback(var_0, var_1) {
  if(isDefined(var_1.gastriggerstouching) && var_1.gastriggerstouching.size > 0) {
    foreach(var_3 in var_1.gastriggerstouching) {
      if(isDefined(var_3.owner) && var_3.owner == var_0)
        return 1;
    }
  }

  return 0;
}