/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_wunderbuss.gsc
**********************************************************/

func_00D5() {
  precacherumble("viewmodel_small");
  level.zm_grenade_funcs["alt+wunderbuss_zm"] = ::onboltfired;
  level.var_62B3["wunderbuss_zm"] = ::wunderbussmodifyenergydamage;
  level.modifyweapondamageoninstakill["alt+wunderbuss_zm"] = ::wunderbussmodifyboltdamageoninstakill;
  level.var_2FE9["wunderbuss_zm"] = 1;
  level.var_4D3D["wunderbuss_zm"] = 1;
  level.weaponmaxammofuncs["wunderbuss_zm"] = ::wunderbussmaxammofunc;
  level.zombieprimaryweapon["wunderbuss_zm"] = 1;
  level.wunderbussbolts = [];
  lib_0547::func_7BA9(::onenemykilled);
  lib_054D::func_7BC6(::wunderbuss_kill_info_fallback);
  setdvarifuninitialized("wunderbuss_debug", 0);
  thread maps\mp\_utility::func_6F74(::func_5330);
  thread scaledamage();
  level.var_611["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_berlin/zmb_wunderbuss_blood_blast");
  level.var_611["zmb_ber_bolt_rod_gk_attach"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_rod_gk_attach");
  level.var_611["zmb_ber_bolt_rod_gk_ground"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_rod_gk_ground");
  level.var_611["zmb_wunderbuss_tube_collect"] = loadfx("vfx/zombie/wunderbuss/zmb_wunderbuss_tube_collect");
  level.var_611["zmb_ber_szlr_buildup_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_buildup_1");
  level.var_611["zmb_ber_szlr_geistkraftdrain_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftdrain_1");
}

wunderbuss_kill_info_fallback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(param_00) && isDefined(self) && isDefined(self.var_A4B)) {
    param_00.secondaryzombiecheck = self.var_A4B;
  }
}

func_5330() {
  var_00 = self;
  var_00.wunderbussbolts = [];
  var_00.wunderbussboltpickups = [];
  var_00.wunderbussstuckbolts = [];
  var_00.wunderbusshintshown = 0;
  var_00 thread handlecliponlyhack();
  var_00 thread onwunderbussequip();
}

onwunderbussequip() {
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    if(var_00 == "wunderbuss_zm") {
      if(1) {
        self setweaponammostock("alt+wunderbuss_zm", 1);
      }

      if(!common_scripts\utility::func_562E(self.wunderbusshintshown)) {
        thread showwunderbussinstructions();
        self.wunderbusshintshown = 1;
      }

      continue;
    }
  }
}

cleanupbolt(param_00, param_01) {
  var_02 = param_00.var_117;
  var_02.wunderbussbolts = common_scripts\utility::func_F93(var_02.wunderbussbolts, param_00);
  if(isDefined(param_00.var_6FD8)) {
    param_00.var_6FD8 delete();
  }

  if(isDefined(param_00.var_776C)) {
    thread deleteboltprojectile(param_00, param_01);
  }

  if(isDefined(param_00.droppedbolt)) {
    thread deletedroppedbolt(param_00);
  }
}

onenemykilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = self;
  if(0) {
    if(var_09.var_A4B == "zombie_sizzler") {
      spawnnewsizzlerbolt(var_09, 1);
    }
  }

  if(lib_0547::func_5565(param_04, "wunderbuss_zm")) {}

  if(isDefined(var_09.stuckwunderbussbolts)) {
    foreach(var_0B in var_09.stuckwunderbussbolts) {
      unstickboltfromenemy(var_0B, 1);
    }
  }
}

onboltfired(param_00) {
  var_01 = self;
  var_02 = spawnStruct();
  param_00.boltstruct = var_02;
  var_02.var_776C = param_00;
  var_02.var_117 = var_01;
  var_02.playerindex = lib_0547::func_429D(var_01);
  var_02.var_5F5C = var_01.var_5F5C;
  var_01.wunderbussbolts = common_scripts\utility::func_972(var_01.wunderbussbolts, var_02);
  var_01 thread manageboltstick(param_00);
  var_01 thread manageboltdelete(param_00);
  if(1) {
    var_01 setweaponammostock("alt+wunderbuss_zm", 1);
  }

  return 1;
}

