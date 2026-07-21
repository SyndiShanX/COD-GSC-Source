/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_loadout.gsc
***********************************************/

init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level.move_speed_scale = ::updatemovespeedscale;
  level.registerplayercharfunc = ::registerplayercharacter;
  init_core_mp_perks();

  if(!isDefined(level.loadoutsgroup))
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();

  scripts\cp\coop_super::init_super();

  if(!isDefined(level.classmap))
    level.classmap = [];

  level.classmap["_encstr_AB8007922817677232"] = 0;
  level.classmap["_encstr_A78007C63685CD3789"] = 1;
  level.classmap["_encstr_A18007BB31E23313B5"] = 2;
  level.classmap["_encstr_A70708DF6DCAB0B8BF17"] = 0;
  level.classmap["_encstr_A307088717F8DDDD407F"] = 1;
  level.classmap["_encstr_930708BF0DAAD0D8DF57"] = 2;
  level.classmap["_encstr_9107083785324850579F"] = 3;
  level.classmap["_encstr_8F0708D09B1239386FD5"] = 4;
  level.classmap["_encstr_B80708569588A8800563"] = 5;
  level.classmap["_encstr_AC07087767838DC0AD0B"] = 6;
  level.classmap["_encstr_BE07082645E74367A0D2"] = 7;
  level.classmap["_encstr_8E0708864DF7B39F1DDF"] = 8;
  level.classmap["_encstr_9375099857F3F3A7A2227F"] = 9;
  level.classmap["_encstr_8D550D5AB82303913579EE03EFFBEF"] = 0;
  level.classmap["_encstr_A5550D2CC3B4CDFAE459B1A5C1AC23"] = 1;
  level.classmap["_encstr_86550D77D8522756CA27B0E85BF5E3"] = 2;
  level.classmap["_encstr_BA550DB0E15A6EFA4E598D9607B268"] = 3;
  level.classmap["_encstr_A9550D58C3A56ED793568D96C1CA4D"] = 4;
  level.classmap["_encstr_8C550D2C0F5A9B7DC92B365A1CAC63"] = 5;
  level.classmap["_encstr_8F800F27CA0AC0B543DE931DA1F3137D72"] = 0;
  level.classmap["_encstr_B8800FD06D7BC43D56211B8DA6082A52D7"] = 1;
  level.classmap["_encstr_AC800FF03AE5D3A9C74F2EAD4B9733839A"] = 2;
  level.classmap["_encstr_BE800F0FE88DF9C27F303AF70613CBBD63"] = 3;
  level.classmap["_encstr_8E800FF383F28310339103F98601F0CDDF"] = 4;
  level.classmap["_encstr_82800F21CABBB32822A71523838C480D6A"] = 5;
  level.classmap["_encstr_AAAC09D09972B9C83F2B7F"] = 0;
  level.classmap["_encstr_A7AA09C616D81B26586CB5"] = 0;
  level.classmap["_encstr_A5450947E0B60E5060CB6B"] = 0;
  level.classmap["_encstr_8345096F85A579A798F922"] = 1;
  level.classmap["_encstr_8B45098A61FC578BB809DB"] = 2;
  level.classmap["_encstr_99450998AF6D91B5706B1C"] = 3;
  level.classmap["_encstr_9B4509237F5259BDAD53AD"] = 4;
  level.classmap["_encstr_A74509851A62C7E8F1E136"] = 5;
  level.classmap["_encstr_AB450911C7C6A81D6A63D7"] = 6;
  level.classmap["_encstr_9345094255FBAA9BB8CB08"] = 7;
  level.classmap["_encstr_A145098DE7DA7B1BDC7B6A"] = 8;
  level.classmap["_encstr_ADCC0A0C40507380E98383F2"] = 9;
  level.classmap["_encstr_85CC0AAB10F1211391751A12"] = 10;
  level.classmap["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = 0;
  level.defaultclass = "_encstr_A5C70EAF9C49C71B915F2F46E7D5397C";

  if(getdvarint("_encstr_8FF112A33F9B792935E3137F6ABA17EF22531BDA", 0))
    level.classtablename = "_encstr_A7F9176B385E8D8D2C6EDC475898B156AF472BE61D171BE667";
  else
    level.classtablename = "_encstr_B8F812C3DBEEAE4049F25BB31E3238D5960F774D";
}

getplayerbodymodel() {
  var_0 = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  return var_0[0];
}

return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(var_0.weaponkitinitialized))
    var_0 waittill("_encstr_81BE245F04EF42BBEA8938A082827778BFB2655B6C83CEEF142381D84A9C09D09F54E34AFD2B");

  if(isDefined(var_0.weapon_build_models[var_1]))
    return asmdevgetallstates(var_0.weapon_build_models[var_1]);
  else
    return var_2;
}

delayreturningperks(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(istrue(var_0.keep_perks)) {
    if(isDefined(var_0.zombies_perks)) {
      var_1 = getarraykeys(var_0.zombies_perks);

      foreach(var_3 in var_1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var_3]) && isDefined(level.coop_perk_callbacks[var_3].set))
          var_0[[level.coop_perk_callbacks[var_3].set]]();
      }
    }

    var_0.keep_perks = undefined;
  }
}

release_character_number(var_0) {
  var_1 = var_0.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var_1) && var_1 != 5)
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var_1);
}

get_player_character_num() {
  if(isDefined(self.player_character_num))
    return self.player_character_num;

  var_1 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = var_1;
  return var_1;
}

updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1.0;
    var_0 = var_0 + self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale))
      var_0 = self.chargemode_speedscale;
    else if(isDefined(self.siege_speedscale))
      var_0 = self.siege_speedscale;

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod))
      var_0 = var_0 + var_1.speedmod;

    if(isDefined(self.speedstripmod))
      var_0 = var_0 + self.speedstripmod;

    if(isDefined(self.phasespeedmod))
      var_0 = var_0 + self.phasespeedmod;

    if(isDefined(self.weaponaffinityspeedboost))
      var_0 = var_0 + self.weaponaffinityspeedboost;

    if(isDefined(self.weaponpassivespeedmod))
      var_0 = var_0 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      var_0 = var_0 + self.weaponpassivespeedonkillmod;

    var_0 = min(1.5, var_0);
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  self setmovespeedscale(var_0 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(var_0) {
  var_1 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("_encstr_862C19C5E885B209E03893177138CFCB73718F7DCDB72B40E970E3", "_encstr_AB0703DBB9") == "_encstr_AB0703DBB9")
    return 1.0;

  if(!self.weaponlist.size)
    var_1 = 0.9;
  else {
    var_2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var_2))
      var_1 = level.superweapons[createheadicon(var_2)].movespeed;
    else {
      var_3 = weaponinventorytype(var_2);

      if(var_3 != "_encstr_BA7F0830B3A7859B60B0" && var_3 != "_encstr_B4DC085639F9C2779108") {
        if(isDefined(self.saved_lastweapon))
          var_2 = self.saved_lastweapon;
        else
          var_2 = undefined;
      }

      if(!isDefined(var_2) || !self hasweapon(var_2))
        var_1 = getweaponspeedslowest();
      else
        var_1 = getweaponspeed(var_2);
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
}

getweaponspeed(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  var_2 = level.weaponmapdata[var_1].speed;
  return var_2;
}

getweaponspeedslowest() {
  var_0 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponspeed(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 0.9;

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

clampweaponspeed(var_0) {
  return clamp(var_0, 0.0, 1.0);
}

getweaponheaviestvalue() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponweight(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 8;

  var_0 = clampweaponweightvalue(var_0);
  return var_0;
}

getweaponweight(var_0) {
  var_1 = undefined;
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_1 = float(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = float(tablelookup(level.game_mode_statstable, 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = 10;

  return var_1;
}

clampweaponweightvalue(var_0) {
  return clamp(var_0, 0.0, 11.0);
}

wait_and_force_weapon_switch(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.5;

  if(!self hasweapon(var_0))
    var_0 = self getweaponslistprimaries()[0];

  self setspawnweapon(var_0);
}

init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = 1;
  level.scriptperks["_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F"] = 1;
  level.scriptperks["_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F"] = 1;
  level.scriptperks["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = 1;
  level.perksetfuncs["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = ::setmomentum;
  level.perkunsetfuncs["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = ::unsetmomentum;
  level.perksetfuncs["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = ::setfreefall;
  level.perkunsetfuncs["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = ::unsetfreefall;
  level.perksetfuncs["_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8"] = ::setlightweight;
  level.perkunsetfuncs["_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8"] = ::unsetlightweight;
}

setmomentum() {
  thread runmomentum();
}

runmomentum() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait 0.1;
  }
}

graduallyincreasespeed() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  thread momentum_monitormovement();
  thread momentum_monitordamage();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    updatemovespeedscale();
    wait 0.4375;
  }

  self playlocalsound("_encstr_8ED00D32E85178BB50A33F95512BA8");
  self notify("_encstr_A92313E83FEDD1A53333D1F00D5AB1DE5BDB20D07B");
  thread momentum_endaftermax();
  self waittill("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
}

momentum_endaftermax() {
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  self waittill("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
  self playlocalsound("_encstr_B2600E507538875308214A770FDADBB4");
}

momentum_monitormovement() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
        break;
      }
    }

    waitframe();
  }
}

momentum_monitordamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B2BE0788BAF573592F");
  self notify("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
}

unsetmomentum() {
  self notify("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
}

setfreefall() {}

unsetfreefall() {}

setlightweight() {
  self.movespeedscaler = lightweightscalar();
  self[[level.move_speed_scale]]();
}

unsetlightweight() {
  self.movespeedscaler = 1;
  self[[level.move_speed_scale]]();
}

lightweightscalar() {
  return 1.12;
}

set_player_perks() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_ACE709DA22939BA8075060") {
    wait 0.1;
    var_0 = 4;
    var_1 = 0;
    var_2 = 0;
    var_2 = var_0;

    if(isDefined(level.player_suit))
      self setsuit(level.player_suit);
    else
      self setsuit("_encstr_AB6C0C1784D2171608824D4727A0");

    self.suit = "_encstr_AB6C0C1784D2171608824D4727A0";
    self allowdoublejump(0);
    self allowslide(var_2 &var_0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);

  if(!scripts\cp\utility::is_consumable_active("_encstr_9B5E111C32FA7589C40F69903F17E0A9A29B37")) {
    if(isDefined(level.power_modifycooldownrate))
      self[[level.power_modifycooldownrate]](0.0);
  }

  scripts\cp\utility::giveperk("_encstr_9B2A145B1F89AF44DB704B930119FC132004D2C13E10");
  self setscriptablepartstate("_encstr_8D6D0C79D7A9D74ECACB11BF4740", "_encstr_B4250C393D87BECBF505530E27C3");
  self notify("_encstr_9342113355B349DAB88E587F3A31C1AF03B00B");
}

registerplayercharacter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();
  var_17.body_model = var_2;
  var_17.view_model = var_3;
  var_17.head_model = var_4;
  var_17.hair_model = var_5;
  var_17.vo_prefix = var_6;
  var_17.vo_suffix = var_7;
  var_17.pap_gesture = var_8;
  var_17.revive_gesture = var_9;
  var_17.photo_index = var_10;
  var_17.fate_card_weapon = var_11;
  var_17.intro_music = var_12;
  var_17.intro_gesture = var_13;
  var_17.melee_weapon = asmdevgetallstates(var_14);
  var_17.starting_weapon = asmdevgetallstates(var_16);
  var_17.post_setup_func = var_15;
  level.player_character_info[var_0] = var_17;

  if(!isDefined(level.available_player_characters))
    level.available_player_characters = [];

  if(var_1 == "_encstr_AC190463F552")
    level.available_player_characters[level.available_player_characters.size] = var_0;
}

loadout_updateclasscustom(var_0, var_1) {
  var_2 = var_1;
  self.class_num = var_2;
  var_0.loadoutprimary = cac_getweapon(var_2, 0);

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.loadoutprimaryattachments[var_3] = cac_getweaponattachment(var_2, 0, var_3);
    var_0.loadoutprimaryattachmentids[var_3] = force_interrupt_current_combat_action(var_2, 0, var_3);
  }

  var_0.loadoutprimarycamo = cac_getweaponcamo(var_2, 0);
  var_0.loadoutprimaryreticle = cac_getweaponreticle(var_2, 0);
  var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_2, 0);
  var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_2, 0);
  var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 0);

  for(var_4 = 0; var_4 < 4; var_4++)
    var_0.loadoutprimarystickers[var_4] = cac_getweaponsticker(var_2, 0, var_4);

  var_0.loadoutsecondary = cac_getweapon(var_2, 1);

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.loadoutsecondaryattachments[var_3] = cac_getweaponattachment(var_2, 1, var_3);
    var_0.loadoutsecondaryattachmentids[var_3] = force_interrupt_current_combat_action(var_2, 1, var_3);
  }

  var_0.loadoutsecondarycamo = cac_getweaponcamo(var_2, 1);
  var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_2, 1);
  var_0.loadoutsecondarylootitemid = cac_getweaponlootitemid(var_2, 1);
  var_0.loadoutsecondaryvariantid = cac_getweaponvariantid(var_2, 1);
  var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 1);

  for(var_4 = 0; var_4 < 4; var_4++)
    var_0.loadoutsecondarystickers[var_4] = cac_getweaponsticker(var_2, 1, var_4);

  var_0.loadoutequipmentprimary = cac_getequipmentprimary(var_2);
  var_0.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var_2);
  var_0.loadoutequipmentsecondary = cac_getequipmentsecondary(var_2);
  var_0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var_2);
  var_0.loadoutgesture = cac_getgesture();
  var_0.loadoutexecution = cac_getexecution();
  var_0.loadoutaccessoryweapon = cac_getaccessoryweapon();
  var_0.loadoutaccessorydata = cac_getaccessorydata();
  var_0.loadoutaccessorylogic = force_interrupt_all_current_combat_actions();
  validateloadout(var_0);
  return var_0;
}

