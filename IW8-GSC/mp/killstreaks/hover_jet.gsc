/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\hover_jet.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8C980A867B3B569CFAA659E8", ::tryusehoverjetfromstruct);
  level.hoverjets = [];
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data("_encstr_8C980A867B3B569CFAA659E8", 12);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1, "_encstr_8C980A867B3B569CFAA659E8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_8C980A867B3B569CFAA659E8", 24, "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 1, "_encstr_8C980A867B3B569CFAA659E8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_8C980A867B3B569CFAA659E8", 9, "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 1, "_encstr_8C980A867B3B569CFAA659E8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_8C980A867B3B569CFAA659E8", 50, "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 1, "_encstr_8C980A867B3B569CFAA659E8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_8C980A867B3B569CFAA659E8", 13, "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1, "_encstr_8C980A867B3B569CFAA659E8");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_8C980A867B3B569CFAA659E8", 18, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  init_hover_jet_anims();
  init_hover_jet_vo();
  level.incomingallhoverjets = 0;
  level.incominghoverjets["_encstr_9A8507BA4040188D08"] = 0;
  level.incominghoverjets["_encstr_8E8405EA382B2A"] = 0;
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

init_hover_jet_anims() {
  level.scr_anim["_encstr_8C980A867B3B569CFAA659E8"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"] = % _encstr_9AD80FD6E0EB34C2366616EB338D97B437;
  level.scr_anim["_encstr_8C980A867B3B569CFAA659E8"]["_encstr_A760055987D2E8"] = % _encstr_B6290ED61CD71A161B6658EB2BC3B447;
}

init_hover_jet_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82890F1A7B3B5927D735CAA3AF6BDE3B56"] = "_encstr_865F168A70E55FCB16C2959C70F947646DD8E34258A997AF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DBF10D0ED67CA4EF553B2A3D776D5B02719"] = "_encstr_8DBF10D0ED67CA4EF553B2A3D776D5B02719";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A71411F3289B3D7BDF52376BD04552C1E39007"] = "_encstr_A71411F3289B3D7BDF52376BD04552C1E39007";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_878117A34DF35BC3D72B50D0170479932AF7ADA0E4BA1B0BC9"] = "_encstr_8AEB15867BEC56C9FA35CA3AEB1A2BC236D186FA8DBDEE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CC915A0A005EAC2407C7DB47961D80507BCD84FAFD1B2"] = "_encstr_9AEB1510A7C8274B28C0C2DB4E9B2F9EB009985FCB082F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B20E1771D03647A27758321508F5AF725979FDFF68B0C9BB71"] = "_encstr_ADB6160967BB6D70B7745973D1783097F29381DFD31224E8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB5E10C03A13755069D27B41FF4E18CFBFE2"] = "_encstr_AB5E10C03A13755069D27B41FF4E18CFBFE2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B5515E3B7037105314AD858F156F1ABB723FAF01127DB"] = "_encstr_863B1599F72BFDC007C4C9E3A1E1C0AE516303357FA23D";
}

weapongivenhoverjet(var_0) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence();
  return 1;
}

tryusehoverjet() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8C980A867B3B569CFAA659E8", self);
  return tryusehoverjetfromstruct(var_0);
}

tryusehoverjetfromstruct(var_0) {
  var_1 = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

    return 0;
  }

  level.incomingallhoverjets++;
  var_2 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    var_2 = 2;

  if(level.hoverjets.size >= var_2 || level.hoverjets.size + level.incomingallhoverjets > var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

    level.incomingallhoverjets--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var_3 = 1;
    level.incominghoverjets[var_1]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(var_1, level.hoverjets) + level.incominghoverjets[var_1] > var_3) {
      level.incomingallhoverjets--;
      level.incominghoverjets[var_1]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_B1A5225A4A89C4A9519451825A9A9735052CF5912552A2E41189CAD7CAA2D398FA528A15");

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var_4 = any_player_within_distance3d(var_0);
  var_4 = istrue(var_4);
  level.incomingallhoverjets--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level.incominghoverjets[var_1]--;

  if(!var_4)
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  return var_4;
}

any_player_within_distance3d(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, getcompleteweaponname("_encstr_B42011379B76D2F27318ABE7680BCA981E68D3"), 1, ::weapongivenhoverjet);

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  var_2 = hoverjet_getmapselectioninfo(var_0, 1);

  if(!isDefined(var_2))
    return 0;

  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  thread starthoverjetairstrikepass(self, var_0, var_2);
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_3 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1, var_3);
  scripts\common\utility::_id_13E0A(level._id_11B2A, "_encstr_8C980A867B3B569CFAA659E8", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_BD8E0F83662BA2B7E088239798FE4A7AD1", self);
  return 1;
}

