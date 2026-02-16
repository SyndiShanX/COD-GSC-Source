/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1838.gsc
*************************************************/

init() {
  level._id_EA71 = ::_id_3E1B;
  level._id_C8A8 = "vfx/iw8/core/blima/vfx_blima_explosion.vfx";
  scripts\engine\utility::_id_80CB();
  _id_383A();
  _id_4735();
  _id_D506();
  _id_D503();
  _id_D854();
  scripts\cp\utility::_id_819E();
  scripts\cp\utility::_id_820E();
  _id_7F98();
  _id_7F99();
  _id_D86B();
  _id_D504();
  _id_D508();

  if(!getdvarint("#x3a26f4bb7b753def0")) {
    _id_D505();
  }

  _id_9617();
  _id_E3CB();
  _id_817F();
  _id_0783::_id_CED7();
  _id_06D4::_id_D86A();
  _id_D9CD();
  _id_81AF();
  _id_8206();
  _id_1195();
  _id_06D6::_id_819D();
  _id_0011::_id_D85E();
  _id_071B::init();
  _id_0744::init();
  _id_06F3::main();
  _id_0741::_id_2D05();
  _id_0726::init();
  _id_073B::_id_7FCE();
  _id_073C::init();
  _id_0719::_id_81CD();

  if(_id_DC0D()) {
    level thread verifydedicatedconfiguration();
  }

  level.leanthread = getdvarint("#x3e3ebdc1d60efb8da", 0) == 1;
  level.script = tolower(getDvar("#x376847958d67972ef"));
  level.gametype = tolower(getDvar("#x315af23e89f368200"));
  level.codcasterenabled = getdvarint("#x32570320b7015b225", 0) == 1;
  level.systemlink = getdvarint("#x3297ffeae3a9e9231", 0) == 1;
  level.useperbullethitmarkers = getdvarint("#x33adeebe7fcfc9b08", 0) == 1;
  level.splitscreen = _func_011F();
  level.onlinegame = getdvarint("#x34e9ab8c76756925d");
  level.rankedmatch = level.onlinegame || getdvarint("#x378c3667dfc793afa");
  level.matchmakingmatch = level.onlinegame && !getdvarint("#x310c28bb5d64c8c6d");
  level.playerxpenabled = level.matchmakingmatch || getdvarint("#x378c3667dfc793afa");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.matchmakingmatch || getdvarint("#x378c3667dfc793afa") || getdvarint("#x39da705b2efed14b2");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level._id_15D8 = 1;
  level._id_EB26 = 1;
  level._id_EB3C = 1;
  level._id_E730 = _func_00D7();
  setDvar("#x3c1ba770f0e3448b4", 0);
  level._id_B0E3 = getdvarint("#x3c1ba770f0e3448b4", 0);
  level._id_418C = [];
  level._id_0F1B = [];
  level._id_10CF1 = [];
  level._id_7142 = [];
  level._id_ED2B = 0;
  level._id_EF89 = ["axis", "allies"];
  level._id_B7F4 = "allies";
  level._id_6016["scriptModelPlayAnim"] = ::_meth_82CB;
  level._id_6016["precacheMpAnim"] = ::_func_01AF;
  level._id_6016["scriptModelClearAnim"] = ::_meth_82CA;
  level._id_10306 = getdvarint("#x348d0964071cde4b5", 0) > 0;
  _id_0706::init();
  level._id_5F3A = level._id_01E2 / 1000;
  _id_10CC8();
  level._id_9AAC = _id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  level thread _id_076E::_id_1041D();
  level thread _id_077E::init();
  level._id_9047 = 0;
  scripts\cp\utility::_id_60C0("prematch_done", 0);
  scripts\cp\utility::_id_60C0("infil_setup_complete", 0);
  scripts\cp\utility::_id_60C0("infil_will_run", 0);
  scripts\cp\utility::_id_60C0("infil_started", 0);
  level thread _id_0961::init();
  _id_095C::init();
  level thread _id_0958::init();

  if(getdvarint("#x3a8fb0620196c6263") != 1) {
    level thread _id_0766::init();
    level thread _id_0766::_id_10C09();
  }

  level thread _id_095E::init();
  level scripts\cp_mp\utility\game_utility::_id_60B4();
  level thread _id_09C8::_id_D9D2();
  level thread _id_071E::_id_7F57();
  level thread _id_0745::_id_8009();
  level thread scripts\cp\cp_outline_utility::init();
  level thread _id_07F9::init();
  thread _id_0705::_id_8289();
  level thread _id_0705::_id_4BC5();
  thread _id_0709::init();
  level thread _id_F428();

  if(getdvarint("#x3a8fb0620196c6263") != 1) {
    level thread _id_0756::init();
  }

  thread _id_072A::init();
  thread _id_070F::init();
  level thread _id_0812::init();
  level thread _id_0750::init();
  _id_09C9::_id_EF5B();
  scripts\cp_mp\utility\player_utility::_id_8182();
  _id_078F::init();
  level thread _id_078D::_id_5181();
  level thread _id_07A2::_id_EC4C();
  thread _id_0793::init();
  thread _id_077D::_id_7F3C();

  if(1) {
    level thread _id_0953::main();
  }

  thread scripts\cp\cp_destinations::init();

  if(getdvarint("#x369fb6163d679d0c9", 0) != 0) {
    level._id_4CE0 = 1;
  }

  level thread _id_10BFA();
  scripts\common\utility::_id_151E("gesture", scripts\cp\utility\player::_id_1543);
  scripts\common\utility::_id_151E("supers", scripts\common\utility::_id_1587);
  scripts\common\utility::_id_151E("health_regen", scripts\cp\utility\player::_id_1546);
  scripts\common\utility::_id_151E("one_hit_melee_victim", scripts\cp\utility\player::_id_1563);
  scripts\common\utility::_id_151E("flashed", scripts\cp\utility\player::_id_153F);
  scripts\common\utility::_id_151E("stunned", scripts\cp\utility\player::_id_1585);
  scripts\common\utility::_id_151E("stick_kill", scripts\cp\utility\player::_id_1584);
  level._id_4A98 = 1;
  scripts\common\utility::_id_E28D();
}

_id_F428() {
  level endon("game_ended");
  scripts\cp\utility::_id_60C2("prematch_done");

  while(!level.gameended) {
    wait 1.0;

    foreach(var_1 in level.players) {
      var_1 _id_F429();
    }
  }
}

_id_F429() {
  if(isDefined(self._id_F242)) {
    var_0 = self.sessionteam;

    if(!isDefined(self._id_F242[var_0])) {
      self._id_F242[var_0] = 0;
    } else {
      self._id_F242[var_0]++;
    }

    if(var_0 != "spectator" && var_0 != "follower") {
      self._id_F242["total"]++;
      self._id_F242["missionTeam"]++;

      if(!scripts\cp\utility\player::isreallyalive(self)) {
        self._id_F242["timeDead"]++;
      }
    }
  }
}

_id_3E1B(var_0) {
  if(!isDefined(level._id_EA72)) {
    level._id_EA72 = [];
  }

  switch (var_0._id_0481) {
    case "lighttank_drop":
      return 0;
  }

  level._id_EA72[var_0._id_0481] = var_0._id_0481;
  return 1;
}

_id_383A() {
  if(getDvar("#x36d16f02578d0ee10") == "cp_landlord_2") {
    var_0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");
    var_0[0].origin = (4143.57, 61393.6, 774.27);
    var_0[0].angles = (0, 181.31, 0);
    var_0[1].origin = (4134.67, 61466.8, 774.54);
    var_0[1].angles = (0, 181.31, 0);
    var_0[2].origin = (4140.57, 61429.5, 774.09);
    var_0[2].angles = (0, 181.31, 0);
    var_0[3].origin = (4144.67, 61338.1, 775.37);
    var_0[3].angles = (0, 181.31, 0);
  }

  if(isDefined(level._id_EA72)) {
    level._id_EA72 = undefined;
  }

  level._id_EA6A = scripts\engine\utility::_id_1BD1(level._id_EA6A);
}

_id_10FC0(var_0, var_1, var_2) {
  _func_03BF("dlog_event_cp_runtime_struct_data", ["key", var_0, "pair", var_1, "count", var_2]);
}

_id_10CC8() {
  if(level.splitscreen) {
    level._id_10CCA = 15;
  } else {
    level._id_10CCA = 8;
  }

  level._id_10CC1 = 0.75;
  level._id_10CC7 = 0;
}

_id_5AE1(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

_id_7F98() {
  scripts\engine\utility::_id_5C11("level_stealth_initialized");
  scripts\engine\utility::_id_5C11("infil_complete");
  scripts\engine\utility::_id_5C11("introscreen_over");
  scripts\engine\utility::_id_5C11("interactions_initialized");
  scripts\engine\utility::_id_5C11("level_ready_for_script");
  scripts\engine\utility::_id_5C11("player_spawned_with_loadout");
  level thread _id_D3D2();
}

_id_7F99() {
  scripts\engine\utility::_id_3F1B("create_script_init", ::_id_3F69);
}

_id_D3D2() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C25("strike_init_done", "infil_complete", "introscreen_over", "interactions_initialized");
  scripts\engine\utility::_id_5C1B("level_ready_for_script");
}