getclassindex(var_0) {
  return level.classmap[var_0];
}

validateloadout(var_0) {
  var_1 = scripts\cp\utility::weaponnumbermap(var_0.loadoutprimary);
  var_2 = 0;

  if(!isDefined(var_1))
    var_2 = 1;
  else if(vehicle_checktrailvfx(var_0.loadoutprimary))
    var_2 = 1;

  if(attachmentisrestricted(var_0.loadoutprimary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_0.loadoutprimary = "_encstr_8C160DAFE71BF161681EB5BCB0F8FC";
    var_0.loadoutprimaryattachments = [];
    var_0.loadoutprimarycamo = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryreticle = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryvariantid = -1;
    var_0.loadoutprimaryattachmentids = [];
    var_0.loadoutprimarycosmeticattachment = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[0] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[2] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[3] = "_encstr_8BBA05185F8B99";
  } else {
    if(vehicle_collision(var_0.loadoutprimary, var_0.loadoutprimaryvariantid))
      var_0.loadoutprimaryvariantid = -1;

    for(var_4 = 0; var_4 < var_0.loadoutprimaryattachments.size; var_4++) {
      var_5 = var_0.loadoutprimaryattachments[var_4];
      var_6 = var_0.loadoutprimaryattachmentids[var_4];

      if(turrets_shields(var_0.loadoutprimary, var_5, var_6))
        var_0.loadoutprimaryattachmentids[var_4] = 0;

      if(var_5 != "_encstr_8BBA05185F8B99" && (perkisrestricted(var_5, var_0.loadoutprimary) || !vandalize(var_0.loadoutprimary, var_5))) {
        var_0.loadoutprimaryattachments[var_4] = "_encstr_8BBA05185F8B99";
        var_7 = 1;
      }
    }
  }

  var_1 = scripts\cp\utility::weaponnumbermap(var_0.loadoutsecondary);
  var_2 = 0;

  if(!isDefined(var_1))
    var_2 = 1;
  else if(vehicle_checktrailvfx(var_0.loadoutsecondary))
    var_2 = 1;

  if(attachmentisrestricted(var_0.loadoutsecondary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_0.loadoutsecondary = "_encstr_9106102387E011DF472978E0722F376ADAB9";
    var_0.loadoutsecondaryattachments = [];
    var_0.loadoutsecondarycamo = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryreticle = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryvariantid = -1;
    var_0.loadoutsecondaryattachmentids = [];
    var_0.loadoutsecondarycosmeticattachment = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[0] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[2] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[3] = "_encstr_8BBA05185F8B99";
  } else {
    if(vehicle_collision(var_0.loadoutsecondary, var_0.loadoutsecondaryvariantid))
      var_0.loadoutsecondaryvariantid = -1;

    for(var_4 = 0; var_4 < var_0.loadoutsecondaryattachments.size; var_4++) {
      var_5 = var_0.loadoutsecondaryattachments[var_4];
      var_6 = var_0.loadoutsecondaryattachmentids[var_4];

      if(turrets_shields(var_0.loadoutsecondary, var_5, var_6))
        var_0.loadoutsecondaryattachmentids[var_4] = 0;

      if(var_5 != "_encstr_8BBA05185F8B99" && (perkisrestricted(var_5, var_0.loadoutsecondary) || !vandalize(var_0.loadoutsecondary, var_5))) {
        var_0.loadoutsecondaryattachments[var_4] = "_encstr_8BBA05185F8B99";
        var_7 = 1;
      }
    }
  }

  return var_0;
}

vandalize(var_0, var_1) {
  var_2 = getdvarint("_encstr_BA901FDC36E4FA6C34ACD8B62B0B36B4C80AD1A3C26CD06BB2E6A3AAE6B1F66CB6", 0) == 1;

  if(var_2)
    return carrier_cleanup(var_0, var_1);

  return 1;
}

carrier_cleanup(var_0, var_1) {
  var_2 = level.weaponattachments[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

vehicle_checktrailvfx(var_0) {
  return isDefined(level.weaponmapdata[var_0]) && istrue(level.weaponmapdata[var_0]._id_13EFC);
}

vehicle_collision(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0)
    return 0;

  var_2 = var_0 + "_encstr_854C021F" + var_1;
  return isDefined(level.weaponlootmapdata[var_2]) && istrue(level.weaponlootmapdata[var_2].update_focus_fire_objective);
}

turrets_shields(var_0, var_1, var_2) {
  if(!isDefined(var_2) || var_2 == 0 || var_1 == "_encstr_8BBA05185F8B99")
    return 0;

  var_3 = 0;
  var_4 = 1;

  for(;;) {
    var_5 = var_0 + "_encstr_854C021F" + var_4;

    if(!isDefined(level.weaponlootmapdata[var_5])) {
      break;
    }

    if(!level.weaponlootmapdata[var_5].update_focus_fire_objective) {
      if(isDefined(level.weaponlootmapdata[var_5].attachcustomtoidmap)) {
        foreach(var_8, var_7 in level.weaponlootmapdata[var_5].attachcustomtoidmap) {
          if(var_2 == var_7 && var_1 == var_8) {
            var_3 = 1;
            break;
          }
        }
      }

      if(var_3) {
        break;
      }
    }

    var_4++;
  }

  return !var_3;
}

loadout_updateclassdefault(var_0, var_1) {
  self.class_num = var_1;
  var_0.loadoutprimary = table_getweapon(level.classtablename, var_1, 0);

  for(var_2 = 0; var_2 < 5; var_2++)
    var_0.loadoutprimaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 0, var_2);

  var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_1, 0);
  var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_1, 0);
  var_0.loadoutsecondary = table_getweapon(level.classtablename, var_1, 1);

  for(var_2 = 0; var_2 < 5; var_2++)
    var_0.loadoutsecondaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 1, var_2);

  var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_1, 1);
  var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_1, 1);
  var_0.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var_1);
  var_0.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var_1);
  var_0.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var_1);
  var_0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var_1);
  var_0.loadoutgesture = table_getgesture(level.classtablename, var_1);
  var_0.loadoutexecution = cac_getexecution();
  var_0.loadoutaccessoryweapon = cac_getaccessoryweapon();
  var_0.loadoutaccessorydata = cac_getaccessorydata();
  var_0.loadoutaccessorylogic = force_interrupt_all_current_combat_actions();

  if(getdvarint("_encstr_A9FC18078342216E07CB69F3D017A688DF34BB97202B81BF4352", 0))
    var_0.loadoutsuper = "_encstr_92520EE65707594E7D894E1646C62BE5";

  return var_0;
}

