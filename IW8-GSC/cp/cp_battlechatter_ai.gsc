/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_battlechatter_ai.gsc
***********************************************/

addtosystem(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }
  if(self.chatinitialized) {
    return;
  }
  if(!isDefined(self.squad)) {
    return;
  }
  if(!isDefined(self.squad.chatinitialized) || !self.squad.chatinitialized)
    self.squad scripts\cp\cp_battlechatter::init_squadbattlechatter();

  self.battlechatter.enemyclass = "_encstr_A20C099FE504225E886B40";
  self.battlechatter.calledout = [];

  if(isPlayer(self)) {
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    self.type = "_encstr_A9C20643EAB52C9B";
    return;
  }

  if(self.unittype == "_encstr_AA180446F6EC") {
    self.battlechatter.enemyclass = undefined;
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    return;
  }

  if(self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    self.battlechatter.enemyclass = undefined;
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    return;
  }

  if(self.team == "_encstr_A7A408B9CA5D1D4E2C63") {
    self.battlechatter.enemyclass = undefined;
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    return;
  }

  self.headknob = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_81CC0586952C91"));
  self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_8D9C11CDD827A5C1E8B246BED12C63AD4BDCB3"));
  self.defaulttalk = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_A57E106FC5B56AF50828EF4BA820D3520D6C"));

  if(!isDefined(self.voice)) {
    return;
  }
  self.battlechatter.countryid = anim.countryids[self.voice];

  if(!isDefined(self.battlechatter.countryid)) {
    return;
  }
  assign_npcid();
  thread ainameandrankwaiter();
  init_aibattlechatter();
  thread aithreadthreader();
  thread scripts\cp\cp_battlechatter::bcprint_info();
}

init_aibattlechatter() {
  self.battlechatter.chatqueue = [];
  self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].priority = 0.0;
  self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].priority = 0.0;
  self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].priority = 0.0;
  self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"].priority = 0.0;
  self.battlechatter.chatqueue["_encstr_88720627AD68179B"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_88720627AD68179B"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_88720627AD68179B"].priority = 0.0;
  self.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"].priority = 0.0;
  self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"] = spawnStruct();
  self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].expiretime = 0;
  self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].priority = 0.0;
  self.battlechatter.nextsaytime = gettime() + 50;
  self.battlechatter.nextsaytimes["_encstr_85CB07BDE04321538B"] = 0;
  self.battlechatter.nextsaytimes["_encstr_8A66099C590B3647D2B79B"] = 0;
  self.battlechatter.nextsaytimes["_encstr_840709B34F76BBF8F072C7"] = 0;
  self.battlechatter.nextsaytimes["_encstr_85E507408AF3D0F005"] = 0;
  self.battlechatter.nextsaytimes["_encstr_88720627AD68179B"] = 0;
  self.battlechatter.nextsaytimes["_encstr_BD34078D57B9A37BD6"] = 0;
  self.battlechatter.nextsaytimes["_encstr_830E086EE82B0B361D86"] = 0;
  self.battlechatter.isspeaking = 0;
  self.battlechatter.minpriority = 0.0;
  self.allowedcallouts = [];
  addallowedthreatcallout("_encstr_8E2508591EE07BE6B246");

  if(self.team == "_encstr_9A8507BA4040188D08") {
    if(scripts\engine\utility::array_contains(anim.playernameids, self.voice)) {
      addallowedthreatcallout("_encstr_8C631507D8165EB24EAFB1F69B1D588DA3FAD88DDEC6B6");
      addallowedthreatcallout("_encstr_8F4914586BB9FA1BEB11850732D25303DFFF6328CF5B");
      addallowedthreatcallout("_encstr_8FE6108308376FD79327C3C955989C6B6F60");
      addallowedthreatcallout("_encstr_855D0FC1B185F2AC9C7DF64C3BA5DEBA37");
      addallowedthreatcallout("_encstr_A37B1403190F2BDD20467D06D8A0E333C89FFB87EFA2");
      addallowedthreatcallout("_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD");
      addallowedthreatcallout("_encstr_86A411B288082775C051A1AB39213E434861AA");
      addallowedthreatcallout("_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD");
    }

    addallowedthreatcallout("_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D");
    addallowedthreatcallout("_encstr_B1610BB3D781C068F6DC603B42");
    addallowedthreatcallout("_encstr_A3731036F6731B168EAFD87BD816A3A5DECD");
    addallowedthreatcallout("_encstr_8B3C1059F1C7C3CB83782CDF93CB39B2D39D");
    addallowedthreatcallout("_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC");

    if(self.voice != "_encstr_841804CCB9B0" && self.voice != "_encstr_A1440A8C62AA7519DD2FC0B0") {
      addallowedthreatcallout("_encstr_8F100C0BD2D763EDB116D15ABD9B");
      addallowedthreatcallout("_encstr_86A411B288082775C051A1AB39213E434861AA");
      addallowedthreatcallout("_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD");
      addallowedthreatcallout("_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73");
      addallowedthreatcallout("_encstr_834E19FFA24A713DA2FF4372FDC85F93AF4E70CA1938D720BF1768");
      addallowedthreatcallout("_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386");
    }
  } else {
    addallowedthreatcallout("_encstr_86A411B288082775C051A1AB39213E434861AA");
    addallowedthreatcallout("_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD");
  }

  self.battlechatterallowed = 0;

  if(isDefined(self.script_battlechatter) && self.script_battlechatter || anim.bcs_enabled)
    self.battlechatterallowed = level.battlechatter[self.team];

  self.flavorbursts = 0;

  if(scripts\cp\cp_battlechatter::voicecanburst() && level.flavorbursts[self.team] == 1 && self != anim.player)
    self.flavorbursts = 1;
  else
    self.flavorbursts = 0;

  if(level.friendlyfire_warnings)
    scripts\cp\utility::set_friendlyfire_warnings(1);
  else
    scripts\cp\utility::set_friendlyfire_warnings(0);

  self.chatinitialized = 1;
}

