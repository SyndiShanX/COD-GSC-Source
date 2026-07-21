/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_skits.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

setup_spawn_skits() {
  level.spawn_skits = [];
  add_spawn_skit("_encstr_8F6D17E6D1CA0BD88EA17DCDA5E8E8B4CDD97D36161C1DEDC1", ::stealth_sitting_laptop);
  add_spawn_skit("_encstr_A9861758839F0B4003B0705E992B8BC3855AC1C8CAB269781B", ::stealth_sitting_pistol);
  add_spawn_skit("_encstr_AB561586236AFBB8448BD980B77C7323020F6806FF5259", ::stealth_sitting_cell);
  add_spawn_skit("_encstr_B6E416E2B31059F215F95FD7C33DBB999039116A28B8E56B", ::stealth_sitting_sleep);
  add_spawn_skit("_encstr_8F2E08B9DADBDA9637B3", ::smoking);
  add_spawn_skit("_encstr_A2A70BE63DEBD0DF7AEA0808D2", ::standing_cellphone);
  add_spawn_skit("_encstr_87D31E9BE85616C61D1AEB9BA53AE82DDCCEF5D82B1B1BD7E67BF50793F61CCD", ::stealth_sitting_cell_no_props);
  add_spawn_skit("_encstr_8C78135ABD4B6AF4B8E83FD7A811A41201DB2595AD", ::standing_cellphone);
  add_spawn_skit("_encstr_AF6C0FFDB00ACF97C89B8FC9F0348DA363", ::movequestobjicon);
  level.scr_animtree["_encstr_AD660B5A46362BBE1B860B2D9C"] = #animtree;
  level.scr_model["_encstr_AD660B5A46362BBE1B860B2D9C"] = "_encstr_87661CB1C1AF19B49B8D7BD7CCB7D8C82D9B3BBEC68685B439EBC6BD3218";
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_87CB13071BFD31B3D819F7BAB0E0EF8956ABD7CFD9"] = % _encstr_8849263959C4BECD8EB1D7D223C695BECDB447F5E6B12BCA074BB9D97DE4950B1BA37DD81A58B4E4;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_8CE513CDA5E8EBDC6356B238B47376EB19952CA343"] = % _encstr_ADF828725D35018B736077B738A855C9AFE37BA13E41FAA5DBA0BB87C9C10D92498BD2B2B087E2E98040;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_83DD143FB1CB297E5F0230BB2A1FA0A0A902AB932333"] = % _encstr_86BB2508CA061FCB7BDC180BAC6371572A92B0D9335C87A017A83768926F39F7539990E8DAB4F5;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_9ACC14721B5941DB11A07B1398089EAAB7257F6E7D89"] = % _encstr_9B5829E4B231F5DC1DB17DA5C83656EBDC4B3AEB1CD07BB9CAC0897DC8AC2CE8A1C08CFA1ABEB11AB04B93;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_8F9F11C3B819395BC9E7ACBFFF567BFF5B903B"] = % _encstr_836A24D349722F0EABF131CF2529637137D839094491B38D5F17917BEDE35188AFEA13E91BB5;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_A1431106E4FB0738D16BA3E053D7F1BB724B73"] = % _encstr_A2AD284E5631BE6E1D8DD7A5238DB2AF37A5E8FAC6C21C3AED0EBE8CCA85A31A0346BE23AFC6D0B02D39;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_977D177B8AA3499BA9E7A018B8FEAFF937FA73773359A3BA65"] = % _encstr_A3EF2C4A85794FF2C140E98228D9AF97B37BB4EF2C23C33D9370C24BD805E61BE9D5175AB5C94F83C748AA129055;
  level.scr_anim["_encstr_AD660B5A46362BBE1B860B2D9C"]["_encstr_A7D117127B3921A8F0783B4F98EE73DAE387DD8155B39AD4B8"] = % _encstr_A26C30DA2BEE46D03BC097C34429EAA10B1B0B4FE8DB3039A1BB7D3C9BB8C2F8CF2F801267027CB082C7D7EF478EA4D6AB13;
  level.scr_model["_encstr_9BD90F2D23B156BE362B8DC6E0A17B3756"] = "_encstr_93611698BD8D824940F98897A591CBFAC950E41940C05605";
}

skit_fx() {
  level.g_effect["_encstr_A66A0F703A75A97BDBEFB03DC73F20671B"] = loadfx("_encstr_8F073578AAD08FF807D770D99DDBA1C1FAC6C01852AE4B1117A4E94B3FF38991A99BF0C00902918833D578C941CF70410107BA12F35F09");
}

