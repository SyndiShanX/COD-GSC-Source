/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3629.gsc
************************/

func_112B5() {
  precachemodel("veh_mil_air_un_pocketdrone");
  precachemodel("veh_mil_air_un_pocketdrone_dyn");
  precachemodel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
  precachemodel("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
  precachemodel("veh_mil_air_un_pocketdrone_timeout_crash_body_4fan");
  precacheitem("supportdrone_trophy_turret");
  precacheitem("supportdrone");
  precacheitem("supportdrone_up2");
  precacheshader("hud_icon_wireless");
  precacheshader("overlay_static");
  precacheshader("icon_ability_drone");
  precacheshader("cb_remotemissile_target_hostile");
  setdvarifuninitialized("support_drone_debug", 0);
  setdvarifuninitialized("scan_ability", 1);
  level._effect["drone_thruster"] = loadfx("vfx\iw7\core\equipment\drone\vfx_drone_down_thrust_child.vfx");
  level._effect["drone_damaged_loop"] = loadfx("vfx\iw7\core\equipment\drone\vfx_drone_damage_malfunction_loop.vfx");
  level._effect["drone_trophy_laser"] = loadfx("vfx\iw7\core\equipment\drone\vfx_drone_muzzle_flash_trophy_r.vfx");
  level._effect["drone_trophy_pop"] = loadfx("vfx\iw7\core\equipment\drone\vfx_drone_trophy_pop.vfx");
  level._effect["drone_shotdown_air_damage"] = loadfx("vfx\iw7\core\equipment\drone\vfx_drone_death_shotdown.vfx");
  level._effect["drone_death_hit_ground"] = loadfx("vfx\iw7\core\equipment\drone\vfx_drone_death.vfx");
  level.player scripts\sp\utility::func_65E0("player_support_drone_active");
  level.player scripts\sp\utility::func_65E0("support_drone_spawning");
  level.var_5C19 = [91, 83, 108, 72];
  level.var_5C18 = 0;
  level.player.var_5CA6 = [];
  level.player.var_5C6E = 0;
  level.player.var_5C4F = 0;
  level.player.var_4C29 = [];
  level.player thread func_5BE1();
  scripts\sp\utility::func_9189("default_supdrone", 2, "default");
}

func_5138() {
  scripts\sp\utility::func_228A(level.player.var_5CA6);
  level.player.var_5CA6 = scripts\engine\utility::array_removeundefined(level.player.var_5CA6);
}

func_5C9E() {
  self endon("death");
  self endon("support_drone_think");
  var_00 = func_129A();
  for(;;) {
    self waittill("secondary_equipment_change");
    waittillframeend;
    if(!isDefined(scripts\sp\utility::func_7C3D()) || scripts\sp\utility::func_7C3D() != var_00) {
      break;
    }
  }

  scripts\engine\utility::flag_clear("secondary_equipment_in_use");
  self notify("drone_unequipped");
}

func_112BB() {
  self endon("death");
  self endon("drone_unequipped");
  self notify("support_drone_think");
  self endon("support_drone_think");
  thread func_5C9E();
  var_00 = func_112B8();
  for(;;) {
    level.var_112B9 = 0;
    for(;;) {
      self waittill("grenade_fire", var_01, var_02);
      if(var_02 == "supportdrone" || var_02 == "supportdrone_up2") {
        break;
      }
    }

    if(!func_385A()) {
      wait(0.05);
      continue;
    }

    level.player scripts\sp\utility::func_65E8("support_drone_spawning");
    level.player scripts\sp\utility::func_65E1("support_drone_spawning");
    scripts\engine\utility::flag_set("secondary_equipment_in_use");
    level.player scripts\engine\utility::allow_usability(0);
    level.player scripts\sp\utility::func_65E1("player_support_drone_active");
    if(!getdvarint("player_sustainAmmo", 0)) {
      var_03 = self getrunningforwardpainanim(func_129A());
      self setweaponammoclip(func_129A(), var_03 - 1);
    }

    self notify("offhand_fired");
    var_04 = func_112BA(var_00);
    var_04.var_D384 = func_7B15();
    var_04.var_9180 = var_04.var_D384;
    self.var_4C29[var_04.var_D384] = spawnStruct();
    self.var_4C29[var_04.var_D384].var_5BD7 = var_04;
    self.var_4C29[var_04.var_D384].var_51BA = 0;
    self.var_4C29[var_04.var_D384].var_9A96 = 1;
    self.var_4C29[var_04.var_D384].var_C7B4 = 0;
    func_F377(var_04.var_9180, "active");
    func_5C32(var_04.var_9180, var_04.ammocount);
    level.player scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::flag_clear("secondary_equipment_in_use");
    level.player thread scripts\sp\utility::func_65DE("support_drone_spawning", 0.05);
  }
}

func_5BE1() {
  self endon("death");
  for(;;) {
    var_00 = 0;
    for(var_01 = 0; var_01 < 5; var_01++) {
      if(isDefined(self.var_4C29[var_01]) && self.var_4C29[var_01].var_51BA == 1) {
        self.var_4C29[var_01] = undefined;
        level notify("drone_max_cleanup");
        var_00 = 1;
      }
    }

    if(var_00) {
      var_02 = 0;
      for(var_01 = 0; var_01 < 5; var_01++) {
        if(isDefined(self.var_4C29[var_01]) && isDefined(self.var_4C29[var_01].var_5BD7)) {
          self.var_4C29[var_01].var_5BD7.var_D384 = var_02;
          var_02++;
        }
      }
    }

    if(level.player.var_5C6E > 0) {
      level.player.var_5C6E = level.player.var_5C6E - 0.05;
    }

    if(level.player.var_5C4F > 0) {
      level.player.var_5C4F = level.player.var_5C4F - 0.05;
    }

    wait(0.05);
  }
}

func_7AC7() {
  if(isDefined(self.var_5CB3)) {
    return 5;
  }

  return 3;
}

func_7B32() {
  var_00 = 0;
  for(var_01 = 0; var_01 < func_7AC7(); var_01++) {
    if(isDefined(self.var_4C29[var_01])) {
      var_00++;
    }
  }

  return var_00;
}

func_7B15() {
  for(var_00 = 0; var_00 < func_7AC7(); var_00++) {
    if(!isDefined(self.var_4C29[var_00])) {
      return var_00;
    }
  }

  return undefined;
}

func_385A() {
  if(!self _meth_843C() || self getteamsize() || !scripts\engine\utility::isoffhandweaponsallowed() || !scripts\engine\utility::isoffhandsecondaryweaponsallowed()) {
    return 0;
  }

  var_00 = self getrunningforwardpainanim(func_129A());
  if(var_00 <= 0) {
    return 0;
  }

  if(func_7B32() >= func_7AC7() - 1) {
    thread func_C808();
    while(func_7B32() > func_7AC7() - 1) {
      wait(0.05);
    }

    return 1;
  }

  return 1;
}

func_C808() {
  if(!isDefined(level.player.var_4C29)) {
    return;
  }

  for(;;) {
    var_00 = undefined;
    var_01 = undefined;
    for(var_02 = 0; var_02 < 5; var_02++) {
      if(!isDefined(level.player.var_4C29[var_02])) {
        continue;
      }

      if(isDefined(level.player.var_4C29[var_02].var_E0EC) && level.player.var_4C29[var_02].var_E0EC) {
        continue;
      }

      if(isDefined(level.player.var_4C29[var_02].var_9A96) && level.player.var_4C29[var_02].var_9A96) {
        continue;
      }

      if(!isDefined(var_00) || level.player.var_4C29[var_02].var_5BD7.ammocount < var_00) {
        var_00 = level.player.var_4C29[var_02].var_5BD7.ammocount;
        var_01 = var_02;
      }
    }

    if(isDefined(var_01)) {
      level.player.var_4C29[var_01].var_5BD7 notify("timeout");
      level.player.var_4C29[var_01].var_E0EC = 1;
      break;
    }

    wait(0.1);
  }
}

func_112BA(param_00) {
  var_01 = getEntArray("support_drone_spawner", "targetname");
  var_02 = var_01[0];
  level.player thread scripts\sp\utility::play_sound_on_entity("support_drone_activate");
  self notify("drone_spawned");
  var_03 = level.player getplayerangles();
  var_04 = scripts\engine\utility::flat_angle(var_03);
  var_05 = level.player getEye();
  var_06 = anglestoup(var_03);
  var_07 = anglestoup(var_04);
  var_08 = anglesToForward(var_04);
  var_09 = 24;
  var_0A = 24;
  var_0B = var_05;
  var_0C = scripts\common\trace::ray_trace(var_05, var_05 + var_06 * var_0A + var_09, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_0C["fraction"] != 1) {
    var_0C = scripts\common\trace::ray_trace(var_05, var_05 + var_07 * var_0A + var_09, undefined, scripts\common\trace::create_solid_ai_contents(1));
    if(var_0C["fraction"] != 1) {
      var_0B = var_05 + var_07 * var_0A * var_0C["fraction"];
    } else {
      var_0B = var_05 + var_07 * var_0A;
    }
  } else {
    var_0B = var_05 + var_06 * var_0A;
  }

  var_02.origin = var_0B;
  var_02.angles = var_04;
  var_0D = var_02 scripts\sp\utility::func_10808();
  var_0D glinton(#animtree);
  var_0D makeentitysentient("allies");
  var_0D getvalidpointtopointmovelocation(1);
  var_0D give_zombies_perk("equipment");
  var_0D setCanDamage(1);
  var_0D scripts\sp\vehicle::playgestureviewmodel();
  var_0D _meth_839E();
  var_0D.var_6DA5 = 0;
  var_0D.var_C181 = 0;
  level.player.var_112AB = var_0D;
  var_0D.var_50 = 0.5;
  var_0D.var_B00E = spawn("script_origin", (0, 0, 0));
  var_0D setlookatent(var_0D.var_B00E);
  var_0D.var_D630 = undefined;
  scripts\engine\utility::array_thread(param_00, ::func_112B7, var_0D);
  var_0D notify("stop_kicking_up_dust");
  var_0D.var_2654 = 0;
  var_0D.ammocount = 20;
  var_0D makeunusable();
  var_0D thread func_5C1F();
  var_0D thread func_5C4B(1, 1);
  if(!isDefined(var_0D.var_B435)) {
    var_0D.var_B435 = 100;
  }

  var_0D.var_1280E = 0;
  var_0D thread func_112BC();
  var_0D thread func_5C30();
  var_0D thread func_5C55();
  var_0D thread func_5C59();
  var_0D thread func_5C5C();
  var_0D thread func_5C3F();
  var_0D thread func_5BED();
  var_0D thread func_5C37();
  var_0D thread func_5BF0();
  var_0D setanimknob( % equip_pocket_drone_hover_loop);
  return var_0D;
}

func_11719(param_00) {
  param_00 endon("death");
  iprintlnbold("Dpad Up: hover");
  iprintlnbold("Dpad Left: damaged");
  iprintlnbold("Dpad Right: death");
  level.player notifyonplayercommand("dpadup", "+actionslot 1");
  level.player notifyonplayercommand("dpaddown", "+actionslot 2");
  level.player notifyonplayercommand("dpadleft", "+actionslot 3");
  for(;;) {
    var_01 = level.player scripts\engine\utility::waittill_any_return("dpadup", "dpaddown", "dpadleft");
    if(var_01 == "dpadup") {
      iprintlnbold("hover");
      param_00 setanimknob( % equip_pocket_drone_hover_loop);
    } else if(var_01 == "dpadleft") {
      iprintlnbold("damaged");
      param_00 setanimknob( % equip_pocket_drone_damaged_loop);
    } else if(var_01 == "dpaddown") {
      iprintlnbold("death");
      param_00 setanimknob( % equip_pocket_drone_death_loop);
    }

    wait(0.25);
  }
}

func_5C30() {
  if(isDefined(self.var_C93D)) {
    return;
  }

  if(self.team == "allies") {
    scripts\sp\utility::func_9196(3, 0, 0, "default_supdrone");
    self.var_5CDB scripts\sp\utility::func_9196(3, 0, 0, "default_supdrone");
    return;
  }

  if(self.team == "axis") {
    scripts\sp\utility::func_9196(1, 0, 0, "default_supdrone");
    self.var_5CDB scripts\sp\utility::func_9196(1, 0, 0, "default_supdrone");
  }
}

func_112BC() {
  foreach(var_01 in self.mgturret) {
    var_01 setturretteam("allies");
    var_01.var_5041 = "manual";
    var_01 give_player_session_tokens("manual");
    var_01 turretfireenable();
    var_01 setleftarc(90);
    var_01 setrightarc(90);
    var_01 settoparc(90);
    var_01 give_crafted_gascan(90);
    var_01 _meth_82C9(0, "yaw");
    var_01 _meth_82C9(0, "pitch");
  }

  self.var_5CDB = self.mgturret[0];
  self.mgturret[0] show();
  self.var_5CAF = ::func_5C0F;
}

func_5C37() {
  self endon("death_anim");
  self endon("death");
  var_00 = 0;
  for(;;) {
    if(func_D2DD()) {
      var_00 = 1;
    } else if(level.player.ignoreme) {
      var_00 = 1;
    } else {
      var_00 = 0;
    }

    self.ignoreme = var_00;
    wait(0.1);
  }
}

func_5C4B(param_00, param_01) {
  if(isDefined(param_00) && param_00) {
    thread func_5BD8();
  }

  if(isDefined(param_01) && param_01) {
    thread func_5BDD();
  }
}

func_5C3F() {
  self endon("death_anim");
  self endon("death");
  wait(100);
  self notify("timeout");
}

func_5BF0() {
  self endon("death_anim");
  self endon("death");
  var_00 = scripts\engine\utility::waittill_any_return("no_ammo", "lethal_damage", "timeout", "vr_delete");
  if(isDefined(level.player.var_4C29[self.var_9180].var_9A96) && level.player.var_4C29[self.var_9180].var_9A96) {
    while(level.player.var_4C29[self.var_9180].var_9A96) {
      wait(0.05);
    }
  }

  thread func_F378(self.var_9180, "off");
  if(var_00 == "no_ammo") {
    wait(1);
    thread func_5BF5(1);
    return;
  }

  if(var_00 == "lethal_damage") {
    thread func_5BF6();
    return;
  }

  if(var_00 == "timeout") {
    thread func_5BF5();
    return;
  }

  if(var_00 == "vr_delete") {
    thread func_5BF7();
    return;
  }
}

func_5BF5(param_00) {
  self notify("death_anim");
  if(isDefined(param_00) && param_00 == 1) {
    func_F377(self.var_9180, "noammo");
  } else {
    func_F377(self.var_9180, "destroyed");
  }

  scripts\sp\utility::func_9193("default_supdrone");
  self.var_5CDB scripts\sp\utility::func_9193("default_supdrone");
  self playSound("support_drone_engine_mvmt_death");
  self setanimknob( % equip_pocket_drone_death_loop);
  thread func_5C0C("veh_mil_air_un_pocketdrone_timeout_crash_body_4fan");
}

func_5BF7() {
  self notify("death_anim");
  func_F377(self.var_9180, "destroyed");
  scripts\sp\utility::func_9193("default_supdrone");
  self.var_5CDB scripts\sp\utility::func_9193("default_supdrone");
  scripts\engine\utility::waitframe();
  if(isDefined(self.var_B00E)) {
    self.var_B00E delete();
  }

  self delete();
}

func_5BF6() {
  self notify("death_anim");
  func_F377(self.var_9180, "destroyed");
  scripts\sp\utility::func_9193("default_supdrone");
  self.var_5CDB scripts\sp\utility::func_9193("default_supdrone");
  self playSound("support_drone_engine_mvmt_death");
  self setanimknob( % equip_pocket_drone_death_loop);
  if(isDefined(self.lastdamagedir)) {
    var_00 = self.lastdamagedir;
  } else {
    var_00 = anglestoright(level.player getplayerangles());
  }

  if(var_00 == (0, 0, 0)) {
    var_00 = (1, 0, 0);
  }

  var_01 = anglestoup(vectortoangles(var_00));
  playFX(level._effect["drone_shotdown_air_damage"], self.origin, var_00, var_01);
  self setModel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
  thread func_5C0C("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
}

func_5C0C(param_00) {
  var_01 = anglesToForward(self.angles + (45, 0, 0) + (0, randomfloat(360), 0));
  var_02 = scripts\common\trace::ray_trace(self.origin, self.origin + var_01 * 999999, undefined, scripts\common\trace::create_solid_ai_contents(1));
  var_03 = distance(self.origin, var_02["position"]);
  var_04 = 0.43;
  var_05 = var_03 * var_04;
  self setneargoalnotifydist(var_05);
  thread func_5C0D();
  self setmaxpitchroll(60, 60);
  self.angles = (45, 45, 0);
  self setvehgoalpos(var_02["position"], 0);
  self waittill("near_goal");
  if(!isDefined(self)) {
    return;
  }

  var_06 = 0.05681818;
  var_07 = self vehicle_getvelocity();
  var_08 = var_07 * var_06;
  var_09 = 2.5;
  var_0A = spawn("script_model", self.origin + var_08);
  var_0A setModel(param_00);
  var_0A hide();
  var_0A.angles = self gettagangles("j_body");
  wait(0.05);
  var_0A show();
  var_0A physicslaunchserver(var_0A.origin, var_07 * var_09);
  if(isDefined(self.var_B00E)) {
    self.var_B00E delete();
  }

  self delete();
  var_0B = 0.1;
  var_0C = 64;
  var_0D = var_0B * var_05 / var_0C;
  wait(var_0D);
  var_0A playSound("support_drone_engine_mvmt_death_impact_hit");
  playFX(level._effect["drone_death_hit_ground"], var_0A.origin, anglesToForward(var_0A.angles), anglestoup(var_0A.angles));
  level.player.var_5CA6 = scripts\engine\utility::array_removeundefined(level.player.var_5CA6);
  if(level.player.var_5CA6.size >= 5) {
    level.player.var_5CA6[0] delete();
    level.player.var_5CA6 = scripts\engine\utility::array_removeundefined(level.player.var_5CA6);
  }

  level.player.var_5CA6[level.player.var_5CA6.size] = var_0A;
  var_0A thread func_5BE7();
}

func_5BE7() {
  level.player endon("death");
  self endon("death");
  self endon("entitydeleted");
  for(;;) {
    if(distance(level.player.origin, self.origin) > 2200) {
      break;
    }

    wait(1);
  }

  level.player.var_5CA6 = scripts\engine\utility::array_remove(level.player.var_5CA6, self);
  self delete();
}

func_5C0D() {
  self endon("death");
  self endon("near_goal");
  self vehicle_setspeed(30, 8, 8);
  wait(0.5);
  if(isDefined(self)) {
    self vehicle_setspeed(30, 25, 25);
  }
}

func_5C55() {
  self endon("death_anim");
  self endon("death");
  thread func_5C44();
  self sethoverparams(2, 10, 10);
  self giveloadout("instant");
  self setneargoalnotifydist(64);
  self vehicle_setspeed(50, 50, 100);
  self.physics_getcharactercollisioncapsule = (0, 0, level.var_5C19[level.var_5C18]);
  level.var_5C18++;
  if(level.var_5C18 >= level.var_5C19.size) {
    level.var_5C18 = 0;
  }

  var_00 = 1;
  var_01 = (-3000, -3000, -3000);
  var_02 = (-3000, -3000, -3000);
  func_5C57(var_02);
  for(;;) {
    wait(0.05);
    var_03 = undefined;
    self.var_6FFF = 0;
    var_04 = func_5C52();
    if(var_04 == "follow") {
      var_05 = scripts\engine\utility::drop_to_ground(level.player.origin, 8);
      if(func_5C56(var_05)) {
        var_03 = func_5C54();
        var_02 = var_05;
        func_5C57(var_02);
      } else {
        var_03 = var_01;
        func_5C5A(var_02);
      }
    } else if(var_04 == "combat") {
      self.var_BE7A = scripts\sp\utility::array_removedeadvehicles(self.var_BE7A);
      if(isDefined(self.var_1155E) && isalive(self.var_1155E) && level.player.var_5C4F > 0) {
        var_03 = var_01;
      } else {
        var_03 = func_5C53(var_01);
      }
    }

    if(var_01 == var_03) {
      continue;
    }

    var_01 = var_03;
    thread func_5C61(var_03);
  }
}

func_5C54() {
  var_00 = anglesToForward(level.player.angles);
  var_01 = anglestoright(level.player.angles);
  var_02 = scripts\engine\utility::drop_to_ground(level.player.origin, 8);
  var_03 = self.physics_getcharactercollisioncapsule[2];
  var_04 = var_02 + (0, 0, var_03);
  var_05 = scripts\common\trace::ray_trace(var_02, var_04, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_05["fraction"] != 1) {
    var_04 = var_02 + (0, 0, var_05["fraction"] * var_03 - 10);
  }

  if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(var_02, var_04, 0, 1, 1, 0.1);
  }

  var_06 = 1;
  var_07 = 1;
  if(self.var_D384 == 1) {
    var_07 = -1;
  } else if(self.var_D384 == 2) {
    var_06 = -1;
  } else if(self.var_D384 >= 3) {
    var_06 = -1;
    var_07 = -1;
  }

  var_08 = 115 * var_06 + self.physics_getcharactercollisioncapsule[0];
  var_09 = 45 * var_07 + self.physics_getcharactercollisioncapsule[1];
  var_0A = var_04 + var_00 * var_08 + var_01 * var_09;
  var_05 = scripts\common\trace::ray_trace(var_04, var_0A, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_05["fraction"] != 1) {
    var_0B = vectornormalize(var_0A - var_04);
    var_0C = distance(var_0A, var_04);
    var_0A = var_04 + var_0B * var_05["fraction"] * var_0C - 10;
  }

  if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(var_04, var_0A, 0, 1, 1, 0.1);
  }

  var_0D = var_0A;
  if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(var_0D, var_0D + (0, 0, 16), 0, 0, 1, 0.1);
  }

  var_0E = scripts\common\trace::ray_trace_passed(self.origin, var_0D, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_0E) {
    self.var_6FFF = 1;
  } else if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(self.origin, var_0D, 1, 0, 0, 0.1);
  }

  var_0F = scripts\engine\utility::drop_to_ground(var_0D, 0);
  var_10 = getclosestpointonnavmesh(var_0F);
  var_11 = 1;
  if(distance(var_0F, var_10) > 8) {
    if(getdvarint("support_drone_debug")) {
      thread scripts\engine\utility::draw_line_for_time(var_0F, var_0F + (0, 0, 16), 1, 0, 0, 0.25);
      thread scripts\engine\utility::draw_line_for_time(var_10, var_10 + (0, 0, 16), 0, 1, 0, 0.25);
    }

    if(!self.var_6FFF) {
      var_11 = 0;
    }
  }

  var_12 = var_0D;
  if(!var_11) {
    if(distance(var_02, var_10) > distance(var_02, var_0F)) {
      var_12 = var_04;
    } else {
      var_12 = (var_10[0], var_10[1], var_04[2]);
    }
  }

  self.var_1D55 = var_03;
  return var_12;
}