hoverjet_getmapselectioninfo(var_0, var_1) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  var_2 = scripts\mp\killstreaks\mapselect::getselectmappoint(var_0, var_1);

  if(!isDefined(var_2)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
    return undefined;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  return var_2;
}

starthoverjetairstrikepass(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = 24000;
  var_5 = 6500;
  var_6 = 3250;
  var_7 = 1500;
  var_8 = (0, 0, 0);
  var_9 = 1500;
  var_10 = var_0.angles;
  var_11 = 1;

  if(isDefined(var_3))
    var_6 = var_3.origin[2] + 750;

  var_12 = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(var_12) && var_12 == "_encstr_8A34097127C761890FA9D2")
    var_6 = var_6 + 500;

  var_14 = var_2[0].location;
  var_10 = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(var_0, var_14, var_6);
  var_15 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_14, var_10, var_4, var_3, var_6, var_5, var_9, var_1.streakname, var_11);
  var_16 = var_15["_encstr_B18C0B5E9C6FA319E20A487853"];
  var_17 = var_15["_encstr_ACB7092280809AF7F8F8DB"];
  var_18 = "_encstr_97A116A3917838C199FB9367D3B3DBAFA0F9DD2F8969ED6B";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_18 = "_encstr_88741B3E8308402FE170A29959CB4341E073ACB623095F9F96CBA9A283";

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_19 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_16, var_10, "_encstr_A23611CCAF724FE0873BF040B7AA194169D547", var_18);

  if(!isDefined(var_19)) {
    return;
  }
  var_20 = 45;
  var_19.speed = 250;
  var_19.accel = 175;
  var_19.health = 2500;
  var_19.maxhealth = 2500;
  var_19.angles = vectortoangles(var_10);
  var_19.lifetime = var_20;
  var_19.team = var_0.team;
  var_19.owner = var_0;
  var_19.streakinfo = var_1;
  var_19.streakname = var_1.streakname;
  var_19.flaresreservecount = 1;
  var_19.returngoal = var_14;
  var_19.currentdamagestate = 0;
  var_19.flyheight = var_6;
  var_19.hoverheight = var_7;
  var_19.missiles = 6;
  var_19.pers["_encstr_8AEF05472BC2D6"] = var_19.team;
  var_19.bestgroundtarget = undefined;
  var_19.bestairtarget = undefined;
  var_19.flightdir = var_15["_encstr_8EC91091A593B28DD1A5EDE628E6EC63CAB9"];
  var_19 setmaxpitchroll(0, 90);
  var_19 vehicle_setspeed(var_19.speed, var_19.accel);
  var_19 sethoverparams(50, 100, 50);
  var_19 setturningability(0.05);
  var_19 setyawspeed(45, 25, 25, 0.5);
  var_19 setotherent(var_19.owner);
  var_19 setCanDamage(1);
  var_19 setneargoalnotifydist(700);
  var_19 setvehicleteam(var_19.team);
  level.hoverjets[level.hoverjets.size] = var_19;
  var_19 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_19.owner, 0, 1, 100);
  var_19 setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_AB0703DBB9", 0);
  var_19 setscriptablepartstate("_encstr_AC450A1D3C03CB736C879898", "_encstr_930B07BB1B6B3854FF", 0);
  var_19 setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9", 0);
  var_19.turret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_19 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), "_encstr_A3BA1420F546180EC9EB83B92723D5E8FACF2B5E9DA8");
  var_19.turret setModel("_encstr_81951A73E7A802681A77015F6F62C6F1707EB8890E37D83583731B01");
  var_19.turret.owner = var_19.owner;
  var_19.turret.team = var_19.team;
  var_19.turret.angles = var_19.angles;
  var_19.turret.streakinfo = var_1;
  var_19.turret linkTo(var_19, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 5), (0, 0, 0));
  var_19.turret setturretteam(var_19.team);
  var_19.turret setturretmodechangewait(0);
  var_19.turret setmode("_encstr_BA7D0EF916AAA3692C479020EB7FA1E9");
  var_19.turret setsentryowner(var_19.owner);
  var_19.turret setdefaultdroppitch(45);
  var_19.turret maketurretinoperable();
  var_19.turret setleftarc(360);
  var_19.turret setrightarc(360);
  var_19.turret setbottomarc(90);
  var_19.turret settoparc(90);
  var_19.turret setconvergencetime(0.5, "_encstr_BD6506F36A2B46B0");
  var_19.turret setconvergencetime(0.5, "_encstr_AF1904C7E3A4");
  var_19.turret setconvergenceheightpercent(0.65);
  var_19.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_19.turret gettagorigin("_encstr_AFBF0A98A5AFD82BDCD1CA27"));
  var_19.killcament linkTo(var_19, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-500, 0, 500), (0, 0, 0));
  var_19.turret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_19.origin);
  var_19.turret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_19.turret.groundtargetent dontinterpolate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_19[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 100);

  var_19.animname = var_1.streakname;
  var_19.scenenode = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_19.returngoal * (1, 1, 0) + (0, 0, var_6));
  var_19.scenenode.angles = var_19.angles;
  var_19.scenenode setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_19 thread hoverjet_firetrackermissiles(var_14);
  var_19 hoverjet_playflyfx();
  var_24 = getanimlength(level.scr_anim[var_19.animname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"]);
  var_25 = scripts\engine\utility::get_notetrack_time(level.scr_anim[var_19.animname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"], "_encstr_91160D8DEDCD47E485A5B17DDBCCCC");
  var_19.scenenode thread scripts\common\anim::anim_single_solo(var_19, "_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5");
  var_19 thread hoverjet_delaysetscriptable(var_25, "_encstr_BD7D0A1E904061166A7C49B3", "_encstr_BA19049F4B2D");
  var_19 thread hoverjet_handledestroyed();
  var_19 thread spawn_script_model_driver_and_passengers();
  var_19 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", self);
  var_19 scripts\mp\utility\killstreak::killstreak_make_vehicle(var_1.streakname, "_encstr_8D8F1440776BFB7AFAF0B728B6CBED6EF27A57B221A3", undefined, "_encstr_8E4512D12DDA59B7AE477D86F6B359E4FA9ACA1D", "_encstr_A6071C5A4159C3ADD069D7F45338B37370FAB2B2EE2397A3788DDFF27B68");
  var_19 scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback(var_1.streakname);
  var_19 scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback(var_1.streakname, ::hoverjet_modifydamage);
  var_19 scripts\mp\utility\killstreak::killstreak_set_death_callback(var_1.streakname, ::hoverjet_handledeathdamage);
  var_19 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(::hoverjet_handlemissiledetection);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_24);

  if(!isDefined(var_19)) {
    return;
  }
  if(isDefined(var_19.scenenode))
    var_19.scenenode delete();

  var_19 starthoverjetdefend(var_1);
}

hoverjet_delaysetscriptable(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate(var_1, var_2, 0);
}

hoverjet_playflyfx() {
  thread scripts\engine\utility::delaythread(0.05, ::hoverjet_playapproachfx);
  thread scripts\engine\utility::delaythread(6, ::hoverjet_playflybyfx);
  thread scripts\engine\utility::delaythread(14, ::hoverjet_playreturnfx);
}

hoverjet_playapproachfx() {
  self playsoundonmovingent("_encstr_A74F15C072EFF0B7DB572D054FA340F0780A6BD81E3B28");
}

hoverjet_playflybyfx() {
  self playsoundonmovingent("_encstr_8FA312677F4183C0B69F8398879C09CCCAFFEDCB");
}

hoverjet_playreturnfx() {
  self playsoundonmovingent("_encstr_88241398F3F748200359766D5B2306EB48A3AD2A32");
}

hoverjet_firetrackermissiles(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::get_notetrack_time(level.scr_anim["_encstr_8C980A867B3B569CFAA659E8"]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"], "_encstr_999A07C61338F9A23A");
  var_2 = var_1 - 4;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_3 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4"];
  var_4 = physics_createcontents(var_3);
  var_5 = self.angles * (0, 1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = [var_0 - var_6 * 2250 + var_7 * 750, var_0 - var_6 * 1500 - var_7 * 750, var_0 - var_6 * 750 + var_7 * 250, var_0 - var_7 * 250, var_0 + var_6 * 750 + var_7 * 750, var_0 + var_6 * 1500 - var_7 * 750, var_0 + var_6 * 2250 + var_7 * 250, var_0 + var_6 * 3000 - var_7 * 250];
  var_9 = ["_encstr_B45E1814A358B1A3DB99FAC3662763B4F00187852B90C29771F1", "_encstr_A925173109D9AFE8DFA9333FD1182038304F0710032F3425B5", "_encstr_B230198433C821334BE98A53F697FBE608931A2753D0720F636052", "_encstr_938718D12C9DFAC6B2998EEB859C6C0D95937DB54BCD37D28DAC"];
  var_10 = 0;
  var_11 = [];

  foreach(var_22, var_13 in var_8) {
    var_14 = var_13 + (0, 0, 10000);
    var_15 = var_13 - (0, 0, 10000);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, level.characters, var_4);
    var_17 = scripts\common\utility::playersinsphere(var_16["_encstr_BD260953AA97E3F014279D"], 1000);
    var_18 = hoverjet_findmissiletarget(var_17, var_11);
    var_19 = self gettagorigin(var_9[var_10]) + anglesToForward(self gettagangles(var_9[var_10])) * 300;
    var_20 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07"), var_19, var_16["_encstr_BD260953AA97E3F014279D"], self.owner);
    var_20.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_20.origin);
    var_20.killcament linkTo(var_20, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-100, 0, 500), (0, 0, 0));
    var_20.killcament thread hoverjet_missilekillcammove(var_16["_encstr_BD260953AA97E3F014279D"], var_20.angles);
    var_20.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread hoverjet_firemissilescriptable(var_10 + 1);

    if(isDefined(var_18)) {
      var_13 = var_18.origin;
      var_11[var_11.size] = var_18;
      thread hoverjet_delaymissiletracking(var_20, 0.05, var_18);
    }

    wait 0.5;
    var_10++;

    if(var_10 > var_9.size - 1)
      var_10 = 0;
  }

  var_11 = undefined;
}

hoverjet_missilekillcammove(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveTo(var_0 - anglesToForward(var_1) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

hoverjet_firemissilescriptable(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setscriptablepartstate("_encstr_AD720E3C542BC3EE6D5F687047B4617F" + var_0, "_encstr_AB0703DBB9", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self setscriptablepartstate("_encstr_AD720E3C542BC3EE6D5F687047B4617F" + var_0, "_encstr_BA19049F4B2D", 0);
}

hoverjet_findmissiletarget(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(level.teambased && var_4.team == self.team) {
      continue;
    }
    if(var_4 == self.owner) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_1, var_4)) {
      continue;
    }
    if(var_4 scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7")) {
      continue;
    }
    var_2 = var_4;
    break;
  }

  return var_2;
}

hoverjet_delaymissiletracking(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(isDefined(var_0))
    var_0 missile_settargetEnt(var_2, (0, 0, 10));
}

hoverjet_delayresetscriptable(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setscriptablepartstate("_encstr_860808CB78E2984063BA" + var_0, "_encstr_930B07BB1B6B3854FF", 0);
  wait 1;
  self setscriptablepartstate("_encstr_860808CB78E2984063BA" + var_0, "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

starthoverjetdefend(var_0) {
  thread hoverjet_defendlocation();
}

hoverjet_defendlocation() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread hoverjet_watchlifetime(self.lifetime);
  thread hoverjet_watchowner();
  thread hoverjet_startcombatlogic();
  thread hoverjet_movetolocation(self.returngoal);
}

hoverjet_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A71411F3289B3D7BDF52376BD04552C1E39007", 1);
      scripts\mp\killstreaks\flares::flares_reducereserves(var_2);
      var_2 thread scripts\mp\killstreaks\flares::flares_playFX("_encstr_BE750BE4D1D8271259ABABCFB7", var_3);
      var_6 = var_2 scripts\mp\killstreaks\flares::flares_deploy();
      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    }

    waitframe();
  }
}