add_spawn_skit(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.skit_name = var_0;
  var_2.skit_func = var_1;
  level.spawn_skits[var_0] = var_2;
}

hostage_rescue_fight(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\mp_agent::spawnnewagentaitype(var_2, var_0.origin, var_0.angles);
  var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_3, var_1.origin, var_1.angles);
  var_4 setup_fight_guy();
  var_5 setup_fight_guy();
  var_6 = var_4 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_ABC110CC969D431D4CBEB03A8EC28DDA5693");
  var_7 = var_4 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_6);
  var_8 = var_5 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_86FE0EB67B216BDBA341D33AB871D437");
  var_9 = var_5 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_8);
  var_4 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_6);
  var_5 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_8);
  var_5.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
  var_5.deathalias = "_encstr_8A8414F551EF7015EED1D3383AD3438009B40B73D494";
  var_10 = 30;
  var_4 thread waitfor_death(var_10, var_5, ::death_fight1, ::victim_killed_fight1);
  var_5 thread waitfor_save(var_4, ::victim_saved);
  var_5 scripts\engine\utility::_id_143C0(30, "_encstr_990D06B916D95691", "_encstr_AD75063D571AE108");
}

hostage_rescue_meatshield(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4))
    var_4 = scripts\mp\mp_agent::spawnnewagentaitype(var_2, var_0.origin, var_0.angles);

  if(!isDefined(var_5))
    var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_3, var_1.origin, var_1.angles);

  var_4 setup_fight_guy();
  var_5 setup_fight_guy();
  var_7 = scripts\cp\cp_weapon::buildweapon("_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
  var_4 giveweapon(var_7);
  var_4.og_weapon = var_4.weapon;
  var_4 setspawnweapon(var_7);
  var_4 scripts\common\utility::initweapon(var_7);
  var_4 _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(var_7, "_encstr_8253060E2B5FE330");
  var_4 _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(var_4.weapon, "_encstr_B69B0589C236B6");
  var_4.sidearm = var_7;
  var_4.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
  var_4.deathalias = "_encstr_A75416F738D49254C2C986BBE313EB745A6249A5FD1AF394";
  var_8 = var_4 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_A66E10543C12B1D36B2F40E0EB5149CF5A62");
  var_9 = var_4 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_8);
  var_10 = var_5 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_81390EC14BF2883DCFBFBD4B3FECF0F0");
  var_11 = var_5 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_10);
  var_4 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_8);
  var_5 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_10);
  var_12 = getanimlength(var_9);
  var_13 = var_12 * 5;

  if(isDefined(var_6))
    var_13 = var_6;

  var_4 thread waitfor_death(var_13, var_5, ::death_fight2, ::victim_killed_fight2);
  var_5 thread waitfor_save(var_4, ::victim_saved_shield);
  var_14 = gettime() + var_12 * 5 * 1000;

  if(isDefined(var_6))
    var_14 = gettime() + var_6 * 1000;

  level thread fight_idle(var_14, var_5, var_4, var_12, var_8, var_10);
}

victim_saved_shield() {
  var_0 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_97CB1479ECDFF885F7B73D0B6FAB43684FC201F31704");
  var_1 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  wait 2;
  reset_guy(self);

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

fight_idle(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_AD75063D571AE108");

  if(var_0 <= 0) {
    for(;;) {
      wait(var_3);
      var_2 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_4);
      var_1 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_5);
    }
  } else {
    while(gettime() < var_0) {
      wait(var_3);
      var_2 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_4);
      var_1 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_5);
    }
  }
}

setup_fight_guy() {
  self.ignoreall = 1;
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self setlookatentity();
  self.headlook_enabled = 0;
  self.disableautolookat = 1;
}

setup_anim_guy() {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self.playing_skit = 1;
}

death_fight2(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
  var_0.deathalias = "_encstr_86441499A5D9D0A399FA3B4BB13A5A5BF532B2168E34";
  magicbullet(self.sidearm, self gettagorigin("_encstr_A14F0AE336178944BA076F41"), anglesToForward(self gettagangles("_encstr_A14F0AE336178944BA076F41")) * 1000);
  self shoot(10, var_0, 1, 1);
  var_0 dodamage(var_0.health + 100, var_0.origin);
  scripts\asm\shared\mp\utility::burndowntime("_encstr_857714FC94BA194BF3C7B80873F9E15722FAF8FC6CC2");
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.og_weapon, "_encstr_8253060E2B5FE330");
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.sidearm, "_encstr_8BBA05185F8B99");
  reset_guy(self);
}