cac_getgesture() {
  var_0 = "_encstr_8BBA05185F8B99";

  if(isDefined(self.changedarchetypeinfo)) {
    var_1 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_84B415C293C6D0B2D15EC1CAA039AC33B2C995E6C6B2CD", var_1, "_encstr_8F0508CE59DCA357392B");
  } else
    var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8F0508CE59DCA357392B");

  return scripts\cp_mp\gestures::getgesturedata(var_0);
}

cac_getaccessoryweapon() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8AB00E403B67A5699B3F6EF409A31159");
  return scripts\cp\cp_accessories::getaccessoryweaponbyindex(var_0);
}

cac_getaccessorydata() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8AB00E403B67A5699B3F6EF409A31159");
  return scripts\cp\cp_accessories::getaccessorydatabyindex(var_0);
}

force_interrupt_all_current_combat_actions() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8AB00E403B67A5699B3F6EF409A31159");
  return scripts\cp\cp_accessories::register_respawn_functions(var_0);
}

cac_getexecution() {
  return "_encstr_A55B0A80A22E2F16CF7CBF26";
}

cac_getweaponsticker(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_929E081F5412E20869BD", var_2);
}

loadout_getclassstruct() {
  var_0 = spawnStruct();
  var_0.loadoutarchetype = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimary = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimaryattachments = [];
  var_0.loadoutprimaryattachmentids = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0.loadoutprimaryattachments[var_1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryattachmentids[var_1] = 0;
  }

  var_0.loadoutprimarycamo = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimaryreticle = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimarylootitemid = 0;
  var_0.loadoutprimaryvariantid = -1;
  var_0.loadoutprimarycosmeticattachment = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimaryweaponstickers = [];

  for(var_2 = 0; var_2 < 4; var_2++)
    var_0.loadoutprimarystickers[var_2] = "_encstr_8BBA05185F8B99";

  var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondaryattachments = [];
  var_0.loadoutsecondaryattachmentids = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0.loadoutsecondaryattachments[var_1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryattachmentids[var_1] = 0;
  }

  var_0.loadoutsecondarycamo = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondaryreticle = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondarylootitemid = 0;
  var_0.loadoutsecondaryvariantid = -1;
  var_0.loadoutsecondarycosmeticattachment = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondaryweaponstickers = [];

  for(var_2 = 0; var_2 < 4; var_2++)
    var_0.loadoutsecondaryweaponstickers[var_2] = "_encstr_8BBA05185F8B99";

  var_0.loadoutmeleeslot = "_encstr_8BBA05185F8B99";
  var_0.loadoutperksfromgamemode = 0;
  var_0.loadoutperks = [];
  var_0.loadoutstandardperks = [];
  var_0.loadoutextraperks = [];
  var_0.loadoutrigtrait = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  var_0.loadoutequipmentprimary = "_encstr_8BBA05185F8B99";
  var_0.loadoutextraequipmentprimary = 0;
  var_0.loadoutequipmentsecondary = "_encstr_8BBA05185F8B99";
  var_0.loadoutextraequipmentsecondary = 0;
  var_0.loadoutsuper = "_encstr_8BBA05185F8B99";
  var_0.loadoutfieldupgrade1 = "_encstr_8BBA05185F8B99";
  var_0.loadoutfieldupgrade2 = "_encstr_8BBA05185F8B99";
  var_0.loadoutgesture = "_encstr_8BBA05185F8B99";
  var_0.loadoutaccessorydata = "_encstr_8BBA05185F8B99";
  var_0.loadoutaccessoryweapon = "_encstr_8BBA05185F8B99";
  var_0.loadoutexecution = "_encstr_8BBA05185F8B99";
  var_0.loadoutstreaksfilled = 0;
  var_0.loadoutstreaktype = "_encstr_ABB313CD4793CA16B5A3CB38B27D0BCD9B165DC6D1";
  var_0.loadoutkillstreak1 = "_encstr_8BBA05185F8B99";
  var_0.loadoutkillstreak2 = "_encstr_8BBA05185F8B99";
  var_0.loadoutkillstreak3 = "_encstr_8BBA05185F8B99";
  return var_0;
}