hoverjet_watchlifetime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A3C8091B70E9F7BDC09927" + self.streakinfo.streakname, 1);
  thread hoverjet_leave();
}

spawn_script_model_driver_and_passengers() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self._id_12AA4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
}

hoverjet_watchowner() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread hoverjet_leaveonownernotify("_encstr_8D820B49520F0EC02DDE6367EC");
  thread hoverjet_leaveonownernotify("_encstr_81170C244F9CBDE72C01BB99A298");
}

hoverjet_leaveonownernotify(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner waittill(var_0);
  thread hoverjet_leave();
}

hoverjet_startcombatlogic() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.turret.killcament = self.killcament;
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(45, 10);
  thread hoverjet_watchforreposition();
  thread hoverjet_engagegroundtargets();
  self setscriptablepartstate("_encstr_AC450A1D3C03CB736C879898", "_encstr_A7C5056BD931D1", 0);
}

hoverjet_movetolocation(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = [self, self.turret];

  for(;;) {
    var_2 = self.origin;
    var_3 = var_0 * (1, 1, 0) + (0, 0, self.origin[2]);
    var_4 = scripts\engine\trace::sphere_trace(var_2, var_3, 256, var_1);
    var_5 = 0;
    var_6 = var_0[0];
    var_7 = var_0[1];

    if(isDefined(var_4)) {
      if(var_4["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_6 = var_4["_encstr_BD260953AA97E3F014279D"][0];
        var_7 = var_4["_encstr_BD260953AA97E3F014279D"][1];
        var_5 = 1;
      }
    }

    var_8 = hoverjet_getcorrectheight(var_6, var_7, 20);
    var_9 = (var_6, var_7, var_8);
    self setvehgoalpos(var_9, 1);
    self waittill("_encstr_B4D10ADC950BE4EB76DE8536");

    if(!istrue(var_5)) {
      self.currentguardlocation = var_9;
      self notify("_encstr_AC4B1B3BE053C5833D1DAB69710FBB8D7F782BB788C8375A43ADF41DE8", var_9);
      break;
    }
  }

  self clearlookatent();
}

hoverjet_getcorrectheight(var_0, var_1, var_2) {
  var_3 = self.hoverheight;
  var_5 = hoverjet_tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_3;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}

hoverjet_tracegroundpoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_2 = -99999;
  var_3 = self.origin[2];
  var_4 = level.averagealliesz;
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0, 0, 0);
  var_6 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 512, self, var_5, 1);

  if(var_6["_encstr_BD260953AA97E3F014279D"][2] < var_4)
    var_7 = var_4;
  else
    var_7 = var_6["_encstr_BD260953AA97E3F014279D"][2];

  return var_7;
}