manageboltdelete(param_00) {
  param_00 endon("missile_stuck");
  var_01 = param_00.boltstruct;
  param_00 waittill("death");
}

ensureslotforbolt(param_00) {
  var_01 = self;
  while(var_01.wunderbussboltpickups.size + var_01.wunderbussstuckbolts.size >= 15) {
    if(var_01.wunderbussboltpickups.size > 0) {
      var_02 = var_01.wunderbussboltpickups[0];
      var_01.wunderbussboltpickups = common_scripts\utility::func_F93(var_01.wunderbussboltpickups, var_02);
      cleanupbolt(var_02);
      continue;
    }

    var_03 = var_01.wunderbussstuckbolts[0];
    var_01.wunderbussstuckbolts = common_scripts\utility::func_F93(var_01.wunderbussstuckbolts, var_03);
    cleanupbolt(var_03);
  }
}

addbolttopickuparray(param_00) {
  var_01 = param_00.var_117;
  ensureslotforbolt(param_00);
  var_01.wunderbussboltpickups = common_scripts\utility::func_F6F(var_01.wunderbussboltpickups, param_00);
  param_00.usingslot = 1;
}

addbolttostuckboltarray(param_00) {
  var_01 = param_00.var_117;
  ensureslotforbolt(param_00);
  var_01.wunderbussstuckbolts = common_scripts\utility::func_F6F(var_01.wunderbussstuckbolts, param_00);
  param_00.usingslot = 1;
}

movestuckbolttopickup(param_00) {
  var_01 = param_00.var_117;
  var_01.wunderbussstuckbolts = common_scripts\utility::func_F93(var_01.wunderbussstuckbolts, param_00);
  var_01.wunderbussboltpickups = common_scripts\utility::func_F6F(var_01.wunderbussboltpickups, param_00);
}

manageboltstick(param_00) {
  var_01 = self;
  param_00 endon("death");
  param_00 makeunusable();
  var_02 = undefined;
  param_00 waittill("missile_stuck", var_02);
  if(isDefined(var_02) && function_01EF(var_02) || isPlayer(var_02)) {
    if(function_01EF(var_02)) {
      if(isalive(var_02) && !lib_0547::func_5565(var_02.var_A4B, "zombie_bob")) {
        boltstucktoenemy(param_00, var_02);
        return;
      }

      var_03 = param_00.boltstruct;
      boltammoinstantreward(var_03, var_02, param_00);
      unstickboltfromenemy(param_00, 0);
      return;
    }

    unstickboltfromally(var_01);
    return;
  }

  boltstucktogeo(var_01);
}

boltstucktoenemy(param_00, param_01) {
  var_02 = self;
  var_02 thread boltstucktoenemyrumbles(param_00, param_01);
  param_00 endon("death");
  var_03 = param_00.boltstruct;
  if(!isDefined(param_01.stuckwunderbussbolts)) {
    param_01.stuckwunderbussbolts = [];
  }

  if(!0) {
    boltammoinstantreward(var_03, param_01);
  }

  if(isDefined(param_01.stuckwunderbussbolts[var_03.playerindex])) {
    thread unstickboltfromenemy(param_00);
    return;
  } else {
    param_01.stuckwunderbussbolts[var_03.playerindex] = param_00;
    var_03.stuckto = param_01;
    var_03.stucktoagenttype = param_01.var_A4B;
    level thread boltfx_chargebeam(param_00, param_01, var_02, var_03);
    param_00 thread boltfx_stuck(self);
  }

  param_01 dodamage(level.wunderbussboltstartdamage, var_03.var_776C.var_116, var_03.var_117, var_03.var_776C, "MOD_RIFLE_BULLET", "dot_generic_zm");
  addbolttostuckboltarray(var_03);
  thread boltdot(var_03);
}