addallowedthreatcallout(var_0) {
  self.allowedcallouts[self.allowedcallouts.size] = var_0;
}

ainameandrankwaiter() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  for(;;) {
    self.bcname = scripts\cp\cp_battlechatter::getname();
    self.bcrank = scripts\cp\cp_battlechatter::getrank();
    self waittill("_encstr_84D6121B2BC12E9B31A175284F387BD635C85212");
  }
}

assign_npcid() {
  if(isDefined(self.script_friendname)) {
    var_0 = tolower(self.script_friendname);
    self.battlechatter.npcid = undefined;

    if(issubstr(var_0, "_encstr_AA83055973B189")) {
      self.battlechatter.countryid = "_encstr_8419042C363C";
      return;
    }

    if(issubstr(var_0, "_encstr_B4C10619C21B7F88")) {
      self.battlechatter.countryid = "_encstr_A71804587AF2";
      return;
    }

    if(issubstr(var_0, "_encstr_B8010EFE97C96B511848C28BC0700B22")) {
      self.battlechatter.countryid = "_encstr_8D19040EC9A5";
      return;
    }

    if(issubstr(var_0, "_encstr_AAD705D6F21BAC")) {
      self.battlechatter.countryid = "_encstr_AAD705D6F21BAC";
      return;
    }

    if(issubstr(var_0, "_encstr_A66906287A77A33B")) {
      self.battlechatter.countryid = "_encstr_A5190403D265";
      return;
    }

    setnpcid();
    return;
    return;
    return;
    return;
    return;
  } else
    setnpcid();
}

setnpcid() {
  var_0 = anim.usedids[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count)
      var_3 = (var_2 + var_4) % var_1;
  }

  thread npcidtracker(var_3);
  self.battlechatter.npcid = var_0[var_3].npcid;
}