func_5C57(param_00) {
  self.var_4B2E = 6;
  self.var_4B2F = param_00;
}

func_5C5A(param_00) {
  var_01 = 4.88;
  self.var_4B2E = min(self.var_4B2E + var_01, 128);
  if(self.var_4B2E != 128) {
    var_02 = self.origin - param_00;
    var_02 = vectornormalize((var_02[0], var_02[1], 0));
    self.var_4B2F = self.var_4B2F + var_02 * distance2d(self.origin, param_00) / 2 * 0.8 * 0.05;
  }
}

func_5C56(param_00) {
  if(getdvarint("support_drone_debug")) {
    thread scripts\sp\utility::draw_circle(self.var_4B2F + (0, 0, 16), self.var_4B2E, (1, 0, 0), 1, 0, 1);
  }

  if(distance(param_00, self.var_4B2F) >= self.var_4B2E) {
    return 1;
  }

  return 0;
}

func_5C51() {
  self.var_4B2E = 0;
}

func_5C53(param_00) {
  var_01 = self.physics_getcharactercollisioncapsule[2];
  var_02 = scripts\engine\utility::drop_to_ground(level.player.origin, 5);
  var_02 = var_02 + (0, 0, var_01);
  var_03 = [];
  var_04 = [];
  foreach(var_06 in self.var_BE7A) {
    var_03[var_03.size] = var_06.origin + (0, 0, var_01);
    var_04[var_04.size] = var_06.origin + (0, 0, var_01);
  }

  for(var_08 = 0; var_08 < int(self.var_BE7A.size * 1.5); var_08++) {
    var_03[var_03.size] = var_02;
  }

  var_09 = averagepoint(var_03);
  var_0A = averagepoint(var_04);
  var_0B = (0, 0, 0);
  if(var_0A == var_02) {
    var_0B = level.player.angles;
  } else {
    var_0B = vectortoangles(vectornormalize(var_0A - var_02));
  }

  var_0C = vectornormalize(var_0A - var_02);
  var_0D = distance(var_09, var_02);
  if(var_0D > 700) {
    var_09 = var_02 + var_0C * 700;
  }

  var_0E = anglestoright(var_0B);
  var_0F = 90;
  if(self.var_D384 == 0) {
    var_09 = var_09 + var_0E * var_0F / 2;
  } else if(self.var_D384 == 1) {
    var_09 = var_09 - var_0E * var_0F / 2;
  } else if(self.var_D384 == 2) {
    var_09 = var_09 + var_0E * var_0F * 1.5;
  } else if(self.var_D384 >= 3) {
    var_09 = var_09 - var_0E * var_0F * 1.5;
  }

  if(isDefined(self.var_1155E) && isalive(self.var_1155E)) {
    var_10 = vectornormalize(self.var_1155E.origin + (0, 0, var_01) - var_09);
    var_11 = distance(self.var_1155E.origin + (0, 0, var_01), var_09) / 4;
    if(var_11 > 100) {
      var_11 = 100;
    }

    var_09 = var_09 + var_10 * var_11;
  }

  if(distancesquared(var_09, param_00) < 2500) {
    return param_00;
  } else {
    level.player.var_5C4F = randomfloatrange(0.2, 2.5);
  }

  var_12 = scripts\common\trace::ray_trace_passed(self.origin, var_09, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_12) {
    self.var_6FFF = 1;
  } else if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(self.origin, var_09, 1, 0, 0, 0.1);
  }

  var_13 = scripts\engine\utility::drop_to_ground(var_09, 0);
  var_14 = getclosestpointonnavmesh(var_13);
  var_15 = 1;
  if(distance(var_13, var_14) > 8) {
    if(getdvarint("support_drone_debug")) {
      thread scripts\engine\utility::draw_line_for_time(var_13, var_13 + (0, 0, 16), 1, 0, 0, 0.25);
      thread scripts\engine\utility::draw_line_for_time(var_14, var_14 + (0, 0, 16), 0, 1, 0, 0.25);
    }

    if(!self.var_6FFF) {
      var_15 = 0;
    }
  }

  var_16 = var_09;
  if(!var_15) {
    var_16 = (var_14[0], var_14[1], var_14[2] + var_01);
  }

  self.var_1D55 = var_01;
  return var_16;
}