hoverjet_engagegroundtargets() {
  self notify("_encstr_81D90D95CDB3169D5674E4EDEACD23");
  self endon("_encstr_81D90D95CDB3169D5674E4EDEACD23");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = undefined;

    if(!isDefined(self.bestgroundtarget)) {
      [self.bestgroundtarget, var_0] = hoverjet_getbestgroundtarget();
      self notify("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24", self.bestgroundtarget);

      if(!isDefined(self.bestgroundtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
        continue;
      }
    }

    var_2 = undefined;

    if(istrue(var_0))
      var_2 = self.bestgroundtarget scripts\cp_mp\utility\player_utility::getvehicle();

    self.turret settargetentity(self.turret.groundtargetent);

    if(!isDefined(self.bestairtarget))
      self setlookatent(self.bestgroundtarget);

    thread hoverjet_watchtargetstatus(self.bestgroundtarget);
    thread hoverjet_watchtargetlos(self.bestgroundtarget, undefined, var_2);
    thread hoverjet_watchtargettimeout(self.bestgroundtarget);
    hoverjet_fireongroundtarget(var_0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

hoverjet_getbestgroundtarget() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_gettargets(self.turret, 3000, 0, 1);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(!scripts\cp_mp\killstreaks\chopper_support::goliath_init(var_5.player)) {
      continue;
    }
    var_6 = 0;
    var_7 = 0;
    var_8 = abs(vectortoangles(var_5.player.origin - self.origin)[1]);
    var_9 = abs(self gettagangles("_encstr_A14F0AE336178944BA076F41")[1]);
    var_8 = abs(var_8 - var_9);
    var_10 = var_5.player getweaponslistitems();

    foreach(var_12 in var_10) {
      var_13 = weaponclass(var_12);

      if(var_13 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        var_8 = var_8 - 40;
    }

    if(istrue(var_5._id_13A93)) {
      var_7 = 1;
      var_8 = var_8 + 40;
    }

    if(!isDefined(var_1) || var_1 > var_8) {
      var_1 = var_8;
      var_2 = var_5.player;
      var_3 = var_7;
    }
  }

  return [var_2, var_3];
}

hoverjet_fireongroundtarget(var_0) {
  var_1 = weaponfiretime("_encstr_A3BA1420F546180EC9EB83B92723D5E8FACF2B5E9DA8");
  var_2 = 0;
  var_3 = 0;
  var_4 = 100;

  while(isDefined(self) && isDefined(self.bestgroundtarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving)) {
    if(self.turret hoverjet_turretlookingattarget()) {
      var_6 = undefined;

      if(istrue(var_0))
        var_6 = self.bestgroundtarget.origin;
      else
        var_6 = self.bestgroundtarget gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");

      scripts\cp_mp\killstreaks\chopper_support::choppersupport_setattackpoint(self.turret, self.bestgroundtarget, var_6, var_4);

      if(var_3 == 15)
        var_4 = 50;
      else if(var_3 == 30)
        var_4 = undefined;

      self.turret shootturret("_encstr_A14F0AE336178944BA076F41");
      var_3++;
      self.turret.streakinfo.shots_fired++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  }
}

hoverjet_turretlookingattarget() {
  var_0 = 0.996;
  var_1 = anglesToForward(self gettagangles("_encstr_A14F0AE336178944BA076F41"));
  var_2 = vectorNormalize(self.groundtargetent.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(isDefined(self gettargetentity(1)) && var_3 >= var_0)
    return 1;

  return 0;
}

hoverjet_engageairtargets() {
  self notify("_encstr_8CCB0AAD2027AA875DB671B2");
  self endon("_encstr_8CCB0AAD2027AA875DB671B2");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(!isDefined(self.bestairtarget)) {
      var_0 = [];
      var_0 = scripts\engine\utility::array_combine(level.helis, level.littlebirds, level.supportdrones);
      self.bestairtarget = hoverjet_getbestairtarget(var_0);
      self notify("_encstr_8C631C86DE67593949B23AF558D85CD54B935ACDCE8296E4A81693EC5947", self.bestairtarget);

      if(!isDefined(self.bestairtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
        continue;
      }
    }

    thread hoverjet_watchtargetstatus(self.bestairtarget);
    hoverjet_fireonairtarget();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

hoverjet_fireonairtarget() {
  var_0 = "_encstr_8253060E2B5FE330";
  var_1 = getcompleteweaponname("_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07");
  var_2 = undefined;
  self setlookatent(self.bestairtarget);

  while(isDefined(self) && isDefined(self.bestairtarget)) {
    var_3 = 5;

    if(!istrue(var_2)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8B5515E3B7037105314AD858F156F1ABB723FAF01127DB");
      var_2 = 1;
    }

    while(var_3 > 0 && isDefined(self.bestairtarget) && !hoverjet_airtargetiswithinview(self.bestairtarget)) {
      var_3 = var_3 - level.framedurationseconds;
      waitframe();
    }

    if(isDefined(self.bestairtarget))
      hoverjet_moveawayfromtarget(self.bestairtarget);
    else
      break;

    if(isDefined(self.bestairtarget)) {
      var_5 = self gettagorigin("_encstr_97EF05D1B0CEFA" + var_0 + "_encstr_8E9A10B72B78365345B3F1DA38A6E76C209B") + anglesToForward(self.angles) * 100;
      var_6 = var_5 + anglesToForward(self.angles) * 100;
      var_7 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var_1, var_5, var_6, self.owner);
      var_8 = hoverjet_setmissileoffset(self.bestairtarget);
      var_7 missile_settargetEnt(self.bestairtarget, var_8);
      var_7.streakinfo = self.streakinfo;

      if(var_0 == "_encstr_8253060E2B5FE330")
        var_0 = "_encstr_A5AD056A019C63";
      else
        var_0 = "_encstr_8253060E2B5FE330";
    } else
      break;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  }

  if(istrue(self.movedoffguardlocation)) {
    thread hoverjet_movetolocation(self.currentguardlocation);
    self.movedoffguardlocation = undefined;
  }
}

hoverjet_setmissileoffset(var_0) {
  var_1 = (0, 0, 0);

  if(isDefined(var_0.streakinfo)) {
    switch (var_0.streakinfo.streakname) {
      case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
      case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
        var_1 = (0, 0, -50);
        break;
      case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        var_1 = (0, 0, -30);
        break;
      case "_encstr_8C980A867B3B569CFAA659E8":
        var_1 = (0, 0, 20);
        break;
      case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        var_1 = (0, 0, 10);
        break;
    }
  }

  return var_1;
}

hoverjet_airtargetiswithinview(var_0) {
  var_1 = 0.866;
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(var_0.origin - self.origin);
  var_4 = vectordot(var_2, var_3);
  return scripts\engine\utility::ter_op(var_4 >= var_1, 1, 0);
}

hoverjet_airtargetistooclose(var_0) {
  return scripts\engine\utility::ter_op(distance2dsquared(var_0.origin, self.origin) < 1000000, 1, 0);
}

hoverjet_moveawayfromtarget(var_0) {
  while(isDefined(var_0) && hoverjet_airtargetistooclose(var_0)) {
    var_1 = undefined;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoright(self.angles);
    var_4 = self.origin - var_2 * 1000;
    var_5 = self.origin + 707.0 * (var_3 - var_2);
    var_6 = self.origin + 707.0 * (-1 * var_2 - var_3);
    var_7 = [var_4, var_5, var_6];
    var_8 = [self, var_0];

    foreach(var_10 in var_7) {
      if(scripts\engine\trace::sphere_trace_passed(self.origin, var_10, 256, var_8))
        var_1 = var_10 * (1, 1, 0) + (0, 0, var_0.origin[2]);
    }

    if(isDefined(var_1)) {
      self.movedoffguardlocation = 1;
      self setvehgoalpos(var_1, 1);
    }

    waitframe();
  }
}

hoverjet_watchforreposition() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setneargoalnotifydist(100);
  self.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.useobj setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, &"_encstr_8D5F22B42913266A2A25510AA56AEB905239A26A79847AB25425BE525415BEE8AA504922", 360, 360, 30000, 30000, 2);
  self.useobj linkTo(self);

  while(isDefined(self.useobj)) {
    self.useobj waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_82890F1A7B3B5927D735CAA3AF6BDE3B56");
    self setscriptablepartstate("_encstr_AC450A1D3C03CB736C879898", "_encstr_930B07BB1B6B3854FF", 0);

    if(isDefined(var_0)) {
      thread hoverjet_movetolocation(var_0.origin);
      thread hoverjet_watchfornearmovementgoal();
    }
  }
}

hoverjet_watchfornearmovementgoal() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  self setscriptablepartstate("_encstr_AC450A1D3C03CB736C879898", "_encstr_A7C5056BD931D1", 0);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8DBF10D0ED67CA4EF553B2A3D776D5B02719");
}

hoverjet_randomizemovement() {
  self notify("_encstr_8C2D103308E065FF686EA8277447ADD9EEB9");
  self endon("_encstr_8C2D103308E065FF686EA8277447ADD9EEB9");
  self endon("_encstr_962509AF305A4221B6B021");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
}

hoverjet_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  self.currenthealth = self.health - var_4;

  if(self.currenthealth > 0) {
    if(self.currenthealth <= 2000 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B20E1771D03647A27758321508F5AF725979FDFF68B0C9BB71");
    } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8CC915A0A005EAC2407C7DB47961D80507BCD84FAFD1B2");
    } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_878117A34DF35BC3D72B50D0170479932AF7ADA0E4BA1B0BC9");
    }
  }

  return 1;
}