death_fight1(var_0) {
  var_0.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
  var_0.deathalias = "_encstr_8A8414F551EF7015EED1D3383AD3438009B40B73D494";
  var_0 dodamage(var_0.health + 100, var_0.origin);
  reset_guy(self);
}

victim_saved() {
  scripts\asm\shared\mp\utility::burndowntime("_encstr_97CB1479ECDFF885F7B73D0B6FAB43684FC201F31704");
  reset_guy(self);
}

victim_killed_fight1() {
  reset_guy(self);
}

victim_killed_fight2() {
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.og_weapon, "_encstr_8253060E2B5FE330");
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.sidearm, "_encstr_8BBA05185F8B99");
  reset_guy(self);
}

waitfor_death(var_0, var_1, var_2, var_3) {
  self endon("_encstr_845310B7DF0260703F3CA0FB27FA9325AB6B");
  var_4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_0, self, "_encstr_AD75063D571AE108", var_1, "_encstr_AD75063D571AE108");

  if(isDefined(var_4) && var_4 == "_encstr_995408F398012F656821")
    self thread[[var_2]](var_1);
  else {
    if(isalive(var_1))
      var_1 notify("_encstr_990D06B916D95691");

    if(isalive(self))
      self thread[[var_3]]();
  }
}

waitfor_save(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_990D06B916D95691");

  if(isDefined(var_1))
    self[[var_1]]();
}

reset_guy(var_0) {
  var_0 allowedstances("_encstr_922406F1A6FD5E05", "_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
  var_0.playing_skit = undefined;

  if(isDefined(self.anchor))
    self.anchor delete();
}

stealth_sitting_laptop(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_B82D0B06E4FB0738D16BA3E053";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(!have_props_spawned())
      spawn_table();

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      var_1 = spawn_chair(var_0);
      thread stealth_sit_react(var_1, "_encstr_B6DE156399B5289BD8FF1F6BEBB86B4839A9FA35816825", "_encstr_836A24D349722F0EABF131CF2529637137D839094491B38D5F17917BEDE35188AFEA13E91BB5");
      thread stealth_sit_death(var_1, "_encstr_A2AD284E5631BE6E1D8DD7A5238DB2AF37A5E8FAC6C21C3AED0EBE8CCA85A31A0346BE23AFC6D0B02D39");
      var_2 = spawn_table();
      set_props_spawned();
    }

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;

    setup_anim_guy();
    self.deathstate = "_encstr_82011C13519085C760E1A64393638B5D7F8F5BB9911B3793F7752858DCF0";
    self.deathalias = "_encstr_AD75063D571AE108";
    thread stealth_sit_idle("_encstr_8A17141BD3EBB3048568B98230D13BA703509984F911");
  }
}

stealth_sitting_pistol(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_921911F7D9F8CE292263A41D6171595839D315";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(!have_props_spawned())
      spawn_table();

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      var_1 = spawn_chair(var_0);
      thread stealth_sit_react(var_1, "_encstr_AF881578D7A3F12BCD09E70210B29BAF90E14A58870BE1", "_encstr_A3EF2C4A85794FF2C140E98228D9AF97B37BB4EF2C23C33D9370C24BD805E61BE9D5175AB5C94F83C748AA129055");
      thread stealth_sit_death(var_1, "_encstr_A26C30DA2BEE46D03BC097C34429EAA10B1B0B4FE8DB3039A1BB7D3C9BB8C2F8CF2F801267027CB082C7D7EF478EA4D6AB13");
      var_2 = spawn_table();
      set_props_spawned();
    }

    setup_anim_guy();
    self.idle_prop = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self.idle_prop setModel("_encstr_84F213D3F04A57DAD0B9AC27CA1F1BF27E0FB927D7");
    self.idle_prop linkTo(self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));
    thread stealth_sit_idle("_encstr_ADAE14DB98E3188B8EE1B1A372FF14C72847E2487489");
  }
}

crouching_phone() {
  setup_anim_guy();
  self.deathstate = "_encstr_BE3E1FD15133B89093E97B20432B5B900F977F63F49DF06BF7D2B1EEAA47073864";
  self.deathalias = "_encstr_AD75063D571AE108";
  thread idle_crouching_phone("_encstr_BD9D17FF53CB8D8B22D7B971F7A8D8D0BB9253EDD1DC04900F");
}

