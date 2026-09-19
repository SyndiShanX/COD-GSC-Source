/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_wunderbuss.gsc
******************************************************************/

init() {
  _precacherumble("viewmodel_small");
  level.zm_grenade_funcs["alt+wunderbuss_zm"] = ::onboltfired;
  level._id_62B3["wunderbuss_zm"] = ::wunderbussmodifyenergydamage;
  level.modifyweapondamageoninstakill["alt+wunderbuss_zm"] = ::wunderbussmodifyboltdamageoninstakill;
  level._id_2FE9["wunderbuss_zm"] = 1;
  level._id_4D3D["wunderbuss_zm"] = 1;
  level.weaponmaxammofuncs["wunderbuss_zm"] = ::wunderbussmaxammofunc;
  level.zombieprimaryweapon["wunderbuss_zm"] = 1;
  level.wunderbussbolts = [];
  _id_0547::_id_7BA9(::onenemykilled);
  _id_054D::_id_7BC6(::wunderbuss_kill_info_fallback);
  setdvarifuninitialized("wunderbuss_debug", 0);
  thread maps\mp\_utility::_id_6F74(::_id_5330);
  thread scaledamage();
  level._effect["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_berlin/zmb_wunderbuss_blood_blast");
  level._effect["zmb_ber_bolt_rod_gk_attach"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_rod_gk_attach");
  level._effect["zmb_ber_bolt_rod_gk_ground"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_rod_gk_ground");
  level._effect["zmb_wunderbuss_tube_collect"] = loadfx("vfx/zombie/wunderbuss/zmb_wunderbuss_tube_collect");
  level._effect["zmb_ber_szlr_buildup_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_buildup_1");
  level._effect["zmb_ber_szlr_geistkraftdrain_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftdrain_1");
}

wunderbuss_kill_info_fallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_0) && isDefined(self) && isDefined(self._id_0A4B))
    var_0.secondaryzombiecheck = self._id_0A4B;
}

_id_5330() {
  var_0 = self;
  var_0.wunderbussbolts = [];
  var_0.wunderbussboltpickups = [];
  var_0.wunderbussstuckbolts = [];
  var_0.wunderbusshintshown = 0;
  var_0 thread handlecliponlyhack();
  var_0 thread onwunderbussequip();
}

onwunderbussequip() {
  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(var_0 == "wunderbuss_zm") {
      if(1)
        self setweaponammostock("alt+wunderbuss_zm", 1);

      if(!common_scripts\utility::_id_562E(self.wunderbusshintshown)) {
        thread showwunderbussinstructions();
        self.wunderbusshintshown = 1;
      }

      continue;
    }
  }
}

cleanupbolt(var_0, var_1) {
  var_2 = var_0._id_0117;
  var_2.wunderbussbolts = common_scripts\utility::_id_0F93(var_2.wunderbussbolts, var_0);

  if(isDefined(var_0._id_6FD8))
    var_0._id_6FD8 delete();

  if(isDefined(var_0._id_776C))
    thread deleteboltprojectile(var_0, var_1);

  if(isDefined(var_0.droppedbolt))
    thread deletedroppedbolt(var_0);
}

onenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;

  if(0) {
    if(var_9._id_0A4B == "zombie_sizzler")
      spawnnewsizzlerbolt(var_9, 1);
  }

  if(_id_0547::_id_5565(var_4, "wunderbuss_zm")) {}

  if(isDefined(var_9.stuckwunderbussbolts)) {
    foreach(var_11 in var_9.stuckwunderbussbolts)
    unstickboltfromenemy(var_11, 1);
  }
}

onboltfired(var_0) {
  var_1 = self;
  var_2 = spawnStruct();
  var_0.boltstruct = var_2;
  var_2._id_776C = var_0;
  var_2._id_0117 = var_1;
  var_2.playerindex = _id_0547::_id_429D(var_1);
  var_2._id_5F5C = var_1._id_5F5C;
  var_1.wunderbussbolts = common_scripts\utility::_id_0972(var_1.wunderbussbolts, var_2);
  var_1 thread manageboltstick(var_0);
  var_1 thread manageboltdelete(var_0);

  if(1)
    var_1 setweaponammostock("alt+wunderbuss_zm", 1);

  return 1;
}