_id_D506() {
  level.splitscreen = _func_011F();
  level.onlinegame = getdvarint("#x34e9ab8c76756925d");
  level.playerxpenabled = level.onlinegame;
  level.rankedmatch = level.onlinegame && !getdvarint("#x310c28bb5d64c8c6d") || getdvarint("#x378c3667dfc793afa");
  level.script = tolower(getDvar("#x376847958d67972ef"));
  level.mapname = scripts\cp_mp\utility\game_utility::_id_6B2D();
  level.gametype = tolower(getDvar("#x3a30c33efc8281eb1"));
  level._id_AC9D["allies"] = "axis";
  level._id_AC9D["axis"] = "allies";
  level._id_A2FC = 0;
  level.teambased = 1;
  level._id_6016 = [];
  level._id_3FD9 = getDvar("#x3ae2cde154e196de") != "";
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  level._id_74C4 = 0;
  level._id_A786 = 0;
  level._id_C113 = [];
  level._id_4363 = scripts\cp\utility::_id_62FC(8);
  level._id_4570 = 2048;
  level._id_AECC = "cp/cp_path_node_table.csv";
  _id_7F47();
}

_id_D503() {
  setDvar("#x31ce9c5116005b62a", 0);
  setDvar("#x36c8f5946a1247e70", getdvarint("#x3a0b18441977f013b"));
  setDvar("#x3ca984a865792777", getDvar("#x3a93070affbb9fe0d"));
  setDvar("#x3be5b00c5664516ea", scripts\cp\utility::matchmakinggame());
  setDvar("#x31da92e2adcc4dee0", 0);
  setDvar("#x3d66aa88265dae2e0", 1);
  setDvar("#x37c9b9af716ef3c26", 1);
  setDvar("#x3e6000dca62024361", 5);
  setDvar("#x3bcc03bfe1a06efd4", 0);
  setDvar("#x3757315ddd429394c", 0);
  setDvar("#x374e27e8df3d55867", scripts\engine\utility::ter_op(level._id_74C4 == 1, 0, 1));
  setDvar("#x396e27990abf87bd5", 1);
  setDvar("#x379a74717c4043423", 0);
  setDvar("#x39cb63f850cbec3e8", 0);
  setDvar("#x385ed7963c5e37386", "");
  setDvar("#x3e1b7f5efb7a1be9a", _id_45C4());
  setdvarifuninitialized("#x35f8270e3c8ac3428", "");
  setDvar("#x3406ec6dcd8b93898", 0);
  setdvarifuninitialized("#x3e10174086b65e381", 600);
  setdvarifuninitialized("#x3e5cdfb67371cb772", 600);
  setdvarifuninitialized("#x3d12e89db8d104a7d", 3.0);
}

_id_D854() {
  level._id_2F59 = ::_id_3D23;
  level._id_2F4A = ::_id_253B;
  level._id_2F4B = ::_id_45C0;
  level._id_2F4D = ::_id_45C2;
  level._id_2F4C = ::_id_45C1;
  level._id_2F4E = ::_id_2F24;
  level._id_2F4F = ::_id_45C3;
  level._id_2F51 = ::_id_45C5;
  level._id_2F48 = ::_id_45B7;
  level._id_6D4A = ::_id_45B3;
  level._id_ABA4 = ::_id_253B;
  level._id_AB7F = ::_id_253B;
  level._id_ABAD = ::_id_253B;
  level._id_B716 = ::_id_45C4;
  level._id_B6DF = ::_id_B4FE;
  level._id_E33A = ::_id_E337;
  level._id_54E2 = ::_id_54E1;
  level._id_83CC = ::_id_E30E;
  level._id_6AEE = ::_id_6AEE;
  level._id_812C = _id_06FE::_id_812C;
  level._id_D468 = _id_06FE::_id_D136;
  level._id_121E = _id_06FE::_id_FF45;
  level._id_1215 = _id_06FE::_id_1215;
  level._id_6A56 = _id_06FE::_id_6A56;
  level._id_115A = _id_06FE::_id_115A;
  level._id_2F50 = _id_073B::_id_2F25;
  level._id_52F7 = _id_0726::_id_52F7;
  level._id_5E9F = _id_0726::_id_5E9F;
  setupthrowingweaponcallbacks();

  if(getDvar("#x3a30c33efc8281eb1") == "cp_survival") {
    level._id_83CC = ::_id_E30E;
  }
}

setupthrowingweaponcallbacks() {
  level._id_7168 = scripts\cp\cp_weapon::_id_7168;
  level._id_8774 = scripts\cp\utility::_id_8774;
  level.getweaponrootname = scripts\cp\utility::getweaponrootname;
  level._id_7AB1 = _id_0733::waitlongdurationwithhostmigrationpause;
}

_id_9617() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

_id_45C1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

_id_45C3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_10BFA() {
  var_0 = "";

  for(;;) {
    if(getDvar("#x35f8270e3c8ac3428", var_0) != var_0) {
      break;
    }

    wait 1;
  }

  var_1 = getdvarfloat("#x35f8270e3c8ac3428");
  _func_01F0(var_1, var_1, 0.0);
  thread _id_10BFA();
}