npcidtracker(var_0) {
  var_1 = self.voice;
  anim.usedids[var_1][var_0].count++;
  scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }
  anim.usedids[var_1][var_0].count--;
}

aifolloworderwaiter() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  for(;;) {
    level waittill("_encstr_8D970D2C857BD827A72E705DE965B0", var_0);

    if(!scripts\cp\cp_battlechatter::bcsenabled()) {
      return;
    }
    if(!isDefined(self.team)) {
      return;
    }
    if(!isDefined(var_0)) {
      continue;
    }
    if(!isalive(var_0) || var_0.team != self.team) {
      continue;
    }
    if(distancesquared(self.origin, var_0.origin) < 360000)
      addresponseevent("_encstr_A71904605AB4", "_encstr_8CAB07EF58A11953A3", var_0, 0.9);
  }
}

aigrenadedangerwaiter() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_0 = undefined;

  for(;;) {
    self waittill("_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA", var_1);

    if(getdvarint("_encstr_BEFC0B0DAB1A390D03A2E128CA") == 0) {
      continue;
    }
    if(isDefined(var_1)) {
      var_0 = aigrenadetypecheck(var_1);

      if(!isDefined(var_0))
        continue;
    } else
      continue;

    addinformevent("_encstr_8A4F099025A3B8715A6B17", var_0);
  }
}

aigrenadetypecheck(var_0) {
  var_1 = undefined;

  if(var_0.model == "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23")
    var_1 = "_encstr_8C8D08671D451291C849";

  if(var_0.model == "_encstr_93D20F684BFBA7799030C04194795067C0")
    var_1 = "_encstr_9748067348F0C794";

  return var_1;
}

aithreadthreader() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isDefined(self.team)) {
    return;
  }
  var_0 = 0.5;
  wait(var_0);
  thread aigrenadedangerwaiter();
  thread aifolloworderwaiter();

  if(self.team == "_encstr_9A8507BA4040188D08") {
    wait(var_0);
    thread aidisplacewaiter();
  } else if((self.team == "_encstr_8E8405EA382B2A" || self.team == "_encstr_B848067B63177293") && !isalliedcountryid(self.battlechatter.countryid)) {
    thread aihostileburstloop();
    var_0 = 5.0;
  }

  if(isDefined(anim.player) && self.team == anim.player.team)
    thread player_friendlyfire_waiter();

  wait(var_0);
  thread aibattlechatterloop();
}

aidisplacewaiter() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A");

    if(getdvarint("_encstr_BEFC0B0DAB1A390D03A2E128CA") == 0) {
      continue;
    }
    if(gettime() < self.a.paintime + 4000) {
      continue;
    }
    addresponseevent("_encstr_A71904605AB4", "_encstr_8CAB07EF58A11953A3", anim.player, 1.0);
  }
}

isalliedcountryid(var_0) {
  switch (var_0) {
    case "_encstr_B47805777A0BD9":
    case "_encstr_AA180535146ABA":
    case "_encstr_81E4051511F5D7":
    case "_encstr_841804C8A9A0":
    case "_encstr_B81904AA6A6A":
    case "_encstr_81190407A676":
      return 1;
    default:
      return 0;
  }
}

aihostileburstloop() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  wait 2;

  for(;;) {
    if(scripts\stealth\utility::bcisincombat()) {
      if(isDefined(anim.player)) {
        if(distancesquared(self.origin, anim.player.origin) < 1048576) {
          if(isDefined(self.squad.membercount) && self.squad.membercount > 1)
            addreactionevent("_encstr_AD2906FBFA7593E3", "_encstr_8D960D2B8507182BBC7FD153C57380");
        }
      }
    }

    wait(randomfloatrange(2, 5));
  }
}