hoverjet_handledeathdamage(var_0) {
  self.killedbyweapon = var_0.objweapon;
  return 1;
}

hoverjet_handledestroyed() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACB90FF2A010D7EA49789F1309191FB8DD");
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\mp\utility\weapon::iskillstreakweapon(self.killedbyweapon))
    hoverjet_crash(75);

  thread hoverjet_explode();
}

hoverjet_crash(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self.iscrashing = 1;
  self.killcament unlink();
  self.killcament.origin = self.origin + (0, 0, 100);

  if(isDefined(self.useobj) && isDefined(self.owner))
    self.useobj disableplayeruse(self.owner);

  self clearlookatent();
  self notify("_encstr_86BD0980BBC647A80FDE04");
  self playsoundonmovingent("_encstr_A78612ADDC7D86F6672B9335B28ED76C2716E634");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_1 = hoverjet_findcrashposition(2500);

  if(!isDefined(var_1)) {
    return;
  }
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AB5E10C03A13755069D27B41FF4E18CFBFE2", 1);
  self setvehgoalpos(var_1, 0);
  thread hoverjet_spinout(var_0);
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

hoverjet_spinout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.5);
    wait 0.5;
  }
}

hoverjet_findcrashposition(var_0) {
  var_1 = self.origin;
  var_2 = 1000;
  var_3 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoright(self.angles);
  var_6 = var_1 + var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 + var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_5 - var_4) - (0, 0, var_2);
  var_7 = scripts\engine\trace::ray_trace(var_1, var_6, self);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (-1 * var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  return var_3;
}