give_weapons_from_loadout(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_4 = var_0 cac_getloadoutselectedidx();

  if(isDefined(var_1))
    var_3 = loadout_updateclassdefault(var_2, var_1);
  else
    var_3 = loadout_updateclasscustom(var_2, var_4);

  self.intro_drive_along_path = var_4;
  self.classstruct = var_3;
  cargo_truck_mg_deletenextframe(var_0, var_3);
  var_5 = get_num_of_charges_for_power(var_0, "_encstr_BA7F0830B3A7859B60B0");
  var_6 = get_grenade_from_struct(var_3.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_6))
    var_6 = "_encstr_8BBA05185F8B99";

  var_7 = get_num_of_charges_for_power(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  var_8 = get_grenade_from_struct(var_3.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_8))
    var_8 = "_encstr_8BBA05185F8B99";

  var_9 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");

  if(!istrue(self.getc130knownsafeheight)) {
    var_0 scripts\cp\cp_munitions::reset_munitions(self, var_9);
    var_0 scripts\cp\cp_munitions::cargo_truck_mg_enterend();
  }

  var_0 thread scripts\cp\cp_powers::givepower(var_6, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, var_5);
  var_0 thread scripts\cp\cp_powers::givepower(var_8, "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, var_7);
}

get_num_of_charges_for_power(var_0, var_1) {
  if(isDefined(level.get_num_of_charges_for_power))
    return [[level.get_num_of_charges_for_power]](var_0);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_2 = cac_getloadoutperk(undefined, 2);

    if(var_2 == "_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6")
      scripts\cp\utility::giveperk("_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953");
  }

  if(scripts\cp\utility::_hasperk("_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953") && var_1 == "_encstr_BA7F0830B3A7859B60B0")
    return 2;

  if(isDefined(self.perk_data["_encstr_A33E0ED0FF02B17136C3B1588745E8F1"]))
    return self.perk_data["_encstr_A33E0ED0FF02B17136C3B1588745E8F1"];

  return 1;
}

get_default_num_equipment_charges() {
  return 1;
}

scout_drone(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 cac_getloadoutselectedidx();

  if(isDefined(var_2))
    var_5 = loadout_updateclassdefault(var_3, var_2);
  else
    var_5 = loadout_updateclasscustom(var_3, var_4);

  var_6 = get_num_of_charges_for_power(var_0, "_encstr_BA7F0830B3A7859B60B0");
  var_7 = get_grenade_from_struct(var_5.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_7))
    var_7 = "_encstr_8BBA05185F8B99";

  var_8 = get_num_of_charges_for_power(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  var_9 = get_grenade_from_struct(var_5.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_9))
    var_9 = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_1)) {
    var_0 thread scripts\cp\cp_powers::givepower(var_7, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, var_6);
    var_0 thread scripts\cp\cp_powers::givepower(var_9, "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, var_8);
  } else if(var_1 == 0)
    var_0 thread scripts\cp\cp_powers::givepower(var_7, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, var_6);
  else if(var_1 == 1)
    var_0 thread scripts\cp\cp_powers::givepower(var_9, "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, var_8);
}

scoreeventnoweaponxp(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0 cac_getloadoutselectedidx();
  var_3 = loadout_updateclasscustom(var_1, var_2);
  var_3.loadoutprimaryobject = var_0 give_primary_weapon(var_0, var_3);
  var_4 = weaponclipsize(var_1.loadoutprimaryobject);
  var_5 = weaponmaxammo(var_1.loadoutprimaryobject);
  var_0 giveweapon(var_1.loadoutprimaryobject);
  var_0 setweaponammoclip(var_1.loadoutprimaryobject, var_4);
  var_0 setweaponammostock(var_1.loadoutprimaryobject, var_5);
  var_0 switchtoweapon(var_1.loadoutprimaryobject);
}

script_struct_autotarget(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 cac_getloadoutselectedidx();
  var_5 = loadout_updateclasscustom(var_3, var_4);
  var_5.loadoutprimaryobject = var_0 give_primary_weapon(var_0, var_5);
  var_0 giveweapon(var_3.loadoutprimaryobject);
  var_0 setweaponammoclip(var_3.loadoutprimaryobject, var_1);
  var_0 setweaponammostock(var_3.loadoutprimaryobject, var_2);
  var_0 switchtoweapon(var_3.loadoutprimaryobject);
}

scoreleadchanged(var_0, var_1) {
  var_1 = spawnStruct();
  var_2 = var_0 cac_getloadoutselectedidx();
  var_3 = loadout_updateclasscustom(var_1, var_2);
  var_3.loadoutsecondaryobject = var_0 give_secondary_weapon(var_0, var_3);
  var_4 = weaponclipsize(var_3.loadoutsecondaryobject);
  var_5 = weaponmaxammo(var_3.loadoutsecondaryobject);
  var_0 giveweapon(var_3.loadoutsecondaryobject);
  var_0 setweaponammoclip(var_3.loadoutsecondaryobject, var_4);
  var_0 setweaponammostock(var_3.loadoutsecondaryobject, var_5);
  var_0 switchtoweaponimmediate(var_3.loadoutsecondaryobject);
}

scriptable_damaged_funcs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_0 cac_getloadoutselectedidx();
  var_5 = loadout_updateclasscustom(var_3, var_4);
  var_5.loadoutsecondaryobject = var_0 give_secondary_weapon(var_0, var_5);
  var_0 giveweapon(var_3.loadoutsecondaryobject);
  var_0 setweaponammoclip(var_3.loadoutsecondaryobject, var_1);
  var_0 setweaponammostock(var_3.loadoutsecondaryobject, var_2);
  var_0 switchtoweapon(var_3.loadoutsecondaryobject);
}