_id_2F24(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_7D5B(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_7D5B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level._id_74CB)) {
    [[level._id_74CB]](var_2, var_0, var_1, var_4, var_5, var_6, var_7, var_8);
  } else {
    var_1 startragdoll();
    var_9 = physics_createcontents(["physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
    var_10 = var_4 + var_5 * 4096;
    var_11 = scripts\engine\trace::_id_C051(var_4, var_10, undefined, var_9, undefined, 1);
    var_10 = var_11["position"] - var_5 * 12;
    var_12 = length(var_10 - var_4);
    var_13 = var_12 / 1250;
    var_13 = clamp(var_13, 0.05, 1);
    wait 0.05;
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = _func_025B(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, _func_0017(var_14, var_16, var_15));
    var_17 moveto(var_10, var_13);
    var_18 = _func_0212(var_1, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkto(var_17);
    thread _id_7D5C(var_1, var_17, var_13 + 0.05, var_18);
  }
}

_id_7D5C(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::_id_108A8(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

_id_D86B() {
  var_0 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage"];

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "classname");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(isDefined(var_3[var_4]._id_CE28)) {
        var_3[var_4]._id_0397 = var_3[var_4]._id_CE28;
      }

      if(isDefined(var_3[var_4]._id_0397)) {
        level thread _id_57C4(var_3[var_4]);
      }
    }
  }
}

_id_E3CB() {
  level thread _id_F405();
  level thread _id_F426();
  level thread _id_F3F5();
}

_id_F405() {
  for(;;) {
    level._id_7177 = getEntArray("grenade", "classname");
    wait 0.05;
  }
}

_id_F426() {
  for(;;) {
    level._id_9F7E = getEntArray("rocket", "classname");
    wait 0.05;
  }
}

_id_F3F5() {
  for(;;) {
    level._id_326E = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

_id_45C4() {
  return 100;
}

_id_D504() {
  game["thermal_vision"] = "thermal_mp";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["clientid"] = 0;
  game["state"] = "playing";
  game["status"] = "normal";
}

_id_D508() {
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night", 0);
  } else {
    visionsetpain("pain_mp", 0);
  }
}

_id_D505() {
  _func_01E6(0, 1);
  _func_01E7(0, 1);
}

setjiprulesbyround() {
  if(level._id_11049 == 3) {
    _func_01E6(1, 0);
  } else if(level._id_11049 == 10) {
    _func_01E6(1, 1);
  }
}

_id_45B3() {
  return _id_68DA(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

_id_68DA(var_0) {
  var_1 = self getentitynumber();
  return var_0[var_1];
}

_id_45B0() {
  level.gameended = 1;
  setomnvar("allow_server_pause", 0);
  level notify("game_ended", "allies");
  wait 0.05;
  exitlevel(0);
}

_id_3D23() {
  [[level._id_AB7F]]();
  level thread _id_A0D8();
  _id_C61F();
  _id_C61E();
  _id_0719::_id_81D5();
  _id_0705::_id_9786();
  _id_0945::_id_8255();
  _id_0776::init();
  thread _id_0753::init();
  _id_0741::init();
  level thread _id_CA6E();
  level thread _id_7118();
  _func_02A0("Ready for Compass");
  _id_07D1::_id_9353("game_over", 0);
  level thread _id_E6B1();
  level thread _id_07F7::_id_80B8();
  level thread _id_073F::init();
  level thread scripts\cp\callouts::init();
  level _id_095E::_id_C29C(::_id_3454);

  if(!istrue(level._id_48D5)) {
    scripts\cp\utility::_id_0FB5(["touchpad", "swap_weapon_release"], ::_id_47B8, undefined, 1);
    scripts\cp\utility::_id_0FB5(["touchpad", "swap_weapon", "swap_weapon_release"], ::_id_47B8, undefined, 1);
    scripts\cp\utility::_id_0FB5(["touchpad", "stance_release"], ::_id_47B9, undefined, 1);
    scripts\cp\utility::_id_0FB5(["touchpad", "stance", "stance_release"], ::_id_47B9, undefined, 1);
    scripts\cp\utility::_id_0FB5(["touchpad", "use_release"], ::_id_47B7, undefined, 1);
    scripts\cp\utility::_id_0FB5(["touchpad", "use", "use_release"], ::_id_47B7, undefined, 1);
  } else {}

  game["gamestarted"] = 1;
  level thread _id_1074D();
  _id_06FC::_id_C1C3();
  _id_06FC::_id_C1C4();
  level._id_8C3E = ::_id_8C3D;
}

_id_8C3D() {}

_id_3F69() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("level_ready_for_script");
}

_id_7F47() {
  level._id_F13C = 1;
  level._id_3F68 = [];
  level._id_40ED = [];
  level._id_CF5B = [];
  level._id_40EF = [];
  level._id_CF5D = [];
  level._id_40EE = [];
  level._id_CF5C = [];
  level._id_4047 = 0;
  level._id_CF59 = [];
  level._id_CF5A = [];
  level._id_CF58 = [];
}

_id_1074D() {
  if(scripts\engine\utility::_id_5C0C("strike_init_done")) {
    level endon("game_ended");
    scripts\engine\utility::_id_5C24("strike_init_done");
  }
}

_id_C61F() {
  level._id_59E1 = 0;
  level.gameended = 0;
  level._id_7116 = 10;
  level._id_7EB0 = level._id_7116;
  level._id_A5BB = getEntArray("noragdoll", "targetname");
  level._id_5FA5 = 0;
  level._id_E72D = gettime();
}

_id_C61E() {
  level.players = [];
  level._id_AE7C = [];
  level.characters = [];
  level._id_77D9 = [];
  level._id_F897 = [];
  level._id_7D60 = [];
  level._id_F906 = [];
  level._id_2194 = [];
  level._id_5901 = [];
  level._id_47B3 = [];
  thread scripts\common\utility::_id_1549();
}

_id_CA6E() {
  level notify("coop_pre_match");
  level endon("coop_pre_match");
  level endon("game_ended");
  setomnvar("ui_prematch_period", 1);

  if(isDefined(level._id_BBA5)) {
    [[level._id_BBA5]]();
  }

  scripts\cp\utility::_id_60C1("prematch_done");
  setomnvar("ui_prematch_period", 0);
}

_id_7118() {
  level notify("coop_grace_period");
  level endon("game_ended");
  level endon("coop_grace_period");

  while(_func_006F() == 0) {
    wait 0.05;
  }

  while(level._id_7EB0 > 0) {
    wait 1.0;
    level._id_7EB0--;
  }

  level._id_7EB0 = 0;
}

_id_E6B1() {
  [[level._id_ABAD]]();
}

_id_DC0D() {
  return getDvar("#x38ce255fac6663f1d") == "dedicated LAN server" || getDvar("#x38ce255fac6663f1d") == "dedicated internet server";
}

verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint("#x310c28bb5d64c8c6d")) {
      exitlevel(0);
    }

    if(getDvar("#x38ce255fac6663f1d") != "dedicated LAN server" && getDvar("#x38ce255fac6663f1d") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

_id_C1AF() {
  var_0 = 0;

  if(level.players.size > 1) {
    var_0 = 1;
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_in_progress", var_0);
  }
}

_id_45C0() {
  self endon("disconnect");
  self._id_0407 = "hud_status_connecting";
  self waittill("begin");
  self._id_0407 = "";

  if(!_func_0107(self.pers)) {
    self.pers = [];
  }

  var_0 = gettime();
  level notify("connected", self);
  _id_06CB::_id_2F23("on_player_connect");
  _id_826E();
  _id_D65D();
  _id_8162();
  _id_D8AC();
  _id_06FA::_id_8055(self);
  _id_8268();
  _id_8208();
  _id_0707::_id_1B55(self);
  _id_0946::_id_826B();
  _id_0945::_id_7F66();
  _id_071A::_id_8260();
  _id_0717::_id_805B();
  self._id_A536 = 0;
  self._id_A521 = 0;
  self._id_53C1 = [];
  self._id_1D16 = 0;
  thread _id_D808();

  if(scripts\cp\utility::_id_3D1D("outline")) {
    thread _id_074A::_id_B731();
  }

  thread _id_47B0();
  thread scripts\cp\utility::_id_47B2();
  thread _id_076F::_id_812E();
  thread _id_0741::_id_FCC7();
  thread _id_0787::_id_10E10();
  thread _id_F3DA();
  self.pers["matchdataWeaponStats"] = [];
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost()) {
    level.player = self;
  }

  waittillframeend;
  _id_1112(self);

  if(game["state"] == "postgame") {
    self._id_3B82 = 1;
    self _meth_82F6("#x3e9de50fa971cd442", 0);
    _id_E30E();
    return;
  }

  if(isai(self) && isDefined(level._id_279D) && isDefined(level._id_279D["think"])) {
    self thread[[level._id_279D["think"]]]();
  }

  level endon("game_ended");

  if(isDefined(level._id_7AAE)) {
    thread _id_0733::_id_7AAF();
  }

  if(isDefined(level._id_AB5B)) {
    [[level._id_AB5B]]();
  }

  if(!isai(self)) {
    _id_B71D();
  }

  if(getdvarint("#x3a85a9b6173d4236a", 0)) {
    thread _id_6F3A();
  }

  scripts\cp_mp\utility\game_utility::_id_E6DE();

  if(getdvarint("#x3dee089cb49164e4e", 0) && scripts\engine\utility::_id_5C0C("rbz_player_join_in_progress") && scripts\engine\utility::_id_5C00("rbz_player_join_in_progress")) {
    self.is_rbz_hot_join = 1;
  }

  _id_E337();
}

_id_3454() {}

_id_47B0() {
  self endon("disconnect");
  thread _id_47B5();

  for(;;) {
    self waittill("demo_debug_outline");

    if(getdvarint("#x35d9a930d72db2fa", 0)) {
      if(isDefined(level._id_446D)) {
        setDvar("#x3226b36501b00064b", 0);
        level._id_446D = undefined;
        _id_074A::_id_F9C3();
        _id_074A::_id_C6FC();
        _func_0012("DEBUG - Outline Turned Off!");
        iprintln("DEBUG - Outline Turned Off!");
      } else {
        setDvar("#x3226b36501b00064b", 1);
        level._id_446D = 1;
        _id_074A::_id_CB3A();
        _id_47B6();
        level thread _id_074A::_id_D2B5("outline_nodepth_red");
        _func_0012("DEBUG - Outline Turned On!");
        iprintln("DEBUG - Outline Turned On!");
      }

      wait 0.1;
      continue;
    }

    wait 1;
  }
}

_id_47B7() {}

_id_47B9() {}

_id_47B8() {
  var_0 = getdvarint("#x3605f9ea8537cbe89", 0);

  if(var_0 == 0) {
    _func_0012("Infinite Ammo - On");
    var_0 = 1;
  } else {
    _func_0012("Infinite Ammo - Off");
    var_0 = 0;
  }

  setDvar("#x3605f9ea8537cbe89", var_0);
}

_id_47B4() {
  var_0 = _func_0070("axis");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] _meth_81FA(level.players[0].origin, level.players[0]);
  }
}

_id_47B5() {
  self endon("disconnect");
  self notifyonplayercommand("first", "-actionslot 1");
  self notifyonplayercommand("second", "-actionslot 2");
  self notifyonplayercommand("third", "+usereload");

  for(;;) {
    var_0 = scripts\engine\utility::_id_108AE(2, "first");

    if(var_0 == "timeout") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_108AE(2, "second");

    if(var_0 == "timeout") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_108AE(2, "first");

    if(var_0 == "timeout") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_108AE(2, "second");

    if(var_0 == "timeout") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_108AE(2, "third");

    if(var_0 == "timeout") {
      continue;
    }
    self notify("demo_debug_outline");
    waitframe();
  }
}

_id_47B6() {
  setDvar("#x3fa08eff177bce1f2", ".5 .5 .5 1");
  setDvar("#x3fa08f0f177bce425", "1 1 1 .2");
  setDvar("#x3a640d72a622b53be", "1 .25 .25 1");
  setDvar("#x3f4882363aaeeb795", ".7 .7 .7 1");
  setDvar("#x36710626bef3b9312", "1 0 0 1");
  setDvar("#x3bf1cef26c4100ba3", 1);
}

_id_D808() {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");
  self waittill("spawned_player");
}