player_friendlyfire_waiter() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  thread player_friendlyfire_waiter_damage();

  for(;;) {
    self waittill("_encstr_A5490D5E05C3F8B363F3C8D83B3E43", var_0, var_1);

    if(!scripts\cp\cp_battlechatter::bcsenabled()) {
      continue;
    }
    if(!isPlayer(var_0)) {
      if(anim.countryids[self.voice] == "_encstr_85070327A3" && scripts\cp\cp_battlechatter::cansay("_encstr_8A66099C590B3647D2B79B", "_encstr_81B70B13BFC78276F1108FFB10", 1.0))
        addreactionevent("_encstr_81B70B13BFC78276F1108FFB10", undefined, var_0, 1.0);

      continue;
    }
  }
}

player_friendlyfire_waiter_damage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_0, var_0, var_2);

    if(isDefined(var_1) && var_1 == anim.player) {
      if(damage_is_valid_for_friendlyfire_warning(var_2))
        player_friendlyfire_addreactionevent();
    }
  }
}

damage_is_valid_for_friendlyfire_warning(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
    case "_encstr_911B0C7DA090E9A7F799FD50DD48":
    case "_encstr_8D4E0A501FCB898912CB3FA3":
    case "_encstr_A1ED0BA9FF84562B60BA073E83":
    case "_encstr_8DED0A21C79B660BC7588981":
      return 0;
  }

  return 1;
}

player_friendlyfire_addreactionevent() {
  addreactionevent("_encstr_A54E0D719B1F05C0B7C45355F91A50", undefined, anim.player, 1.0);
}

aibattlechatterloop() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\stealth\utility::bcisincombat()) {
    var_0 = gettime();

    for(var_1 = var_0 + randomintrange(7, 15) * 1000; !scripts\stealth\utility::bcisincombat() && var_0 < var_1; var_0 = gettime())
      waitframe();

    scripts\cp\cp_battlechatter::clearisspeaking("_encstr_830E086EE82B0B361D86");
  }

  for(;;) {
    scripts\cp\cp_battlechatter::playbattlechatter();
    wait(0.3 + randomfloat(0.2));
  }
}

evaluatemoveevent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }
  if(!isDefined(self.node)) {
    return;
  }
  if(distancesquared(self.origin, self.node.origin) < 23040) {
    return;
  }
  if(!scripts\cp\cp_battlechatter::isnodecoverorconceal()) {
    return;
  }
  if(!nationalityokformoveorder()) {
    return;
  }
  var_1 = scripts\cp\cp_battlechatter::getresponder(24, 1024, "_encstr_840709B34F76BBF8F072C7");

  if(self.team != "_encstr_8E8405EA382B2A" && self.team != "_encstr_B848067B63177293") {
    if(!isDefined(var_1))
      var_1 = anim.player;
    else if(randomint(100) < anim.eventchance["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_BEDD0EFD1EE17A42BB4083FB58720D53"])
      var_1 = anim.player;
  }

  if(1) {
    if(randomint(100) < anim.eventchance["_encstr_BA630AF5205B07DF65A89A33"]["_encstr_AD6908D8F63B2BE46B56"])
      addorderevent("_encstr_B40B07666F8BC31783", "_encstr_AD6908D8F63B2BE46B56", var_1);
    else
      addorderevent("_encstr_ACA20538F84D39", "_encstr_82EE0B8DE82C13A2187BCEFE14", var_1);
  } else if(nationalityokformoveordernoncombat()) {
    if(gettime() - self.starttime > 3000)
      addorderevent("_encstr_ACA20538F84D39", "_encstr_93500E11C773016D6D5AD8B002462B7B", var_1);
  }
}

nationalityokformoveorder() {
  if(isDefined(self.battlechatter.countryid) && self.battlechatter.countryid == "_encstr_8307034AF7")
    return 0;

  return 1;
}

nationalityokformoveordernoncombat() {
  if(!isDefined(self.battlechatter.countryid))
    return 0;

  switch (self.battlechatter.countryid) {
    case "_encstr_AA180535146ABA":
    case "_encstr_81E4051511F5D7":
    case "_encstr_B81904AA6A6A":
    case "_encstr_81190407A676":
      return 1;
    default:
      return 0;
  }
}