idle_crouching_phone(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  thread ai_notetrack_loop("_encstr_8F2E08B9DADBDA9637B3");

  for(;;) {
    smoking_idle_start("_encstr_9278139783E0E23938A9E96CA1407DF94619671B29");
    scripts\asm\shared\mp\utility::burndowntime(var_0);
    smoking_idle_end("_encstr_A7DE1192197F10CFDEA7E00BC5FC1DF7F30228");
  }
}

stealth_sitting_cell_no_props(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_AF180EEFF325E97B38801DE2F8908E82";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      var_1 = spawn_chair(var_0);
      thread stealth_sit_react(var_1, "_encstr_AB2E186B5C7CA8BBF2879FEFA7FA71D008B5B02149C2E867DAD3", "_encstr_86BB2508CA061FCB7BDC180BAC6371572A92B0D9335C87A017A83768926F39F7539990E8DAB4F5");
      thread stealth_sit_death(var_1, "_encstr_9B5829E4B231F5DC1DB17DA5C83656EBDC4B3AEB1CD07BB9CAC0897DC8AC2CE8A1C08CFA1ABEB11AB04B93");
      set_props_spawned();
    }

    setup_anim_guy();
    self.deathstate = "_encstr_BE3E1FD15133B89093E97B20432B5B900F977F63F49DF06BF7D2B1EEAA47073864";
    self.deathalias = "_encstr_AD75063D571AE108";
    self.idle_prop = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self.idle_prop setModel("_encstr_85D219A752C23BC05D4C4F4EC047DF2FC80413EBE7508DE89F6ACF");
    self.idle_prop linkTo(self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));
    thread stealth_sit_idle("_encstr_BD9D17FF53CB8D8B22D7B971F7A8D8D0BB9253EDD1DC04900F");
  }
}

stealth_sitting_cell(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_AF180EEFF325E97B38801DE2F8908E82";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(!have_props_spawned())
      spawn_table();

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      var_1 = spawn_chair(var_0);
      thread stealth_sit_react(var_1, "_encstr_AB2E186B5C7CA8BBF2879FEFA7FA71D008B5B02149C2E867DAD3", "_encstr_86BB2508CA061FCB7BDC180BAC6371572A92B0D9335C87A017A83768926F39F7539990E8DAB4F5");
      thread stealth_sit_death(var_1, "_encstr_9B5829E4B231F5DC1DB17DA5C83656EBDC4B3AEB1CD07BB9CAC0897DC8AC2CE8A1C08CFA1ABEB11AB04B93");
      var_2 = spawn_table();
      set_props_spawned();
    }

    setup_anim_guy();
    self.deathstate = "_encstr_BE3E1FD15133B89093E97B20432B5B900F977F63F49DF06BF7D2B1EEAA47073864";
    self.deathalias = "_encstr_AD75063D571AE108";
    self.idle_prop = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self.idle_prop setModel("_encstr_916E21ED6B20D453213142EB5E875F4A782F6E71F9C99AEFDFCBDBB3C050BB47C13949");
    self.idle_prop linkTo(self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));
    thread stealth_sit_idle("_encstr_BD9D17FF53CB8D8B22D7B971F7A8D8D0BB9253EDD1DC04900F");
  }
}

stealth_sitting_sleep(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_866C0D5844AB102F63CFA80F31C82F";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      var_1 = spawn_chair(var_0);
      thread stealth_sit_react(var_1, "_encstr_8CFE17C36310AB1F882939E3505567E240C54F67AD70360FAD", "_encstr_8849263959C4BECD8EB1D7D223C695BECDB447F5E6B12BCA074BB9D97DE4950B1BA37DD81A58B4E4");
      thread stealth_sit_death(var_1, "_encstr_ADF828725D35018B736077B738A855C9AFE37BA13E41FAA5DBA0BB87C9C10D92498BD2B2B087E2E98040");
      set_props_spawned();
    }

    setup_anim_guy();
    self.deathstate = "_encstr_8A131E18D7EBAB8581A97BD298D97CA3E150838C7D116BCC5D50A17A08CBF373";
    self.deathalias = "_encstr_AD75063D571AE108";
    thread stealth_sit_idle("_encstr_8693166E8C9339E0A65F41281BC53969EAF5ECE0646AC1A9");
  }
}

spawn_table() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + anglesToForward(self.angles) * 32);
  var_0.angles = self.angles + (0, 90, 0);
  var_0 setModel("_encstr_8F2F2033EA9C9B963ABA392BBEE8C231C6B2F533B7C68CB4B976EB0689F5DE0795DC");
  var_0 disconnectPaths();
}