_id_F3DA() {
  self notify("track_forward_velocity");
  self endon("track_forward_velocity");
  self endon("disconnect");
  self waittill("spawned_player");
  self._id_1039C = [];
  self._id_1F9A = (0, 0, 0);
  self._id_9928 = [];
  self._id_1F99 = 0;
  self._id_1039D = self.origin;
  self._id_1039E = [];
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = undefined;

  for(;;) {
    var_5 = self getvelocity();
    var_6 = [];
    var_7 = [1024 * min(length(var_5) / 240, 1)];
    var_8 = [];

    if(var_5 != (0, 0, 0)) {
      if(!isDefined(var_4) || distance2dsquared(self.origin, var_4) >= 62500) {
        var_0 = 1;
        var_1 = 1;
        var_2 = 0;
        var_3 = 0;
        var_8[var_8.size] = self.origin;
        var_6[var_6.size] = var_5;
        var_4 = self.origin;
      } else {
        var_2++;
        var_3++;

        if(var_2 >= 12) {
          var_2 = 0;
          var_0 = 0;
        }

        if(var_3 >= 5) {
          var_3 = 0;
          var_1 = 0;
        }
      }
    } else {
      var_2++;
      var_3++;

      if(var_2 >= 12) {
        var_2 = 0;
        var_0 = 0;
      }

      if(var_3 >= 5) {
        var_3 = 0;
        var_1 = 0;
      }
    }

    var_9 = var_7[0];
    var_10 = int(min(20, self._id_1039C.size));

    for(var_11 = 0; var_11 < var_10; var_11++) {
      if(!var_0 && var_11 + 1 >= var_10) {
        var_0 = 1;
        break;
      }

      var_6[var_6.size] = self._id_1039C[var_11];
      var_7[var_7.size] = self._id_9928[var_11];
      var_9 = var_9 + self._id_9928[var_11];
    }

    var_12 = 5;

    if(isDefined(level._id_4A3F)) {
      var_12 = level._id_4A3F;
    }

    var_10 = int(min(var_12, self._id_1039E.size));

    for(var_11 = 0; var_11 < var_10; var_11++) {
      if(!var_1 && var_11 + 1 >= var_10) {
        var_1 = 1;
        break;
      }

      var_13 = var_8.size;
      var_8[var_13] = self._id_1039E[var_11];
    }

    self._id_1039E = var_8;
    self._id_1039C = var_6;

    if(self._id_1039C.size > 0) {
      self._id_1F9A = _id_2ECC(self._id_1039C);
    }

    self._id_9928 = var_7;
    self._id_1F99 = var_9 / self._id_9928.size;
    self._id_1039D = self.origin + vectornormalize(self._id_1F9A) * self._id_1F99;
    wait 0.5;
  }
}

_id_2ECC(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_1 = var_0[0];

  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];
  }

  return var_1 / var_0.size;
}

_id_6F3A() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 2;
  self._id_A300 = 1;

  if(_id_155A(self)) {
    _id_0745::_id_6F15("ammo_crate", 1);
    _id_0745::_id_6F15("armor", 2);
    _id_0745::_id_6F15("grenade_crate", 3);
  }

  self._id_A300 = undefined;
}

_id_155A(var_0) {
  if(isDefined(level._id_155A)) {
    return [[level._id_155A]](var_0);
  }

  return 1;
}

_id_B71D() {
  thread _id_DDEB();
  thread _id_5EA0();
  _id_D791();
  thread _id_0745::_id_6FBB();
  thread _id_B3CA(self);
  thread _id_073C::_id_33C8(self);
}

getfreeclientid() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_399D) && var_3._id_399D == var_0) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      return var_0;
    }
  }
}

_id_D65D() {
  self.guid = scripts\cp\utility::getuniqueid();
  self._id_399D = getfreeclientid();
  self.usingonlinedataoffline = self _meth_81F3();
  self._id_3B81 = 1;
  self._id_10849 = 0;
  self._id_A25F = 1;
  self._id_A8EC = 1;
  self.inlaststand = 0;
  self.needinitializeheart = 1;
}

_id_8162() {
  _id_8163();
  self _meth_82F6("#x3e9de50fa971cd442", 1, "#x3b5ba1bcd76e618ed", 0, "#x3b5721151de5f5352", 1, "#x3abb511cb818d7f09", 1, "#x3cd356b42db4dc9e1", 0, "#x3fb6716a48e67d4f6", 0);

  if(level.teambased) {
    self setclientdvar("#x3acf57c223df6ab1e", 0);
  }
}

_id_8163() {
  if(level.splitscreen || self _meth_81E2()) {
    self _meth_82F6("#x38bd4585c77e2050", "0.75");
    setDvar("#x39e121f7b6097fb74", 0);
  } else
    self _meth_82F6("#x38bd4585c77e2050", "1");
}

_id_D8AC() {
  self._id_CB42 = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    self._id_CB42[var_0] = spawnStruct();
    self._id_CB42[var_0].type = "";
    self._id_CB42[var_0]._id_024F = undefined;
  }

  if(!self _meth_8684()) {
    for(var_0 = 5; var_0 <= 8; var_0++) {
      self._id_CB42[var_0] = spawnStruct();
      self._id_CB42[var_0].type = "";
      self._id_CB42[var_0]._id_024F = undefined;
    }
  }
}

_id_8268() {
  self.perks = [];
  self._id_AFFC = [];
}

_id_DDEB() {
  if(isDefined(level._effect["slide_dust"]) && level._effect["slide_dust"] != 0) {
    self endon("disconnect");

    for(;;) {
      self waittill("sprint_slide_begin");
      self _meth_8275(level._effect["slide_dust"], self getEye());
    }
  }
}

_id_5EA0() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "arcade_off") {
      self notify("adjustedStance");
    }

    if(var_0 == "end_game") {
      level thread[[level._id_5E9F]]();
      self notify("disconnect");
    }
  }
}

_id_D791() {
  self setactionslot(1, "");

  if(istrue(level._id_4A29)) {
    self setactionslot(2, "");
  }

  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("D_pad_up", "+actionslot 1");
  self notifyonplayercommand("D_pad_down", "+actionslot 2");
  self notifyonplayercommand("D_pad_left", "+actionslot 3");
  self notifyonplayercommand("D_pad_right", "+actionslot 4");
}

_id_E30E(var_0) {
  self endon("disconnect");
  _id_D578();
  var_1 = self._id_5EC2;
  self _meth_8282(self._id_5EC7, 1);
  wait 2;

  while(!self _meth_8284()) {
    wait 0.5;
  }

  self setclientdvar("#x3acf57c223df6ab1e", 1);
  self _meth_830B(0, 128, 512, 4000, 6, 1.8);

  if(self _meth_8684()) {
    self setclientdvar("#x356e0c9e15809767a", "90");
  }

  scripts\cp\utility::_id_FD26("intermission");
}

_id_E30F(var_0) {
  self visionsetnakedforplayer("flir_0_black_to_white", 0);
  self setclientdvar("#x3acf57c223df6ab1e", 1);
  scripts\cp\utility::_id_FD26("intermission");
}

_id_D578() {
  var_0 = _id_6A71();
  _id_D56B(var_0.origin, var_0.angles);
}

_id_D56B(var_0, var_1) {
  self._id_5EC7 = var_0;
  self._id_5EC2 = var_1;
}

_id_6A71() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  return var_0[0];
}

_id_E337(var_0) {
  thread _id_E339(var_0);
}

_id_E339(var_0) {
  level endon("game_ended");
  self notify("spawnPlayer_internal");
  self endon("spawnPlayer_internal");
  self endon("disconnect");
  self endon("joined_spectators");

  if(self._id_10849) {
    return;
  }
  _id_10829();
  _id_E338(var_0);
}

_id_10829() {
  self._id_10849 = 1;

  if(scripts\cp\utility::_id_8ACE()) {
    self waittill("stopped_using_remote");
  }

  self._id_10849 = 0;
}

_id_395B() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

_id_FCBD() {
  if(!isDefined(game["numPlayersConsideredPlaying"])) {
    _id_395B();
  }

  var_0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++) {
        level.players[var_1] setclientomnvar("match_has_more_than_1_player", 1);
      }
    } else
      self setclientomnvar("match_has_more_than_1_player", 1);
  }

  self._id_9BA4 = 1;
}

_id_FCBC() {
  if(istrue(self._id_9BA4)) {
    var_0 = game["matchHasMoreThan1Player"];
    game["numPlayersConsideredPlaying"]--;

    if(game["matchHasMoreThan1Player"]) {
      if(game["numPlayersConsideredPlaying"] <= 1) {
        game["matchHasMoreThan1Player"] = 0;
      }
    }

    if(!game["matchHasMoreThan1Player"]) {
      if(var_0) {
        for(var_1 = 0; var_1 < level.players.size; var_1++) {
          level.players[var_1] setclientomnvar("match_has_more_than_1_player", 0);
        }
      }
    }

    self._id_9BA4 = 0;
  }
}

