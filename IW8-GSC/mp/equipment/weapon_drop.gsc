/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\weapon_drop.gsc
***********************************************/

weapondrop_init() {
  level._effect["_encstr_8C67132B924787C02DEF6145F79279C3DF5B61516B"] = loadfx("_encstr_A58B337BB2F1AFF7101B1F07A36FB7C338C1FF4B4268DE83C893DD8BD998EFE33DC02077D1A3072EF40868AF277F3B6B1B0214A48B");
}

weapondrop_beginsuper() {
  thread weapondrop_givedropweapon();
  return 1;
}

weapondrop_givedropweapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_83AC0BD465392B7F30EBAA055B", self);
  var_0.deployweaponobj = getcompleteweaponname("_encstr_A6AB15078F8AEBD883CFBB7F6A7BA560BA5595F3CF3293");
  scripts\common\utility::allow_killstreaks(0);
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_0.deployweaponobj, "_encstr_9B620D8F0DC07577C551F16A3826BF");
  scripts\common\utility::allow_killstreaks(1);

  if(istrue(var_1)) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]]();
  } else if(scripts\mp\supers::issuperinuse()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]](1);
  }
}

weapondrop_used(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_860808CB78E2984063BA", var_1);
  var_0 weapondrop_deploydrone(self, var_1);
  return 1;
}

weapondrop_deploydrone(var_0, var_1) {
  var_2 = var_0 scripts\cp_mp\killstreaks\helper_drone::deliverydrone_delivertopoint(var_1, ::weapondrop_dronedelivery);

  if(isDefined(var_2)) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_3 setModel("_encstr_A3D1208F70B029038B760889D6956AFC39592B67F8689CF9CB0F97FACF51E28FEB82");
    var_3 setotherent(var_0);
    var_3.owner = var_0;
    var_3.team = var_0.team;
    var_3 linkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, -15), (0, 0, 0));
    var_3 enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");

    if(level.teambased)
      var_3 filteroutplayermarks(var_0.team);
    else
      var_3 filteroutplayermarks(var_0);

    var_2.deliverybox = var_3;
    var_2 thread _id_1457F(var_3);
  }
}

weapondrop_dronedelivery() {
  self.deliverybox weapondrop_createdrop();
}

_id_1457F(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");
  var_0 endon("_encstr_95E6148C59D8A5672B9C2F21F63CFA324EED38C15991");
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");
  var_0 thread weapondrop_createdrop();
}

weapondrop_createdrop() {
  if(istrue(self.should_give_grenades)) {
    return;
  }
  self.should_give_grenades = 1;
  self notify("_encstr_95E6148C59D8A5672B9C2F21F63CFA324EED38C15991");
  self unlink();
  infinite_chopper();
  var_0 = self.origin - (0, 0, 1000);
  scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(var_0, 100, 1000, 30.0, self.owner, self.team);
  thread watchcrateimpact();
  thread watchcratesettle();
}

deletecrate() {
  infilweaponraise();
  self delete();
}

infinite_chopper() {
  if(istrue(self._id_12331)) {
    return;
  }
  self._id_12331 = 1;
  self.unresolved_collision_kill = 1;
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_0 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_0, (0, 0, -1));
  self physics_registerforcollisioncallback();
}

infilweaponraise() {
  if(!istrue(self._id_12331)) {
    return;
  }
  self notify("_encstr_9AFE126CE4B01DB2EBE04397E6D2D8CDD7DE99CC");
  self._id_12331 = undefined;
  self.unresolved_collision_kill = undefined;
  self physicsstopserver();
  self physics_unregisterforcollisioncallback();
  self stoploopsound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone();
}

watchcratesettle() {
  self endon("_encstr_9AFE126CE4B01DB2EBE04397E6D2D8CDD7DE99CC");
  watchcratesettleinternal();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")]]()) {
      thread deletecrate();
      return;
    }
  }

  self.owner thread scripts\mp\equipment\ammo_box::ammobox_settled(self);
  thread infilweaponraise();
}

watchcratesettleinternal() {
  wait 1;
  var_0 = gettime() + 10000;

  while(gettime() < var_0) {
    var_1 = self physics_getbodyid(0);
    var_2 = physics_getbodylinvel(var_1);

    if(lengthsquared(var_2) <= 0.5) {
      break;
    }

    waitframe();
  }
}

watchcrateimpact(var_0) {
  self endon("_encstr_9AFE126CE4B01DB2EBE04397E6D2D8CDD7DE99CC");
  self playLoopSound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");

  if(isDefined(var_0))
    wait(var_0);

  var_1 = 0;

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks())
      var_9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();

    if(gettime() - var_1 >= 200) {
      var_1 = gettime();
      var_10 = physics_getsurfacetypefromflags(var_5);
      var_11 = getsubstr(var_10["_encstr_84BA05A8CA852B"], 9);

      if(var_11 == "_encstr_A1140EEA6EB2E4EB3A9593C90BB4734C")
        var_11 = "_encstr_AA9D0F9543A77B872312D8C04A3CAD964E";

      if(var_11 == "_encstr_9B140E63868B6317C37893AB6058EEDF")
        var_11 = "_encstr_8A9D0F4F7F25B3CF2829E2EA412836B9A5";

      _id_1245C(var_6, var_7, var_8, var_11);
    }
  }
}

_id_1245C(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("_encstr_8C67132B924787C02DEF6145F79279C3DF5B61516B"), var_0, var_1);

  if(var_2 < 150)
    self playsurfacesound("_encstr_8EC81BB5C1FAB185C995EB072C366D0BCEB27DB1DE77EBA5B583851BD1", var_3);
  else if(var_2 < 300)
    self playsurfacesound("_encstr_BD5C1BF7C0AE2B5AB5E5897ADFBF32F17180C77FF0615F82F3070EB6BD", var_3);
  else
    self playsurfacesound("_encstr_BEEB1CF5796146279E0141BBE97E77BEC8CB4F48E3784C17CB38ABD2B1CD", var_3);

  self stoploopsound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
}