func_5C52() {
  if(func_D2DD()) {
    return "follow";
  }

  self.var_BE7A = scripts\sp\utility::array_removedeadvehicles(self.var_BE7A);
  if(self.var_BE7A.size > 0) {
    return "combat";
  }

  return "follow";
}

func_5C61(param_00) {
  self notify("new_path");
  self endon("new_path");
  self endon("death");
  if(self.var_6FFF == 1) {
    self setvehgoalpos(param_00, 1);
    if(getdvarint("support_drone_debug")) {
      thread scripts\engine\utility::draw_line_for_time(self.origin, param_00, 0, 1, 0, 0.25);
    }

    scripts\engine\utility::waittill_any_3("near_goal", "goal");
    return;
  }

  var_01 = scripts\engine\utility::drop_to_ground(self.origin, 0) + (0, 0, 8);
  var_02 = param_00 - (0, 0, self.var_1D55);
  var_03 = level.player findpath(var_01, var_02);
  var_04 = self.origin;
  if(getdvarint("support_drone_debug")) {
    foreach(var_06 in var_03) {
      thread scripts\engine\utility::draw_line_for_time(var_04, var_06, 0, 1, 0, 0.25);
      var_04 = var_06;
    }
  }

  foreach(var_06 in var_03) {
    if(getdvarint("support_drone_debug")) {}

    if(isDefined(self.var_1D55)) {
      var_06 = var_06 + (0, 0, self.var_1D55);
    }

    if(getdvarint("support_drone_debug")) {}

    self setvehgoalpos(var_06, 1);
    scripts\engine\utility::waittill_any_3("near_goal", "goal");
  }
}