change_loadout_watcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(var_1 == "_encstr_A5EF0DF98DF99B2651677B6157FAED" || var_1 == "_encstr_88D00B37718B3BE3F7ED25D31C" || var_1 == "_encstr_81EC128DC6859BCDD75B95E657D76CD8ED6ECAC8") {
      if(is_player_carrying_special_item())
        self notify("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349");

      if(var_1 == "_encstr_A5EF0DF98DF99B2651677B6157FAED") {
        if(var_2 >= 100)
          var_3 = var_2 - 100;
        else
          var_3 = undefined;

        if(scripts\cp\cp_laststand::player_in_laststand(self))
          self notify("_encstr_A26014B9FAC2217A9FF9B95DA585BB79A34CFFD8CD71");
        else {
          self.getc130knownsafeheight = 1;
          self.juggernautoutsidegoalradius = var_3;

          if(scripts\engine\utility::ent_flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0") && scripts\engine\utility::ent_flag("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
            self[[level.custom_giveloadout]](0, undefined, var_3, 1);
          else
            self[[level.custom_giveloadout]](0, undefined, var_3);
        }

        thread logevent_spawnviateamrevive(self, 5);
      }

      if(var_1 == "_encstr_81EC128DC6859BCDD75B95E657D76CD8ED6ECAC8") {
        self notify("_encstr_A26014B9FAC2217A9FF9B95DA585BB79A34CFFD8CD71");

        if(scripts\cp\utility::turn_off_sniper_laser())
          thread flip_target();
      }

      continue;
    }

    if(var_1 == "_encstr_AF3E0DAD28FC38258D1798B881475B") {
      scripts\cp\coop_super::give_player_super();
      continue;
    }

    if(var_1 == "_encstr_865412719B221333D10FD838E7E58BB17A43FD0D") {
      var_4 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");
      scripts\cp\cp_munitions::reset_munitions(self, var_4);

      if(scripts\cp\utility::turn_off_sniper_laser()) {
        _id_139D7();
        thread flip_target();
      }

      continue;
    }

    if(var_1 == "_encstr_A10511BB565807ED37BE38BA4EB1A1B0DC2B8C" && scripts\cp\utility::turn_off_sniper_laser()) {
      _id_139D7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        var_0 waittill("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        waitframe();
      }

      if(self getweaponslistprimaries().size > 1) {
        var_5 = scripts\cp\utility::getvalidtakeweapon();
        self takeweapon(var_5);
      }

      if(self._id_120B7 == 0)
        scoreeventnoweaponxp(self);
      else if(self._id_120B7 == 1)
        scoreleadchanged(self);

      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE");
      continue;
    }

    if(var_1 == "_encstr_AD33150BA38E16D8A1DAB2B9A3F51CBA93B1D02CE62B46" && scripts\cp\utility::turn_off_sniper_laser()) {
      _id_139D7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        var_0 waittill("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        waitframe();
      }

      var_5 = scripts\cp\utility::getvalidtakeweapon();
      var_6 = self getweaponammoclip(var_5);
      var_7 = self getweaponammostock(var_5);
      self takeweapon(var_5);

      if(self._id_120B7 == 0)
        script_struct_autotarget(self, var_6, var_7);
      else if(self._id_120B7 == 1)
        scriptable_damaged_funcs(self, var_6, var_7);

      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_869B19EAD880971957090B570F8B62CDE803A2B9B1605672362B6F");
      continue;
    }

    if(var_1 == "_encstr_B8D613C0E3E6ED377EB31BD0B0B5888B83A9630301" && scripts\cp\utility::turn_off_sniper_laser()) {
      _id_139D7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        var_0 waittill("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        waitframe();
      }

      scout_drone(self, 1, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE");
      continue;
    }

    if(var_1 == "_encstr_9A3911F9C51B1A067DD16335EA1E08D723E25A" && scripts\cp\utility::turn_off_sniper_laser()) {
      _id_139D7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        var_0 waittill("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        waitframe();
      }

      scout_drone(self, 0, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE");
      continue;
    }

    if(var_1 == "_encstr_B6BB18235422586FBAF7B1CFBBD2B6C0F7AA6B9B3E900BA662DB" && scripts\cp\utility::turn_off_sniper_laser()) {
      _id_139D7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        var_0 waittill("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        waitframe();
      }

      scout_drone(self, 0, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE");
      continue;
    }

    if(var_1 == "_encstr_933C0F7A6BB3BD1F53ED222B0B19E747D9" && scripts\cp\utility::turn_off_sniper_laser()) {
      var_5 = scripts\cp\utility::getvalidtakeweapon();
      _id_139D7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        var_0 waittill("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
        waitframe();
      }

      self givemaxammo(var_5);
      self setweaponammoclip(var_5, weaponclipsize(var_5));
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_AF4D07932B1BDE5846", undefined, 0.2);
    }
  }
}

logevent_spawnviateamrevive(var_0, var_1) {
  wait 1.5;

  if(level.set_relics.size > 0) {
    var_0 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_1);
    wait(var_1);
    var_0 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  }
}

flip_target() {
  self clearsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
}

_id_139D7() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_85A411D6B5F5337DD038CF6F308B3588B745DF");
  scripts\cp\cp_persistence::set_player_currency(var_0);
}