addorderevent(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::cansay("_encstr_88720627AD68179B", var_0, var_3)) {
    return;
  }
  var_4 = scripts\cp\cp_battlechatter::createchatevent("_encstr_88720627AD68179B", var_0, var_3);
  var_4.modifier = var_1;
  var_4.orderto = var_2;
  self.battlechatter.chatqueue["_encstr_88720627AD68179B"] = undefined;
  self.battlechatter.chatqueue["_encstr_88720627AD68179B"] = var_4;
}

evaluatereloadevent() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }
  addinformevent("_encstr_878B0A2323D11281F8F8551F", "_encstr_979608DF73C8E70B73A1");
}

addinformevent(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::cansay("_encstr_85E507408AF3D0F005", var_0, var_2)) {
    return;
  }
  var_4 = scripts\cp\cp_battlechatter::createchatevent("_encstr_85E507408AF3D0F005", var_0, var_2);

  switch (var_0) {
    case "_encstr_878B0A2323D11281F8F8551F":
      var_4.modifier = var_1;
      break;
    case "_encstr_86B209B07AF529395F72B1":
      if(isDefined(var_3))
        var_4.threat_type = var_3;
    default:
      var_4.modifier = var_1;
  }

  self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"] = undefined;
  self.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"] = var_4;
}

addreactionevent(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!isDefined(self.battlechatter.chatqueue)) {
    return;
  }
  if(!isDefined(anim.eventduration) || !isDefined(anim.eventpriority)) {
    return;
  }
  if(!scripts\stealth\utility::bcisincombat()) {
    return;
  }
  var_4 = scripts\cp\cp_battlechatter::createchatevent("_encstr_8A66099C590B3647D2B79B", var_0, var_3);
  var_4.reactto = var_2;
  var_4.modifier = var_1;
  self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"] = undefined;
  self.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"] = var_4;
}

addthreatevent(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::cansay("_encstr_85CB07BDE04321538B", var_0, var_2)) {
    return;
  }
  if(scripts\cp\cp_battlechatter::threatwasalreadycalledout(var_1) && !isPlayer(var_1)) {
    return;
  }
  var_3 = scripts\cp\cp_battlechatter::createchatevent("_encstr_85CB07BDE04321538B", var_0, var_2);

  switch (var_0) {
    case "_encstr_A20C099FE504225E886B40":
      var_3.threat = var_1;
      break;
    case "_encstr_82F309E237DB1B6B6367E9":
      var_3.threat = var_1;
      break;
  }

  if(isDefined(var_1.squad))
    self.squad scripts\cp\cp_battlechatter::updatecontact(var_1.squad.squadname, self);

  self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"] = undefined;
  self.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"] = var_3;
}

evaluateattackevent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }
  var_1 = 0;
  var_2 = "_encstr_8A78055C8D488C";

  switch (var_0) {
    case "_encstr_8A78055C8D488C":
      var_2 = "_encstr_8A78055C8D488C";
      break;
    case "_encstr_8C8D08671D451291C849":
      var_2 = "_encstr_8C8D08671D451291C849";
      break;
    case "_encstr_8B1804DF2043":
      var_2 = "_encstr_9748067348F0C794";
      break;
    case "_encstr_9AA80EDECC6686857346E61AB4CA8D23":
      var_2 = "_encstr_A32D07CFD14BAA94D0";
      break;
    case "_encstr_847205CE57E6E6":
      var_2 = "_encstr_8C180C3FC8C9981A2D58275B38FF";
      var_1 = 1;
      break;
    case "_encstr_86C808FF9BFE73295899":
      var_2 = "_encstr_83CE0FDD56B0C1F6377DD6A5DC6E2D36B2";
      var_1 = 1;
      break;
    case "_encstr_B1A9062B08CFA39F":
      var_2 = "_encstr_8DEA0D3CED0F834F0D6990C8A22203";
      break;
    case "_encstr_8DCB085BEF657B4DCF0B":
      var_2 = "_encstr_8DCB085BEF657B4DCF0B";
      break;
  }

  addinformevent("_encstr_999A07C61338F9A23A", var_2);

  if(var_1) {
    if(randomint(100) < 25) {
      wait(randomfloatrange(1, 2));

      if(isalive(self))
        thread addreactionevent("_encstr_B18F09518733412BAF1AA0");
    }
  }
}

addresponseevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread addresponseevent_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

getthreatsovertime(var_0, var_1) {
  var_2 = var_0.size;

  if(var_2 == 0) {
    wait(var_1);
    return var_0;
  }

  var_3 = var_1 * 20;
  var_4 = var_2 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0[var_6];

    if(!isDefined(var_7) || isDefined(var_7) && !isDefined(var_7.voice)) {
      continue;
    }
    if(!isDefined(var_7.battlechatter.enemyclass)) {
      continue;
    }
    var_5[var_5.size] = var_0[var_6];
  }

  if(var_5.size == 0) {
    wait(var_1);
    return var_5;
  }

  var_5 = sortbydistance(var_5, anim.player.origin);
  var_8 = [];
  var_9 = [];
  var_10 = 0;

  foreach(var_12 in var_5) {
    if(isDefined(var_12) && threatisviable(var_12)) {
      var_13 = var_12 scripts\cp\cp_battlechatter::getlocation();

      if(isDefined(var_13) && !scripts\cp\cp_battlechatter::location_called_out_recently(var_13))
        var_8[var_8.size] = var_12;
      else
        var_9[var_9.size] = var_12;
    }

    var_10++;

    if(var_10 >= var_4) {
      waitframe();
      var_10 = 0;
    }
  }

  var_5 = [];

  foreach(var_16 in var_8)
  var_5[var_5.size] = var_16;

  foreach(var_16 in var_9)
  var_5[var_5.size] = var_16;

  return var_5;
}

aideathenemy() {
  var_0 = self.attacker;
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0) || !issentient(var_0) && var_0 != anim.player || !isDefined(var_0.squad)) {
    return;
  }
  if(!isDefined(var_0.battlechatter.countryid)) {
    return;
  }
  switch (var_0.battlechatter.countryid) {
    case "_encstr_B47805777A0BD9":
    case "_encstr_AA180535146ABA":
    case "_encstr_81E4051511F5D7":
    case "_encstr_841804C8A9A0":
    case "_encstr_B81904AA6A6A":
    case "_encstr_81190407A676":
      break;
    default:
      return;
  }

  if(!isDefined(var_1))
    var_1 = self.unittype;

  if(isDefined(var_1))
    var_0 thread aikilleventthread(var_1);
}

aideathfriendly() {
  var_0 = self.attacker;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.unittype) && self.unittype == "_encstr_ABBE07B995566D569C") {
    return;
  }
  if(isDefined(self.squad) && isDefined(var_0.squad) && self.squad == var_0.squad) {
    return;
  }
  scripts\engine\utility::array_thread(self.squad.members, ::aideatheventthread, self);

  if(!isDefined(var_0.battlechatterallowed)) {
    return;
  }
  if(isalive(var_0) && !isPlayer(var_0) && isDefined(var_0.squad) && var_0.battlechatterallowed) {
    if(isDefined(var_0.battlechatter.calledout) && isDefined(var_0.battlechatter.calledout[var_0.squad.squadname]))
      var_0.battlechatter.calledout[var_0.squad.squadname] = undefined;

    if(!isDefined(var_0.battlechatter.enemyclass)) {
      return;
    }
    if(!var_0 scripts\cp\cp_battlechatter::is_in_callable_location()) {
      return;
    }
    foreach(var_2 in self.squad.members) {
      if(var_2 == anim.player) {
        continue;
      }
      if(gettime() > var_2.lastenemysighttime + 2000) {
        continue;
      }
      var_2 addthreatevent(var_0.battlechatter.enemyclass, var_0);
    }
  }
}