boltstucktoenemyrumbles(param_00, param_01) {
  var_02 = self;
  var_03 = param_00.boltstruct;
  while(isDefined(var_02) && isalive(var_02) && isDefined(param_01) && isalive(param_01) && isDefined(param_00) && !common_scripts\utility::func_562E(var_03.targetdrained)) {
    var_02 playrumbleonentity("viewmodel_small");
    wait(0.25);
  }

  var_02 playrumbleonentity("viewmodel_small");
  wait(0.2);
  var_02 playrumbleonentity("viewmodel_small");
}

boltfx_stuck(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01 endon("entitydeleted");
  var_01 endon("projectileCleanup");
  wait 0.05;
  wait 0.05;
  var_01.bolt_effects = spawnlinkedfx(level.var_611["zmb_ber_bolt_rod_gk_attach"], var_01, "Tag_Origin");
  triggerfx(var_01.bolt_effects);
}

boltfx_chargebeam(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    return;
  }

  var_04 = undefined;
  if(isDefined(param_02) && !isDefined(param_02.wunder_beams)) {
    param_02.wunder_beams = [];
  }

  if(param_02.wunder_beams.size < 1) {
    var_05 = param_00 common_scripts\utility::func_8FFC();
    var_05 linkto(param_00, "Tag_FX", (0, 0, 0), (0, 180, 0));
    var_05 thread boltfx_chargebeamupdateangle(param_02);
    var_04 = launchbeam("zmb_wunderbuss_charge_beam", var_05, "tag_origin", param_02, "Tag_Origin");
    var_04 lib_0378::func_8D74("aud_ber_wunderbuss_charge_beam", var_05.var_116, param_02.var_116);
    var_04 method_805C();
    var_04 showtoclient(param_02);
    param_02.wunder_beams = common_scripts\utility::func_F6F(param_02.wunder_beams, var_04);
    wait(0.5);
    var_06 = 0;
    var_07 = 9;
    if(isalive(param_01)) {
      for(;;) {
        if(!isDefined(param_00) || !isDefined(param_03) || common_scripts\utility::func_562E(param_03.targetdrained) || var_06 >= var_07) {
          break;
        } else {
          var_06 = var_06 + 0.5;
          wait(0.5);
        }
      }
    }

    param_02 lib_0378::func_8D74("aud_ber_wunderbuss_charge_beam_end");
    param_02.wunder_beams = common_scripts\utility::func_F93(param_02.wunder_beams, var_04);
    var_04 notify("aud_stop_beam_charge");
    var_04 delete();
    var_05 delete();
  }
}

boltfx_chargebeamupdateangle(param_00) {
  self endon("death");
  for(;;) {
    self.var_1D = vectortoangles(self.var_116 - param_00 getEye());
    wait(0.5);
  }
}

boltfx_ground() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("entitydeleted");
  var_00 endon("droppedBoltCleanup");
  wait 0.05;
  wait 0.05;
  var_00.bolt_effects = spawnlinkedfx(level.var_611["zmb_ber_bolt_rod_gk_ground"], var_00, "Tag_Origin");
  triggerfx(var_00.bolt_effects);
}

unstickboltfromenemy(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = param_00.boltstruct;
  if(common_scripts\utility::func_562E(var_02.var_5F5C) || !0) {
    var_02 notify("bolt_kill");
    if(isDefined(param_00)) {
      playFX(common_scripts\utility::func_44F5("zmb_ber_szlr_geistkraftdrain_1"), param_00.var_116);
    }

    cleanupbolt(var_02);
    return;
  }

  var_03 = spawn("script_model", param_00.var_116);
  var_03.boltstruct = var_02;
  var_02.droppedbolt = var_03;
  var_02.droppedbolt setModel("npc_zom_wonderweapon_bolt");
  var_02.droppedbolt physicslaunchserver();
  var_02.droppedbolt.var_1D = param_00.var_1D;
  var_02.droppedbolt thread boltfx_ground();
  var_02 notify("bolt_drop");
  if(isDefined(var_02.stuckto)) {
    var_02.stuckto.stuckwunderbussbolts[var_02.playerindex] = undefined;
    movestuckbolttopickup(var_02);
  } else {
    addbolttopickuparray(var_02);
  }

  thread createpickuptrigger(var_02, var_02.droppedbolt);
  thread deleteboltprojectile(var_02, param_01);
}