get_grenade_from_struct(var_0) {
  switch (var_0) {
    case "_encstr_8C450D955CD52D07D7DC2BB6A39587":
      return "_encstr_A76F0D83DB77B239AF372BB54756E1";
    case "_encstr_84CB0CB2680B841B3E76A5AF0201":
      return "_encstr_ABE813B8E843EAD21733C8EF4C832F8BBB8581C741";
    case "_encstr_8BBB0B9D41E718D9E922D8582A":
      return "_encstr_81580B52FF3F7F3D195A6A61A7";
    case "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9":
      return "_encstr_87CB0E0B177C92B2411875BD7030E71B";
    case "_encstr_82A70F2B3B73E33B472371FF21D7809DDF":
      return "_encstr_8E910FA7E764B78317A2C973305A28B33B";
    case "_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F":
      return "_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F";
    case "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381":
      return "_encstr_B8F514D0A28B93131F1C5B4EEF57B87D7708B8908AA7";
    case "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC":
      return "_encstr_8D4919C1BDDD5627F5A334E4DBDDB4CDB369B95ACCB2BE332D2795";
    case "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B":
      return "_encstr_B8631DCA3868B5EB68291B7B772402E64004C514F12B4752D9134F7B75C36A";
    case "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1":
      return "_encstr_A6901AE78F3F490D39B3B890FACBF3E0A70360D31E1F76795A4A9068";
    case "_encstr_843D095F2B7D52B041D9A3":
      return "_encstr_8D7C09102FE7216D71A66D";
    case "_encstr_A78210CAB8D5A507FAA198F5CD2BCDE6BD93":
      return "_encstr_A78210CAB8D5A507FAA198F5CD2BCDE6BD93";
    case "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61":
      return "_encstr_A5B00F4AB8E8356BE8A99BA7CDA9827CD0";
    case "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95":
      return "_encstr_8B960D1CF6DD599CD7C247A94BCD56";
    case "_encstr_BD170C5B689B786221E98009A80C":
      return "_encstr_B81D0C38EDBB56C9F599B12CDC34";
    case "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E":
      return "_encstr_A71C18E89AB3BB3B07E330B8FB77C35F9C2290C9234FF511C30D";
    case "_encstr_AA870D15FAF37393C74318F8BB184A":
      return "_encstr_92D60D79F74BB8B6F7C333986BC3EB";
    case "_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02":
      return "_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895";
    case "_encstr_820F114AE740032B7F8680CAD930B1D239F212":
      return "_encstr_820F114AE740032B7F8680CAD930B1D239F212";
    case "_encstr_8B0E0CAC5CAB4B38FA46566CBDF2":
      return "_encstr_8B0E0CAC5CAB4B38FA46566CBDF2";
    default:
      return "_encstr_8BBA05185F8B99";
  }
}

cac_getloadoutselectedidx() {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_99500DC6137977023DD7D72B57551A");
}

cac_getloadoutperk(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_86CB0DFB97F7022F90BB3A7F53487B", var_1);
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_86CB0DFB97F7022F90BB3A7F53487B", var_1);
}

cac_getloadoutextraperk(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_88350B3DCA135B1A8FAA969243", var_1);
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_88350B3DCA135B1A8FAA969243", var_1);
}

cac_getweapon(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_AC20072B9FA9487832");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_AC20072B9FA9487832");
}

cac_getweaponattachment(var_0, var_1, var_2) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_2, "_encstr_B19A0BD803A4E10F42E50598BB");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_2, "_encstr_B19A0BD803A4E10F42E50598BB");
}

force_interrupt_current_combat_action(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_2, "_encstr_8A3E0A0D67C353E09EEBD48D");
}

cac_getweaponlootitemid(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_8DE00B8DF6DBA34AD1B2D64A88");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_8DE00B8DF6DBA34AD1B2D64A88");
}

cac_getweaponvariantid(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_8A3E0A0D67C353E09EEBD48D");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_8A3E0A0D67C353E09EEBD48D");
}

cac_getweaponcamo(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_B19005D885B5F6");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_B19005D885B5F6");
}

cac_getweaponreticle(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_925008E456475A6CB195");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_925008E456475A6CB195");
}

cac_getweaponcosmeticattachment(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_88AC1316CD5A9A3BEBCB973F34541E073007CDED93");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_88AC1316CD5A9A3BEBCB973F34541E073007CDED93");
}

cac_checkoverkillperk(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_86CB0DFB97F7022F90BB3A7F53487B", 0);
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_86CB0DFB97F7022F90BB3A7F53487B", 0);
}

cac_getequipmentprimary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 0, "_encstr_BE8F0A272F9B2BE97268AE8B");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 0, "_encstr_BE8F0A272F9B2BE97268AE8B");
}

cac_getextraequipmentprimary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 0, "_encstr_8E770C58F36B9D518FE03FAEC73F");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 0, "_encstr_8E770C58F36B9D518FE03FAEC73F");
}

cac_getequipmentsecondary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 1, "_encstr_BE8F0A272F9B2BE97268AE8B");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 1, "_encstr_BE8F0A272F9B2BE97268AE8B");
}

cac_getextraequipmentsecondary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8DA21036F6B023F6EA47ABC2D9CAA6ED8CCA", "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 1, "_encstr_8E770C58F36B9D518FE03FAEC73F");
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 1, "_encstr_8E770C58F36B9D518FE03FAEC73F");
}

cargo_truck_mg_deletenextframe(var_0, var_1) {
  if(var_1.loadoutprimary == "_encstr_8BBA05185F8B99") {
    var_1.loadoutprimaryfullname = "_encstr_8BBA05185F8B99";
    var_1.loadoutprimaryobject = undefined;
  } else {
    var_1.loadoutprimaryobject = scripts\cp\cp_weapon::buildweapon(var_1.loadoutprimary, var_1.loadoutprimaryattachments, var_1.loadoutprimarycamo, var_1.loadoutprimaryreticle, var_1.loadoutprimaryvariantid, var_1.loadoutprimaryattachmentids, var_1.loadoutprimarycosmeticattachment, var_1.loadoutprimarystickers, istrue(var_1.loadouthasnvg));
    var_1.loadoutprimaryobject = scriptable_door_get_in_radius(var_0, var_1.loadoutprimaryobject);
    var_1.loadoutprimaryfullname = createheadicon(var_1.loadoutprimaryobject);
  }

  if(var_1.loadoutsecondary == "_encstr_8BBA05185F8B99") {
    var_1.loadoutsecondaryfullname = "_encstr_8BBA05185F8B99";
    var_1.loadoutsecondaryobject = undefined;
  } else {
    var_1.loadoutsecondaryobject = scripts\cp\cp_weapon::buildweapon(var_1.loadoutsecondary, var_1.loadoutsecondaryattachments, var_1.loadoutsecondarycamo, var_1.loadoutsecondaryreticle, var_1.loadoutsecondaryvariantid, var_1.loadoutsecondaryattachmentids, var_1.loadoutsecondarycosmeticattachment, var_1.loadoutsecondarystickers, istrue(var_1.loadouthasnvg));
    var_1.loadoutsecondaryobject = scriptable_door_get_in_radius(var_0, var_1.loadoutsecondaryobject);
    var_1.loadoutsecondaryfullname = createheadicon(var_1.loadoutsecondaryobject);
  }

  var_0.starting_weapon = var_1.loadoutprimaryobject;
  var_0.primaryweaponobj = var_0.starting_weapon;
  var_0.default_starting_pistol = var_1.loadoutsecondaryobject;
  var_0.secondaryweaponobj = var_0.default_starting_pistol;
}