_id_E338(var_0) {
  self notify("spawned");
  self notify("started_spawnPlayer");
  var_1 = getDvar("#x37c07c0ad254a7b86");

  if(var_1 != "") {
    var_2 = _id_0710::_id_3543(var_1, "player_spawn");
    self._id_5EC7 = var_2.origin;
    self._id_354D = var_2;

    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    self._id_5EC2 = var_2.angles;
    var_2 thread _id_0710::_id_3547(self);
  }

  if(level.gameended) {
    self spawn(_id_6D49(self, 1), _id_6D3E(self));
  } else {
    self spawn(_id_6D49(self), _id_6D3E(self));
  }

  _id_C636();
  _id_C638();
  _id_C62F();
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 0);

  if(!var_0) {
    _id_A5AB();
  }

  if(level.gametype == "cp_survival" && !scripts\cp\utility::_id_8694()) {
    if(!var_0 && !istrue(self._id_2C59)) {
      self setclientomnvar("ui_session_state", "spectator");
    }
  }

  if(isai(self)) {
    _id_E260(var_0);
  }

  [[level._id_ABA4]](var_0);

  if(!var_0) {
    _id_076E::_id_3F8D(self);
  }

  thread _id_073C::update_instant_loadout_swap();

  if(isDefined(self.respawnclassindex)) {
    self._id_45A9 = self.respawnclassindex;
    self.respawnclassindex = undefined;
  }

  if(isDefined(self.respawncustomclass)) {
    self.usecustomclass = self.respawncustomclass;
    self.respawncustomclass = undefined;
  }

  self[[level._id_4249]](var_0, undefined, self._id_45A9, istrue(self.usecustomclass));

  if(getdvarint("#x36c8f5946a1247e70")) {
    scripts\cp\utility::setthirdpersondof(1);
  }

  scripts\cp\utility::_id_6FC2("specialty_pistoldeath");
  self painvisionon();

  if(istrue(level._id_4A29)) {
    self setactionslot(2, "");
  }

  self setactionslot(3, "altmode");
  self setclientomnvar("ui_hide_objectives", 0);
  waittillframeend;

  if(scripts\cp\utility::_id_871A()) {
    if(!istrue(self._id_9BA4)) {
      _id_FCBD();
    }
  }

  self notify("spawned_player");
  level notify("player_spawned", self);
  _id_06CB::_id_2F23("on_player_spawned");
  thread _id_7B5E();
  thread _id_10A83();
  thread _id_1536();

  if(!istrue(level._id_4CE0)) {
    if(!var_0) {}
  }

  thread _id_0945::_id_9B38();

  if(scripts\cp\utility::_id_871A()) {
    self._id_4A59 = 1;
  }

  self._id_A521 = 0;
  self._id_A536 = 0;
  scripts\cp\utility::_unsetperk("specialty_spygame");
  scripts\cp\utility::_unsetperk("specialty_coldblooded");
  scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
  scripts\cp\utility::_unsetperk("specialty_heartbreaker");
  self notify("covenant_unlock_check_ready");

  if(istrue(self._id_2C59)) {
    _id_073B::_id_6EEA(self);
  } else if(istrue(self.is_rbz_hot_join) && isDefined(level.rbz_on_player_hot_join)) {
    self thread[[level.rbz_on_player_hot_join]]();
  } else if(!_id_0726::_id_60B9() && !istrue(var_0)) {
    if(!scripts\cp\utility::_id_871A() && !istrue(self._id_88AB)) {
      if(!istrue(self._id_9BA4)) {
        _id_FCBD();
      }

      if(isDefined(level._id_BA32)) {
        self thread[[level._id_BA32]]();
      }

      if(level.gametype == "cp_survival") {
        self setclientomnvar("ui_session_state", "playing");
      }
    }
  }

  clearplayercamoscripts();
  runplayercamoscripts();
  setupultraoperatorskins(_id_9818());
  self.on_initializing = undefined;
}

_id_AD3F() {
  self._id_581C = 1;
}

_id_7B5E() {
  self endon("disconnect");
  _id_C637();
}

_id_AC0E() {
  if(!scripts\cp\utility::_id_871A()) {
    self waittill("open_loadout_menu");
    self setclientomnvar("ui_options_menu", 2);
  }
}

close_all_menus() {
  self setclientomnvar("ui_options_menu", 0);
}

_id_C637() {
  self setclientomnvar("ui_hud_shake", 0);
  self setclientomnvar("ui_refresh_hud", 1);
  self setclientomnvar("zm_ui_player_in_laststand", 0);

  if(scripts\cp\utility::_id_871A()) {
    self setclientomnvar("ui_hide_minimap", 0);
  } else if(scripts\cp\utility::_id_872D()) {
    self setclientomnvar("ui_hide_minimap", 0);
  } else {
    self setclientomnvar("ui_hide_minimap", 1);
  }

  scripts\cp\utility::_id_80FF();
}

_id_C636() {
  self _meth_83F5();
  self _meth_83F4("damage_heavy");
  self _meth_830B(0, 0, 512, 512, 4, 0);

  if(self _meth_8684()) {
    self setclientdvar("#x356e0c9e15809767a", "65");
  }
}

_id_C62F() {
  if(isDefined(self._id_10D9)) {
    var_0 = getarraykeys(self._id_10D9);

    foreach(var_2 in var_0) {
      scripts\cp\utility::_id_C48A(var_2, 1);
    }
  }

  if(isDefined(self._id_A2FB)) {
    var_0 = getarraykeys(self._id_A2FB);

    foreach(var_2 in var_0) {
      scripts\cp\utility::_id_C48A(var_2, 0);
    }
  }
}

_id_C638() {
  var_0 = _id_6D5F();
  self.team = var_0;
  self.sessionteam = _id_6D5A(var_0);
  self.pers["team"] = var_0;
  self._id_59E0 = undefined;
  self._id_A25F = 1;
  scripts\common\input_allow::_id_38B0("weapon");
  scripts\common\input_allow::_id_38B0("offhandWeaps");
  self._id_75A6 = 0;
  self._id_75A5 = 0;
}

_id_6D5A(var_0) {
  if(isDefined(level._id_B7D3)) {
    return [[level._id_B7D3]](self, var_0);
  }

  return var_0;
}

_id_6D5F() {
  if(isDefined(level._id_B7D4)) {
    return [[level._id_B7D4]](self);
  }

  return "allies";
}

_id_A5AB() {
  _id_C626();
  scripts\cp\utility::_id_FD26("playing");
}

_id_C626() {
  self.maxhealth = self[[level._id_B716]]();
  self.health = self.maxhealth;
  self._id_1FAF = 5.0;
  self._id_5FA4 = undefined;
  self._id_75B4 = 1;
  self._id_E393 = gettime();
  self._id_A8EC = 1;
}

_id_E260(var_0) {
  if(!var_0) {
    if(isDefined(level._id_279D) && isDefined(level._id_279D["player_spawned"])) {
      self[[level._id_279D["player_spawned"]]]();
    }
  }
}

_id_6D49(var_0, var_1) {
  var_2 = undefined;
  var_3 = istrue(level._id_DD94);
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(scripts\engine\utility::is_equal(var_0, var_6)) {
      continue;
    }
    if(isDefined(var_4)) {
      continue;
    }
    var_7 = 1;

    if(scripts\engine\utility::cointoss()) {
      var_7 = -1;
    }

    var_8 = 1;

    if(scripts\engine\utility::cointoss()) {
      var_8 = -1;
    }

    var_9 = (var_7 * 32, -1 * var_8 * 32, 0);
    var_4 = _func_02AB(var_6.origin + var_9);
  }

  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51)) {
    var_11 = _id_0987::_id_6692(level._id_3BE9._id_0F51);

    if(isDefined(level._id_3BE9._id_0F51.a_unused_player_spawn_pts) && level._id_3BE9._id_0F51.a_unused_player_spawn_pts.size > 0) {
      foreach(var_13 in level._id_3BE9._id_0F51.a_unused_player_spawn_pts) {
        var_14 = _func_02AB(var_13.origin);

        if(isDefined(var_14)) {
          return var_14;
        }
      }

      if(isDefined(var_4)) {
        return var_4;
      } else {
        return level._id_3BE9._id_0F51.a_unused_player_spawn_pts[0].origin;
      }
    }

    if(isDefined(var_11) && isDefined(var_11[0])) {
      foreach(var_13 in var_11) {
        var_14 = _func_02AB(var_13.origin);

        if(isDefined(var_14)) {
          return var_14;
        }
      }
    }

    if(isDefined(var_4)) {
      return var_4;
    }

    if(isDefined(var_11) && isDefined(var_11[0])) {
      return var_11[0].origin;
    }
  }

  if(isDefined(var_0._id_5EC7)) {
    var_2 = var_0._id_5EC7;

    if(!var_3) {
      var_2 = _func_02AB(var_2);
    }

    if(isDefined(var_1)) {
      var_2 = var_0._id_5EC7;
    }

    var_0._id_5EC7 = undefined;
  } else {
    var_18 = var_0[[level._id_6D4A]]();
    var_2 = scripts\engine\utility::ter_op(istrue(level._id_4A56), scripts\engine\utility::_id_5000(var_18.origin, 32, -100), _func_02AB(var_18.origin));

    if(isDefined(var_1)) {
      var_2 = var_18;
    }
  }

  return var_2;
}

_id_6D3E(var_0) {
  var_1 = undefined;

  if(isDefined(var_0._id_5EC2)) {
    var_1 = var_0._id_5EC2;
    var_0._id_5EC2 = undefined;
  } else {
    var_2 = var_0[[level._id_6D4A]]();
    var_1 = scripts\engine\utility::ter_op(isDefined(var_2.angles), var_2.angles, (0, 0, 0));
  }

  return var_1;
}

_id_DB61() {
  if(game["state"] == "postgame") {
    return 1;
  }

  return 0;
}