manageboltdelete(var_0) {
  var_0 endon("missile_stuck");
  var_1 = var_0.boltstruct;
  var_0 waittill("death");
}

ensureslotforbolt(var_0) {
  var_1 = self;

  while(var_1.wunderbussboltpickups.size + var_1.wunderbussstuckbolts.size >= 15) {
    if(var_1.wunderbussboltpickups.size > 0) {
      var_2 = var_1.wunderbussboltpickups[0];
      var_1.wunderbussboltpickups = common_scripts\utility::_id_0F93(var_1.wunderbussboltpickups, var_2);
      cleanupbolt(var_2);
      continue;
    }

    var_3 = var_1.wunderbussstuckbolts[0];
    var_1.wunderbussstuckbolts = common_scripts\utility::_id_0F93(var_1.wunderbussstuckbolts, var_3);
    cleanupbolt(var_3);
  }
}

addbolttopickuparray(var_0) {
  var_1 = var_0._id_0117;
  ensureslotforbolt(var_0);
  var_1.wunderbussboltpickups = common_scripts\utility::_id_0F6F(var_1.wunderbussboltpickups, var_0);
  var_0.usingslot = 1;
}

addbolttostuckboltarray(var_0) {
  var_1 = var_0._id_0117;
  ensureslotforbolt(var_0);
  var_1.wunderbussstuckbolts = common_scripts\utility::_id_0F6F(var_1.wunderbussstuckbolts, var_0);
  var_0.usingslot = 1;
}

movestuckbolttopickup(var_0) {
  var_1 = var_0._id_0117;
  var_1.wunderbussstuckbolts = common_scripts\utility::_id_0F93(var_1.wunderbussstuckbolts, var_0);
  var_1.wunderbussboltpickups = common_scripts\utility::_id_0F6F(var_1.wunderbussboltpickups, var_0);
}

manageboltstick(var_0) {
  var_1 = self;
  var_0 endon("death");
  var_0 makeunusable();
  var_2 = undefined;
  var_0 waittill("missile_stuck", var_2);

  if(isDefined(var_2) && (_isagent(var_2) || isPlayer(var_2))) {
    if(_isagent(var_2)) {
      if(isalive(var_2) && !_id_0547::_id_5565(var_2._id_0A4B, "zombie_bob"))
        boltstucktoenemy(var_0, var_2);
      else {
        var_3 = var_0.boltstruct;
        boltammoinstantreward(var_3, var_2, var_0);
        unstickboltfromenemy(var_0, 0);
      }
    } else
      unstickboltfromally(var_0);
  } else
    boltstucktogeo(var_0);
}

boltstucktoenemy(var_0, var_1) {
  var_2 = self;
  var_2 thread boltstucktoenemyrumbles(var_0, var_1);
  var_0 endon("death");
  var_3 = var_0.boltstruct;

  if(!isDefined(var_1.stuckwunderbussbolts))
    var_1.stuckwunderbussbolts = [];

  if(!0)
    boltammoinstantreward(var_3, var_1);

  if(isDefined(var_1.stuckwunderbussbolts[var_3.playerindex])) {
    thread unstickboltfromenemy(var_0);
    return;
  } else {
    var_1.stuckwunderbussbolts[var_3.playerindex] = var_0;
    var_3.stuckto = var_1;
    var_3.stucktoagenttype = var_1._id_0A4B;
    level thread boltfx_chargebeam(var_0, var_1, var_2, var_3);
    var_0 thread boltfx_stuck(self);
  }

  var_1 dodamage(level.wunderbussboltstartdamage, var_3._id_776C.origin, var_3._id_0117, var_3._id_776C, "MOD_RIFLE_BULLET", "dot_generic_zm");
  addbolttostuckboltarray(var_3);
  thread boltdot(var_3);
}