hoverjet_explode() {
  self notify("_encstr_860808CB78E2984063BA");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A3BA1420F546180EC9EB83B92723D5E8FACF2B5E9DA8");
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_AB0703DBB9", 0);
  wait 0.35;
  thread hoverjet_cleanup(1);
}

hoverjet_leave() {
  self endon("_encstr_AD75063D571AE108");
  self.isleaving = 1;
  self notify("_encstr_BA2D081B2B58B32D37EC");

  if(isDefined(self.useobj) && isDefined(self.owner))
    self.useobj disableplayeruse(self.owner);

  hoverjet_breakofftarget(undefined, 1);
  self setmaxpitchroll(0, 0);
  self vehicle_setspeed(35, 25);
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 = var_0 + (0, 0, 900);
  self setvehgoalpos(var_0, 1);
  self vehicleplayanim(level.scr_anim["_encstr_8C980A867B3B569CFAA659E8"]["_encstr_A760055987D2E8"]);
  self playsoundonmovingent("_encstr_9ACE1274160F32D773E8037BF06BAF3AC3A7BB6F");
  self waittill("_encstr_8B7205D9ED5958");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9", 0);
  var_1 = self.origin + anglesToForward(self.angles) * 24000;
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_1, 1);
  self waittill("_encstr_8B7205D9ED5958");
  self notify("_encstr_ACB90FF2A010D7EA49789F1309191FB8DD");
  hoverjet_cleanup();
}