_id_54E1() {
  var_0 = _id_6A71();
  self _meth_8380(var_0.origin, var_0.angles);
  _id_D56B(var_0.origin, var_0.angles);
  _id_D6E3();
  scripts\cp\utility::_id_FD26("spectator");
}

_id_D6E3() {
  if(isDefined(level._id_E3E4)) {
    [[level._id_E3E4]](self);
  } else {
    _id_45C9(self);
  }
}

_id_45C9(var_0) {
  var_0 _meth_8013("allies", 1);
  var_0 _meth_8013("axis", 1);
  var_0 _meth_8013("freelook", 0);
  var_0 _meth_8013("none", 1);
}

_id_45C2(var_0) {
  if(!isDefined(self._id_3B81)) {
    return;
  }
  _id_0705::_id_AA5E(var_0);
  _id_C508(self);

  if(_id_4B19()) {
    _id_C5C6();

    if(level.players.size == 0) {
      level thread _id_0726::_id_52F7("axis", _id_0726::_id_6472("host_end"));
    } else {
      level thread _id_0726::_id_52F7("axis", _id_0726::_id_6472("kia"));
    }
  }

  if(isDefined(level._id_AB63)) {
    level thread[[level._id_AB63]](self, var_0);
  }

  _id_FCBC();
  level notify("player_disconnect");
}

_id_4B19() {
  if(level.splitscreen) {
    return level.players.size <= 1;
  }

  if(level.players.size < 1) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in level.players) {
    if(!istrue(var_2._id_E3E5)) {
      var_0 = 0;
      break;
    }
  }

  if(var_0) {
    return 1;
  }

  var_4 = 0;

  foreach(var_2 in level.players) {
    if(_id_073B::_id_B4EF(var_2)) {
      var_4 = _id_073B::_id_60E5(var_2);
    }
  }

  return var_4;
}

_id_1112(var_0) {
  level.players[level.players.size] = var_0;
  level._id_AE7C[level._id_AE7C.size] = var_0;
  level.characters[level.characters.size] = var_0;
}

_id_C508(var_0) {
  level.players = scripts\engine\utility::array_remove(level.players, var_0);
  level._id_AE7C = scripts\engine\utility::array_remove(level._id_AE7C, var_0);
  level.characters = scripts\engine\utility::array_remove(level.characters, var_0);
}

_id_45C5() {
  if(self ishost()) {
    _id_8163();
  }

  if(_id_88AD(self)) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(_id_88AD(var_2)) {
        var_0++;
      }
    }

    level._id_7AAC++;

    if(level._id_7AAC >= var_0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
    }
  }
}

_id_88AD(var_0) {
  return !isbot(var_0) && !_func_03DA(var_0);
}

_id_45B7() {
  if(level.gameended) {
    return;
  }
  level._id_7AAC = 0;

  foreach(var_1 in level.characters) {
    var_1._id_7AA9 = 0;
  }

  level._id_7AAE = 1;
  setDvar("#x31ce9c5116005b62a", 1);
  level notify("host_migration_begin");

  foreach(var_1 in level.characters) {
    if(isDefined(var_1)) {
      var_1 thread _id_0733::_id_7AAF();
    }

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_session_state", var_1.sessionstate);
    }
  }

  setDvar("#x3744574c7226889f7", game["state"]);
  level endon("host_migration_begin");
  _id_0733::_id_7AB1();
  level._id_7AAE = undefined;
  setDvar("#x31ce9c5116005b62a", 0);

  if(isDefined(level._id_7AAA)) {
    level thread[[level._id_7AAA]]();
  }

  level notify("host_migration_end");
  level _id_06CB::_id_2F23("on_host_migration_end", undefined);
}

_id_817F() {
  var_0 = getEntArray("destructable", "targetname");

  if(getDvar("#x3208394a84c38a7b8") == "0") {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] delete();
    }
  } else {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] thread _id_486B();
    }
  }
}

_id_486B() {
  var_0 = 40;
  var_1 = 0;

  if(isDefined(self._id_CC8B)) {
    var_0 = self._id_CC8B;
  }

  if(isDefined(self._id_CE82)) {
    var_1 = self._id_CE82;
  }

  if(isDefined(self._id_CD65)) {
    self._id_605B = loadfx(self._id_CD65);
  }

  var_2 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_3, var_4);

    if(var_3 >= var_1) {
      var_2 = var_2 + var_3;

      if(var_2 >= var_0) {
        thread _id_486A();
        return;
      }
    }
  }
}

_id_486A() {
  var_0 = self;

  if(isDefined(var_0._id_605B)) {
    playFX(var_0._id_605B, var_0.origin + (0, 0, 6));
  }

  var_0 delete();
}

_id_81AF() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level._id_7B25["allies"] = spawnStruct();
  level._id_7B25["axis"] = spawnStruct();
  level._id_BCDC = -61;
  level._id_BCDB = 0;
  level._id_BCD7 = 9;
  level._id_BCDA = 120;
  level._id_BCD9 = -75;
  level._id_BCD8 = 0;
  level._id_BCD6 = 1.2;
  level._id_EF99 = 32;
  level._id_EF96 = 14;
  level._id_EF98 = 192;
  level._id_EF97 = 8;
  level._id_EF95 = 1.65;
  level._id_98CA = "BOTTOM";
  level._id_98C9 = -140;
  level._id_98C8 = 1.2;
}

_id_57C4(var_0) {
  level endon("killexplodertridgers" + var_0._id_0397);
  var_0 waittill("trigger");

  if(isDefined(var_0._id_CCD7) && randomfloat(1) > var_0._id_CCD7) {
    if(isDefined(var_0._id_0393)) {
      wait(var_0._id_0393);
    } else {
      wait 4;
    }

    level thread _id_57C4(var_0);
    return;
  }

  scripts\engine\utility::_id_57BA(var_0._id_0397);
  level notify("killexplodertridgers" + var_0._id_0397);
}

_id_B4FD() {
  self._id_C1BA = 1;
}

_id_B4FE() {
  self._id_75D0 = 1;
}

_id_B4FB() {
  self._id_4329 = gettime();
}

_id_253B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_826E() {
  self setplayerdata("cp", "alienSession", "team_shots", 0);
  self setplayerdata("cp", "alienSession", "team_kills", 0);
  self setplayerdata("cp", "alienSession", "team_hives", 0);
  self setplayerdata("cp", "alienSession", "downed", 0);
  self setplayerdata("cp", "alienSession", "hivesDestroyed", 0);
  self setplayerdata("cp", "alienSession", "prestigenerfs", 0);
  self setplayerdata("cp", "alienSession", "repairs", 0);
  self setplayerdata("cp", "alienSession", "drillPlants", 0);
  self setplayerdata("cp", "alienSession", "deployables", 0);
  self setplayerdata("cp", "alienSession", "challengesCompleted", 0);
  self setplayerdata("cp", "alienSession", "challengesAttempted", 0);
  self setplayerdata("cp", "alienSession", "trapKills", 0);
  self setplayerdata("cp", "alienSession", "currencyTotal", 0);
  self setplayerdata("cp", "alienSession", "currencySpent", 0);
  self setplayerdata("cp", "alienSession", "currency", 0);
  self setplayerdata("cp", "alienSession", "kills", 0);
  self setplayerdata("cp", "alienSession", "revives", 0);
  self setplayerdata("cp", "alienSession", "time", 0);
  self setplayerdata("cp", "alienSession", "score", 0);
  self setplayerdata("cp", "alienSession", "shots", 0);
  self setplayerdata("cp", "alienSession", "last_stand_count", 0);
  self setplayerdata("cp", "alienSession", "deaths", 0);
  self setplayerdata("cp", "alienSession", "headShots", 0);
  self setplayerdata("cp", "alienSession", "hits", 0);
  self setplayerdata("cp", "alienSession", "resources", 0);
  self setplayerdata("cp", "alienSession", "waveNum", 0);
}

_id_8208() {
  if(isDefined(level._id_B4FF)) {
    [[level._id_B4FF]]();
  } else {
    _id_073B::_id_4582();
  }
}

_id_8206() {
  level._id_8DF3 = scripts\engine\utility::getStructArray("respawn_edge", "targetname");
}

_id_6AEE() {
  return scripts\engine\utility::_id_6969(self.origin, level._id_8DF3);
}

_id_E677() {
  if(scripts\engine\utility::_id_5C0C("interactions_initialized")) {
    scripts\engine\utility::_id_5C24("interactions_initialized");
  } else {
    wait 0.2;
  }
}

_id_990E() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("stop_watch_for_LUINotifies");
  self endon("stop_watch_for_LUINotifies");
  var_0 = 0;

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(isDefined(var_1)) {
      switch (var_1) {
        case "disable_player_view":
          break;
        case "enable_player_view":
          break;
        case "skill_updated":
          _id_0913::_id_6FF0(var_2);
          break;
        case "dpad_slot_up":
          break;
        case "dpad_slot_right":
          break;
      }
    }
  }
}