unstickboltfromally(param_00) {
  var_01 = param_00.boltstruct;
  var_01 notify("bolt_kill");
  if(isDefined(param_00)) {
    playFX(common_scripts\utility::func_44F5("zmb_ber_szlr_geistkraftdrain_1"), param_00.var_116);
  }

  cleanupbolt(var_01);
}

deleteboltprojectile(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(common_scripts\utility::func_562E(param_00.projectiledeleting)) {
    return;
  }

  var_02 = param_00.var_776C;
  var_02 notify("projectileCleanup");
  if(isDefined(var_02.bolt_effects)) {
    var_02.bolt_effects delete();
    var_02.bolt_effects = undefined;
  }

  if(param_01) {
    param_00.var_776C endon("death");
    param_00.projectiledeleting = 1;
    param_00.var_776C common_scripts\utility::func_4CEB();
    wait(5);
  }

  param_00.var_776C delete();
}

deletedroppedbolt(param_00) {
  var_01 = param_00.droppedbolt;
  var_01 notify("droppedBoltCleanup");
  if(isDefined(var_01.bolt_effects)) {
    var_01.bolt_effects delete();
    var_01.bolt_effects = undefined;
  }

  param_00.droppedbolt delete();
}

boltstucktogeo(param_00) {
  var_01 = param_00.boltstruct;
  var_01.stucktogeo = 1;
  if(common_scripts\utility::func_562E(var_01.var_5F5C)) {
    cleanupbolt(var_01);
    return;
  }

  if(1) {
    thread delayedcleanupbolt(5, var_01);
    return;
  }

  addbolttopickuparray(var_01);
  thread createpickuptrigger(var_01, param_00);
}

delayedcleanupbolt(param_00, param_01) {
  wait(param_00);
  cleanupbolt(param_01);
}

createpickuptrigger(param_00, param_01, param_02) {
  if(!0) {
    cleanupbolt(param_00, param_02);
    return;
  }

  var_03 = spawn("trigger_radius", param_01.var_116, 0, 64, 64);
  var_03 enablelinkto();
  var_03 linkto(param_01);
  var_03.var_1A5 = "stuck_wunderbuss_bolt";
  param_00.var_6FD8 = var_03;
  if(1) {
    param_01 hudoutlineenableforclient(param_00.var_117, 0, 0);
  }

  for(;;) {
    wait 0.05;
    if(!isDefined(var_03)) {
      return;
    }

    var_03 waittill("trigger", var_04);
    if(!isPlayer(var_04) || !maps\mp\_utility::func_57A0(var_04)) {
      continue;
    }

    if(param_00.var_117 != level && param_00.var_117 != var_04) {
      continue;
    }

    if(!var_04 hasweapon("alt+wunderbuss_zm")) {
      continue;
    }

    if(var_04 method_8655("alt+wunderbuss_zm") == 0) {
      continue;
    }

    if(!1) {
      var_05 = var_04 getweaponammostock("alt+wunderbuss_zm");
      var_04 setweaponammostock("alt+wunderbuss_zm", var_05 + 1);
      var_04 maps\mp\gametypes\_damagefeedback::func_A102("resupply_launcher");
    }

    if(0) {
      if(isDefined(param_00.ammoreward)) {
        var_04 wunderbussaddenergyammo(param_00.ammoreward);
      }
    }

    if(1) {
      param_01 hudoutlinedisableforclient(param_00.var_117);
    }

    cleanupbolt(param_00);
  }
}

spawnnewsizzlerbolt(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_117 = level;
  var_02.droppedbolt = spawn("script_model", param_00.var_116 + (0, 0, 60));
  var_02.droppedbolt setModel("npc_zom_wonderweapon_bolt");
  var_02.droppedbolt physicslaunchserver();
  var_02.droppedbysizzler = 1;
  var_02.ammoreward = 10;
  while(level.wunderbussbolts.size > 5) {
    var_03 = level.wunderbussbolts[0];
    cleanupbolt(var_03, param_01);
  }

  if(0) {
    thread createpickuptrigger(var_02, var_02.droppedbolt, param_01);
  }
}