func_5C44() {
  self endon("death_anim");
  self endon("death");
  for(;;) {
    if(isDefined(self.var_1155E) && isalive(self.var_1155E)) {
      self.var_B00E.origin = self.var_1155E gettagorigin("j_Spine4");
      self.var_5CDB laseron();
    } else {
      var_00 = level.player getEye();
      var_01 = anglesToForward(level.player getplayerangles());
      var_02 = var_00 + var_01 * 5000;
      var_03 = scripts\common\trace::ray_trace(var_00, var_02, level.player);
      self.var_B00E.origin = var_03["position"];
      self.var_5CDB laseroff();
    }

    if(getdvarint("support_drone_debug")) {}

    wait(0.1);
  }
}

func_5C1F() {
  self endon("death_anim");
  self endon("death");
  if(!isDefined(self.var_BE7A)) {
    self.var_BE7A = [];
  }

  for(;;) {
    var_00 = [];
    foreach(var_02 in getaiarray("axis")) {
      if(func_64EA(var_02) && !issubstr(var_02.classname, "c12")) {
        var_00[var_00.size] = var_02;
      }
    }

    if(self.var_BE7A.size == 0 && var_00.size > 0) {
      self notify("found_enemies");
    } else if(self.var_BE7A.size > 0 && var_00.size == 0) {
      self notify("no_enemies");
    }

    self.var_BE7A = var_00;
    wait(0.1);
  }
}