_id_B845(var_0) {
  self endon("disconnect");

  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case 1:
      self _meth_84AF("ges_hack_loop_end");
      break;
    case 0:
      self _meth_84AF("ges_hack_loop");
      break;
  }

  scripts\common\utility::_id_153E(var_0);
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_1593(var_0);
  scripts\common\utility::_id_158A(var_0);
  scripts\common\utility::_id_151F(var_0);
}

_id_B3CA(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  wait 1;
  var_1 = 0;
  var_2 = 120;

  if(scripts\cp\utility::_id_871A()) {
    _id_2BF6(var_0);
  }

  _id_2BF8(var_0, 0);
  _id_2BF7(var_0);
  var_3 = scripts\cp\utility::_id_871A();
  var_4 = scripts\cp\utility::_id_8588();

  for(;;) {
    waitframe();
    var_1 = var_1 + 1;

    if(var_1 == var_2) {
      var_1 = 0;
      _id_2BF7(var_0);

      if(var_3) {
        waitframe();
        _id_2BF6(var_0);
        continue;
      }

      if(var_4) {
        waitframe();
        _id_2BF5(var_0);
      }
    }
  }
}

_id_2BF6(var_0) {
  var_1 = var_0 getentitynumber();
  var_2 = var_0 getplayerdata("cp", "alienSession", "currency");
  _id_074E::_id_D4E4("EoGPlayer", var_1, "currency", var_2);
}

_id_2BF7(var_0) {}

_id_2BF5(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(var_0._id_32EA)) {
    var_0._id_32EA = 0;
  }

  if(!isDefined(var_0._id_32E9)) {
    var_0._id_32E9 = 0;
  }

  _id_074E::_id_D4E4("EoGPlayer", var_1, "carryItem2", var_0._id_32E9);
  _id_074E::_id_D4E4("EoGPlayer", var_1, "carryItem", var_0._id_32EA);
}

_id_2BF8(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  _id_074E::_id_D4E4("EoGPlayer", var_2, "playerStatus", var_1);
}

_id_10A83() {
  self endon("death");
  self endon("disconnect");
  self._id_EEA5 = [];

  for(;;) {
    if(scripts\cp\utility::_id_872D()) {
      var_0 = self getEye();
      var_1 = self getplayerangles();
      var_2 = anglesToForward(var_1);
      var_3 = var_0 + var_2 * 10000;
      var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 1, self, 0, 1, 0, 0, 0);
      var_5 = var_4["entity"];

      if(isDefined(var_5) && _func_011D(var_5) && !isPlayer(var_5) && !istrue(var_5.disable_ui_target)) {
        var_6 = var_5 _id_09A4::get_enemy_type_num();
        var_7 = var_5 _id_09A4::get_enemy_class_num();

        if(isDefined(var_5.team) && var_5.team == self.team) {
          var_7 = 4;
        }

        _id_FBD5("ui_target_enemy_type", var_6);
        _id_FBD5("ui_target_enemy_class", var_7);
        _id_FBD5("ui_target_health", var_5.health);
        _id_FBD5("ui_target_max_health", var_5.maxhealth);
        _id_FBD5("ui_target_entity_num", var_5 getentitynumber());
      } else if(isDefined(level.force_check_health_bar_for_certain_entity))
        self[[level.force_check_health_bar_for_certain_entity]](level.entity_to_check_health_bar);
      else {
        _id_FBD5("ui_target_entity_num", -1);
      }
    }

    wait 0.1;
  }
}

_id_FBD5(var_0, var_1) {
  wait 0.05;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(self._id_EEA5[var_0]) || var_1 != self._id_EEA5[var_0]) {
    self setclientomnvar(var_0, var_1);
    self._id_EEA5[var_0] = var_1;
  }
}

send_damage_number_to_player(var_0, var_1, var_2, var_3) {
  var_2 = int(clamp(var_2, 0, 1000000));
  var_4 = int(clamp(var_3[0], -100000, 100000));
  var_5 = int(clamp(var_3[1], -100000, 100000));
  var_6 = int(clamp(var_3[2], -100000, 100000));
  var_0 setclientomnvar("ui_zm_dmg_num_amount", var_2);
  var_0 setclientomnvar("ui_zm_dmg_num_x", var_4);
  var_0 setclientomnvar("ui_zm_dmg_num_y", var_5);
  var_0 setclientomnvar("ui_zm_dmg_num_z", var_6);
  var_0 setclientomnvar("ui_zm_dmg_num_state", var_1);
}

display_damage_number(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\cp\utility::getweaponrootname(var_4);
  var_9 = _func_0222("mp/statstable.csv", 4, var_8, 1);
  var_10 = 0;

  if(istrue(var_7)) {
    var_10 = 2;
  } else if(var_1 scripts\cp\utility::_id_8891(var_4, var_2, var_3, var_0) && (var_9 != "weapon_projectile" || var_8 == "s4_la_walpha2")) {
    var_10 = 1;
  }

  if(var_2 == "none" && var_3 != "MOD_MELEE") {
    var_11 = scripts\cp\utility::_id_459B(var_1.override_damage_number_offset, (0, 0, 12));

    if(isalive(var_1)) {
      var_12 = scripts\cp\utility::_id_459B(var_1.override_damage_number_fallback_tag, "j_head");
      var_6 = var_1 gettagorigin(var_12) + var_11;
    } else
      var_6 = var_1.origin + var_11;
  }

  thread display_damage_number_internal(var_0, var_10, var_5, var_6);
}

display_damage_number_internal(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");

  if(!isDefined(var_0.damagenumcount)) {
    var_0.damagenumcount = 0;
  }

  var_0.damagenumcount++;
  wait(0.05 * var_0.damagenumcount);
  send_damage_number_to_player(var_0, var_1, var_2, var_3);

  if(isDefined(var_0.damagenumcount)) {
    var_0.damagenumcount--;
  }
}

_id_1536() {
  wait 5;

  if(getdvarint("#x3c60993fdcfd0ab16", 0) == 0) {
    return;
  }
  var_0 = 0;

  while(var_0 < 30) {
    var_0++;

    if(!isDefined(level._id_7E42)) {
      break;
    }

    wait 2;
  }
}

_id_A0D8() {
  scripts\engine\utility::_id_5C11("player_count_determined");
  var_0 = getDvar("#x345ba6dff8ecba1eb");

  if(var_0 != "1") {
    level._id_AB30 = 0;
    scripts\engine\utility::_id_5C1B("player_count_determined");
    return;
  }

  level._id_AB30 = 1;
  scripts\engine\utility::_id_5C1B("player_count_determined");

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level._id_AB30 = 0;
  level notify("multiple_players");
}

_id_D9CD() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", ::_id_616B);
}

_id_616B(var_0) {
  return 200.0;
}

_id_4735() {
  scripts\engine\utility::_id_1BA4(getEntArray("delete_on_load", "targetname"));
  scripts\engine\utility::delaythread(0.05, scripts\engine\utility::_id_1BA4, getEntArray("delete_on_firstframeend", "targetname"));
}

_id_C5C6() {
  setDvar("#x37c07c0ad254a7b86", "");
  setDvar("#x3f48b841d6974edd0", "");
  setDvar("#x339461d29b45a1c1", "");
  setDvar("#x3a798699f4200f536", "");
  setDvar("#x3ba355a76ad865d82", "");
  setDvar("#x33ac7852ce5f68088", "");
}

_id_1195() {
  setDvar("#x3881f7a32e9ff6122", 1500);
  setDvar("#x3aaf3f884808e1bdb", 1800);
  setDvar("#x3cd655c8e993af39f", 1800);
  setDvar("#x341ca217cbf873de6", 1000);
  setDvar("#x3312716a1e25168bb", 1800);
  setDvar("#x3aa9b7fb1ca2f5f48", 500);
  setDvar("#x32b07ac54b70a2a6a", 60);
  setDvar("#x38415a8ae0089f7d0", 0);
}

runplayercamoscripts() {
  if(!getdvarint("#x3b1d87d8e0b53e10", 1) || !self _meth_86EE()) {
    return;
  }
  if(playerhasreactivecamo()) {
    thread playerreactivecamo();
    thread devplayerreactivecamo();
  } else
    self setscriptablepartstate("playerActiveCamo", "no_stage");
}

clearplayercamoscripts() {
  self notify("endPlayerReactiveCamoThread");

  if(isDefined(self.playerreactivecamo)) {
    self.playerreactivecamo.stage = 0;
    self.playerreactivecamo._id_0267 = 0;
  }

  self setscriptablepartstate("playerActiveCamo", "no_stage");
}

playerreactivecamosetstage(var_0, var_1) {
  self.playerreactivecamo.stage = var_0;

  if(var_1 == 1) {
    self setscriptablepartstate("playerActiveCamo", "stage" + var_0);
  } else {
    self setscriptablepartstate("playerActiveCamo", "init_stage" + var_0);
  }

  setultraoperatorskinreactivestage(var_0);
}