boltstucktoenemyrumbles(var_0, var_1) {
  var_2 = self;
  var_3 = var_0.boltstruct;

  while(isDefined(var_2) && isalive(var_2) && isDefined(var_1) && isalive(var_1) && isDefined(var_0) && !common_scripts\utility::_id_562E(var_3.targetdrained)) {
    var_2 playrumbleonentity("viewmodel_small");
    wait 0.25;
  }

  var_2 playrumbleonentity("viewmodel_small");
  wait 0.2;
  var_2 playrumbleonentity("viewmodel_small");
}

boltfx_stuck(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("projectileCleanup");
  waitframe();
  waitframe();
  var_1.bolt_effects = _spawnlinkedfx(level._effect["zmb_ber_bolt_rod_gk_attach"], var_1, "Tag_Origin");
  _triggerfx(var_1.bolt_effects);
}

boltfx_chargebeam(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    return;
  }
  var_4 = undefined;

  if(isDefined(var_2) && !isDefined(var_2.wunder_beams))
    var_2.wunder_beams = [];

  if(var_2.wunder_beams.size < 1) {
    var_5 = var_0 common_scripts\utility::_id_8FFC();
    var_5 linkto(var_0, "Tag_FX", (0, 0, 0), (0, 180, 0));
    var_5 thread boltfx_chargebeamupdateangle(var_2);
    var_4 = _func_382("zmb_wunderbuss_charge_beam", var_5, "tag_origin", var_2, "Tag_Origin");
    var_4 _id_0378::_id_8D74("aud_ber_wunderbuss_charge_beam", var_5.origin, var_2.origin);
    var_4 hide();
    var_4 showtoplayer(var_2);
    var_2.wunder_beams = common_scripts\utility::_id_0F6F(var_2.wunder_beams, var_4);
    wait 0.5;
    var_6 = 0;
    var_7 = 9.0;

    if(isalive(var_1)) {
      for(;;) {
        if(!isDefined(var_0) || !isDefined(var_3) || common_scripts\utility::_id_562E(var_3.targetdrained) || var_6 >= var_7) {
          break;
        } else {
          var_6 = var_6 + 0.5;
          wait 0.5;
        }
      }
    }

    var_2 _id_0378::_id_8D74("aud_ber_wunderbuss_charge_beam_end");
    var_2.wunder_beams = common_scripts\utility::_id_0F93(var_2.wunder_beams, var_4);
    var_4 notify("aud_stop_beam_charge");
    var_4 delete();
    var_5 delete();
  }
}

boltfx_chargebeamupdateangle(var_0) {
  self endon("death");

  for(;;) {
    self.angles = vectortoangles(self.origin - var_0 getEye());
    wait 0.5;
  }
}

boltfx_ground() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("droppedBoltCleanup");
  waitframe();
  waitframe();
  var_0.bolt_effects = _spawnlinkedfx(level._effect["zmb_ber_bolt_rod_gk_ground"], var_0, "Tag_Origin");
  _triggerfx(var_0.bolt_effects);
}

unstickboltfromenemy(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = var_0.boltstruct;

  if(common_scripts\utility::_id_562E(var_2._id_5F5C) || !0) {
    var_2 notify("bolt_kill");

    if(isDefined(var_0))
      playFX(common_scripts\utility::_id_44F5("zmb_ber_szlr_geistkraftdrain_1"), var_0.origin);

    cleanupbolt(var_2);
    return;
  }

  var_3 = spawn("script_model", var_0.origin);
  var_3.boltstruct = var_2;
  var_2.droppedbolt = var_3;
  var_2.droppedbolt setModel("npc_zom_wonderweapon_bolt");
  var_2.droppedbolt physicslaunchserver();
  var_2.droppedbolt.angles = var_0.angles;
  var_2.droppedbolt thread boltfx_ground();
  var_2 notify("bolt_drop");

  if(isDefined(var_2.stuckto)) {
    var_2.stuckto.stuckwunderbussbolts[var_2.playerindex] = undefined;
    movestuckbolttopickup(var_2);
  } else
    addbolttopickuparray(var_2);

  thread createpickuptrigger(var_2, var_2.droppedbolt);
  thread deleteboltprojectile(var_2, var_1);
}