func_64EA(param_00) {
  if(!isalive(param_00) || param_00 scripts\sp\utility::func_58DA()) {
    return 0;
  }

  if(distance(param_00.origin, self.origin) > 1200) {
    return 0;
  }

  if(isDefined(param_00.var_1CAC)) {
    return param_00.var_1CAC;
  }

  if(param_00.ignoreme) {
    return 0;
  }

  return 1;
}

func_5C22() {
  self endon("death_anim");
  self endon("death");
  for(;;) {
    var_00 = randomfloatrange(-10, 10);
    var_01 = randomfloatrange(-10, 10);
    var_02 = randomfloatrange(-10, 10);
    self.physics_getcharactercollisioncapsule = (var_01, var_02, var_00);
    wait(randomfloatrange(2, 4));
  }
}

func_112B8() {
  var_00 = getEntArray("drone_point_of_interest", "targetname");
  foreach(var_02 in var_00) {
    var_03 = scripts\engine\utility::getstructarray(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      var_06 = var_05.origin[2];
      var_05.var_8D12 = (0, 0, var_06);
      var_05.origin = (var_05.origin[0], var_05.origin[1], 0);
    }

    var_02.var_D62F = var_03;
  }

  return var_00;
}

func_112B7(param_00) {
  if(!func_1310A()) {
    return;
  }

  param_00 endon("death");
  var_01 = 4000;
  for(;;) {
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    self waittill("trigger");
    if(isDefined(param_00.var_D630)) {
      continue;
    }

    var_02 = gettime();
    var_03 = randomintrange(2500, 5000);
    param_00.var_D630 = scripts\engine\utility::random(self.var_D62F);
    while(level.player istouching(self)) {
      if(scripts\engine\utility::flag("stealth_spotted")) {
        break;
      }

      if(gettime() - var_02 <= var_03) {
        param_00.var_D630 = scripts\engine\utility::random(self.var_D62F);
        var_03 = randomintrange(2500, 5000);
      }

      wait(0.1);
    }

    param_00.var_D630 = undefined;
  }
}