handlecliponlyhack() {
  var_00 = self;
  for(;;) {
    var_00 common_scripts\utility::knock_off_battery("weapon_given", "heavyMeleeClip_earned");
    wait 0.05;
    if(var_00 hasweapon("wunderbuss_zm")) {
      wunderbussaddenergyammo(0);
    }
  }
}

scaledamage() {
  while(!isDefined(level.var_A50) || !isDefined(level.var_A50["zombie_generic"])) {
    wait 0.05;
  }

  var_00 = 1;
  var_01 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), 16);
  level.wunderbussboltstartdamage = int(ceil(var_01 / pow(2, 5)));
  for(;;) {
    var_02 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), var_00);
    level.wunderbussenergydamage = var_02 * 0.15;
    level waittill("waveupdate");
    var_00 = level.var_A980;
  }
}

boltdot(param_00) {
  param_00 endon("bolt_drop");
  param_00 endon("bolt_kill");
  param_00.var_776C endon("death");
  var_01 = level.wunderbussboltstartdamage;
  for(var_02 = 0; var_02 < 5; var_02++) {
    wait(1.5);
    var_03 = var_01;
    if(param_00.stuckto.var_A4B == "zombie_heavy") {
      var_03 = var_03 * 5;
    }

    param_00.var_117 wunderbussaddenergyammo(1);
    wunderbuss_challenges_report_zombie_hit_by_bolt(param_00.var_117, param_00.stucktoagenttype);
    param_00.stuckto dodamage(var_03, param_00.var_776C.var_116, param_00.var_117, param_00.var_776C, "MOD_RIFLE_BULLET", "dot_generic_zm");
    var_01 = var_01 * 2;
  }

  thread unstickboltfromenemy(param_00.var_776C);
}

boltammoinstantreward(param_00, param_01, param_02) {
  param_00.bolt_juice_collected = 0;
  var_03 = 5;
  if(lib_0547::func_5565(param_01.var_A4B, "zombie_heavy")) {
    var_03 = 1;
  }

  if(lib_0547::func_5565(param_01.var_A4B, "zombie_bob")) {
    var_03 = 1;
  }

  wunderbuss_challenges_report_zombie_hit_by_bolt(param_00.var_117, param_01.var_A4B, param_02);
  param_00.var_117 wunderbussaddenergyammo(var_03);
  param_00.bolt_juice_collected = param_00.bolt_juice_collected + var_03;
}

wunderbussmodifyenergydamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_04 == "alt+wunderbuss_zm") {
    return 0;
  }

  return level.wunderbussenergydamage;
}

wunderbussmodifyboltdamageoninstakill(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return 0;
}

wunderbuss_challenges_report_zombie_hit_by_bolt(param_00, param_01, param_02) {
  if(isDefined(level.add_zombie_type_to_geistkraft_challenge)) {
    level thread[[level.add_zombie_type_to_geistkraft_challenge]](param_00, param_01, param_02);
  }
}

wunderbussmaxammofunc(param_00) {
  var_01 = self;
  var_01 wunderbussaddenergyammo(undefined);
  return 1;
}

wunderbussaddenergyammo(param_00) {
  var_01 = self;
  var_02 = weaponclipsize("wunderbuss_zm", var_01);
  if(!isDefined(param_00)) {
    param_00 = var_02;
  }

  var_03 = var_01 getweaponammoclip("wunderbuss_zm");
  var_04 = var_01 getweaponammostock("wunderbuss_zm");
  wunderbusssetenergyammo(var_03 + var_04 + param_00);
}

wunderbusssetenergyammo(param_00) {
  var_01 = self;
  var_02 = weaponclipsize("wunderbuss_zm", var_01);
  param_00 = int(min(param_00, var_02));
  var_01 method_82FA("wunderbuss_zm", param_00, "right");
  var_01 setweaponammostock("wunderbuss_zm", 0);
}

showwunderbussinstructions() {
  lib_0555::func_83DD("dlc2_weap_hint", self);
}