aideatheventthread(var_0) {
  if(!isalive(self)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self notify("_encstr_8B971358961159581DD054CE2BCD472A349C958523");
  self endon("_encstr_8B971358961159581DD054CE2BCD472A349C958523");

  if(self == anim.player) {
    if(isDefined(var_0) && !anim.player scripts\cp\cp_battlechatter::bccansee(var_0))
      return;
  }

  wait 1.2;
  addreactionevent("_encstr_8A3C092767D35DE09CEBD2", "_encstr_979608DF73C8E70B73A1", var_0, 0.9);
}

aikilleventthread(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(var_0 == "_encstr_83E8094727E333E8F9CE50") {
    return;
  }
  wait 1.2;
  addinformevent("_encstr_86B209B07AF529395F72B1", "_encstr_979608DF73C8E70B73A1", undefined, var_0);
}

removefromsystem(var_0) {
  if(scripts\cp\cp_battlechatter::bcsenabled()) {
    if(!isalive(self)) {
      if(isDefined(self)) {
        aideathfriendly();
        aideathenemy();
      }
    }
  }

  if(isDefined(self)) {
    self.battlechatterallowed = 0;
    self.chatinitialized = 0;
    self.battlechatter_removed = 1;
  }

  self notify("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(isDefined(self) && isDefined(self.battlechatter)) {
    self.battlechatter.chatqueue = undefined;
    self.battlechatter.nextsaytime = undefined;
    self.battlechatter.nextsaytimes = undefined;
    self.battlechatter.isspeaking = undefined;
    self.battlechatter.enemyclass = undefined;
    self.battlechatter.calledout = undefined;
    self.battlechatter.countryid = undefined;
    self.battlechatter.npcid = undefined;
  }
}

threatisviable(var_0) {
  if(distancesquared(anim.player.origin, var_0.origin) > level.bcs_maxthreatdistsqrdfromplayer)
    return 0;

  if(isDefined(self.team))
    return 1;

  if(self.team != "_encstr_9A8507BA4040188D08" && !anim.player scripts\cp\cp_battlechatter::entinfrontarc(var_0))
    return 0;

  return 1;
}

squadthreatwaiter() {
  anim endon("_encstr_AAED17080A03C9A8BF53038F3C83F18D7EC2D838A25E014193");
  anim endon("_encstr_A6A30F6EB8AB0BC80123ACC6CA3A959180" + self.squadname);

  for(;;) {
    while(!isDefined(anim.bcs_enabled) || !anim.bcs_enabled)
      waitframe();

    while(anim.bcs_enabled) {
      if(self.team == "_encstr_9A8507BA4040188D08")
        var_0 = getthreatsovertime(getaiarray("_encstr_8E8405EA382B2A"), 0.5);
      else if(self.team == "_encstr_B848067B63177293")
        var_0 = getthreatsovertime(getaiarray("_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A"), 0.5);
      else {
        waitframe();
        var_0 = getaiarray("_encstr_9A8507BA4040188D08");
        var_0[var_0.size] = anim.player;
      }

      if(!var_0.size) {
        wait 0.1;
        continue;
      }

      var_1 = [];

      foreach(var_11, var_3 in self.members) {
        if(!isalive(var_3)) {
          continue;
        }
        if(!var_3 scripts\stealth\utility::bcisincombat()) {
          if(var_3.team != "_encstr_9A8507BA4040188D08" && isDefined(var_3.fnisinstealthinvestigate) && var_3[[var_3.fnisinstealthinvestigate]]())
            var_3 addstealthevent("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2");
          else if(var_3.team != "_encstr_9A8507BA4040188D08" && isDefined(var_3.fnisinstealthhunt) && var_3[[var_3.fnisinstealthhunt]]()) {} else if(var_3.team != "_encstr_9A8507BA4040188D08" && isDefined(var_3.fnisinstealthidle) && [[var_3.fnisinstealthidle]]() == 0) {
            if(isDefined(var_3.demeanoroverride) && var_3.demeanoroverride == "_encstr_85BB067A08A3FAB3")
              var_3 addstealthevent("_encstr_A16D0B492D908FC1D36852DB50");
            else
              var_3 addstealthevent("_encstr_A7C5056BD931D1");
          }

          var_3.laststealthtime = gettime();
          continue;
        }

        while(isalive(var_3) && var_3.team == "_encstr_8E8405EA382B2A" && isDefined(var_3.laststealthtime) && gettime() - var_3.laststealthtime < 1000)
          waitframe();

        if(!var_0.size) {
          var_0 = var_1;
          var_1 = [];
        }

        foreach(var_10, var_5 in var_0) {
          if(!isDefined(var_5)) {
            if(var_10 == 0)
              var_0 = [];

            continue;
          }

          if(!isalive(var_5)) {
            continue;
          }
          if(!var_3 scripts\cp\cp_battlechatter::bccansee(var_5)) {
            if(!anim.player scripts\cp\cp_battlechatter::bccansee(var_5))
              continue;
          }

          if(isDefined(var_3.bt) && isDefined(var_3.bt.pursuer))
            var_3 addreactionevent("_encstr_83A107A3F3185A4DB0", undefined, var_3.bt.pursuer);
          else
            var_3 addthreatevent("_encstr_A20C099FE504225E886B40", var_5);

          var_1[var_1.size] = var_5;
          var_6 = [];

          foreach(var_8 in var_0) {
            if(var_8 != var_5)
              var_6[var_6.size] = var_8;
          }

          var_0 = var_6;
          break;
        }

        waitframe();
      }

      waitframe();
    }
  }
}

addstealthevent(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");

  if(!scripts\cp\cp_battlechatter::cansay("_encstr_830E086EE82B0B361D86", var_0, var_2))
    return 0;

  if(anim.eventpriority["_encstr_830E086EE82B0B361D86"][var_0] < self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].priority)
    return 0;

  var_4 = scripts\cp\cp_battlechatter::createchatevent("_encstr_830E086EE82B0B361D86", var_0, var_2);

  if(isDefined(var_3))
    var_4.location = var_3.origin;

  var_4.modifier = var_1;
  self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"] = undefined;
  self.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"] = var_4;
  return 1;
}