func_5BED() {
  self endon("death");
  var_00 = 0;
  var_01 = 0;
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06);
    var_00 = var_00 + var_02;
    self.lastdamagedir = var_04;
    if(var_00 > 600 && !var_01) {
      thread func_5C05();
      var_01 = 1;
    }

    if(var_00 > 1200) {
      self notify("lethal_damage");
    }
  }
}

func_5C05() {
  self setanimknob( % equip_pocket_drone_damaged_loop);
  scripts\sp\utility::func_75C4("drone_damaged_loop", "tag_origin");
  scripts\engine\utility::waittill_any_3("death", "death_anim");
  if(isDefined(self)) {
    scripts\sp\utility::func_75F8("drone_damaged_loop", "tag_origin");
  }
}

func_5BD8() {
  self endon("death_anim");
  self endon("death");
  self endon("entitydeleted");
  if(!scripts\sp\utility::func_65DF("target_timeout")) {
    scripts\sp\utility::func_65E0("target_timeout");
  }

  if(!scripts\sp\utility::func_65DF("target_killed_wait")) {
    scripts\sp\utility::func_65E0("target_killed_wait");
  }

  self.var_2654 = 1;
  childthread func_5BE6();
  thread func_5BE5();
  wait(2);
  for(;;) {
    self waittill("new_target_enemy");
    self playSound("support_drone_engine_mvmt_fast");
    childthread func_5C98(self.var_1155E);
  }
}

func_5BE5() {
  scripts\engine\utility::waittill_any_3("death_anim", "death", "entitydeleted");
  func_F378(self.var_9180, "off");
}

func_5BE6() {
  wait(2);
  for(;;) {
    wait(0.05);
    var_00 = 0;
    var_01 = 0;
    while(level.player.var_5C6E > 0) {
      scripts\engine\utility::waitframe();
    }

    while(func_D2DD()) {
      wait(0.25);
    }

    if(self.var_BE7A.size == 0) {
      self waittill("found_enemies");
      continue;
    }

    if((isDefined(self.var_1155E) && !isalive(self.var_1155E) || self.var_1155E scripts\sp\utility::func_58DA()) || scripts\sp\utility::func_65DB("target_killed_wait")) {
      var_01 = 1;
    }

    if(!var_01 || scripts\sp\utility::func_65DB("target_timeout")) {
      var_00 = 1;
    }

    if(var_00) {
      var_02 = func_5C1C(self.var_1155E);
      if(!isDefined(var_02)) {
        continue;
      }

      level.player.var_5C6E = randomfloatrange(0.5, 1.5);
      if(isDefined(self.var_1155E) && var_02 == self.var_1155E) {
        continue;
      }

      self notify("stop_hud");
      self.var_1155E = var_02;
      var_02 notify("drone_targeting");
      self notify("new_target_enemy");
      thread func_5BEB();
      scripts\sp\utility::func_65DD("target_timeout");
      scripts\sp\utility::func_65E1("target_killed_wait");
    }
  }
}

func_5C1C(param_00) {
  self.var_BE7A = scripts\sp\utility::array_removedeadvehicles(self.var_BE7A);
  if(self.var_BE7A.size == 0) {
    return undefined;
  }

  var_01 = [];
  foreach(var_03 in self.var_BE7A) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(isDefined(var_03.var_1CAC)) {
      if(var_03.var_1CAC) {
        var_01[var_01.size] = var_03;
      } else {
        continue;
      }
    }

    if(isDefined(var_03.ignoreme) && var_03.ignoreme) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  if(var_01.size == 0) {
    return undefined;
  }

  var_05 = [];
  foreach(var_03 in var_01) {
    if(func_5BE9(var_03)) {
      var_05[var_05.size] = var_03;
    }
  }

  var_08 = var_05;
  if(var_08.size == 0) {
    return undefined;
  }

  if(isDefined(param_00) && scripts\engine\utility::array_contains(var_08, param_00)) {
    return param_00;
  }

  var_09 = var_08[randomint(var_08.size)];
  return var_09;
}