spawn_chair(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + anglesToForward(self.angles) * -8);
    var_0.angles = self.angles;
    var_0 setModel("_encstr_87661CB1C1AF19B49B8D7BD7CCB7D8C82D9B3BBEC68685B439EBC6BD3218");
    var_0 disconnectPaths();
  }

  return var_0;
}

stealth_sit_idle(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_0);
}

stealth_sit_react(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_BA22087EA808525BA5D9");
  scripts\cp\cp_modular_spawning::set_kill_off_time(20);
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  var_0 scriptmodelplayanimdeltamotion(var_2);
  scripts\asm\shared\mp\utility::burndowntime(var_1);
  var_0 scriptmodelclearanim();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 15));
  reset_guy(self);
}

stealth_sit_death(var_0, var_1) {
  self endon("_encstr_BA22087EA808525BA5D9");
  var_2 = undefined;

  if(isDefined(self.idle_prop))
    var_2 = self.idle_prop;

  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_2)) {
    var_2 unlink();
    var_2 physicslaunchserver(var_2.origin, (0, 0, -10));
  }

  var_0 scriptmodelplayanimdeltamotion(var_1);
  wait 1;
  var_0 scriptmodelclearanim();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 15));
}

smoking() {
  self.playing_skit = 1;

  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_8F2E08B9DADBDA9637B3";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;
  } else {
    setup_anim_guy();
    self.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
    self.deathalias = "_encstr_B13D0E7BD370D4B720F1D16A998F9B4C";
    thread smoking_idle("_encstr_A2CB0D9B5BDE6DD2739DF55A32C62B");
    thread smoking_react("_encstr_A6E40EE01D3FFA1848A7D0B37F28BF03");
    thread smoking_death("_encstr_B13D0E7BD370D4B720F1D16A998F9B4C");
  }
}