addresponseevent_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  self endon("_encstr_958F17C959E638DBB9DCCAA8B3B2B9D17D33585AC637169956");
  thread responseevent_failsafe(var_2);
  var_6 = var_2 scripts\engine\utility::_id_143AE("_encstr_AD75063D571AE108", "_encstr_B4650E6A50F57FA2732F75694AD85307", "_encstr_BD4C109A81983FEFD881BBA013E8345F30F9");

  if(var_6 == "_encstr_BD4C109A81983FEFD881BBA013E8345F30F9") {
    return;
  }
  if(!isalive(var_2)) {
    return;
  }
  if(!scripts\cp\cp_battlechatter::cansay("_encstr_840709B34F76BBF8F072C7", var_0, var_3)) {
    return;
  }
  if(!isPlayer(var_2)) {
    if(scripts\cp\cp_battlechatter::isusingsamevoice(var_2))
      return;
  }

  var_7 = scripts\cp\cp_battlechatter::createchatevent("_encstr_840709B34F76BBF8F072C7", var_0, var_3);

  if(isDefined(var_4))
    var_7.reportalias = var_4;

  if(isDefined(var_5))
    var_7.location = var_5;

  var_7.respondto = var_2;
  var_7.modifier = var_1;
  self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"] = undefined;
  self.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"] = var_7;
}

responseevent_failsafe(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B6321B9635BFD7DD956DAAF8752D7170804B041DF860F972C2E313FD2B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B4650E6A50F57FA2732F75694AD85307");
  var_0 endon("_encstr_BD4C109A81983FEFD881BBA013E8345F30F9");
  wait 25;
  self notify("_encstr_958F17C959E638DBB9DCCAA8B3B2B9D17D33585AC637169956");
}