playerreactivecamowatchgesturenotetracks() {
  self.playerreactivecamocurprocgestures = [];

  if(!isDefined(level.playerreactivecamoexcludedgestures)) {
    level.playerreactivecamoexcludedgestures = [];
  }

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!self _meth_84B7() && !self _meth_887C()) {
      waitframe();
      continue;
    }

    if(self _meth_84B7()) {
      var_0 = self _meth_84AE();

      foreach(var_2 in var_0) {
        if(scripts\engine\utility::array_contains(self.playerreactivecamocurprocgestures, var_2) || scripts\engine\utility::array_contains(level.playerreactivecamoexcludedgestures, var_2)) {
          waitframe();
          continue;
        }

        var_3 = self _meth_8879(var_2, "prac_");

        if(var_3.size > 0) {
          var_4 = self _meth_887A(var_2);
          var_5 = self _meth_8495(var_2);

          if(var_4 > var_5 * 0.75) {
            waitframe();
            continue;
          }

          thread end_watcher_gesture(var_2);
          thread playerreactivecamonotetrackwatcher(var_3, var_4, var_5, var_2);
          continue;
        }

        level.playerreactivecamoexcludedgestures = scripts\engine\utility::array_add(level.playerreactivecamoexcludedgestures, var_2);
      }
    } else if(self _meth_887C()) {
      var_7 = self getcurrentweapon();

      if(scripts\engine\utility::array_contains(self.playerreactivecamocurprocgestures, var_7.basename) || scripts\engine\utility::array_contains(level.playerreactivecamoexcludedgestures, var_7.basename)) {
        waitframe();
        continue;
      }

      var_3 = self _meth_887F("prac_");

      if(var_3.size > 0) {
        var_8 = self _meth_887D();
        var_9 = self _meth_887E();

        if(var_8 > var_9 * 0.75) {
          waitframe();
          continue;
        }

        thread end_watcher_inspect(var_7.basename);
        thread playerreactivecamonotetrackwatcher(var_3, var_8, var_9, var_7.basename);
      } else
        level.playerreactivecamoexcludedgestures = scripts\engine\utility::array_add(level.playerreactivecamoexcludedgestures, var_7.basename);
    }

    waitframe();
  }
}

end_watcher_gesture(var_0) {
  while(self _meth_84B7(var_0)) {
    waitframe();
  }

  self notify("cancel_player_reactive_watcher");
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_remove(self.playerreactivecamocurprocgestures, var_0);
}

end_watcher_inspect(var_0) {
  while(self _meth_887C()) {
    waitframe();
  }

  self notify("cancel_player_reactive_watcher");
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_remove(self.playerreactivecamocurprocgestures, var_0);
}

playerreactivecamonotetrackcomparefunc(var_0, var_1) {
  return var_0._id_110F4 < var_1._id_110F4;
}

playerreactivecamonotetrackwatcher(var_0, var_1, var_2, var_3) {
  self endon("cancel_player_reactive_watcher");
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_add(self.playerreactivecamocurprocgestures, var_3);
  var_0 = scripts\engine\utility::_id_1BD6(var_0, ::playerreactivecamonotetrackcomparefunc);
  var_4 = 0.0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_6._id_110F4 * var_2 < var_1) {
      playerreactivecamoprocessnotetrack(var_6.name);
      continue;
    }

    break;
  }

  var_4 = var_1;

  for(var_7 = var_5; var_7 < var_0.size; var_7++) {
    var_8 = var_0[var_7]._id_110F4 * var_2;
    wait(var_8 - var_4);
    var_4 = var_8;
    playerreactivecamoprocessnotetrack(var_0[var_7].name);
  }

  wait(var_2 - var_4);
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_remove(self.playerreactivecamocurprocgestures, var_3);
}

playerreactivecamoprocessnotetrack(var_0) {
  var_1 = getplayerreactivecamostagecount();
  var_2 = getplayerreactivecamostage();
  var_3 = 0;
  var_0 = _func_00D6(var_0, 5);
  var_4 = strtok(var_0, ",");

  if(var_4[0] == "increment") {
    if(var_4.size > 1 && var_4[1] == "cyclical") {
      var_2 = (var_2 + 1) % var_1;
      var_3 = 2;
    } else {
      var_2 = int(min(var_2 + 1, var_1 - 1));
      var_3 = 1;
    }
  } else if(var_4[0] == "set" && var_4.size > 1) {
    var_2 = int(var_4[1]);
    var_2 = int(clamp(var_2, 0, var_1));
    var_3 = 2;
  }

  var_5 = 0;

  if(var_4.size > var_3) {
    var_5 = int(var_4[var_3]) == 1;
  }

  setplayerreactivecamostage(var_2, var_5);
}

playerreactivecamosetup() {
  if(!isDefined(self.playerreactivecamo)) {
    self.playerreactivecamo = spawnStruct();
    self.playerreactivecamo._id_0267 = 0;
    self.playerreactivecamo.stage = 0;
    self.playerreactivecamo._id_E06D = getplayerreactivesource();
    var_0 = getplayerreactivestagesetdef();
    self _meth_8884(var_0);
  }
}

getplayerreactivecamostage() {
  if(!isDefined(self.playerreactivecamo)) {
    return -1;
  }

  return self.playerreactivecamo.stage;
}

setplayerreactivecamostage(var_0, var_1) {
  playerreactivecamosetup();
  playerreactivecamosetstage(var_0, var_1);
}

getplayerreactivecamostagecount() {
  var_0 = self _meth_8886();
  return var_0.size;
}

playerreactivecamo() {
  self endon("disconnect");
  self endon("death");
  self endon("endPlayerReactiveCamoThread");
  playerreactivecamosetup();

  if(!istrue(self.handledplayerreactivecamo)) {
    self.handledplayerreactivecamo = 1;
    thread playerreactivecamowatchgesturenotetracks();
  }

  var_0 = self.playerreactivecamo;
  playerreactivecamosetstage(var_0.stage, 0);

  if(var_0._id_E06D == "kills") {
    var_1 = self _meth_8886();
    var_2 = int(var_1.size - 1);

    for(;;) {
      scripts\engine\utility::_id_108C5("on_ai_killed", "scr_advanceplayerreactivecamo");
      var_3 = int(var_1[int(min(var_0.stage + 1, var_2))]);
      var_0._id_0267++;

      if(var_0._id_0267 == var_3) {
        playerreactivecamosetstage(var_0.stage + 1, 1);
      }
    }
  } else if(var_0._id_E06D == "heal") {
    for(;;) {
      self waittill("heal_started");
      playerreactivecamosetstage(2, 1);
      scripts\engine\utility::waittill_any_3("healed", "heal_interrupted", "death");
      wait(getdvarfloat("#x3d12e89db8d104a7d", 3.0));
      playerreactivecamosetstage(1, 1);
    }
  }
}

devplayerreactivecamo(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endPlayerReactiveCamoThread");
  playerreactivecamosetup();

  for(;;) {
    self waittill("scr_resetplayerreactivecamo");
    var_1 = self.playerreactivecamo;
    var_1._id_0267 = 0;
    var_1.stage = 0;
    playerreactivecamosetstage(var_1.stage, 0);
  }
}

getplayerreactivestagesetdef() {
  return getoperatorreactivestagesetdef();
}

getplayerreactivesource() {
  return getoperatorreactivesource();
}

playerhasreactivecamo() {
  return getplayerreactivestagesetdef() != "";
}

setupultraoperatorskins(var_0) {
  if(!self _meth_86EE() || !self _meth_8679("ultra_operators")) {
    return;
  }
  var_1 = _func_0222("loot/operator_skin_ids.csv", 0, var_0, 32);

  if(isDefined(var_1) && var_1 != "") {
    if(self _meth_867A("ultra_operators", var_1)) {
      self setscriptablepartstate("ultra_operators", var_1);
    } else if(self _meth_867A("ultra_operators", var_1 + "_0")) {
      self setscriptablepartstate("ultra_operators", var_1 + "_0");
    } else {
      self setscriptablepartstate("ultra_operators", "neutral");
    }
  } else
    self setscriptablepartstate("ultra_operators", "neutral");

  var_2 = _func_0222("loot/operator_skin_ids.csv", 0, var_0, 37);

  if(isDefined(var_2) && var_2 != "") {
    return;
  }
}

_id_0CF0(var_0) {
  if(isDefined(self._id_EAF7) && self._id_EAF7 == var_0) {
    return;
  }
  self _meth_84A4(var_0);
  self._id_EAF7 = var_0;
}

setultraoperatorskinreactivestage(var_0) {
  if(!self _meth_86EE() || !self _meth_8679("ultra_operators")) {
    return;
  }
  var_1 = _id_9818();
  var_2 = _func_0222("loot/operator_skin_ids.csv", 0, var_1, 32);

  if(isDefined(var_2) && var_2 != "") {
    var_3 = var_2 + "_" + var_0;

    if(self _meth_867A("ultra_operators", var_3)) {
      self setscriptablepartstate("ultra_operators", var_3);
    }
  }
}

getoperatorreactivestagesetdef() {
  var_0 = _id_9818();
  return _func_0222("loot/operator_skin_ids.csv", 0, var_0, 38);
}

getoperatorreactivesource() {
  var_0 = _id_9818();
  return _func_0222("loot/operator_skin_ids.csv", 0, var_0, 40);
}

_id_9818() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", 0);
  return self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "skin");
}