unstickboltfromally(var_0) {
  var_1 = var_0.boltstruct;
  var_1 notify("bolt_kill");

  if(isDefined(var_0))
    playFX(common_scripts\utility::_id_44F5("zmb_ber_szlr_geistkraftdrain_1"), var_0.origin);

  cleanupbolt(var_1);
}

deleteboltprojectile(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(common_scripts\utility::_id_562E(var_0.projectiledeleting)) {
    return;
  }
  var_2 = var_0._id_776C;
  var_2 notify("projectileCleanup");

  if(isDefined(var_2.bolt_effects)) {
    var_2.bolt_effects delete();
    var_2.bolt_effects = undefined;
  }

  if(var_1) {
    var_0._id_776C endon("death");
    var_0.projectiledeleting = 1;
    var_0._id_776C common_scripts\utility::_id_4CEB();
    wait 5;
  }

  var_0._id_776C delete();
}

deletedroppedbolt(var_0) {
  var_1 = var_0.droppedbolt;
  var_1 notify("droppedBoltCleanup");

  if(isDefined(var_1.bolt_effects)) {
    var_1.bolt_effects delete();
    var_1.bolt_effects = undefined;
  }

  var_0.droppedbolt delete();
}

boltstucktogeo(var_0) {
  var_1 = var_0.boltstruct;
  var_1.stucktogeo = 1;

  if(common_scripts\utility::_id_562E(var_1._id_5F5C))
    cleanupbolt(var_1);
  else {
    if(1) {
      thread delayedcleanupbolt(5, var_1);
      return;
    }

    addbolttopickuparray(var_1);
    thread createpickuptrigger(var_1, var_0);
  }
}

delayedcleanupbolt(var_0, var_1) {
  wait(var_0);
  cleanupbolt(var_1);
}

createpickuptrigger(var_0, var_1, var_2) {
  if(!0) {
    cleanupbolt(var_0, var_2);
    return;
  }

  var_3 = spawn("trigger_radius", var_1.origin, 0, 64, 64);
  var_3 enablelinkto();
  var_3 linkto(var_1);
  var_3.targetname = "stuck_wunderbuss_bolt";
  var_0._id_6FD8 = var_3;

  if(1)
    var_1 hudoutlineenableforclient(var_0._id_0117, 0, 0);

  for(;;) {
    waitframe();

    if(!isDefined(var_3)) {
      return;
    }
    var_3 waittill("trigger", var_4);

    if(!isPlayer(var_4) || !maps\mp\_utility::isreallyalive(var_4)) {
      continue;
    }
    if(var_0._id_0117 != level && var_0._id_0117 != var_4) {
      continue;
    }
    if(!var_4 hasweapon("alt+wunderbuss_zm")) {
      continue;
    }
    if(var_4 _meth_8655("alt+wunderbuss_zm") == 0) {
      continue;
    }
    if(!1) {
      var_5 = var_4 getweaponammostock("alt+wunderbuss_zm");
      var_4 setweaponammostock("alt+wunderbuss_zm", var_5 + 1);
      var_4 _id_04C7::_id_A102("resupply_launcher");
    }

    if(0) {
      if(isDefined(var_0.ammoreward))
        var_4 wunderbussaddenergyammo(var_0.ammoreward);
    }

    if(1)
      var_1 hudoutlinedisableforclient(var_0._id_0117);

    cleanupbolt(var_0);
    return;
  }
}

spawnnewsizzlerbolt(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_0117 = level;
  var_2.droppedbolt = spawn("script_model", var_0.origin + (0, 0, 60));
  var_2.droppedbolt setModel("npc_zom_wonderweapon_bolt");
  var_2.droppedbolt physicslaunchserver();
  var_2.droppedbysizzler = 1;
  var_2.ammoreward = 10;

  while(level.wunderbussbolts.size > 5) {
    var_3 = level.wunderbussbolts[0];
    cleanupbolt(var_3, var_1);
  }

  if(0)
    thread createpickuptrigger(var_2, var_2.droppedbolt, var_1);
}