func_5BE9(param_00) {
  var_01 = 0;
  var_02 = scripts\common\trace::ray_trace(self.origin, param_00 gettagorigin("j_head"), undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_02["fraction"] == 1) {
    var_01 = 1;
  }

  if(isalive(level.player) && var_01 == 0) {
    var_02 = scripts\common\trace::ray_trace(level.player getEye(), param_00 gettagorigin("j_head"), undefined, scripts\common\trace::create_solid_ai_contents(1));
    if(var_02["fraction"] == 1) {
      var_01 = 1;
    }
  }

  return var_01;
}

func_5C98(param_00) {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  self endon("target_enemy_died");
  childthread func_5C60(param_00);
  thread func_5C01(param_00);
  wait(0.5);
  while(isDefined(param_00) && isalive(param_00)) {
    if(self.var_1280E) {
      wait(0.05);
      continue;
    }

    var_01 = self.var_5CDB gettagorigin("tag_flash");
    var_02 = param_00 gettagorigin("j_Spine4");
    var_03 = cos(90);
    if(!scripts\engine\utility::within_fov(var_01, self.var_5CDB gettagangles("tag_flash"), var_02, var_03)) {
      wait(0.05);
      continue;
    }

    var_04 = ["j_Head", "j_Spine4", "j_SpineLower"];
    if(param_00.asmname == "seeker") {
      var_04 = scripts\engine\utility::array_remove(var_04, "j_SpineLower");
    }

    var_05 = undefined;
    foreach(var_07 in var_04) {
      if(getdvarint("support_drone_debug")) {
        thread scripts\engine\utility::draw_line_for_time(var_01, param_00 gettagorigin(var_07), 0.7, 0, 0, 0.1);
      }

      var_08 = scripts\common\trace::ray_trace_detail(var_01, param_00 gettagorigin(var_07), self);
      if(!isDefined(var_08["entity"])) {
        continue;
      }

      if(var_08["entity"] == level.player) {
        return;
      }

      if(var_08["entity"] == param_00) {
        var_05 = param_00 gettagorigin(var_07);
        break;
      }
    }

    if(!isDefined(var_05)) {
      wait(0.05);
      continue;
    }

    var_0A = var_05 - param_00.origin;
    self.var_5CDB settargetentity(param_00, var_0A);
    self thread[[self.var_5CAF]]();
    wait(1.2);
    thread func_5C89();
  }

  self.var_1155E = undefined;
}

func_5C89() {
  self notify("new_target_timeout");
  self endon("new_target_timeout");
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  wait(3);
  scripts\sp\utility::func_65E1("target_timeout");
}

func_5C60(param_00) {
  thread scripts\sp\utility::play_sound_on_entity("support_drone_lockon");
  func_F378(self.var_9180, "lockon", param_00);
}

func_5C01(param_00) {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  param_00 scripts\engine\utility::waittill_any_3("death", "entitydeleted", "death_anim");
  self notify("target_enemy_died");
  self.var_1155E = undefined;
  scripts\sp\utility::func_65E8("target_killed_wait");
  func_F378(self.var_9180, "off");
}

func_5BDD() {
  self endon("death_anim");
  self endon("death");
  self.var_11AD3 = [];
  thread func_5C9C();
  for(;;) {
    self.var_11AD3 = scripts\engine\utility::array_removeundefined(self.var_11AD3);
    if(self.var_11AD3.size <= 0) {
      level waittill("enemy_grenade_fire", var_00);
      wait(0.05);
      continue;
    }

    if(self.var_1280E) {
      wait(0.05);
      continue;
    }

    foreach(var_00 in self.var_11AD3) {
      var_02 = distance(var_00.origin, self.origin);
      if(var_02 <= 800) {
        thread func_5C9B(var_00);
        self.var_11AD3 = scripts\engine\utility::array_remove(self.var_11AD3, var_00);
        break;
      }
    }

    wait(0.05);
  }
}

func_5C9C() {
  self endon("death_anim");
  self endon("death");
  for(;;) {
    level waittill("enemy_grenade_fire", var_00);
    self.var_11AD3 = scripts\engine\utility::array_add(self.var_11AD3, var_00);
  }
}

func_5C9B(param_00) {
  self.var_1280E = 1;
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_trophy_scan");
  wait(0.5);
  if(!isDefined(param_00)) {
    self.var_1280E = 0;
    return;
  }

  self notify("trophy_system_engaged");
  thread scripts\engine\utility::stop_loop_sound_on_entity("support_drone_trophy_scan");
  self playSound("support_drone_trophy_fire");
  var_01 = vectornormalize(param_00.origin - self.var_5CDB gettagorigin("tag_flash"));
  playfxbetweenpoints(level._effect["drone_trophy_laser"], self.var_5CDB gettagorigin("tag_flash"), vectortoangles(var_01), param_00.origin);
  playFX(level._effect["drone_trophy_pop"], param_00.origin);
  playworldsound("support_drone_trophy_impact", param_00.origin);
  param_00 delete();
  self.var_1280E = 0;
}

func_5C0F() {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  var_00 = self.var_1155E;
  func_F378(self.var_9180, "fire");
  self.ammocount = self.ammocount - 1;
  func_5C32(self.var_9180, self.ammocount);
  if(self.ammocount <= 0) {
    self notify("no_ammo");
  }

  var_01 = var_00 gettagorigin("j_spine4");
  var_02 = var_01 - var_00.origin;
  var_03 = 4;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    if(self.ammocount <= 0) {
      wait(0.1);
    }

    thread func_5C10();
    self.var_5CDB shootturret();
    wait(0.1);
  }

  wait(0.05);
  if(isDefined(var_00) && !isalive(var_00) || var_00 scripts\sp\utility::func_58DA()) {
    func_F378(self.var_9180, "kill");
  }
}

func_5BEB() {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  for(;;) {
    wait(0.05);
    if(!isDefined(self.var_1155E) || !isalive(self.var_1155E) || self.var_1155E scripts\sp\utility::func_58DA()) {
      break;
    }
  }

  wait(1.6);
  scripts\sp\utility::func_65DD("target_killed_wait");
}