hoverjet_cleanup(var_0) {
  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.useobj))
    self.useobj delete();

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.turret.groundtargetent))
    self.turret.groundtargetent delete();

  if(isDefined(self.scenenode))
    self.scenenode delete();

  self setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_BA19049F4B2D", 0);
  self setscriptablepartstate("_encstr_AC450A1D3C03CB736C879898", "_encstr_BA19049F4B2D", 0);
  self.streakinfo.onspray = istrue(var_0);

  if(!istrue(self._id_12AA4))
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);

  level.hoverjets = scripts\engine\utility::array_remove(level.hoverjets, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

hoverjet_watchtargetstatus(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_1);
  self endon("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(isPlayer(var_0))
    thread hoverjet_watchgroundtargetdeathdisconnect(var_0);
  else
    thread hoverjet_watchairtargetdeath(var_0);

  thread hoverjet_watchforbreakaction(var_0, "_encstr_953C151AEDD92B27942B1DF51DC239CECAA326BDB98E02" + var_1);
  thread hoverjet_watchforbreakaction(var_0, "_encstr_AD621AC8085352DBEA305477819B2ACFE370951D59D97844E8F11B72" + var_1);
  thread hoverjet_watchforbreakaction(var_0, "_encstr_AC4B1B3BE053C5833D1DAB69710FBB8D7F782BB788C8375A43ADF41DE8");
  thread hoverjet_watchforbreakaction(var_0, "_encstr_A6FF172BF0C88033D8BDC350C3C16B5F1FD9C95217084FE728");
}

hoverjet_watchgroundtargetdeathdisconnect(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_1);
  self endon("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_953C151AEDD92B27942B1DF51DC239CECAA326BDB98E02" + var_1);
}