handlecliponlyhack() {
  var_0 = self;

  for(;;) {
    var_0 common_scripts\utility::_id_A70A("weapon_given", "heavyMeleeClip_earned");
    waitframe();

    if(var_0 hasweapon("wunderbuss_zm"))
      wunderbussaddenergyammo(0);
  }
}

scaledamage() {
  while(!isDefined(level._id_0A50) || !isDefined(level._id_0A50["zombie_generic"]))
    waitframe();

  var_0 = 1;
  var_1 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 16);
  level.wunderbussboltstartdamage = int(_ceil(var_1 / _pow(2, 5)));

  for(;;) {
    var_2 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), var_0);
    level.wunderbussenergydamage = var_2 * 0.15;
    level waittill("waveupdate");
    var_0 = level._id_A980;
  }
}

boltdot(var_0) {
  var_0 endon("bolt_drop");
  var_0 endon("bolt_kill");
  var_0._id_776C endon("death");
  var_1 = level.wunderbussboltstartdamage;

  for(var_2 = 0; var_2 < 5; var_2++) {
    wait 1.5;
    var_3 = var_1;

    if(var_0.stuckto._id_0A4B == "zombie_heavy")
      var_3 = var_3 * 5;

    var_0._id_0117 wunderbussaddenergyammo(1);
    wunderbuss_challenges_report_zombie_hit_by_bolt(var_0._id_0117, var_0.stucktoagenttype);
    var_0.stuckto dodamage(var_3, var_0._id_776C.origin, var_0._id_0117, var_0._id_776C, "MOD_RIFLE_BULLET", "dot_generic_zm");
    var_1 = var_1 * 2;
  }

  thread unstickboltfromenemy(var_0._id_776C);
}

boltammoinstantreward(var_0, var_1, var_2) {
  var_0.bolt_juice_collected = 0;
  var_3 = 5;

  if(_id_0547::_id_5565(var_1._id_0A4B, "zombie_heavy"))
    var_3 = 1;

  if(_id_0547::_id_5565(var_1._id_0A4B, "zombie_bob"))
    var_3 = 1;

  wunderbuss_challenges_report_zombie_hit_by_bolt(var_0._id_0117, var_1._id_0A4B, var_2);
  var_0._id_0117 wunderbussaddenergyammo(var_3);
  var_0.bolt_juice_collected = var_0.bolt_juice_collected + var_3;
}

wunderbussmodifyenergydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_4 == "alt+wunderbuss_zm")
    return 0;

  return level.wunderbussenergydamage;
}

wunderbussmodifyboltdamageoninstakill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return 0;
}

wunderbuss_challenges_report_zombie_hit_by_bolt(var_0, var_1, var_2) {
  if(isDefined(level.add_zombie_type_to_geistkraft_challenge))
    level thread[[level.add_zombie_type_to_geistkraft_challenge]](var_0, var_1, var_2);
}

wunderbussmaxammofunc(var_0) {
  var_1 = self;
  var_1 wunderbussaddenergyammo(undefined);
  return 1;
}

wunderbussaddenergyammo(var_0) {
  var_1 = self;
  var_2 = _weaponclipsize("wunderbuss_zm", var_1);

  if(!isDefined(var_0))
    var_0 = var_2;

  var_3 = var_1 getweaponammoclip("wunderbuss_zm");
  var_4 = var_1 getweaponammostock("wunderbuss_zm");
  wunderbusssetenergyammo(var_3 + var_4 + var_0);
}

wunderbusssetenergyammo(var_0) {
  var_1 = self;
  var_2 = _weaponclipsize("wunderbuss_zm", var_1);
  var_0 = int(_min(var_0, var_2));
  var_1 setweaponammoclip("wunderbuss_zm", var_0, "right");
  var_1 setweaponammostock("wunderbuss_zm", 0);
}

showwunderbussinstructions() {
  _id_0555::issprinting("dlc2_weap_hint", self);
}