give_primary_weapon(var_0, var_1) {
  return scripts\cp\cp_weapon::buildweapon(var_1.loadoutprimary, var_1.loadoutprimaryattachments);
}

give_secondary_weapon(var_0, var_1) {
  return scripts\cp\cp_weapon::buildweapon(var_1.loadoutsecondary, var_1.loadoutsecondaryattachments);
}

scriptable_door_get_in_radius(var_0, var_1) {
  var_2 = var_1 getaltweapon();

  if(var_2.basename != "_encstr_8BBA05185F8B99") {
    var_3 = weaponclass(var_2);

    if(var_3 == "_encstr_A1100738A33A638123")
      var_0 setweaponammoclip(var_2, weaponclipsize(var_2));
  }

  return var_1;
}

table_getarchetype(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1", var_1 + 1);
}

table_getloadoutname(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_ADDA0C81370E70F89F03F419FAB7", var_1 + 1);
}

table_getweapon(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_1 + 1);
  else
    return tablelookup(var_0, 0, "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_1 + 1);
}

table_getweaponattachment(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_8BBA05185F8B99";

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878" + (var_3 + 1), var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB" + (var_3 + 1), var_1 + 1);

  if(var_4 == "_encstr_B40101" || var_4 == "_encstr_8BBA05185F8B99")
    return "_encstr_8BBA05185F8B99";
  else
    return var_4;
}

table_getweaponcamo(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED", var_1 + 1);
  else
    return tablelookup(var_0, 0, "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560", var_1 + 1);
}

table_getweaponreticle(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3", var_1 + 1);
  else
    return tablelookup(var_0, 0, "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D", var_1 + 1);
}

table_getperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "_encstr_AD0E0C49FFD6A830573B7FC143F7" + (var_2 + 1), var_1 + 1);
}

table_getextraperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "_encstr_8EAD11E1576E1098FF63B51A4BCB476987A217" + (var_2 + 1), var_1 + 1);
}

table_getequipmentprimary(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_1 + 1);
}

table_getextraequipmentprimary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B", var_1 + 1);
  return isDefined(var_2) && var_2 == "_encstr_AAEF05B9394BAB";
}

table_getequipmentsecondary(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_1 + 1);
}

table_getextraequipmentsecondary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617", var_1 + 1);
  return isDefined(var_2) && var_2 == "_encstr_AAEF05B9394BAB";
}

table_getsuper(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_85920D9D304BCAFF3B38EF7F3011BA", var_1 + 1);
}

table_getspecialist(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "_encstr_A1AF127930DEA598DB6B4723D21841095413CABD", var_1 + 1);
  return isDefined(var_2) && var_2 == "_encstr_AAEF05B9394BAB";
}

table_getgesture(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_B4450F51E53FE10F4B0C1791B7ABED8085", var_1 + 1);
}

table_getaccessory(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_A705111CF85BBB97531BE8D8909F9B1B570231", var_1 + 1);
}

table_getexecution(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD", var_1 + 1);
}

table_getkillstreak(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "_encstr_8AA50E70256120B05BC3BFC9E3628F10" + var_2, var_1 + 1);
}

_id_139E5(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_9BFC0C5BFFFECF774B3C223863DF", var_1 + 1);
}

getclasschoice(var_0) {
  var_0++;
  var_1 = undefined;

  if(var_0 > 100) {
    var_2 = var_0 - 100;
    var_1 = "_encstr_8B1608EC43B8D647A113" + var_2;
  } else
    var_1 = "_encstr_BD34078D57B9A37BD6" + var_0;

  return var_1;
}

is_player_carrying_special_item() {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self)
    return 1;
  else if(scripts\cp\cp_weapon::_id_124AD(self))
    return 1;
  else
    return 0;
}

drop_special_item() {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(istrue(self.binc130)) {
      return;
    }
    if(isDefined(self.play_disguise_vo)) {
      level.nuclear_core_carrier = undefined;

      if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
        if(istrue(self.oob)) {
          self notify("_encstr_A38711702563083D9AAFC59FFB138F50333F3B");
          level._id_11EDF.origin = getEnt("_encstr_85D215A6639239E0435A4F5B801DD3C7291A5766E9D50D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
          level._id_11EDF.angles = getEnt("_encstr_85D215A6639239E0435A4F5B801DD3C7291A5766E9D50D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles;
        }
      }

      if(isDefined(self.headicon))
        thread scripts\cp\utility::ent_deleteheadicon(self, self.headicon);

      var_0 = self.origin;

      if(scripts\cp\cp_outofbounds::isoob(self, 0))
        var_0 = level._id_11EDF.origin;

      level.nuclear_core = scripts\cp\respawn\cp_respawn::_id_11AA1(var_0 + (0, 0, 64));

      if(isDefined(self.primaryweaponobj)) {
        scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

        if(isDefined(self.primaryweaponclipammo)) {
          self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
          self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
        }
      }

      if(isDefined(self.secondaryweaponobj)) {
        scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

        if(isDefined(self.secondaryweaponclipammo)) {
          self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
          self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
          return;
        }

        return;
      }
    } else if(!istrue(self.c4_placed_bc)) {
      level.nuclear_core_carrier = undefined;
      self.c4_placed_bc = undefined;
      thread scripts\cp\respawn\cp_respawn::dropnukeweapon("_encstr_8CBE0BD1BED30936AB03C0B02B", self.previousweaponbeforenukein747);
    } else {}
  } else if(scripts\cp\cp_weapon::_id_124AD(self))
    scripts\cp\cp_weapon::minigamefinishcount(self);
}