func_5C12() {
  self endon("death_anim");
  self endon("death");
  thread scripts\sp\utility::play_loop_sound_on_tag("support_drone_windup", "tag_origin");
  wait(0.5);
  scripts\engine\utility::delaythread(0.15, ::scripts\engine\utility::stop_loop_sound_on_entity, "support_drone_windup");
  self.ammocount = self.ammocount - 1;
  func_5C32(self.var_9180, self.ammocount);
  if(self.ammocount <= 0) {
    self notify("no_ammo");
  }

  var_00 = 1;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    if(self.ammocount <= 0) {
      wait(0.1);
    }

    self.var_5CDB shootturret();
    wait(0.1);
  }
}

func_5C10() {
  self endon("death_anim");
  self endon("death");
  self notify("firing");
  self endon("firing");
  if(!self.var_6DA5) {
    self.var_6DA5 = 1;
  }

  wait(1);
  self.var_6DA5 = 0;
}

func_5C59() {
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_engine");
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_close_lyr");
  scripts\engine\utility::waittill_any_3("death", "death_anim");
  if(isDefined(self)) {
    func_5C58("support_drone_engine", "support_drone_close_lyr");
  }
}

func_5C58(param_00, param_01) {
  self notify("stop sound" + param_00);
  self notify("stop sound" + param_01);
}

func_5C5C() {
  scripts\sp\utility::func_75C4("drone_thruster", "j_fan_front_le");
  scripts\sp\utility::func_75C4("drone_thruster", "j_fan_front_ri");
  scripts\sp\utility::func_75C4("drone_thruster", "j_fan_rear_le");
  scripts\sp\utility::func_75C4("drone_thruster", "j_fan_rear_ri");
  scripts\engine\utility::waittill_any_3("death", "death_anim");
  if(isDefined(self)) {
    func_5C5B();
  }
}

func_5C5B() {
  scripts\sp\utility::func_75F8("drone_thruster", "j_fan_front_le");
  scripts\sp\utility::func_75F8("drone_thruster", "j_fan_front_ri");
  scripts\sp\utility::func_75F8("drone_thruster", "j_fan_rear_le");
  scripts\sp\utility::func_75F8("drone_thruster", "j_fan_rear_ri");
}

func_9C6F() {
  if(!isDefined(level.player.var_4C29)) {
    return 0;
  }

  if(level.player.var_4C29.size <= 0) {
    return 0;
  }

  return 1;
}

get_all_drones() {
  var_00 = [];
  for(var_01 = 0; var_01 < 5; var_01++) {
    if(isDefined(level.player.var_4C29[var_01]) && isDefined(level.player.var_4C29[var_01].var_5BD7) && isalive(level.player.var_4C29[var_01].var_5BD7)) {
      var_00 = scripts\engine\utility::array_add(var_00, level.player.var_4C29[var_01].var_5BD7);
    }
  }

  return var_00;
}

func_A5B9() {
  if(!isDefined(level.player.var_4C29) || level.player.var_4C29.size == 0) {
    return;
  }

  foreach(var_01 in level.player.var_4C29) {
    var_01.var_5BD7 notify("lethal_damage");
  }
}

func_5139() {
  if(!isDefined(level.player.var_4C29) || level.player.var_4C29.size == 0) {
    return;
  }

  foreach(var_01 in level.player.var_4C29) {
    var_01.var_5BD7 notify("vr_delete");
  }
}

func_1310A() {
  return level.player scripts\sp\utility::func_65DF("stealth_enabled") && level.player scripts\sp\utility::func_65DB("stealth_enabled");
}

func_D2DD() {
  if(func_1310A()) {
    return !scripts\engine\utility::flag("stealth_spotted");
  }

  return 0;
}

func_F378(param_00, param_01, param_02) {
  if(param_01 == "lockon") {
    setomnvar("ui_supdrone_reticle_" + param_00 + "_target_ent", param_02);
    setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state", 1);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + param_00 + "_lock_state", 0);
    return;
  }

  if(param_01 == "fire") {
    setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state", 2);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + param_00 + "_lock_state", 0);
    return;
  }

  if(param_01 == "kill") {
    setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state", 3);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + param_00 + "_lock_state", 0);
    return;
  }

  if(param_01 == "off") {
    setomnvar("ui_supdrone_reticle_" + param_00 + "_target_ent", undefined);
    setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state", 0);
    return;
  }
}

func_F377(param_00, param_01) {
  if(param_01 == "active") {
    setomnvarbit("ui_supdrone_bits", param_00, 1);
    setomnvar("ui_supdrone_state_" + param_00, 1);
    level.player.var_4C29[param_00].var_9A96 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::func_F424, param_00);
    return;
  }

  if(param_01 == "destroyed") {
    setomnvar("ui_supdrone_state_" + param_00, 2);
    scripts\engine\utility::noself_delaycall(1.5, ::setomnvarbit, "ui_supdrone_bits", param_00, 0);
    level.player.var_4C29[param_00].var_C7B4 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::func_F4B1, param_00);
    return;
  }

  if(param_01 == "noammo") {
    setomnvar("ui_supdrone_state_" + param_00, 3);
    scripts\engine\utility::noself_delaycall(1.5, ::setomnvarbit, "ui_supdrone_bits", param_00, 0);
    level.player.var_4C29[param_00].var_C7B4 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::func_F4B1, param_00);
    return;
  }
}

func_5C32(param_00, param_01) {
  param_01 = scripts\engine\utility::ter_op(param_01 < 0, 0, param_01);
  setomnvar("ui_supdrone_ammo_" + param_00, param_01);
}

func_F424(param_00) {
  level.player.var_4C29[param_00].var_9A96 = 0;
}

func_F4B1(param_00) {
  level.player.var_4C29[param_00].var_C7B4 = 0;
  level.player.var_4C29[param_00].var_51BA = 1;
}

func_129A() {
  if(isDefined(level.player.var_5CB3) && level.player.var_5CB3 == 1) {
    return "supportdrone_up2";
  }

  return "supportdrone";
}