hoverjet_watchairtargetdeath(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_1);
  self endon("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 waittill("_encstr_AD75063D571AE108");
  self notify("_encstr_953C151AEDD92B27942B1DF51DC239CECAA326BDB98E02" + var_1);
}

hoverjet_watchforbreakaction(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  self endon("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_2);
  self endon("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self waittill(var_1);
  hoverjet_breakofftarget(var_2);
}

hoverjet_watchtargetlos(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_3);
  self endon("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
  self.bestgroundtarget endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_4 = undefined;

  if(!isDefined(var_1))
    var_1 = 500;

  var_5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_6 = [self.turret];

  if(isDefined(var_2)) {
    var_6[var_6.size] = var_2;
    var_7 = var_2 getlinkedchildren();

    if(isDefined(var_7) && var_7.size > 0)
      var_6 = scripts\engine\utility::array_combine(var_6, var_7);
  }

  for(;;) {
    var_8 = scripts\engine\trace::ray_trace_passed(self.turret gettagorigin("_encstr_91E80B3A2CCE7D262C4E9359D8"), var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_6, var_5);

    if(!istrue(var_8)) {
      if(!isDefined(var_4))
        var_4 = gettime();

      if(gettime() - var_4 > var_1) {
        self notify("_encstr_AD621AC8085352DBEA305477819B2ACFE370951D59D97844E8F11B72" + var_3);
        return;
      }
    } else
      var_4 = undefined;

    wait 0.25;
  }
}

hoverjet_watchtargettimeout(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_1);
  self endon("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
  self.bestgroundtarget endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self notify("_encstr_A6FF172BF0C88033D8BDC350C3C16B5F1FD9C95217084FE728");
}

hoverjet_breakofftarget(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0) || istrue(var_1)) {
    self.bestgroundtarget = undefined;
    self.bestairtarget = undefined;
    self clearlookatent();
    self.turret cleartargetentity();
    self.turret.groundtargetent unlink();
    var_2 = "_encstr_9B531972D5186E978B883A56B054EB768041C49821D0729FA5A373";
    self notify("_encstr_9AA71C86BD9DAC274995A37D4C27CA58ADF4CC99823663452C4EB359A3E6");
    return;
  } else {
    if(isDefined(self.bestgroundtarget) && var_0 == self.bestgroundtarget getentitynumber()) {
      var_2 = "_encstr_AA2F1D4D9A6D0BBA82A3EF698F5A745207F2902305D4C2EDFACBD7FB9BC76F" + self.bestgroundtarget.name;
      self.bestgroundtarget = undefined;
      self.turret cleartargetentity();
      self.turret.groundtargetent unlink();
    } else if(isDefined(self.bestairtarget) && var_0 == self.bestairtarget getentitynumber()) {
      var_2 = "_encstr_A9371A58BB4768FA8A0E9712A823B8215F931A660B1BB2C1D77B2276" + self.bestairtarget.model;
      self.bestairtarget = undefined;
    } else
      var_2 = "_encstr_AD211E48C9AC0BD6B4B9EC40B76666029C95ADF63BCAC8403A58E47659478E08" + var_0;

    if(!isDefined(self.bestgroundtarget) && !isDefined(self.bestairtarget))
      self clearlookatent();
  }

  self notify("_encstr_8BD91954A0F82D631AF3E357E52E5A61A80C4F5F3FA8E20AD5B9BA" + var_0);
}

hoverjet_getbestairtarget(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(!istrue(var_3)) {
      if(level.teambased && var_5.team == self.team) {
        continue;
      }
      if(var_5.owner == self.owner)
        continue;
    }

    var_7 = distance2dsquared(var_5.origin, self.origin);

    if(var_7 >= 6250000) {
      continue;
    }
    if(!isDefined(var_2) || var_7 < var_2) {
      var_1 = var_5;
      var_2 = var_7;
    }
  }

  return var_1;
}