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
  var_0 = func_129A();
  for(;;) {
    self waittill("secondary_equipment_change");
    waittillframeend;
    if(!isDefined(scripts\sp\utility::func_7C3D()) || scripts\sp\utility::func_7C3D() != var_0) {
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
  var_0 = func_112B8();
  for(;;) {
    level.var_112B9 = 0;
    for(;;) {
      self waittill("grenade_fire", var_1, var_2);
      if(var_2 == "supportdrone" || var_2 == "supportdrone_up2") {
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
      var_3 = self getrunningforwardpainanim(func_129A());
      self setweaponammoclip(func_129A(), var_3 - 1);
    }

    self notify("offhand_fired");
    var_4 = func_112BA(var_0);
    var_4.var_D384 = func_7B15();
    var_4.var_9180 = var_4.var_D384;
    self.var_4C29[var_4.var_D384] = spawnStruct();
    self.var_4C29[var_4.var_D384].var_5BD7 = var_4;
    self.var_4C29[var_4.var_D384].var_51BA = 0;
    self.var_4C29[var_4.var_D384].var_9A96 = 1;
    self.var_4C29[var_4.var_D384].var_C7B4 = 0;
    func_F377(var_4.var_9180, "active");
    func_5C32(var_4.var_9180, var_4.ammocount);
    level.player scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::flag_clear("secondary_equipment_in_use");
    level.player thread scripts\sp\utility::func_65DE("support_drone_spawning", 0.05);
  }
}

func_5BE1() {
  self endon("death");
  for(;;) {
    var_0 = 0;
    for(var_1 = 0; var_1 < 5; var_1++) {
      if(isDefined(self.var_4C29[var_1]) && self.var_4C29[var_1].var_51BA == 1) {
        self.var_4C29[var_1] = undefined;
        level notify("drone_max_cleanup");
        var_0 = 1;
      }
    }

    if(var_0) {
      var_2 = 0;
      for(var_1 = 0; var_1 < 5; var_1++) {
        if(isDefined(self.var_4C29[var_1]) && isDefined(self.var_4C29[var_1].var_5BD7)) {
          self.var_4C29[var_1].var_5BD7.var_D384 = var_2;
          var_2++;
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
  var_0 = 0;
  for(var_1 = 0; var_1 < func_7AC7(); var_1++) {
    if(isDefined(self.var_4C29[var_1])) {
      var_0++;
    }
  }

  return var_0;
}

func_7B15() {
  for(var_0 = 0; var_0 < func_7AC7(); var_0++) {
    if(!isDefined(self.var_4C29[var_0])) {
      return var_0;
    }
  }

  return undefined;
}

func_385A() {
  if(!self _meth_843C() || self getteamsize() || !scripts\engine\utility::isoffhandweaponsallowed() || !scripts\engine\utility::isoffhandsecondaryweaponsallowed()) {
    return 0;
  }

  var_0 = self getrunningforwardpainanim(func_129A());
  if(var_0 <= 0) {
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
    var_0 = undefined;
    var_1 = undefined;
    for(var_2 = 0; var_2 < 5; var_2++) {
      if(!isDefined(level.player.var_4C29[var_2])) {
        continue;
      }

      if(isDefined(level.player.var_4C29[var_2].var_E0EC) && level.player.var_4C29[var_2].var_E0EC) {
        continue;
      }

      if(isDefined(level.player.var_4C29[var_2].var_9A96) && level.player.var_4C29[var_2].var_9A96) {
        continue;
      }

      if(!isDefined(var_0) || level.player.var_4C29[var_2].var_5BD7.ammocount < var_0) {
        var_0 = level.player.var_4C29[var_2].var_5BD7.ammocount;
        var_1 = var_2;
      }
    }

    if(isDefined(var_1)) {
      level.player.var_4C29[var_1].var_5BD7 notify("timeout");
      level.player.var_4C29[var_1].var_E0EC = 1;
      break;
    }

    wait(0.1);
  }
}

func_112BA(var_0) {
  var_1 = getEntArray("support_drone_spawner", "targetname");
  var_2 = var_1[0];
  level.player thread scripts\sp\utility::play_sound_on_entity("support_drone_activate");
  self notify("drone_spawned");
  var_3 = level.player getplayerangles();
  var_4 = scripts\engine\utility::flat_angle(var_3);
  var_5 = level.player getEye();
  var_6 = anglestoup(var_3);
  var_7 = anglestoup(var_4);
  var_8 = anglesToForward(var_4);
  var_9 = 24;
  var_0A = 24;
  var_0B = var_5;
  var_0C = scripts\common\trace::ray_trace(var_5, var_5 + var_6 * var_0A + var_9, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_0C["fraction"] != 1) {
    var_0C = scripts\common\trace::ray_trace(var_5, var_5 + var_7 * var_0A + var_9, undefined, scripts\common\trace::create_solid_ai_contents(1));
    if(var_0C["fraction"] != 1) {
      var_0B = var_5 + var_7 * var_0A * var_0C["fraction"];
    } else {
      var_0B = var_5 + var_7 * var_0A;
    }
  } else {
    var_0B = var_5 + var_6 * var_0A;
  }

  var_2.origin = var_0B;
  var_2.angles = var_4;
  var_0D = var_2 scripts\sp\utility::func_10808();
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
  scripts\engine\utility::array_thread(var_0, ::func_112B7, var_0D);
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

func_11719(var_0) {
  var_0 endon("death");
  iprintlnbold("Dpad Up: hover");
  iprintlnbold("Dpad Left: damaged");
  iprintlnbold("Dpad Right: death");
  level.player notifyonplayercommand("dpadup", "+actionslot 1");
  level.player notifyonplayercommand("dpaddown", "+actionslot 2");
  level.player notifyonplayercommand("dpadleft", "+actionslot 3");
  for(;;) {
    var_1 = level.player scripts\engine\utility::waittill_any_return("dpadup", "dpaddown", "dpadleft");
    if(var_1 == "dpadup") {
      iprintlnbold("hover");
      var_0 setanimknob( % equip_pocket_drone_hover_loop);
    } else if(var_1 == "dpadleft") {
      iprintlnbold("damaged");
      var_0 setanimknob( % equip_pocket_drone_damaged_loop);
    } else if(var_1 == "dpaddown") {
      iprintlnbold("death");
      var_0 setanimknob( % equip_pocket_drone_death_loop);
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
  foreach(var_1 in self.mgturret) {
    var_1 setturretteam("allies");
    var_1.var_5041 = "manual";
    var_1 give_player_session_tokens("manual");
    var_1 turretfireenable();
    var_1 setleftarc(90);
    var_1 setrightarc(90);
    var_1 settoparc(90);
    var_1 give_crafted_gascan(90);
    var_1 _meth_82C9(0, "yaw");
    var_1 _meth_82C9(0, "pitch");
  }

  self.var_5CDB = self.mgturret[0];
  self.mgturret[0] show();
  self.var_5CAF = ::func_5C0F;
}

func_5C37() {
  self endon("death_anim");
  self endon("death");
  var_0 = 0;
  for(;;) {
    if(func_D2DD()) {
      var_0 = 1;
    } else if(level.player.ignoreme) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }

    self.ignoreme = var_0;
    wait(0.1);
  }
}

func_5C4B(var_0, var_1) {
  if(isDefined(var_0) && var_0) {
    thread func_5BD8();
  }

  if(isDefined(var_1) && var_1) {
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
  var_0 = scripts\engine\utility::waittill_any_return("no_ammo", "lethal_damage", "timeout", "vr_delete");
  if(isDefined(level.player.var_4C29[self.var_9180].var_9A96) && level.player.var_4C29[self.var_9180].var_9A96) {
    while(level.player.var_4C29[self.var_9180].var_9A96) {
      wait(0.05);
    }
  }

  thread func_F378(self.var_9180, "off");
  if(var_0 == "no_ammo") {
    wait(1);
    thread func_5BF5(1);
    return;
  }

  if(var_0 == "lethal_damage") {
    thread func_5BF6();
    return;
  }

  if(var_0 == "timeout") {
    thread func_5BF5();
    return;
  }

  if(var_0 == "vr_delete") {
    thread func_5BF7();
    return;
  }
}

func_5BF5(var_0) {
  self notify("death_anim");
  if(isDefined(var_0) && var_0 == 1) {
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
    var_0 = self.lastdamagedir;
  } else {
    var_0 = anglestoright(level.player getplayerangles());
  }

  if(var_0 == (0, 0, 0)) {
    var_0 = (1, 0, 0);
  }

  var_1 = anglestoup(vectortoangles(var_0));
  playFX(level._effect["drone_shotdown_air_damage"], self.origin, var_0, var_1);
  self setModel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
  thread func_5C0C("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
}

func_5C0C(var_0) {
  var_1 = anglesToForward(self.angles + (45, 0, 0) + (0, randomfloat(360), 0));
  var_2 = scripts\common\trace::ray_trace(self.origin, self.origin + var_1 * 999999, undefined, scripts\common\trace::create_solid_ai_contents(1));
  var_3 = distance(self.origin, var_2["position"]);
  var_4 = 0.43;
  var_5 = var_3 * var_4;
  self setneargoalnotifydist(var_5);
  thread func_5C0D();
  self setmaxpitchroll(60, 60);
  self.angles = (45, 45, 0);
  self setvehgoalpos(var_2["position"], 0);
  self waittill("near_goal");
  if(!isDefined(self)) {
    return;
  }

  var_6 = 0.05681818;
  var_7 = self vehicle_getvelocity();
  var_8 = var_7 * var_6;
  var_9 = 2.5;
  var_0A = spawn("script_model", self.origin + var_8);
  var_0A setModel(var_0);
  var_0A hide();
  var_0A.angles = self gettagangles("j_body");
  wait(0.05);
  var_0A show();
  var_0A physicslaunchserver(var_0A.origin, var_7 * var_9);
  if(isDefined(self.var_B00E)) {
    self.var_B00E delete();
  }

  self delete();
  var_0B = 0.1;
  var_0C = 64;
  var_0D = var_0B * var_5 / var_0C;
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

  var_0 = 1;
  var_1 = (-3000, -3000, -3000);
  var_2 = (-3000, -3000, -3000);
  func_5C57(var_2);
  for(;;) {
    wait(0.05);
    var_3 = undefined;
    self.var_6FFF = 0;
    var_4 = func_5C52();
    if(var_4 == "follow") {
      var_5 = scripts\engine\utility::drop_to_ground(level.player.origin, 8);
      if(func_5C56(var_5)) {
        var_3 = func_5C54();
        var_2 = var_5;
        func_5C57(var_2);
      } else {
        var_3 = var_1;
        func_5C5A(var_2);
      }
    } else if(var_4 == "combat") {
      self.var_BE7A = scripts\sp\utility::array_removedeadvehicles(self.var_BE7A);
      if(isDefined(self.var_1155E) && isalive(self.var_1155E) && level.player.var_5C4F > 0) {
        var_3 = var_1;
      } else {
        var_3 = func_5C53(var_1);
      }
    }

    if(var_1 == var_3) {
      continue;
    }

    var_1 = var_3;
    thread func_5C61(var_3);
  }
}

func_5C54() {
  var_0 = anglesToForward(level.player.angles);
  var_1 = anglestoright(level.player.angles);
  var_2 = scripts\engine\utility::drop_to_ground(level.player.origin, 8);
  var_3 = self.physics_getcharactercollisioncapsule[2];
  var_4 = var_2 + (0, 0, var_3);
  var_5 = scripts\common\trace::ray_trace(var_2, var_4, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_5["fraction"] != 1) {
    var_4 = var_2 + (0, 0, var_5["fraction"] * var_3 - 10);
  }

  if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(var_2, var_4, 0, 1, 1, 0.1);
  }

  var_6 = 1;
  var_7 = 1;
  if(self.var_D384 == 1) {
    var_7 = -1;
  } else if(self.var_D384 == 2) {
    var_6 = -1;
  } else if(self.var_D384 >= 3) {
    var_6 = -1;
    var_7 = -1;
  }

  var_8 = 115 * var_6 + self.physics_getcharactercollisioncapsule[0];
  var_9 = 45 * var_7 + self.physics_getcharactercollisioncapsule[1];
  var_0A = var_4 + var_0 * var_8 + var_1 * var_9;
  var_5 = scripts\common\trace::ray_trace(var_4, var_0A, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_5["fraction"] != 1) {
    var_0B = vectornormalize(var_0A - var_4);
    var_0C = distance(var_0A, var_4);
    var_0A = var_4 + var_0B * var_5["fraction"] * var_0C - 10;
  }

  if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(var_4, var_0A, 0, 1, 1, 0.1);
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
    if(distance(var_2, var_10) > distance(var_2, var_0F)) {
      var_12 = var_4;
    } else {
      var_12 = (var_10[0], var_10[1], var_4[2]);
    }
  }

  self.var_1D55 = var_3;
  return var_12;
}

func_5C57(var_0) {
  self.var_4B2E = 6;
  self.var_4B2F = var_0;
}

func_5C5A(var_0) {
  var_1 = 4.88;
  self.var_4B2E = min(self.var_4B2E + var_1, 128);
  if(self.var_4B2E != 128) {
    var_2 = self.origin - var_0;
    var_2 = vectornormalize((var_2[0], var_2[1], 0));
    self.var_4B2F = self.var_4B2F + var_2 * distance2d(self.origin, var_0) / 2 * 0.8 * 0.05;
  }
}

func_5C56(var_0) {
  if(getdvarint("support_drone_debug")) {
    thread scripts\sp\utility::draw_circle(self.var_4B2F + (0, 0, 16), self.var_4B2E, (1, 0, 0), 1, 0, 1);
  }

  if(distance(var_0, self.var_4B2F) >= self.var_4B2E) {
    return 1;
  }

  return 0;
}

func_5C51() {
  self.var_4B2E = 0;
}

func_5C53(var_0) {
  var_1 = self.physics_getcharactercollisioncapsule[2];
  var_2 = scripts\engine\utility::drop_to_ground(level.player.origin, 5);
  var_2 = var_2 + (0, 0, var_1);
  var_3 = [];
  var_4 = [];
  foreach(var_6 in self.var_BE7A) {
    var_3[var_3.size] = var_6.origin + (0, 0, var_1);
    var_4[var_4.size] = var_6.origin + (0, 0, var_1);
  }

  for(var_8 = 0; var_8 < int(self.var_BE7A.size * 1.5); var_8++) {
    var_3[var_3.size] = var_2;
  }

  var_9 = averagepoint(var_3);
  var_0A = averagepoint(var_4);
  var_0B = (0, 0, 0);
  if(var_0A == var_2) {
    var_0B = level.player.angles;
  } else {
    var_0B = vectortoangles(vectornormalize(var_0A - var_2));
  }

  var_0C = vectornormalize(var_0A - var_2);
  var_0D = distance(var_9, var_2);
  if(var_0D > 700) {
    var_9 = var_2 + var_0C * 700;
  }

  var_0E = anglestoright(var_0B);
  var_0F = 90;
  if(self.var_D384 == 0) {
    var_9 = var_9 + var_0E * var_0F / 2;
  } else if(self.var_D384 == 1) {
    var_9 = var_9 - var_0E * var_0F / 2;
  } else if(self.var_D384 == 2) {
    var_9 = var_9 + var_0E * var_0F * 1.5;
  } else if(self.var_D384 >= 3) {
    var_9 = var_9 - var_0E * var_0F * 1.5;
  }

  if(isDefined(self.var_1155E) && isalive(self.var_1155E)) {
    var_10 = vectornormalize(self.var_1155E.origin + (0, 0, var_1) - var_9);
    var_11 = distance(self.var_1155E.origin + (0, 0, var_1), var_9) / 4;
    if(var_11 > 100) {
      var_11 = 100;
    }

    var_9 = var_9 + var_10 * var_11;
  }

  if(distancesquared(var_9, var_0) < 2500) {
    return var_0;
  } else {
    level.player.var_5C4F = randomfloatrange(0.2, 2.5);
  }

  var_12 = scripts\common\trace::ray_trace_passed(self.origin, var_9, undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_12) {
    self.var_6FFF = 1;
  } else if(getdvarint("support_drone_debug")) {
    thread scripts\engine\utility::draw_line_for_time(self.origin, var_9, 1, 0, 0, 0.1);
  }

  var_13 = scripts\engine\utility::drop_to_ground(var_9, 0);
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

  var_16 = var_9;
  if(!var_15) {
    var_16 = (var_14[0], var_14[1], var_14[2] + var_1);
  }

  self.var_1D55 = var_1;
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

func_5C61(var_0) {
  self notify("new_path");
  self endon("new_path");
  self endon("death");
  if(self.var_6FFF == 1) {
    self setvehgoalpos(var_0, 1);
    if(getdvarint("support_drone_debug")) {
      thread scripts\engine\utility::draw_line_for_time(self.origin, var_0, 0, 1, 0, 0.25);
    }

    scripts\engine\utility::waittill_any_3("near_goal", "goal");
    return;
  }

  var_1 = scripts\engine\utility::drop_to_ground(self.origin, 0) + (0, 0, 8);
  var_2 = var_0 - (0, 0, self.var_1D55);
  var_3 = level.player findpath(var_1, var_2);
  var_4 = self.origin;
  if(getdvarint("support_drone_debug")) {
    foreach(var_6 in var_3) {
      thread scripts\engine\utility::draw_line_for_time(var_4, var_6, 0, 1, 0, 0.25);
      var_4 = var_6;
    }
  }

  foreach(var_6 in var_3) {
    if(getdvarint("support_drone_debug")) {}

    if(isDefined(self.var_1D55)) {
      var_6 = var_6 + (0, 0, self.var_1D55);
    }

    if(getdvarint("support_drone_debug")) {}

    self setvehgoalpos(var_6, 1);
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
      var_0 = level.player getEye();
      var_1 = anglesToForward(level.player getplayerangles());
      var_2 = var_0 + var_1 * 5000;
      var_3 = scripts\common\trace::ray_trace(var_0, var_2, level.player);
      self.var_B00E.origin = var_3["position"];
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
    var_0 = [];
    foreach(var_2 in getaiarray("axis")) {
      if(func_64EA(var_2) && !issubstr(var_2.classname, "c12")) {
        var_0[var_0.size] = var_2;
      }
    }

    if(self.var_BE7A.size == 0 && var_0.size > 0) {
      self notify("found_enemies");
    } else if(self.var_BE7A.size > 0 && var_0.size == 0) {
      self notify("no_enemies");
    }

    self.var_BE7A = var_0;
    wait(0.1);
  }
}

func_64EA(var_0) {
  if(!isalive(var_0) || var_0 scripts\sp\utility::func_58DA()) {
    return 0;
  }

  if(distance(var_0.origin, self.origin) > 1200) {
    return 0;
  }

  if(isDefined(var_0.var_1CAC)) {
    return var_0.var_1CAC;
  }

  if(var_0.ignoreme) {
    return 0;
  }

  return 1;
}

func_5C22() {
  self endon("death_anim");
  self endon("death");
  for(;;) {
    var_0 = randomfloatrange(-10, 10);
    var_1 = randomfloatrange(-10, 10);
    var_2 = randomfloatrange(-10, 10);
    self.physics_getcharactercollisioncapsule = (var_1, var_2, var_0);
    wait(randomfloatrange(2, 4));
  }
}

func_112B8() {
  var_0 = getEntArray("drone_point_of_interest", "targetname");
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      var_6 = var_5.origin[2];
      var_5.var_8D12 = (0, 0, var_6);
      var_5.origin = (var_5.origin[0], var_5.origin[1], 0);
    }

    var_2.var_D62F = var_3;
  }

  return var_0;
}

func_112B7(var_0) {
  if(!func_1310A()) {
    return;
  }

  var_0 endon("death");
  var_1 = 4000;
  for(;;) {
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    self waittill("trigger");
    if(isDefined(var_0.var_D630)) {
      continue;
    }

    var_2 = gettime();
    var_3 = randomintrange(2500, 5000);
    var_0.var_D630 = scripts\engine\utility::random(self.var_D62F);
    while(level.player istouching(self)) {
      if(scripts\engine\utility::flag("stealth_spotted")) {
        break;
      }

      if(gettime() - var_2 <= var_3) {
        var_0.var_D630 = scripts\engine\utility::random(self.var_D62F);
        var_3 = randomintrange(2500, 5000);
      }

      wait(0.1);
    }

    var_0.var_D630 = undefined;
  }
}

func_5BED() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);
    var_0 = var_0 + var_2;
    self.lastdamagedir = var_4;
    if(var_0 > 600 && !var_1) {
      thread func_5C05();
      var_1 = 1;
    }

    if(var_0 > 1200) {
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
    var_0 = 0;
    var_1 = 0;
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
      var_1 = 1;
    }

    if(!var_1 || scripts\sp\utility::func_65DB("target_timeout")) {
      var_0 = 1;
    }

    if(var_0) {
      var_2 = func_5C1C(self.var_1155E);
      if(!isDefined(var_2)) {
        continue;
      }

      level.player.var_5C6E = randomfloatrange(0.5, 1.5);
      if(isDefined(self.var_1155E) && var_2 == self.var_1155E) {
        continue;
      }

      self notify("stop_hud");
      self.var_1155E = var_2;
      var_2 notify("drone_targeting");
      self notify("new_target_enemy");
      thread func_5BEB();
      scripts\sp\utility::func_65DD("target_timeout");
      scripts\sp\utility::func_65E1("target_killed_wait");
    }
  }
}

func_5C1C(var_0) {
  self.var_BE7A = scripts\sp\utility::array_removedeadvehicles(self.var_BE7A);
  if(self.var_BE7A.size == 0) {
    return undefined;
  }

  var_1 = [];
  foreach(var_3 in self.var_BE7A) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3.var_1CAC)) {
      if(var_3.var_1CAC) {
        var_1[var_1.size] = var_3;
      } else {
        continue;
      }
    }

    if(isDefined(var_3.ignoreme) && var_3.ignoreme) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = [];
  foreach(var_3 in var_1) {
    if(func_5BE9(var_3)) {
      var_5[var_5.size] = var_3;
    }
  }

  var_8 = var_5;
  if(var_8.size == 0) {
    return undefined;
  }

  if(isDefined(var_0) && scripts\engine\utility::array_contains(var_8, var_0)) {
    return var_0;
  }

  var_9 = var_8[randomint(var_8.size)];
  return var_9;
}

func_5BE9(var_0) {
  var_1 = 0;
  var_2 = scripts\common\trace::ray_trace(self.origin, var_0 gettagorigin("j_head"), undefined, scripts\common\trace::create_solid_ai_contents(1));
  if(var_2["fraction"] == 1) {
    var_1 = 1;
  }

  if(isalive(level.player) && var_1 == 0) {
    var_2 = scripts\common\trace::ray_trace(level.player getEye(), var_0 gettagorigin("j_head"), undefined, scripts\common\trace::create_solid_ai_contents(1));
    if(var_2["fraction"] == 1) {
      var_1 = 1;
    }
  }

  return var_1;
}

func_5C98(var_0) {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  self endon("target_enemy_died");
  childthread func_5C60(var_0);
  thread func_5C01(var_0);
  wait(0.5);
  while(isDefined(var_0) && isalive(var_0)) {
    if(self.var_1280E) {
      wait(0.05);
      continue;
    }

    var_1 = self.var_5CDB gettagorigin("tag_flash");
    var_2 = var_0 gettagorigin("j_Spine4");
    var_3 = cos(90);
    if(!scripts\engine\utility::within_fov(var_1, self.var_5CDB gettagangles("tag_flash"), var_2, var_3)) {
      wait(0.05);
      continue;
    }

    var_4 = ["j_Head", "j_Spine4", "j_SpineLower"];
    if(var_0.asmname == "seeker") {
      var_4 = scripts\engine\utility::array_remove(var_4, "j_SpineLower");
    }

    var_5 = undefined;
    foreach(var_7 in var_4) {
      if(getdvarint("support_drone_debug")) {
        thread scripts\engine\utility::draw_line_for_time(var_1, var_0 gettagorigin(var_7), 0.7, 0, 0, 0.1);
      }

      var_8 = scripts\common\trace::ray_trace_detail(var_1, var_0 gettagorigin(var_7), self);
      if(!isDefined(var_8["entity"])) {
        continue;
      }

      if(var_8["entity"] == level.player) {
        return;
      }

      if(var_8["entity"] == var_0) {
        var_5 = var_0 gettagorigin(var_7);
        break;
      }
    }

    if(!isDefined(var_5)) {
      wait(0.05);
      continue;
    }

    var_0A = var_5 - var_0.origin;
    self.var_5CDB settargetentity(var_0, var_0A);
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

func_5C60(var_0) {
  thread scripts\sp\utility::play_sound_on_entity("support_drone_lockon");
  func_F378(self.var_9180, "lockon", var_0);
}

func_5C01(var_0) {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  var_0 scripts\engine\utility::waittill_any_3("death", "entitydeleted", "death_anim");
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
      level waittill("enemy_grenade_fire", var_0);
      wait(0.05);
      continue;
    }

    if(self.var_1280E) {
      wait(0.05);
      continue;
    }

    foreach(var_0 in self.var_11AD3) {
      var_2 = distance(var_0.origin, self.origin);
      if(var_2 <= 800) {
        thread func_5C9B(var_0);
        self.var_11AD3 = scripts\engine\utility::array_remove(self.var_11AD3, var_0);
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
    level waittill("enemy_grenade_fire", var_0);
    self.var_11AD3 = scripts\engine\utility::array_add(self.var_11AD3, var_0);
  }
}

func_5C9B(var_0) {
  self.var_1280E = 1;
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_trophy_scan");
  wait(0.5);
  if(!isDefined(var_0)) {
    self.var_1280E = 0;
    return;
  }

  self notify("trophy_system_engaged");
  thread scripts\engine\utility::stop_loop_sound_on_entity("support_drone_trophy_scan");
  self playSound("support_drone_trophy_fire");
  var_1 = vectornormalize(var_0.origin - self.var_5CDB gettagorigin("tag_flash"));
  playfxbetweenpoints(level._effect["drone_trophy_laser"], self.var_5CDB gettagorigin("tag_flash"), vectortoangles(var_1), var_0.origin);
  playFX(level._effect["drone_trophy_pop"], var_0.origin);
  playworldsound("support_drone_trophy_impact", var_0.origin);
  var_0 delete();
  self.var_1280E = 0;
}

func_5C0F() {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  var_0 = self.var_1155E;
  func_F378(self.var_9180, "fire");
  self.ammocount = self.ammocount - 1;
  func_5C32(self.var_9180, self.ammocount);
  if(self.ammocount <= 0) {
    self notify("no_ammo");
  }

  var_1 = var_0 gettagorigin("j_spine4");
  var_2 = var_1 - var_0.origin;
  var_3 = 4;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(self.ammocount <= 0) {
      wait(0.1);
    }

    thread func_5C10();
    self.var_5CDB shootturret();
    wait(0.1);
  }

  wait(0.05);
  if(isDefined(var_0) && !isalive(var_0) || var_0 scripts\sp\utility::func_58DA()) {
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

  var_0 = 1;
  for(var_1 = 0; var_1 < var_0; var_1++) {
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

func_5C58(var_0, var_1) {
  self notify("stop sound" + var_0);
  self notify("stop sound" + var_1);
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
  var_0 = [];
  for(var_1 = 0; var_1 < 5; var_1++) {
    if(isDefined(level.player.var_4C29[var_1]) && isDefined(level.player.var_4C29[var_1].var_5BD7) && isalive(level.player.var_4C29[var_1].var_5BD7)) {
      var_0 = scripts\engine\utility::array_add(var_0, level.player.var_4C29[var_1].var_5BD7);
    }
  }

  return var_0;
}

func_A5B9() {
  if(!isDefined(level.player.var_4C29) || level.player.var_4C29.size == 0) {
    return;
  }

  foreach(var_1 in level.player.var_4C29) {
    var_1.var_5BD7 notify("lethal_damage");
  }
}

func_5139() {
  if(!isDefined(level.player.var_4C29) || level.player.var_4C29.size == 0) {
    return;
  }

  foreach(var_1 in level.player.var_4C29) {
    var_1.var_5BD7 notify("vr_delete");
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

func_F378(var_0, var_1, var_2) {
  if(var_1 == "lockon") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_target_ent", var_2);
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 1);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
    return;
  }

  if(var_1 == "fire") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 2);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
    return;
  }

  if(var_1 == "kill") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 3);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
    return;
  }

  if(var_1 == "off") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_target_ent", undefined);
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
    return;
  }
}

func_F377(var_0, var_1) {
  if(var_1 == "active") {
    setomnvarbit("ui_supdrone_bits", var_0, 1);
    setomnvar("ui_supdrone_state_" + var_0, 1);
    level.player.var_4C29[var_0].var_9A96 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::func_F424, var_0);
    return;
  }

  if(var_1 == "destroyed") {
    setomnvar("ui_supdrone_state_" + var_0, 2);
    scripts\engine\utility::noself_delaycall(1.5, ::setomnvarbit, "ui_supdrone_bits", var_0, 0);
    level.player.var_4C29[var_0].var_C7B4 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::func_F4B1, var_0);
    return;
  }

  if(var_1 == "noammo") {
    setomnvar("ui_supdrone_state_" + var_0, 3);
    scripts\engine\utility::noself_delaycall(1.5, ::setomnvarbit, "ui_supdrone_bits", var_0, 0);
    level.player.var_4C29[var_0].var_C7B4 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::func_F4B1, var_0);
    return;
  }
}

func_5C32(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(var_1 < 0, 0, var_1);
  setomnvar("ui_supdrone_ammo_" + var_0, var_1);
}

func_F424(var_0) {
  level.player.var_4C29[var_0].var_9A96 = 0;
}

func_F4B1(var_0) {
  level.player.var_4C29[var_0].var_C7B4 = 0;
  level.player.var_4C29[var_0].var_51BA = 1;
}

func_129A() {
  if(isDefined(level.player.var_5CB3) && level.player.var_5CB3 == 1) {
    return "supportdrone_up2";
  }

  return "supportdrone";
}