smoking_idle(var_0) {
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  thread ai_notetrack_loop("_encstr_8F2E08B9DADBDA9637B3");

  for(;;) {
    smoking_idle_start("_encstr_9278139783E0E23938A9E96CA1407DF94619671B29");
    scripts\asm\shared\mp\utility::burndowntime(var_0);
    smoking_idle_end("_encstr_A7DE1192197F10CFDEA7E00BC5FC1DF7F30228");
    ai_smoking_cleanup();

    if(istrue(self._id_133A4)) {
      self notify("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
      self notify("_encstr_A70C0C3ED3583157788FD0689D4B");
      reset_guy(self);
      break;
    }
  }
}

smoking_idle_start(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

smoking_idle_end(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

smoking_react(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A70C0C3ED3583157788FD0689D4B");
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\cp\utility::add_wait(scripts\engine\utility::_id_143A5, "_encstr_BA22087EA808525BA5D9", "_encstr_BD9D19BFD3DA068F52DE78F6FB58F078B8225BF1D15E0F604A6B2A");
  scripts\cp\utility::do_wait_any();
  scripts\cp\cp_modular_spawning::set_kill_off_time(20);
  ai_smoking_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self);
}

smoking_death(var_0) {
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_A70C0C3ED3583157788FD0689D4B");
  self waittill("_encstr_AD75063D571AE108");
  ai_smoking_cleanup();
}

ai_notetrack_loop(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_BA22087EA808525BA5D9");

  for(;;) {
    self waittill("_encstr_84610D49100897C2DF809A03583BFF", var_1);

    if(!isDefined(var_1))
      var_1 = ["_encstr_8C500ABA9B23CACC2D37AC8C"];

    if(!isarray(var_1))
      var_1 = [var_1];

    var_2 = undefined;

    foreach(var_4 in var_1) {
      if(var_0 == "_encstr_8F2E08B9DADBDA9637B3") {
        ai_notehandler_smoking(var_4);
        continue;
      }

      if(var_0 == "_encstr_8C78135ABD4B6AF4B8E83FD7A811A41201DB2595AD")
        ai_notehandler_cellphone(var_4);
    }
  }
}

ai_notehandler_smoking(var_0) {
  switch (var_0) {
    case "_encstr_A19A077135838FDED1":
      playFXOnTag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      break;
    case "_encstr_8FA906CC80677438":
      playFXOnTag(level.g_effect["_encstr_AFD40E33339FC96BA2953B0BA1A818F3"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      stopFXOnTag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      playFX(level.g_effect["_encstr_881A0DC6B4B3343A2B277D9D36EDDD"], self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"));
      thread ai_smoking_blowsmoke();
      break;
    case "_encstr_A1A107973D7982FB90":
      stopFXOnTag(level.g_effect["_encstr_AFD40E33339FC96BA2953B0BA1A818F3"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      stopFXOnTag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      playFX(level.g_effect["_encstr_88F913764BD7E813A959859AF04C87A8971B87B2FF"], self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"), anglesToForward(self gettagangles("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5")));
      break;
  }
}

ai_smoking_blowsmoke() {
  self endon("_encstr_BD9E0CFF517A028B22D7B9B1DBE8");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_AC0E1277117F26D80917F8EB783E3BC8B55865E9");
  self endon("_encstr_BA22087EA808525BA5D9");

  for(;;) {
    playFX(level.g_effect["_encstr_91A41017B917C0FE57FB3B01515739F8AC0D"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("_encstr_A130084D2FDAD8AA8F62")));
    var_0 = randomintrange(5, 8);
    wait(var_0);
  }
}

ai_smoking_cleanup() {
  self notify("_encstr_BD9E0CFF517A028B22D7B9B1DBE8");

  if(isDefined(self gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", 1))) {
    killfxontag(level.g_effect["_encstr_AFD40E33339FC96BA2953B0BA1A818F3"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
    killfxontag(level.g_effect["_encstr_8E0A108651A711A51F0BF0709133A50837D4"], self, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
  }
}

standing_cellphone(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "_encstr_B6D80AD859C6C6C10DDBE62B";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;
  } else {
    if(!isDefined(var_0))
      var_0 = 1;

    setup_anim_guy();
    self.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
    self.deathalias = "_encstr_826616739DC908BC212611B3FB13CCBFCDB5B1ECF26F1CBA";
    thread ai_notetrack_loop("_encstr_8C78135ABD4B6AF4B8E83FD7A811A41201DB2595AD");
    thread standing_cellphone_anim_seq(var_0);
  }
}

standing_cellphone_anim_seq(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  thread cellphone_react("_encstr_A6E40EE01D3FFA1848A7D0B37F28BF03");
  standing_cellphone_anim("_encstr_B1EA169F034E48A01FEAD361224A78BDF573C95CBD246E5F");

  if(var_0 > 0)
    standing_cellphone_loop("_encstr_837315DCA3C273C8BEC6CA8D8D8334DBCD957DB1B7F61C", var_0);

  standing_cellphone_anim("_encstr_822515E6434A85D90FC76858835810CFE2AF4865D82249");
}

standing_cellphone_anim(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

standing_cellphone_loop(var_0, var_1) {
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  scripts\asm\shared\mp\utility::bunkeropened(var_0, var_1);
  reset_guy(self);
}

ai_notehandler_cellphone(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");

  switch (var_0) {
    case "_encstr_A19A077135838FDED1":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("_encstr_93611698BD8D824940F98897A591CBFAC950E41940C05605", "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
      break;
    case "_encstr_A1A107973D7982FB90":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
  }
}

cellphone_react(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\cp\utility::add_wait(scripts\engine\utility::_id_143A5, "_encstr_BA22087EA808525BA5D9", "_encstr_BD9D19BFD3DA068F52DE78F6FB58F078B8225BF1D15E0F604A6B2A");
  scripts\cp\utility::do_wait_any();
  scripts\cp\cp_modular_spawning::set_kill_off_time(20);
  ai_cellphone_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self);
}

ai_cellphone_cleanup() {
  self endon("_encstr_AD75063D571AE108");
}

have_props_spawned() {
  return isDefined(self.spawnpoint) && istrue(self.spawnpoint.props_spawned);
}

set_props_spawned() {
  if(isDefined(self.spawnpoint))
    self.spawnpoint.props_spawned = 1;
}

movequestobjicon() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_96080730D8534E0A28");
  scripts\cp\cp_modular_spawning::set_goal_radius(4);
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self takeallweapons();
  var_0 = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(var_0);
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::forceuseweapon(var_0, "_encstr_BA7F0830B3A7859B60B0");
  wait 0.5;
  var_1 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setlookatentity(var_1);
  wait 0.5;
  setup_anim_guy();
  var_2 = ["_encstr_831D1DFFBF4B1734F727B38ECBFE4E34050D7A377B7327B0809F31F8EDA927", "_encstr_AB1D1D8B2B68396BC416071F13B0A72C689B122F6788FF037D0ECA82E35FAA", "_encstr_991D1DBB67DBAF570539BFA72A1F4E2BD1DD120F86418F9D3B21F23A201992", "_encstr_A11D1DC60B38FA6699F5062606F5C60DB256C97DDCC695372BAF1B5AECC00D", "_encstr_A31D1DC60B1C7D33CCEB604C0CD76C1AACCA93D79B1B959B2B7DB12D3BC01B", "_encstr_931D1DC67123AF119969772E9A8987646BBDD28F079FE22B71799AC2DB9863", "_encstr_911D1D5342D3E9EF7149015753E9A3107153335706B25DCA0D574A532B8992", "_encstr_8F1D1DCB17ABDF0755698F97FACFBEFBE18D427FB6917F4D0B51A2EAD02960", "_encstr_8D1D1D6C85C1D733337D608960D76C342BAC39FACD1B95B9ACF58D5A3B6206", "_encstr_A51D1D2FD26F7F3AAEF7B12F72D9F6C8E92DC097906609E8B569C9EA638BAB", "_encstr_9A1D1D1B2C38D7CC66AF0C98607DD8432BCA4EAFE66CAC73B2EB8D4BEC8991", "_encstr_AF1D1DAFE327E97E20E60AB2F3118352757363E76FC6323E10CED6AC134A9B"];
  var_3 = [];
  var_3[var_3.size] = [::play_looping_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", var_2, undefined, undefined];
  play_anim_sequence(var_3, 1);
}

setup_gulag_weapon_check() {
  add_spawn_skit("_encstr_AD0C1357F8D79032279A9E8133DF7660E141D1D19D", ::checkin_guard_idle);
}

checkin_guard_idle() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  setup_anim_guy();
  var_0 = [];
  var_0[var_0.size] = [::play_looping_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", "_encstr_8D5C1E360ED7B4CD33F69C6BB0CD8EBED8A12B6C5B9673FA3796E8FA9619D8AC", 2, self.spawnpoint];
  var_0[var_0.size] = [::play_single_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", "_encstr_85E2213638EB2D7399DBC9DA859B47FA36A195D85BB4DCFA6E5A1DD746EBE6470BB9C8", undefined, undefined, undefined];
  var_0[var_0.size] = [::play_looping_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", ["_encstr_9B502353D1C96C830CA86B827150A3A99049CDDB1F90757FAEA352BAF9200FDF80CB7F7003", "_encstr_8350237663A96136B63F23B2DB801B595FCB510A1828B5C6D7D3493DC9E7D4711DD7497137"], 2, self.spawnpoint];
  var_0[var_0.size] = [::play_single_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", ["_encstr_9AF2261B38D7B4B9337B9CD6B0DC1DAF1B43CA8DB65ACDEBDC8EC273C8D71C2C2FADAC3747FA0698", "_encstr_A5F226E39A9E12F3F84F031DC7C0E9371A0315C7DC74806E2A1D3F90A5E1E811C8A8B5B0EBB1D05A"], undefined];
  var_0[var_0.size] = [::play_single_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", "_encstr_B8252192201FC4235938FAEDC7A0B3818F787A2A502B7DAFD39DF1166DAEE2D91798F3", undefined];
  var_0[var_0.size] = [::play_looping_skit_anim, "_encstr_A6F70EB2E633421759FA701F5BF14557", "_encstr_8D5C1E360ED7B4CD33F69C6BB0CD8EBED8A12B6C5B9673FA3796E8FA9619D8AC", undefined, self.spawnpoint];
  var_1 = [];
  var_1[var_1.size] = [::spawn_skit_prop, "_encstr_96BD1AE9F213082861C07747F193C8C0D3A9C1916B8F3E9884A67B51", ::get_position_from_actor, ::get_angles_from_actor, "_encstr_840F26ACCAAFCCAB939BD2E85DC9CABEB1D058A593AFDAB21DC28DF5CC7B8D8C96E6D9BEDB83CAE6", 1];
  play_anim_sequence(var_0, 1);
}

play_anim_sequence(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];
      var_5 = var_4[0];
      var_6 = scripts\engine\utility::ter_op(isDefined(var_4[1]), var_4[1], undefined);
      var_7 = scripts\engine\utility::ter_op(isDefined(var_4[2]), var_4[2], undefined);
      var_8 = scripts\engine\utility::ter_op(isDefined(var_4[3]), var_4[3], undefined);
      var_9 = scripts\engine\utility::ter_op(isDefined(var_4[4]), var_4[4], undefined);
      var_10 = scripts\engine\utility::ter_op(isDefined(var_4[5]), var_4[5], undefined);
      var_11 = scripts\engine\utility::ter_op(isDefined(var_4[6]), var_4[6], undefined);
      self childthread[[var_5]](var_6, var_7, var_8, var_9, var_10);
    }
  }

  for(;;) {
    for(var_12 = 0; var_12 < var_0.size; var_12++) {
      var_4 = var_0[var_12];
      var_5 = var_4[0];
      var_6 = scripts\engine\utility::ter_op(isDefined(var_4[1]), var_4[1], undefined);
      var_7 = scripts\engine\utility::ter_op(isDefined(var_4[2]), var_4[2], undefined);
      var_8 = scripts\engine\utility::ter_op(isDefined(var_4[3]), var_4[3], undefined);
      var_9 = scripts\engine\utility::ter_op(isDefined(var_4[4]), var_4[4], undefined);
      self[[var_5]](var_6, var_7, var_8, var_9);
    }

    if(!istrue(var_1)) {
      break;
    }
  }
}

play_looping_skit_anim(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845A1681B554C9866B8BAD9BE323C0E0E3CC2B5E9EB6A049");
  self endon("_encstr_845A1681B554C9866B8BAD9BE323C0E0E3CC2B5E9EB6A049");

  if(isDefined(var_1) && !isarray(var_1)) {
    var_4 = [var_1];
    var_1 = var_4;
    var_4 = undefined;
  }

  var_5 = scripts\engine\utility::random(var_1);

  if(!isDefined(var_0))
    var_0 = "_encstr_84610D49100897C2DF809A03583BFF";

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_5);
  var_7 = scripts\asm\asm::asm_getxanim(var_0, var_6);
  var_8 = 0;
  var_9 = undefined;
  var_10 = undefined;

  if(isDefined(var_3)) {
    var_9 = var_3.origin;
    var_10 = var_3.angles;
  }

  for(;;) {
    if(isDefined(var_3)) {
      var_11 = getstartorigin(var_9, var_10, var_7);
      var_12 = getstartangles(var_9, var_10, var_7);
      self dontinterpolate();
      self forceteleport(var_11, var_12);
      self notify("_encstr_96BD1AE9F213082861C07747F193C8C0D3A9C1916B8F3E9884A67B51");
    }

    self aisetanim(var_0, var_6);
    wait(getanimlength(var_7));

    if(isDefined(var_2)) {
      var_8++;

      if(var_8 >= var_2)
        return;
    }
  }
}

play_single_skit_anim(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845A1681B554C9866B8BAD9BE323C0E0E3CC2B5E9EB6A049");
  self endon("_encstr_845A1681B554C9866B8BAD9BE323C0E0E3CC2B5E9EB6A049");

  if(isDefined(var_1) && !isarray(var_1)) {
    var_4 = [var_1];
    var_1 = var_4;
    var_4 = undefined;
  }

  var_5 = scripts\engine\utility::random(var_1);

  if(!isDefined(var_0))
    var_0 = "_encstr_84610D49100897C2DF809A03583BFF";

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_5);
  var_7 = scripts\asm\asm::asm_getxanim(var_0, var_6);
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(var_2)) {
    var_8 = var_2.origin;
    var_9 = var_2.angles;
  }

  if(isDefined(var_2)) {
    var_10 = getstartorigin(var_8, var_9, var_7);
    var_11 = getstartangles(var_8, var_9, var_7);
    self dontinterpolate();
    self forceteleport(var_10, var_11);
    self notify("_encstr_96BD1AE9F213082861C07747F193C8C0D3A9C1916B8F3E9884A67B51");
  }

  self aisetanim(var_0, var_6);
  wait(getanimlength(var_7));
}

spawn_skit_prop(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0))
    self waittill(var_0);

  if(isbuiltinfunction(var_1))
    var_1 = self[[var_1]]();

  if(isbuiltinfunction(var_2))
    var_2 = self[[var_2]]();

  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_5.angles = self.angles;
  var_5 setModel(var_3);

  if(istrue(var_4))
    var_5 disconnectPaths();

  return var_5;
}

get_position_from_actor() {
  var_0 = self gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");
  thread scripts\engine\utility::draw_line_for_time(var_0, var_0 + (0, 0, 128), 1, 1, 1, 30);
  return var_0;
}

get_angles_from_actor() {
  var_0 = self gettagangles("_encstr_8FE10B52092BB64F28E6B7BFFD");
  thread scripts\engine\utility::draw_angles(var_0, var_0 + (0, 0, 128), 1, 1, 1, 30);
  return var_0;
}