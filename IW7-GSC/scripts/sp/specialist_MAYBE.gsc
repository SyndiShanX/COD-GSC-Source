/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\specialist_MAYBE.gsc
*******************************************/

unlockspecialist() {
  if(getdvarint("mis_cheat") == 0) {
    return;
  }

  if(level.script == "europa") {
    wait(1);
    var_00 = gettime() + 10000;
    while(gettime() < var_00 && level.player buttonpressed("BUTTON_LSTICK") || level.player buttonpressed("m")) {
      wait(0.05);
    }

    if(gettime() >= var_00) {
      level.player _meth_84C7("unlockedRealism", 1);
      level.player _meth_84C7("beatRealism", 1);
      scripts\sp\endmission::func_725B(1);
      level.player playrumbleonentity("light_2s");
      var_01 = newhudelem();
      var_01.horzalign = "center";
      var_01.vertalign = "fullscreen";
      var_01.alignx = "center";
      var_01.aligny = "top";
      var_01.y = 10;
      var_01 setshader("white", 1, 1);
      wait(0.1);
      var_01 destroy();
    }
  }
}

init() {
  precacheshellshock("plane_sway");
  precacheshader("hud_injury_leg_right");
  precacheshader("hud_injury_arm_right");
  precacheshader("hud_injury_arm_left");
  precacheshader("hud_injury_leg_left");
  precacheshader("hud_injury_pristine");
  precacheshader("hud_injury_scanner");
  precacheshader("hud_injury_chest");
  precacheshader("hud_injury_skull");
  precacheshader("helmet_crack_00");
  precacheshader("helmet_crack_01");
  precacheshader("helmet_burn_00");
  precacheshader("helmet_burn_01");
  precacheshader("helmet_broken");
  precacheitem("iw7_fists_specialist_mode");
  precacheitem("nanoshot");
  precacheitem("helmet");
  precachemodel("equipment_mp_nanoshot_wm");
  precachemodel("mil_grenade_box_dynamic");
  setsaveddvar("ai_suppression_decrement_enemy", 0.001);
  setsaveddvar("cg_drawDamageDirection", 0);
  scripts\sp\utility::func_16EB("helmet_tutorial_hint", &"SPECIALIST_MODE_TUTORIAL_HELMET");
  scripts\sp\utility::func_16EB("nanoshot_tutorial_hint", &"SPECIALIST_MODE_TUTORIAL_NANOSHOT");
  scripts\sp\utility::func_16EB("suffocate_tutorial_hint", &"SPECIALIST_MODE_TUTORIAL_SUFFOCATE");
  scripts\sp\utility::func_16EB("left_arm_tutorial_hint_equipment", &"SPECIALIST_MODE_TUTORIAL_LEFT_ARM_EQUIPMENT");
  scripts\sp\utility::func_16EB("left_arm_tutorial_hint_melee", &"SPECIALIST_MODE_TUTORIAL_LEFT_ARM_MELEE");
  scripts\sp\utility::func_16EB("helmet_already_on_tutorial_hint", &"SPECIALIST_MODE_TUTORIAL_HELMET_ALREADY_ON");
  scripts\sp\utility::func_16EB("nanoshot_tutorial_hint_at_max_health", &"SPECIALIST_MODE_TUTORIAL_NANOSHOT_MAX_HEALTH");
  scripts\sp\utility::func_16EB("helmet_find", &"SPECIALIST_MODE_TUTORIAL_HELMET_FIND");
  scripts\sp\utility::func_16EB("helmet_equip", &"SPECIALIST_MODE_TUTORIAL_HELMET_EQUIP");
  scripts\sp\utility::func_16EB("press_use_pc", &"SPECIALIST_MODE_USE_PC", ::func_86C8);
  scripts\sp\utility::func_16EB("press_use_console", &"SPECIALIST_MODE_USE_CONSOLE", ::func_86C8);
  scripts\sp\utility::func_16EB("specialist_loadout", &"SPECIALIST_MODE_LOADOUT");
  level.var_10DB5 = 5;
  level._effect["vfx_blood_impact"] = loadfx("vfx\code\impacts\flesh_hit_knife.vfx");
  level._effect["vfx_gun_sparks"] = loadfx("vfx\misc\specialist_mode\gun_sparks.vfx");
  level.var_10964 = spawnStruct();
  level.var_10964.allowhints = 1;
  level.var_10964.var_98EC = 0;
  level.var_10964.ignorehelmetfuncs = 1;
  func_F2D2(0);
  var_00 = getEntArray("specialist_mode_only", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.script_parameters)) {
      if(var_02.script_parameters == "notsolid") {
        var_02 notsolid();
      }
    }
  }

  thread unlockspecialist();
  level.var_10964.var_2610 = spawn("script_origin", level.player.origin);
  level.var_10964.var_2610 linkto(level.player);
}

main() {
  level.player notifyonplayercommand("reload_pressed", "+usereload");
  level.player notifyonplayercommand("reload_pressed", "+reload");
  level.player notifyonplayercommand("use_pressed", "+activate");
  level.player notifyonplayercommand("use_pressed", "+usereload");
  level.player notifyonplayercommand("frag_pressed", "+frag");
  level.player notifyonplayercommand("smoke_pressed", "+smoke");
  level.player notifyonplayercommand("melee_pressed", "+melee");
  level.player notifyonplayercommand("melee_pressed", "+melee_zoom");
  level.player notifyonplayercommand("melee_pressed", "+melee_sprint");
  level.player notifyonplayercommand("actionslot_weapon_pressed", "+actionslot 1");
  level.player _meth_857E(1);
  level.player scripts\engine\utility::allow_autoreload(0);
  level.player scripts\sp\utility::func_1C3E(0);
  lib_0B61::func_95A4();
  self.var_86F4 = 3;
  self.var_BFAA = 0;
  self.var_D430 = 0;
  self.var_8E12 = 0;
  self.var_D467 = 0;
  self.var_4C97 = 0;
  self.var_58DE = 0;
  self.var_111BE = 0;
  self.var_BF7E = 0;
  self.var_10B3B = 0;
  self.var_8E1B = 0;
  self.helmetimpacts = [];
  self.hidehelmetimpacts = 0;
  var_00 = ["arm_left", "arm_right", "leg_left", "leg_right", "chest"];
  self.var_2C19 = [];
  foreach(var_02 in var_00) {
    self.var_2C19[var_02] = spawnStruct();
    self.var_2C19[var_02].name = var_02;
    self.var_2C19[var_02].maxhealth = 60;
    self.var_2C19[var_02].health = 60;
  }

  func_9150(var_00);
  func_F3FF(0);
  func_F2A6(0);
  func_F53C(1);
  func_F400(0);
  thread func_4D05();
  thread func_BE50();
  thread func_8DE3();
  thread func_4E1B();
  thread func_25FD();
  thread func_12AAF();
  thread spawn_specialist_crates();
  thread move_specialist_crates();
  thread delete_specialist_crates();
}

func_4D05() {
  level.player endon("death");
  level.player endon("headshot_death");
  for(;;) {
    level.player waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_05, var_05, var_05, var_06);
    if(!func_2C8C()) {
      continue;
    }

    if(func_2C8D()) {
      thread func_4E1A(1);
      break;
    }

    if(isDefined(level.player.burning) && level.player.burning) {
      func_4CE0("chest", 0.25);
      func_4CE0("arm_left", 0.25);
      continue;
    }

    thread func_25E3();
    level.player playSound("melee_knife_stab_upper_hit_plr");
    if(vectortoangles(var_02) == (90, 0, 0)) {
      thread func_4D16(scripts\engine\utility::random(["left", "right"]), var_00);
      continue;
    }

    var_07 = level.player getEye()[2] + 12 - level.player.origin[2];
    var_08 = var_03[2] - level.player.origin[2] / var_07;
    if(var_08 > 0.79) {
      var_09 = var_01.origin;
      if(isai(var_01)) {
        var_09 = var_01 getEye();
      } else if(var_01.classname != "worldspawn" && isDefined(var_01.model) && scripts\sp\utility::hastag(var_01.model, "j_head")) {
        var_09 = var_01 gettagorigin("j_head");
      }

      thread func_4D14(var_00, var_04, var_09, var_06);
    } else if(var_08 > 0.61) {
      thread func_4D18(func_4CFA(var_03, 1), var_00);
    } else {
      thread func_4D16(func_4CFA(var_03, 0), var_00);
    }

    func_F531(0.55);
    func_F49E(1);
    thread func_F49E(0, 1.83);
  }
}

func_4CFA(param_00, param_01) {
  var_02 = param_00 - level.player.origin;
  var_03 = scripts\sp\math::func_EB9B(anglestoleft(level.player.angles), var_02);
  var_04 = scripts\sp\math::func_EB9B(anglestoright(level.player.angles), var_02);
  var_05 = max(var_03, var_04);
  if(var_05 <= 1.35 && param_01) {
    return "chest";
  } else if(var_05 == var_03) {
    return "left";
  }

  return "right";
}

func_4D14(param_00, param_01, param_02, param_03) {
  if(param_01 == "MOD_MELEE") {
    var_04 = 0;
  } else {
    var_04 = 0.422618;
  }

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, param_02, var_04)) {
    var_05 = ["chest", "left", "right"];
    thread func_4D18(scripts\engine\utility::random(var_05), param_00);
    return;
  }

  if(func_2C95() && self.var_8E1B < 4) {
    if(isDefined(var_04) && weaponclass(var_04) == "sniper" && self.var_8E1B < 3) {
      self.var_8E1B = 3;
      param_01 = param_01 * 0.75;
    } else {
      self.var_8E1B++;
    }

    func_F52C(level.player.health + param_01);
    if(self.var_8E1B >= 4) {
      thread func_4CE1();
      return;
    }

    thread func_25E9("injury", "helmet");
    if(level.var_10964.var_8E1B == 3) {
      thread func_9147(1);
    } else if(param_02 == "MOD_MELEE") {
      func_4CFB(0, 1, param_03);
    } else {
      func_4CFB(1, 1, param_03);
    }

    if(!self.var_8E12) {
      thread func_9146();
      return;
    }

    return;
  }

  thread func_4E1A(0);
}

func_4D16(param_00, param_01) {
  level.player endon("death");
  if(level.player getstance() == "prone") {
    thread func_4D18(param_00, param_01);
    return;
  }

  screenshake(level.player.origin, 10, 20, 5, 0.75);
  var_02 = "leg_" + param_00;
  var_03 = func_2C94(var_02);
  func_4CE0(var_02, param_01);
  if(var_03) {
    return;
  }

  if(!func_2C94(var_02)) {
    thread func_25E9("injury", "leg", "generic");
    return;
  }

  thread func_4D12();
  var_04 = func_2C94("leg_right") && func_2C94("leg_left");
  if(var_04) {
    thread func_25E9("injury", "legs", "critical");
    return;
  }

  thread func_4D39();
  thread func_25E9("injury", "leg", "critical");
}

func_4D39() {
  level.player endon("nanoshot_healing");
  level.player notify("leg_damage");
  childthread damage_leg_view_dvar_thread();
  for(;;) {
    var_00 = 1;
    var_01 = 6;
    var_02 = 0.5;
    var_03 = level.player getstance();
    if(var_03 == "crouch") {
      var_00 = var_00 * 0.5;
      var_01 = var_01 * 0.5;
    }

    if(level.player getweaponrankinfominxp() > 0) {
      var_00 = var_00 * 0.5;
      var_01 = var_01 * 0.4;
      var_02 = var_02 * 0.333333;
    }

    if(scripts\sp\utility::func_93AC() || func_2C97()) {
      scripts\sp\utility::func_AB9A("bg_viewBobMax", 0, 0.5);
      level.player give_crafted_fireworks_trap(0);
    } else if(level.player isonground()) {
      level.player give_crafted_fireworks_trap(var_00);
      scripts\sp\utility::func_AB9A("bg_viewBobMax", var_01, var_02);
    } else {
      level.player give_crafted_fireworks_trap(1);
      scripts\sp\utility::func_AB9A("bg_viewBobMax", 7, 0.5);
    }

    wait(0.05);
  }
}

damage_leg_view_dvar_thread() {
  for(;;) {
    var_00 = getdvarint("bg_viewBobConstantAmplitude");
    if(level.player islinked() && var_00 == 1) {
      setsaveddvar("bg_viewBobConstantAmplitude", 0);
    } else if(!level.player islinked() && var_00 == 0) {
      setsaveddvar("bg_viewBobConstantAmplitude", 1);
    }

    wait(0.05);
  }
}

func_4D12() {
  level.player endon("death");
  if(issubstr(level.player getcurrentprimaryweapon(), "steeldragon")) {
    return;
  }

  if(!level.player isonground()) {
    return;
  }

  if(scripts\sp\utility::func_93AC()) {
    return;
  }

  var_00 = level.player getstance();
  if(var_00 == "prone") {
    return;
  }

  level.player scripts\engine\utility::allow_stances(0);
  if(not_able_to_prone()) {
    level.player setstance("crouch");
    var_01 = 0;
  } else {
    level.player scripts\engine\utility::allow_crouch(0);
    level.player setstance("prone");
    var_01 = 1;
  }

  level.player scripts\engine\utility::allow_jump(0);
  thread func_4D13(var_01);
}

not_able_to_prone() {
  if(isDefined(level.player.disabledprone) && level.player.disabledprone > 0) {
    return 1;
  }

  var_00 = getEntArray("trigger_multiple_no_prone", "classname");
  foreach(var_02 in var_00) {
    if(level.player istouching(var_02)) {
      return 1;
    }
  }

  return 0;
}

func_4D18(param_00, param_01) {
  level.player endon("death");
  if(param_00 == "chest") {
    thread func_4D11(param_01);
    return;
  }

  var_02 = "arm_" + param_00;
  if(func_2C8A() && var_02 == "arm_right") {
    self.var_BF7E = gettime() + 120000 + randomint(120000);
    thread func_4D1D();
    func_F52C(level.player.health + param_01);
    return;
  }

  playFX(level._effect["vfx_blood_impact"], level.player getEye());
  screenshake(level.player.origin, 20, 30, 10, 0.75);
  var_03 = func_2C94(var_02);
  func_4CE0(var_02, param_01);
  if(var_03) {
    return;
  }

  if(!func_2C94(var_02)) {
    thread func_25E9("injury", "arm", "generic");
    return;
  }

  if(var_02 == "arm_left") {
    thread func_4D36();
    if(func_2C94("arm_right")) {
      thread func_4D31();
    }
  } else if(var_02 == "arm_right") {
    if(func_2C94("arm_left")) {
      thread func_4D31();
    } else {
      thread func_4D3E();
    }
  }

  var_04 = func_2C94("arm_right") && func_2C94("arm_left");
  if(var_04) {
    thread func_25E9("injury", "arms", "critical");
    return;
  }

  thread func_25E9("injury", "arm", "critical");
}

func_4D11(param_00) {
  var_01 = func_2C94("chest");
  screenshake(level.player.origin, 20, 30, 10, 0.75);
  func_4CE0("chest", param_00);
  if(var_01) {
    return;
  }

  if(!func_2C94("chest")) {
    return;
  }

  thread func_25E9("injury", "chest", "critical");
}

func_4D13(param_00) {
  level.player endon("death");
  level.player forceplaygestureviewmodel("ges_hold_here", undefined, 0.25, 0, 1, 0);
  wait(0.6);
  level.player stopgestureviewmodel("ges_hold_here");
  level.player scripts\engine\utility::allow_stances(1);
  if(param_00) {
    level.player scripts\engine\utility::allow_crouch(1);
  }

  level.player scripts\engine\utility::allow_jump(1);
}

func_4D36() {
  level.player endon("death");
  level.player endon("both_arms_hurt");
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\sp\utility::func_1C72(0);
  level.player scripts\sp\utility::func_1C34(0);
  level notify("pause_jackal_streak_message");
  if(scripts\sp\utility::func_D0BD("grapplingdevice", 1)) {
    level.player notify("spacegrapple_cancel");
    level.player _meth_8507();
  }

  thread func_4D37();
  thread func_4D38();
  thread func_4D35();
  level.player waittill("nanoshot_healing");
  level.player scripts\engine\utility::allow_reload(1);
  level.player stopgestureviewmodel("ges_left_arm_damage");
  level.player stopgestureviewmodel("ges_left_arm_damage_reload");
}

func_4D35() {
  level.player endon("nanoshot_healing");
  level endon("both_arms_hurt");
  level.player forceplaygestureviewmodel("ges_left_arm_damage", undefined, 0.2, 0, 1, 0);
  var_00 = 1;
  wait(var_00);
  for(;;) {
    wait(0.05);
    if(!func_2C88()) {
      continue;
    }

    level.player forceplaygestureviewmodel("ges_left_arm_damage", undefined, 0, var_00, 1, 1);
  }
}

func_4D37() {
  level.player endon("nanoshot_healing");
  level.player endon("headshot_death");
  level.player endon("death");
  for(;;) {
    level.player waittill("frag_pressed");
    if(func_2C87()) {
      level.player playSound("melee_knife_human_default_fatal_plr");
      var_00 = level.player getweaponammostock("nanoshot");
      level.player setweaponammostock("nanoshot", var_00 - 1);
      wait(1);
      level.player stopgestureviewmodel("ges_both_arm_damage", 0.75, 1);
      level.player stopgestureviewmodel("ges_left_arm_damage", 0.75, 1);
      thread func_BE54();
    }

    wait(0.05);
  }
}

func_4D38() {
  level.player endon("nanoshot_healing");
  for(;;) {
    level.player waittill("reload_pressed");
    if(!func_2C89()) {
      continue;
    }

    thread damageed_left_arm_reload_internal();
    level.player waittill("damaged_left_arm_reload_done");
  }
}

damageed_left_arm_reload_internal() {
  self.var_4C97 = 1;
  level.player forceplaygestureviewmodel("ges_left_arm_damage_reload", undefined, 0.2, 0, 1, 1);
  level.player scripts\engine\utility::allow_fire(0);
  wait(2.7);
  if(func_2C94("arm_right") && func_2C94("arm_left")) {
    level.player forceplaygestureviewmodel("ges_both_arm_damage", undefined, 0.5, 0, 1, 1);
  } else if(func_2C94("arm_left")) {
    level.player forceplaygestureviewmodel("ges_left_arm_damage", undefined, 0.2, 1, 1, 1);
  }

  var_00 = level.player getcurrentprimaryweapon();
  var_01 = weaponclipsize(var_00);
  var_02 = level.player getcurrentweaponclipammo();
  var_03 = level.player getweaponammostock(var_00);
  var_04 = min(var_01 - var_02, var_03);
  level.player setweaponammoclip(var_00, int(var_02 + var_04));
  level.player setweaponammostock(var_00, int(var_03 - var_04));
  level.player scripts\engine\utility::allow_fire(1);
  self.var_4C97 = 0;
  level.player notify("damaged_left_arm_reload_done");
}

func_4D3E() {
  level.player endon("nanoshot_healing");
  level endon("both_arms_hurt");
  for(;;) {
    wait(0.05);
    if(!func_2C88()) {
      continue;
    }

    level.player forceplaygestureviewmodel("ges_right_arm_damage", undefined, 0.5, 0, 1, 1);
  }
}

func_4D31() {
  level notify("both_arms_hurt");
  level.player endon("nanoshot_healing");
  for(;;) {
    wait(0.05);
    if(!func_2C88()) {
      continue;
    }

    level.player forceplaygestureviewmodel("ges_both_arm_damage", undefined, 0.5, 0, 1, 1);
  }
}

func_4D1D() {
  level.player specialist_allow_invulnerability(1);
  level.player playgestureviewmodel("ges_shocknade_loop", undefined, 1, 0.25, 0, 0);
  playworldsound("bullet_ricochet_heavy", level.player getEye());
  self.var_86F4--;
  level.player giveweapon("iw7_fists_specialist_mode");
  level.player switchtoweapon("iw7_fists_specialist_mode");
  level.player disableweaponpickup();
  thread func_86CB(0);
  wait(0.5);
  level.player stopgestureviewmodel("ges_shocknade_loop");
}

func_86CB(param_00) {
  var_01 = level.player getcurrentprimaryweapon();
  if(level.player _meth_8519(var_01, 1) && !issubstr(var_01, "iw7_fmg")) {
    var_01 = weaponaltweaponname(var_01);
  }

  var_02 = level.player iswallrunning() || !level.player isonground();
  if(!var_02) {
    level.player allowmovement(0);
    wait(0.1);
  }

  var_03 = level.player getEye() + (0, 0, -3);
  var_03 = var_03 + anglesToForward(level.player.angles) * 19;
  var_03 = var_03 + anglestoright(level.player.angles) * 7;
  var_04 = spawn("weapon_" + var_01, var_03);
  var_04.angles = level.player.angles;
  if(!param_00) {
    var_04 thread func_86CC(var_01, var_02);
    return;
  }

  level.player takeweapon(var_01);
  var_04 physicslaunchserveritem(var_04.origin, var_04.origin + anglesToForward(level.player.angles) * 30);
}

func_86CC(param_00, param_01) {
  var_02 = level.player getcurrentweaponclipammo();
  var_03 = level.player getweaponammostock(param_00);
  if(!param_01) {
    thread func_86CE(0.5);
  } else {
    thread gun_drop_while_wallrunning();
  }

  level.player takeweapon(level.player getcurrentprimaryweapon());
  var_04 = level.player getplayerangles();
  var_05 = vectortoangles(self.origin - level.player getEye());
  level.player setplayerangles(var_05);
  level.player getrawbaseweaponname(0.05, 0.05);
  scripts\sp\audio::func_F5A0();
  setslowmotion(1, 0.1, 0.05);
  var_06 = scripts\engine\utility::spawn_tag_origin(self.origin, (0, 0, 0));
  var_06 linkto(self);
  playFXOnTag(level._effect["vfx_gun_sparks"], var_06, "tag_origin");
  scripts\engine\utility::noself_delaycall(0.1, ::playfxontag, level._effect["vfx_gun_sparks"], var_06, "tag_origin");
  var_06 scripts\engine\utility::delaycall(1, ::delete);
  thread scripts\sp\utility::func_C12D("weapon_pickup_failed", 0.5);
  level.player scripts\engine\utility::delaycall(0.5, ::enableweaponpickup);
  thread func_86C9();
  thread func_86CF(param_00);
  level scripts\engine\utility::waittill_any_3("weapon_pickup_failed", "player_grabbed_weapon");
  setslowmotion(0.25, 1, 0.4);
  level.player getrawbaseweaponname(1, 1);
  level.player allowmovement(1);
  level.player specialist_allow_invulnerability(0);
  scripts\sp\audio::func_F59F();
  thread func_86CD(param_00, var_02, var_03);
}

func_86CD(param_00, param_01, param_02) {
  for(;;) {
    level.player waittill("weapon_change", var_03);
    if(isDefined(var_03) && var_03 == "none" || var_03 == "iw7_fists_specialist_mode") {
      continue;
    }

    if(scripts\sp\utility::func_D0CA("iw7_fists_specialist_mode")) {
      level.player takeweapon("iw7_fists_specialist_mode");
    }

    if(isDefined(self)) {
      if(distance2dsquared(self.origin, level.player.origin) > 1000000) {
        break;
      }

      continue;
    } else if(var_03 == param_00) {
      level.player setweaponammoclip(var_03, param_01);
      level.player setweaponammostock(var_03, param_02);
      break;
    }
  }
}

func_86CE(param_00) {
  level endon("player_grabbed_weapon");
  var_01 = 0.27;
  var_02 = gettime() + var_01 * 1000;
  var_03 = param_00 - var_01;
  var_04 = 20;
  var_05 = 15;
  var_06 = 1;
  var_07 = 2.5;
  while(gettime() < var_02) {
    if(!isDefined(self)) {
      break;
    }

    var_08 = level.player getEye();
    var_09 = anglesToForward(level.player.angles);
    var_0A = anglestoup(level.player.angles);
    var_0B = var_08 + var_09 * var_04;
    var_0B = var_0B + var_0A * var_05;
    var_0C = distance(self.origin, var_0B);
    var_0D = vectortoangles(var_0B - self.origin);
    var_0D = anglesToForward(var_0D);
    var_0E = scripts\sp\math::func_C097(0, var_04, var_0C);
    self.origin = self.origin + var_0D * var_07;
    var_0F = randomfloatrange(-11, -9);
    self.angles = self.angles + (var_0F, var_0F, var_0F);
    wait(0.05);
  }

  wait(var_03);
  level notify("weapon_pickup_failed");
}

gun_drop_while_wallrunning() {
  level endon("player_grabbed_weapon");
  var_00 = anglesToForward(level.player getplayerangles());
  self.origin = self.origin + var_00 * 20;
  var_01 = vectornormalize(level.player getvelocity() + (0, 0, 10));
  self physicslaunchserveritem(self.origin, var_01 * 1700);
  wait(0.5);
  level notify("weapon_pickup_failed");
}

func_86C9() {
  if(level.console || level.player usinggamepad()) {
    scripts\sp\utility::func_56BE("press_use_console", 0.5);
    return;
  }

  scripts\sp\utility::func_56BE("press_use_pc", 0.5);
}

func_86C8() {
  return level.player usebuttonpressed();
}

func_86CF(param_00) {
  level.player endon("death");
  level endon("weapon_pickup_failed");
  level.player waittill("use_pressed");
  level.player stopgestureviewmodel("ges_shocknade_loop", 0);
  level.player playgestureviewmodel("ges_swipe", self, 1, 0, 0.3, 1);
  var_01 = level.player.origin + anglesToForward(level.player.angles) * -30;
  if(!scripts\engine\utility::within_fov(var_01, level.player.angles, self.origin, 0.5)) {
    return;
  }

  if(distancesquared(level.player getEye(), self.origin) > 2500) {
    return;
  }

  level notify("player_grabbed_weapon");
  func_86CA();
  playworldsound("scrap_pickup_small", level.player.origin);
  level.player giveweapon(param_00);
  level.player switchtoweapon(param_00);
  if(scripts\sp\utility::func_D0CA("iw7_fists_specialist_mode")) {
    level.player takeweapon("iw7_fists_specialist_mode");
  }
}

func_86CA() {
  var_00 = level.player getEye() + (0, 0, -20);
  var_00 = var_00 + anglestoright(level.player getplayerangles()) * 5;
  var_00 = var_00 + anglesToForward(level.player getplayerangles()) * -25;
  var_01 = distance(var_00, self.origin);
  var_02 = vectortoangles(var_00 - self.origin);
  var_02 = anglesToForward(var_02);
  var_03 = self.origin;
  var_04 = 0.5;
  var_05 = 0;
  while(var_05 < 1 && isDefined(self)) {
    self.origin = var_03 + var_02 * var_01 * var_05;
    var_05 = var_05 + var_04;
    wait(0.05);
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_BE50() {
  level.player endon("death");
  thread func_BE4F();
  thread nanoshot_pickup_watcher();
  for(;;) {
    level.player waittill("grenade_fire", var_00, var_01);
    if(var_01 == "nanoshot") {
      level.player playSound("melee_knife_human_default_fatal_plr");
      var_00 delete();
      thread func_BE54();
    }

    wait(0.05);
  }
}

func_BE4F() {
  level.player endon("death");
  for(;;) {
    wait(0.05);
    if(func_2C99()) {
      level.player grenade_earthquakeatposition();
      continue;
    }

    level.player grenade_earthquakeatposition_internal();
  }
}

func_BE54() {
  level.player notify("nanoshot_healing");
  thread func_BE53();
  thread func_BE51();
  thread announce_healed();
  var_00 = func_2296(0);
  foreach(var_02 in var_00) {
    thread func_BE52(var_02);
  }

  func_F52C(level.player.maxhealth);
}

announce_healed() {
  var_00 = 0;
  var_01 = 0;
  var_02 = func_2C94("leg_left") || func_2C94("leg_right");
  if(var_02) {
    var_00 = func_2C94("leg_left") && func_2C94("leg_right");
  }

  var_03 = func_2C94("arm_left") || func_2C94("arm_right");
  if(var_03) {
    var_01 = func_2C94("arm_left") && func_2C94("arm_right");
  }

  if(!var_02 && var_03) {
    if(var_01) {
      if(scripts\engine\utility::cointoss()) {
        thread func_25E9("repair", "arms");
        return;
      }

      thread func_25E9("repair", "status");
      return;
    }

    thread func_25E9("repair", "arm");
    return;
  }

  if(var_02 && !var_03) {
    if(var_00) {
      if(scripts\engine\utility::cointoss()) {
        thread func_25E9("repair", "legs");
        return;
      }

      thread func_25E9("repair", "status");
      return;
    }

    thread func_25E9("repair", "leg");
    return;
  }

  thread func_25E9("repair", "status");
}

func_BE53() {
  var_00 = func_2C94("leg_left") || func_2C94("leg_right");
  if(var_00) {
    var_01 = 0.25;
    thread scripts\sp\utility::func_AB9A("bg_viewBobMax", 7, var_01);
    level.player give_crafted_fireworks_trap(0);
    level.player endon("leg_damage");
    wait(var_01);
    setsaveddvar("bg_viewBobConstantAmplitude", 0);
  }
}

func_BE51() {
  if(func_2C94("arm_left")) {
    level.player scripts\engine\utility::allow_melee(1);
    level.player scripts\engine\utility::allow_ads(1);
    level.player scripts\engine\utility::allow_offhand_weapons(1);
    level.player scripts\sp\utility::func_1C72(1);
    level.player scripts\sp\utility::func_1C34(1);
    if(scripts\sp\utility::func_D0BD("grapplingdevice", 1)) {
      level.player _meth_8503("ges_grapple", "ges_grav_jump_combat_fail", level.var_10533, level.var_10532);
    }
  }
}

func_8DE3() {
  level.player endon("death");
  thread func_8DE0();
  thread func_8DE1();
  for(;;) {
    level.player waittill("smoke_pressed");
    if(!func_2C8B()) {
      continue;
    }

    level.var_10964.togglinghelmet = 1;
    if(bool_player_helmet_damaged_enough()) {
      func_F3FF(0);
    }

    var_00 = level.player getweaponammostock("helmet");
    level.player setweaponammostock("helmet", var_00 - 1);
    func_8E05();
    level.var_10964.togglinghelmet = undefined;
  }
}

func_8DE0() {
  func_137D2();
  func_F400(1);
}

func_8DE1() {
  level.player endon("death");
  for(;;) {
    var_00 = level.player.var_4B21;
    level.player waittill("secondary_equipment_change", var_01);
    if(var_01 == "helmet") {
      if(scripts\sp\utility::func_D0BD("grapplingdevice", 1) && !func_2C94("arm_left")) {
        level.player _meth_8507();
      }

      level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
      continue;
    }

    if(var_00 == "helmet") {
      if(scripts\sp\utility::func_D0BD("grapplingdevice", 0) && !func_2C94("arm_left")) {
        level.player _meth_8503("ges_grapple", "ges_grav_jump_combat_fail", level.var_10533, level.var_10532);
      }

      level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
    }
  }
}

func_8E01() {
  level.var_10964.var_BB4A = 1;
  func_F3FF(0);
}

func_4CE0(param_00, param_01) {
  var_02 = level.var_10964.var_2C19[param_00];
  var_03 = var_02.health - param_01 <= 30;
  if(self.var_BFAA && !var_03) {
    var_04 = var_02.health - param_01 - 30;
    param_01 = param_01 + var_04;
    func_F52C(level.player.health - var_04);
  }

  var_02.health = var_02.health - param_01;
  var_02.health = clamp(var_02.health, 0, var_02.maxhealth);
  if(func_2C95()) {
    level.var_10964 thread func_9151();
  }

  var_05 = var_02.health / var_02.maxhealth;
  self.var_98F1[param_00] notify("hud_flicker_stop");
  self.var_98F1[param_00].alpha_req = 1 - var_05;
}

func_BE52(param_00) {
  self.var_98F1[param_00.name] notify("hud_flicker_stop");
  self.var_98F1[param_00.name].alpha_req = 0;
  param_00.health = param_00.maxhealth;
}

func_4CFB(param_00, param_01, param_02) {
  level.player playrumbleonentity("grenade_rumble");
  if(param_01) {
    screenshake(level.player.origin, 50, 60, 10, 0.75);
    playworldsound("plr_helmet_glass_break", level.player getEye());
  }

  if(!isDefined(param_02)) {
    param_02 = level.player.origin + scripts\engine\utility::randomvector(500);
  }

  var_03 = scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, param_02, 0.866025);
  var_04 = level.player scripts\sp\math::func_9C86(param_02);
  if((var_03 && var_04) || !var_03 && !var_04) {
    var_05 = [-55, 100];
    var_06 = [30, 430];
  } else {
    var_05 = [500, 650];
    var_06 = [30, 400];
  }

  if(isDefined(level.var_10964.var_A99C)) {
    var_07 = var_06[1] - var_06[0] * 0.5;
    if(level.var_10964.var_A99C > var_07) {
      var_06[1] = var_06[1] - int(var_07);
    } else {
      var_06[0] = var_06[0] + int(var_07);
    }
  }

  var_08 = randomintrange(var_05[0], var_05[1]);
  var_09 = randomintrange(var_06[0], var_06[1]);
  level.var_10964.var_A99C = var_09;
  thread func_914F(var_08, var_09, param_00, !var_04);
}

func_914F(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(param_02) {
    var_05 = ["crack", "burn"];
  } else {
    var_05 = ["crack"];
  }

  var_06 = randomintrange(270, 350);
  foreach(var_08 in var_05) {
    var_04[var_08] = newclienthudelem(level.player);
    var_04[var_08] setshader("helmet_" + var_08 + "_0" + param_03, var_06, var_06);
    var_04[var_08].alignx = "center";
    var_04[var_08].aligny = "middle";
    var_04[var_08].x = param_00;
    var_04[var_08].y = param_01;
    var_04[var_08].sort = 2;
    var_04[var_08].foreground = 1;
  }

  level.var_10964.helmetimpacts[level.var_10964.helmetimpacts.size] = var_04;
  if(param_02) {
    var_04["burn"].alpha = 0.7;
    var_0A = 3;
    var_04["burn"] scripts\engine\utility::delaythread(0.5, ::scripts\sp\hud_util::func_6AAB, 0, var_0A - 0.5);
    var_04["burn"] thread func_9175(var_0A);
  }

  func_137D1();
  if(isDefined(level.var_10964.var_BB4A) && level.var_10964.var_BB4A) {
    level.var_10964 func_915F(var_04);
  }

  if(scripts\engine\utility::istrue(level.var_10964.jackalhelmetcrackfade)) {
    level.var_10964 hud_fade_cracks(var_04, var_05, 4);
    level.var_10964.jackalhelmetcrackfade = undefined;
  }

  var_04["crack"] destroy();
  if(param_02 && isDefined(var_04["burn"])) {
    var_04["burn"] destroy();
  }

  scripts\engine\utility::array_removeundefined(level.var_10964.helmetimpacts);
}

func_9147(param_00) {
  level.player playrumbleonentity("grenade_rumble");
  if(param_00) {
    screenshake(level.player.origin, 50, 60, 10, 0.75);
    playworldsound("plr_helmet_glass_break", level.player getEye());
  }

  var_01 = newclienthudelem(level.player);
  var_01.foreground = 1;
  var_01.alignx = "left";
  var_01.aligny = "top";
  var_01.horzalign = "fullscreen";
  var_01.vertalign = "fullscreen";
  var_01 setshader("helmet_broken", 640, 480);
  level.var_10964.helmetimpacts[level.var_10964.helmetimpacts.size]["crack"] = var_01;
  func_137D1();
  var_01 destroy();
}

func_4CE1() {
  func_F3FF(0);
  playworldsound("glass_pane_piece_break", level.player getEye());
  screenshake(level.player.origin, 70, 80, 40, 1);
  thread func_25E9("injury", "helmet");
  level.player specialist_allow_invulnerability(1);
  level.player scripts\engine\utility::allow_ads(0);
  playFX(level._effect["vfx_gun_sparks"], level.player getEye(), anglesToForward(level.player.angles), anglestoup(level.player.angles));
  if(isDefined(level.var_10964.helmet)) {
    level.var_10964.helmet hide();
  }

  thread func_4D17();
  wait(0.5);
  level.player scripts\engine\utility::allow_ads(1);
  wait(1);
  level.player specialist_allow_invulnerability(0);
}

func_4D17() {
  level endon("player_replacing_helmet");
  level.player endon("death");
  level.player endon("headshot_death");
  if(!level.player.var_8C0F) {
    level.player playSound("player_death_helmet_decomp");
  }

  for(;;) {
    if(level.player.var_8C0F) {
      wait(0.05);
      continue;
    }

    self.var_D430 = 1;
    if(!func_2C94("arm_left")) {
      level.player scripts\engine\utility::delaycall(0.2, ::playgestureviewmodel, "ges_neck_grab", undefined, 1, 0.3, 0.2, 0);
    }

    level.player shellshock("plane_sway", 12);
    level.player _meth_82C2("phstreets_building_hvt_breach", "reverb", "mix", "filter");
    level.player scripts\engine\utility::allow_reload(0);
    scripts\sp\utility::func_D020();
    thread func_25E9("injury", "oxygen");
    var_00 = gettime() + 12000;
    var_01 = 0;
    while(gettime() < var_00) {
      setblur(var_01, 0.05);
      if(func_2C95()) {
        self.var_D430 = 0;
        level.player stopgestureviewmodel("ges_neck_grab");
        level.player stopshellshock();
        level.player clearclienttriggeraudiozone(2);
        setblur(0, 1);
        level.player scripts\engine\utility::allow_reload(1);
        level.player scripts\engine\utility::delaythread(1.5, ::scripts\sp\utility::play_sound_on_entity, "breathing_better");
        scripts\engine\utility::delaythread(2, ::func_25E9, "repair", "oxygen");
        level notify("player_replacing_helmet");
        break;
      }

      var_01 = var_01 + 0.025;
      wait(0.05);
    }

    level.player _meth_80A1();
    level.player _meth_81D0();
    scripts\sp\utility::func_B8D1();
  }
}

hide_helmet_impacts() {
  if(!isDefined(level.var_10964.helmetimpacts)) {
    return;
  }

  foreach(var_01 in level.var_10964.helmetimpacts) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }

      var_03.old_alpha = var_03.alpha;
      var_03.alpha = 0;
    }
  }
}

show_helmet_impacts() {
  if(!isDefined(level.var_10964.helmetimpacts)) {
    return;
  }

  foreach(var_01 in level.var_10964.helmetimpacts) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }

      var_03.alpha = var_03.old_alpha;
      var_03.old_alpha = undefined;
    }
  }
}

func_8E05() {
  level.player notify("putting_on_helmet");
  if(!isDefined(level.var_10964.helmet)) {
    level.var_10964.helmet = spawn("script_model", level.player.origin);
    level.var_10964.helmet setModel("vm_hero_protagonist_helmet");
    level.var_10964.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
    level.var_10964.helmet notsolid();
  }

  level.player blendlinktoplayerviewmotion(0.25, 0);
  level.var_10964.helmet show();
  level.var_10964.helmet glinton(#animtree);
  level.var_10964.helmet clearanim( % vm_gesture_visor_up_visor, 0);
  level.var_10964.helmet give_attacker_kill_rewards( % vm_gesture_visor_down_visor);
  thread lib_0E4B::func_8DE2();
  level.player playSound("plr_helmet_visor_on");
  level.player scripts\engine\utility::delaycall(0.65, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
  level.player scripts\engine\utility::delaycall(1.4, ::playsound, "plr_helmet_oxygen_lr");
  level.player scripts\engine\utility::delaycall(2.8, ::playsound, "plr_helmet_short_boot_up_lr");
  level.player scripts\engine\utility::delaycall(3.15, ::clearclienttriggeraudiozone, 0.2);
  level.player forceplaygestureviewmodel("ges_visor_down", undefined, undefined, undefined, 1);
  wait(getanimlength( % vm_gesture_visor_down_visor));
  func_F3FF(1);
  level.var_10964.var_8E1B = 0;
  level.player blendlinktoplayerviewmotion(0.25, 1);
}

specialist_helmet_on_immediate() {
  level.var_10964.helmet = spawn("script_model", level.player.origin);
  level.var_10964.helmet setModel("vm_hero_protagonist_helmet");
  level.var_10964.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  level.var_10964.helmet notsolid();
  level.player blendlinktoplayerviewmotion(0.25, 0);
  func_F3FF(1);
}

func_4E1A(param_00) {
  if(!isalive(level.player)) {
    return;
  }

  level.player notify("headshot_death");
  if(scripts\sp\utility::func_93AB()) {
    level.player _meth_8591(1);
    updategamerprofile();
    scripts\sp\endmission::func_41ED();
  }

  level.player scripts\engine\utility::allow_usability(0);
  level.player freezecontrols(1);
  level.player stopsounds();
  scripts\sp\utility::func_D020();
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  level.player _meth_82C2("phstreets_building_hvt_breach", "reverb", "mix", "filter", "occlusion", "ambient", "ambient_events", "player_adsr", "weapon_reflection", "contexts", "full_occlusion");
  level.player playrumbleonentity("grenade_rumble");
  playFX(level.var_7649["human_gib_head"], level.player getEye(), anglesToForward(level.player.angles), anglestoleft(level.player.angles));
  playFX(level.var_7649["human_gib_fullbody"], level.player getEye() + (0, 0, 5));
  playworldsound("bullet_large_flesh_head_npc", level.player getEye());
  playworldsound("bullet_impact_headshot", level.player getEye());
  self.var_98F1["pristine"].foreground = 1;
  self.var_98F1["pristine"].alpha_req = 0.5;
  self.var_98F1["skull"].alpha_req = 0.5;
  screenshake(level.player.origin, 8, 2, 2, 6);
  soundfade(0, 7);
  setblur(3, 3);
  thread func_4E0F();
  var_01 = level.player getcurrentprimaryweapon();
  if(isDefined(var_01) && var_01 != "none" && var_01 != "iw7_fists_specialist_mode" && var_01 != "mars_killstreak") {
    thread func_86CB(1);
  }

  if(param_00) {
    level.player getradiuspathsighttestnodes();
    level.player _meth_80A1();
    level.player _meth_81D0();
    scripts\sp\utility::func_B8D1();
    return;
  }

  level.player playSound("plr_death_explosion");
  var_02 = scripts\engine\utility::spawn_tag_origin(level.player.origin, level.player.angles);
  level.player playerlinktoabsolute(var_02, "tag_origin");
  func_F52C(1);
  level.player specialist_allow_invulnerability(1);
  level.player _meth_84FE();
  level.player.ignoreme = 1;
  var_02 thread func_4E10();
}

func_4E10() {
  var_00 = level.player isonground();
  var_01 = level.player getstance();
  if(var_01 == "stand") {
    var_02 = -43;
  } else {
    var_02 = -30;
  }

  level.player takeweapon(level.player getcurrentprimaryweapon());
  var_03 = anglesToForward(level.player.angles) * -30;
  self rotatepitch(-20, 0.25);
  if(var_01 == "crouch") {
    self moveto(self.origin + (0, 0, 15) + anglesToForward(level.player.angles) * -10, 0.35);
  } else if(var_01 == "stand") {
    self moveto(self.origin + (0, 0, 25) + anglesToForward(level.player.angles) * -10, 0.35);
  }

  wait(0.35);
  level.player getradiuspathsighttestnodes();
  wait(0.65);
  self rotatepitch(-5, 0.25);
  if(var_01 == "prone" || !var_00 || scripts\sp\utility::func_93AC()) {
    wait(4);
    level.player _meth_80A1();
    level.player _meth_81D0();
    scripts\sp\utility::func_B8D1();
    return;
  }

  self moveto(self.origin + (0, 0, var_02) + var_03 / 15, 0.5);
  wait(0.5);
  level.player playrumbleonentity("grenade_rumble");
  wait(0.5);
  self rotatepitch(10, 0.5, 0.5);
  wait(0.5);
  var_04 = 0.45;
  self rotatepitch(92, var_04);
  var_05 = self.origin + var_03 + (0, 0, 11);
  level.player playSound("player_death_fall_back");
  self moveto(var_05, var_04, 0, var_04);
  wait(var_04);
  earthquake(0.75, 0.75, level.player.origin, 200);
  level.player playrumbleonentity("grenade_rumble");
  playFX(level._effect["deathfx_bloodpool_generic"], level.player getEye() + (0, 0, -25) + anglesToForward(level.player.angles) * -4);
  wait(4);
  level.player _meth_80A1();
  level.player _meth_81D0();
  scripts\sp\utility::func_B8D1();
}

func_4E0F() {
  for(var_00 = 0; var_00 < 4; var_00++) {
    wait(randomfloatrange(0.05, 0.25));
    playFX(level.var_7649["human_gib_head"], level.player getEye() + (0, 0, 5));
  }
}

func_4E1B() {
  var_00 = level.player scripts\engine\utility::waittill_any_return("death", "headshot_death");
  level waittill("do_death_hint");
  var_01 = 204;
  var_02 = var_01 + 6;
  var_03 = var_02 + 11;
  var_04 = var_03 + 6;
  var_05 = 0.25;
  var_06 = 0.05;
  var_01 = randomintrange(var_01, var_02);
  var_07 = 0;
  var_08 = randomfloat(1);
  if(var_08 <= var_06) {
    var_07 = 1;
    var_01 = randomintrange(var_03, var_04);
    var_09 = 0;
    while(getomnvar("ui_death_hint") == var_01) {
      var_01 = randomintrange(var_03, var_04);
      var_09++;
      if(var_09 % 20) {
        wait(0.05);
      }
    }
  } else if(var_08 <= var_05) {
    var_01 = randomintrange(var_02, var_03);
    var_09 = 0;
    while(getomnvar("ui_death_hint") == var_01) {
      var_01 = randomintrange(var_02, var_03);
      var_09++;
      if(var_09 % 20) {
        wait(0.05);
      }
    }
  }

  if(scripts\sp\utility::func_93AB()) {
    var_01 = 230;
  } else if(!func_2C97()) {
    if(func_2C96("nanoshot", 0, 1)) {
      var_01 = 200;
    }

    if(randomint(100) < 40) {
      if(var_00 == "headshot_death" && !func_2C96("helmet", 0, 1)) {
        var_01 = 203;
      }

      if(var_00 == "headshot_death" && func_2C96("helmet", 0, 1)) {
        var_01 = 201;
      }

      if(var_00 == "headshot_death" && var_07) {
        var_01 = 226;
      }
    }

    if(level.var_10964.var_D430) {
      if(func_2C96("helmet", 0, 1)) {
        var_01 = 202;
      } else {
        var_01 = 208;
      }
    }

    if(level.script == "europa" && var_07 && randomint(100) < 20) {
      var_01 = 228;
    } else if(level.script == "yard" && var_07 && randomint(100) < 20) {
      var_01 = 229;
    }
  }

  setomnvar("ui_death_hint", var_01);
}

func_12AAF() {
  thread func_12AAC();
  thread func_12AAD();
  thread func_12AAB();
  thread func_12AB2();
  thread func_12AAA();
  if(func_2C91()) {
    thread func_12AB1();
  }
}

func_12AAC() {
  level.player endon("headshot_death");
  level.player endon("death");
  var_00 = 4;
  for(;;) {
    var_01 = level.player scripts\engine\utility::waittill_any_return("frag_pressed", "smoke_pressed", "actionslot_weapon_pressed");
    if(!isDefined(level.player.var_1586) && var_01 == "actionslot_weapon_pressed") {
      continue;
    }

    if(func_2C97()) {
      continue;
    }

    if(!func_2C94("arm_left")) {
      continue;
    }

    var_02 = scripts\sp\utility::func_7BD6();
    if(isDefined(var_02) && var_02 == "nanoshot" && var_01 == "frag_pressed") {
      continue;
    }

    level.var_10964.var_58DE = 1;
    thread scripts\sp\utility::func_56BE("left_arm_tutorial_hint_equipment", var_00);
    wait(var_00);
    level.var_10964.var_58DE = 0;
    level.var_10964 notify("tutorial_over");
  }
}

func_12AAD() {
  level.player endon("headshot_death");
  level.player endon("death");
  var_00 = 4;
  for(;;) {
    level.player waittill("melee_pressed");
    if(func_2C97()) {
      continue;
    }

    if(!func_2C94("arm_left")) {
      continue;
    }

    if(isDefined(level.player.inrodeo) && level.player.inrodeo) {
      continue;
    }

    level.var_10964.var_58DE = 1;
    thread scripts\sp\utility::func_56BE("left_arm_tutorial_hint_melee", var_00);
    wait(var_00);
    level.var_10964.var_58DE = 0;
    level.var_10964 notify("tutorial_over");
  }
}

func_12AAB() {
  level.player endon("headshot_death");
  level.player endon("death");
  var_00 = 4;
  for(;;) {
    level.player waittill("smoke_pressed");
    if(func_2C97()) {
      continue;
    }

    if(func_2C94("arm_left")) {
      continue;
    }

    if(!func_2C95()) {
      continue;
    }

    var_01 = scripts\sp\utility::func_7C3D();
    if(!isDefined(var_01)) {
      continue;
    }

    if(var_01 != "helmet") {
      continue;
    }

    if(!level.player getweaponammostock(var_01)) {
      continue;
    }

    if(level.var_10964.var_8E1B > 0) {
      continue;
    }

    level.var_10964.var_58DE = 1;
    thread scripts\sp\utility::func_56BE("helmet_already_on_tutorial_hint", var_00);
    wait(var_00);
    level.var_10964.var_58DE = 0;
    level.var_10964 notify("tutorial_over");
  }
}

func_12AB2() {
  level.player endon("headshot_death");
  level.player endon("death");
  var_00 = 4;
  for(;;) {
    level.player waittill("frag_pressed");
    if(level.player func_8448()) {
      continue;
    }

    if(!func_2C99()) {
      continue;
    }

    var_01 = scripts\sp\utility::func_7BD6();
    if(!isDefined(var_01)) {
      continue;
    }

    if(var_01 != "nanoshot") {
      continue;
    }

    if(!level.player getweaponammostock(var_01)) {
      continue;
    }

    level.var_10964.var_58DE = 1;
    thread scripts\sp\utility::func_56BE("nanoshot_tutorial_hint_at_max_health", var_00);
    wait(var_00);
    level.var_10964.var_58DE = 0;
    level.var_10964 notify("tutorial_over");
  }
}

func_12AB1() {
  level.player endon("death");
  level.player endon("headshot_death");
  for(;;) {
    wait(0.05);
    func_137F1();
    func_1381A();
    if(func_2C97()) {
      continue;
    }

    if(!func_2C98()) {
      continue;
    }

    if(!func_2C96("nanoshot", 0, 0)) {
      continue;
    }

    if(func_2C96("nanoshot", 0, 1) && !scripts\sp\utility::func_D0BD("nanoshot", 0)) {
      level.player lib_0B2A::func_1418();
    }

    if(isDefined(level.player.inrodeo) && level.player.inrodeo) {
      continue;
    }

    level.player specialist_allow_invulnerability(1);
    var_00 = 1.5;
    level.var_10964.var_58DE = 1;
    thread scripts\sp\utility::func_56BE("nanoshot_tutorial_hint", var_00);
    level.player scripts\engine\utility::waittill_notify_or_timeout("frag_pressed", var_00);
    settimescale(1);
    wait(2);
    level.player specialist_allow_invulnerability(0);
    level.var_10964.var_58DE = 0;
    level.var_10964 notify("tutorial_over");
    break;
  }
}

func_12AAA() {
  level.player endon("death");
  level.player endon("headshot_death");
  var_00 = 0;
  func_137D2();
  for(;;) {
    wait(0.05);
    func_137D1();
    func_1381A();
    if(!isDefined(level.var_10964.allowhints)) {
      continue;
    }

    if(func_2C97()) {
      continue;
    }

    if(func_2C95()) {
      continue;
    }

    if(isDefined(level.var_10964.togglinghelmet) && level.var_10964.togglinghelmet) {
      continue;
    }

    if(func_2C94("arm_left")) {
      continue;
    }

    if(isDefined(level.player.inrodeo) && level.player.inrodeo) {
      continue;
    }

    if(func_2C96("helmet", 1, 1)) {
      var_01 = "helmet_tutorial_hint";
    } else if(func_2C96("helmet", 0, 1)) {
      var_01 = "helmet_equip";
    } else {
      var_01 = "helmet_find";
    }

    var_02 = 0;
    if(func_2C91() && func_2C96("helmet", 0, 1) && !var_00) {
      if(!scripts\sp\utility::func_D0BD("helmet", 0)) {
        level.player lib_0B2A::func_1419();
      }

      var_01 = "helmet_tutorial_hint";
      level.player specialist_allow_invulnerability(1);
      var_02 = 1;
      var_03 = 1.5;
    } else {
      var_03 = 4;
    }

    level.var_10964.var_58DE = 1;
    thread scripts\sp\utility::func_56BE(var_01, var_03);
    level.player scripts\engine\utility::waittill_notify_or_timeout("smoke_pressed", var_03);
    settimescale(1);
    wait(2);
    if(var_02) {
      level.player specialist_allow_invulnerability(0);
    }

    level.var_10964.var_58DE = 0;
    level.var_10964 notify("tutorial_over");
    if(func_2C91()) {
      var_00 = 1;
      continue;
    }

    func_137D2();
  }
}

tutorial_loadout() {
  level.player scripts\engine\utility::allow_usability(0);
  wait(0.25);
  setslowmotion(1, 0.2, 0.5);
  var_00 = 1.2;
  scripts\sp\utility::func_56BE("specialist_loadout", var_00);
  wait(var_00);
  setslowmotion(0.2, 1, 2);
  level.player scripts\engine\utility::allow_usability(1);
}

func_25E9(param_00, param_01, param_02) {
  level.var_10964.var_2610 scripts\sp\utility::func_74D7(::audio_request_suit_vo_internal, param_00, param_01, param_02);
}

audio_request_suit_vo_internal(param_00, param_01, param_02) {
  if(isDefined(param_00) && param_00 == "nag") {
    if(isDefined(param_01) && param_01 == "helmet") {
      if(!level.var_10964.var_8E1B) {
        return;
      }

      if(isDefined(level.var_10964.togglinghelmet)) {
        return;
      }
    }

    if(isDefined(param_01) && param_01 == "nano" || param_01 == "status") {
      if(!func_2C98()) {
        return;
      }
    }
  } else {
    wait(0.7);
  }

  if(isDefined(param_00) && param_00 == "injury") {
    if(isDefined(param_01)) {
      if(!level.var_10964 ispartinjured(param_01)) {
        return;
      }
    }
  } else if(isDefined(param_00) && param_00 == "repair") {
    if(isDefined(param_01) && param_01 == "status") {
      var_03 = ["legs", "arms", "chest"];
      foreach(var_05 in var_03) {
        if(level.var_10964 ispartinjured(var_05)) {
          return;
        }
      }
    }
  }

  if(level.var_10964.var_10B3B > 1) {
    return;
  }

  level.var_10964.var_10B3B++;
  while(level.var_10964.var_111BE) {
    wait(0.05);
  }

  level.var_10964.var_111BE = 1;
  if(isDefined(param_02)) {
    level.var_10964.var_2610 playSound("specialist_mode_" + param_00 + "_" + param_01 + "_" + param_02, "vo_over");
  } else {
    level.var_10964.var_2610 playSound("specialist_mode_" + param_00 + "_" + param_01, "vo_over");
  }

  level.var_10964.var_2610 waittill("vo_over");
  level.var_10964.var_111BE = 0;
  level.var_10964.var_10B3B--;
}

ispartinjured(param_00) {
  switch (param_00) {
    case "legs":
    case "leg":
      return self.var_2C19["leg_left"].health != self.var_2C19["leg_left"].maxhealth || self.var_2C19["leg_right"].health != self.var_2C19["leg_right"].maxhealth;

    case "arms":
    case "arm":
      return self.var_2C19["arm_left"].health != self.var_2C19["arm_left"].maxhealth || self.var_2C19["arm_right"].health != self.var_2C19["arm_right"].maxhealth;

    case "chest":
      return self.var_2C19["chest"].health != self.var_2C19["chest"].maxhealth;

    case "oxygen":
      return scripts\engine\utility::istrue(self.var_D430);

    case "helmet":
      return scripts\engine\utility::istrue(level.var_10964.var_8E1B);

    default:
      return 0;
  }
}

func_25FD() {
  level.player endon("death");
  level.player endon("headshot_death");
  func_137D2();
  thread func_2608();
  for(;;) {
    wait(0.05);
    if(func_2C97()) {
      continue;
    }

    var_00 = length(level.player getvelocity());
    if(func_2C90() && var_00 > 0) {
      continue;
    }

    if(func_2C98()) {
      level.var_10964.var_2610 func_25E1(var_00);
    }
  }
}

func_2608() {
  level.player endon("death");
  level.player endon("headshot_death");
  for(;;) {
    wait(0.05);
    if(func_2C97()) {
      continue;
    }

    if(!func_2C95()) {
      if(level.var_10964.var_D430) {
        thread func_25E9("injury", "oxygen");
      } else {
        thread func_25E9("nag", "helmet");
        if(!func_2C96("helmet", 0, 0)) {
          wait(13);
        }
      }

      wait(13);
      continue;
    }

    if(func_2C98()) {
      if(func_2C96("nanoshot", 0, 1)) {
        thread func_25E9("nag", "nano");
      } else {
        thread func_25E9("nag", "status");
        wait(13);
      }

      wait(13);
    }
  }
}

func_25E1(param_00) {
  var_01 = func_25E2(param_00);
  var_02 = func_25FE(var_01);
  var_03 = randomint(100);
  if(var_01 == "sprint" || var_03 > 75) {
    var_04 = "breathing_limp";
  } else if(var_02 == "run" || var_04 > 50) {
    var_04 = "breathing_limp_better";
  } else if(var_02 == "walk" || var_04 > 25) {
    var_04 = "breathing_hurt";
  } else {
    var_04 = "breathing_hurt_alt";
  }

  if(randomint(100) > 50) {
    self playSound(var_04);
    func_25BD(var_02);
    return;
  }

  func_25BD(var_02);
  self playSound(var_04);
}

func_25BD(param_00) {
  wait(param_00 * 0.5);
  level.player playrumbleonentity("damage_light");
  if(randomint(100) > 50) {
    self playSound("breathing_heartbeat_fade1");
  } else {
    self playSound("breathing_heartbeat_fade2");
  }

  wait(param_00 * 0.5);
}

func_25E2(param_00) {
  if(level.player issprinting()) {
    return "sprint";
  }

  if(param_00 <= 0.1) {
    return "idle";
  }

  if(param_00 <= 0.5) {
    return "walk";
  }

  return "run";
}

func_25FE(param_00) {
  switch (param_00) {
    case "idle":
      return randomfloatrange(3.5, 4.5);

    case "walk":
      return randomfloatrange(2.5, 3.5);

    case "run":
      return randomfloatrange(1.5, 2.5);

    case "sprint":
      return randomfloatrange(0.75, 1.5);
  }
}

func_25E3() {
  level.player endon("death");
  level.player endon("headshot_death");
  if(!self.var_D467) {
    self.var_D467 = 1;
    scripts\sp\utility::func_D020();
    if(scripts\engine\utility::cointoss()) {
      var_00 = "plr_death_generic";
    } else {
      var_00 = "plr_death_explosion";
    }

    level.player playSound(var_00, "player_done_yelling");
    level.player waittill("player_done_yelling");
    self.var_D467 = 0;
  }
}

func_9150(param_00) {
  level.var_10964.var_98F1 = [];
  param_00[param_00.size] = "pristine";
  param_00[param_00.size] = "skull";
  foreach(var_02 in param_00) {
    var_03 = newhudelem();
    var_03.x = 15;
    var_03.y = -40;
    var_03.width = 70;
    var_03.height = 135;
    var_03.alignx = "left";
    var_03.aligny = "bottom";
    var_03.horzalign = "left";
    var_03.vertalign = "bottom";
    var_03.sort = 1;
    var_03.alpha_req = 1;
    var_03.hidewheninmenu = 1;
    var_03 setshader("hud_injury_" + var_02, var_03.width, var_03.height);
    if(var_02 != "pristine") {
      var_03.alpha_req = 0;
      var_03.alpha = 0;
      var_03.foreground = 1;
    }

    level.var_10964.var_98F1[var_02] = var_03;
  }

  thread hud_thread();
}

hudcanshow() {
  if(!level.player _meth_843C()) {
    return 0;
  }

  var_00 = level.player getcurrentweapon();
  if(var_00 == "none" || var_00 == "iw7_gunless") {
    return 0;
  }

  if(getomnvar("ui_hide_hud")) {
    return 0;
  }

  if(!isalive(level.player)) {
    return 0;
  }

  if(scripts\sp\utility::func_7B8C() == "safe") {
    return 0;
  }

  return 1;
}

usingspecialequipment() {
  if(level.var_10964.hidehelmetimpacts) {
    return 1;
  }

  var_00 = ["transitiontorobot", "controllingrobot", "selfdestruct"];
  var_01 = lib_0E29::func_87A7();
  foreach(var_03 in var_00) {
    if(var_01 == var_03) {
      return 1;
    }
  }

  return 0;
}

hud_thread() {
  level endon("stop_updating_specialist_hud");
  for(;;) {
    var_00 = usingspecialequipment();
    if(hudcanshow() && !var_00) {
      foreach(var_02 in level.var_10964.var_98F1) {
        var_02 fadeovertime(0.3);
        if(var_02.alpha != var_02.alpha_req) {
          var_02.alpha = var_02.alpha_req;
        }
      }
    } else {
      foreach(var_02 in level.var_10964.var_98F1) {
        var_02 fadeovertime(0.3);
        if(var_02.alpha != 0) {
          var_02.alpha = 0;
        }
      }
    }

    if(!var_00) {
      foreach(var_07 in level.var_10964.helmetimpacts) {
        foreach(var_02 in var_07) {
          if(!isDefined(var_02)) {
            continue;
          }

          if(isDefined(var_02.og_y)) {
            var_02.y = var_02.og_y;
            var_02.og_y = undefined;
          }
        }
      }
    } else {
      foreach(var_07 in level.var_10964.helmetimpacts) {
        foreach(var_02 in var_07) {
          if(!isDefined(var_02)) {
            continue;
          }

          if(isDefined(var_02.og_y)) {
            continue;
          }

          var_02.og_y = var_02.y;
          var_02.y = var_02.y - 5000;
        }
      }
    }

    wait(0.05);
  }
}

destroyhelmetimpacts() {
  level notify("stop_updating_specialist_hud");
  foreach(var_01 in level.var_10964.helmetimpacts) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }

      var_03 destroy();
    }
  }
}

func_9160(param_00, param_01) {
  if(!isDefined(level.var_10964.var_98F1)) {
    return;
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  foreach(var_03 in level.var_10964.var_98F1) {
    if(param_00) {
      var_03.x = 15;
      continue;
    }

    var_03.x = -985;
  }
}

func_9151() {
  level notify("kill_injury_hud_scanner");
  level endon("kill_injury_hud_scanner");
  if(isDefined(self.var_914B)) {
    self.var_914B destroy();
  }

  var_00 = scripts\sp\hud_util::createicon("hud_injury_scanner", 70, 20);
  var_00.x = 15;
  var_00.y = self.var_98F1["pristine"].y - self.var_98F1["pristine"].height + var_00.height;
  var_00.alignx = "left";
  var_00.aligny = "bottom";
  var_00.horzalign = "left";
  var_00.vertalign = "bottom";
  var_00.sort = 1;
  var_00.foreground = 1;
  var_00.alpha_req = 0;
  self.var_914B = var_00;
  self.var_914B thread scripts\sp\hud_util::func_6AAB(0.7, 0.25);
  while(self.var_914B.y < self.var_98F1["pristine"].y - 10) {
    wait(0.05);
    self.var_914B.y = self.var_914B.y + 7;
  }

  self.var_914B thread scripts\sp\hud_util::func_6AAB(0, 0.25);
}

func_9146() {
  if(isDefined(self.var_914B)) {
    level notify("kill_injury_hud_scanner");
    self.var_914B destroy();
  }

  self.var_8E12 = 1;
  foreach(var_01 in self.var_98F1) {
    var_01 thread func_9144(3);
  }

  for(var_03 = 0; var_03 < 3; var_03++) {
    setomnvar("ui_hide_hud", 1);
    wait(randomfloatrange(0.05, 0.15));
    setomnvar("ui_hide_hud", 0);
    wait(randomfloatrange(0.15, 0.25));
  }

  wait(3);
  self.var_8E12 = 0;
}

func_9144(param_00, param_01) {
  self endon("death");
  self endon("hud_flicker_stop");
  self.var_8E12 = 1;
  var_02 = self.alpha_req;
  self.alpha_req = 0;
  for(var_03 = 0; var_03 < param_00; var_03++) {
    wait(randomfloatrange(0.05, 0.1));
    self.alpha_req = randomfloatrange(0.25, 0.75);
    wait(randomfloatrange(0.1, 0.15));
    self.alpha_req = 0;
  }

  wait(randomfloatrange(0.05, 0.15));
  if(isDefined(param_01) && param_01) {
    self.alpha_req = 1;
  } else {
    self.alpha_req = var_02;
  }

  self.var_8E12 = 0;
}

hud_fade_cracks(param_00, param_01, param_02) {
  foreach(var_04 in param_01) {
    if(!isDefined(param_00[var_04])) {
      continue;
    }

    param_00[var_04] fadeovertime(param_02);
    param_00[var_04].alpha = 0;
  }

  wait(param_02);
}

func_915F(param_00) {
  var_01 = param_00["crack"].x + 80;
  param_00["crack"] moveovertime(0.1);
  param_00["crack"].x = var_01;
  if(isDefined(param_00["burn"])) {
    param_00["burn"] moveovertime(0.1);
    param_00["burn"].x = var_01;
  }

  wait(0.35);
  var_02 = -200;
  param_00["crack"] moveovertime(0.2);
  param_00["crack"].y = var_02;
  if(isDefined(param_00["burn"])) {
    param_00["burn"] moveovertime(0.2);
    param_00["burn"].y = var_02;
  }

  wait(0.25);
  self.var_BB4A = 0;
}

func_9175(param_00) {
  level.player endon("death");
  self endon("death");
  var_01 = gettime() + param_00 * 1000;
  var_02 = param_00 / 0.05;
  var_03 = -1 / var_02;
  while(gettime() < var_01) {
    var_04 = self.color[0];
    var_05 = self.color[1];
    var_06 = self.color[2];
    self.color = (var_04 + var_03, var_05 + var_03, var_06 + var_03);
    wait(0.05);
  }

  self destroy();
  scripts\engine\utility::array_removeundefined(level.var_10964.helmetimpacts);
}

func_2296(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_10964.var_2C19) {
    if(param_00) {
      if(func_2C94(var_03.name)) {
        var_01 = scripts\engine\utility::array_add_safe(var_01, var_03);
      }

      continue;
    }

    if(var_03.health < var_03.maxhealth) {
      var_01 = scripts\engine\utility::array_add_safe(var_01, var_03);
    }
  }

  return var_01;
}

func_2683() {
  scripts\sp\utility::func_266B("specialist_mode", undefined, undefined, scripts\sp\utility::func_93AB());
}

func_2C87() {
  if(!func_2C96("nanoshot", 1, 1)) {
    return 0;
  }

  if(func_2C97()) {
    return 0;
  }

  var_00 = level.player getweaponammostock("nanoshot");
  if(!isDefined(var_00)) {
    return 0;
  }

  if(isDefined(var_00) && var_00 <= 0) {
    return 0;
  }

  return 1;
}

func_2C88() {
  if(level.player isgestureplaying()) {
    return 0;
  }

  if(func_2C97()) {
    return 0;
  }

  if(level.var_10964.var_4C97) {
    return 0;
  }

  if(level.player isthrowinggrenade()) {
    return 0;
  }

  if(level.player fragbuttonpressed()) {
    return 0;
  }

  if(level.player islinked()) {
    return 0;
  }

  if(!level.player _meth_843C()) {
    return 0;
  }

  if(isDefined(level.player.inrodeo) && level.player.inrodeo) {
    return 0;
  }

  return 1;
}

func_2C89() {
  if(level.player.disabledreload > 1) {
    return 0;
  }

  if(self.var_4C97) {
    return 0;
  }

  if(func_2C97()) {
    return 0;
  }

  var_00 = level.player getcurrentprimaryweapon();
  var_01 = weaponclipsize(var_00);
  var_02 = level.player getcurrentweaponclipammo();
  if(var_02 >= var_01) {
    return 0;
  }

  var_03 = level.player getweaponammostock(var_00);
  if(var_03 <= 0) {
    return 0;
  }

  return 1;
}

func_2C8A() {
  if(self.var_BF7E >= gettime()) {
    return 0;
  }

  if(self.var_86F4 <= 0) {
    return 0;
  }

  if(func_2C94("arm_left")) {
    return 0;
  }

  if(!isalive(level.player)) {
    return 0;
  }

  if(scripts\sp\utility::func_93AC()) {
    return 0;
  }

  if(level.player issprinting()) {
    return 0;
  }

  if(level.player isthrowinggrenade()) {
    return 0;
  }

  if(level.player func_8448()) {
    return 0;
  }

  if(level.player ismeleeing()) {
    return 0;
  }

  if(level.player islinked()) {
    return 0;
  }

  if(level.player.var_C337.var_19) {
    return 0;
  }

  var_00 = lib_0E29::func_87A7();
  if(var_00 != "none") {
    return 0;
  }

  if(getomnvar("ui_jackal_call_down_active") > 0) {
    return 0;
  }

  if(getomnvar("ui_c12_active") > 0) {
    return 0;
  }

  if(scripts\engine\utility::flag_exist("player_in_mars_killstreak") && scripts\engine\utility::flag("player_in_mars_killstreak")) {
    return 0;
  }

  var_01 = level.player getEye();
  var_02 = anglesToForward(level.player.angles);
  if(!scripts\common\trace::ray_trace_passed(var_01, var_01 + var_02 * 40, level.player)) {
    return 0;
  }

  var_03 = level.player getcurrentweapon();
  if(var_03 == "none") {
    return 0;
  }

  if(issubstr(var_03, "steeldragon")) {
    return 0;
  }

  if(issubstr(var_03, "fist")) {
    return 0;
  }

  if(issubstr(var_03, "gunless")) {
    return 0;
  }

  if(issubstr(var_03, "knife")) {
    return 0;
  }

  return 1;
}

func_2C8B() {
  if(!func_2C8E()) {
    return 0;
  }

  if(func_2C95() && !bool_player_helmet_damaged_enough()) {
    return 0;
  }

  if(!func_2C96("helmet", 1, 1)) {
    return 0;
  }

  if(!isalive(level.player)) {
    return 0;
  }

  if(level.player isthrowinggrenade()) {
    return 0;
  }

  if(level.player func_8448()) {
    return 0;
  }

  if(level.player ismeleeing()) {
    return 0;
  }

  if(level.player islinked()) {
    return 0;
  }

  if(!level.player _meth_843C()) {
    return 0;
  }

  if(!level.player scripts\engine\utility::isoffhandweaponsallowed()) {
    return 0;
  }

  if(func_2C97()) {
    return 0;
  }

  return 1;
}

func_2C8C() {
  if(lib_0E29::func_87A7() != "none") {
    return 0;
  }

  if(func_2C97()) {
    return 0;
  }

  if(getomnvar("ui_jackal_call_down_active") > 0) {
    return 0;
  }

  if(getomnvar("ui_c12_active") > 0) {
    return 0;
  }

  if(scripts\engine\utility::flag_exist("player_in_mars_killstreak") && scripts\engine\utility::flag("player_in_mars_killstreak")) {
    return 0;
  }

  return 1;
}

func_2C8D() {
  return level.var_10964.var_1BFC;
}

func_2C8E() {
  return level.var_10964.var_8E1F;
}

func_2C8F() {
  return level.script == "phspace" || level.script == "moonjackal" || issubstr(level.script, "ja_");
}

func_2C90() {
  return func_2C94("leg_left") || func_2C94("leg_right");
}

func_2C92() {
  return issubstr(level.script, "sa_") && isDefined(level.var_10533) && isDefined(level.var_10532);
}

func_2C91() {
  return level.script == "europa" || level.script == "phparade" || level.script == "phstreets" || level.script == "phspace";
}

func_2C93() {
  if(func_2C8F() || level.script == "heist" || level.script == "sa_wounded" || level.script == "sa_empambush") {
    return 1;
  }

  return 0;
}

func_2C94(param_00) {
  return func_993F(param_00) <= 30;
}

func_2C95() {
  return level.var_10964.var_8E16;
}

bool_player_helmet_damaged_enough() {
  if(level.var_10964.var_8E1B > 0) {
    return 1;
  }

  return 0;
}

func_2C96(param_00, param_01, param_02) {
  if(!scripts\sp\utility::func_D0BD(param_00, 1)) {
    return 0;
  }

  if(param_01 && !scripts\sp\utility::func_D0BD(param_00, 0)) {
    return 0;
  }

  if(param_02 && !scripts\sp\utility::func_799C(param_00)) {
    return 0;
  }

  return 1;
}

func_2C97() {
  return level.var_10964.var_98EC;
}

halt_specialist_hints() {
  if(isDefined(level.var_10964)) {
    level.var_10964.allowhints = undefined;
  }
}

continue_specialist_hints() {
  if(isDefined(level.var_10964)) {
    level.var_10964.allowhints = 1;
  }
}

func_2C98() {
  return level.player.health <= level.player.maxhealth * 0.4;
}

func_2C99() {
  var_00 = level.player scripts\sp\utility::func_7BD6();
  if(func_2C97()) {
    return 0;
  }

  if(!isDefined(var_00)) {
    return 0;
  }

  if(var_00 != "nanoshot") {
    return 0;
  }

  if(level.player.health != level.player.maxhealth) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.player.disable_nanoshot_hint)) {
    return 0;
  }

  return 1;
}

func_993F(param_00) {
  return level.var_10964.var_2C19[param_00].health;
}

func_F2A6(param_00) {
  level.var_10964.var_1BFC = param_00;
}

func_F2D2(param_00) {
  level.var_10964.var_2687 = param_00;
}

func_F3FF(param_00) {
  level.var_10964.var_8E16 = param_00;
  if(param_00) {
    level.var_10964 notify("helmet_on");
    setomnvar("ui_helmet_state", 1);
  } else {
    level.var_10964 notify("helmet_off");
    setomnvar("ui_helmet_state", 0);
  }

  func_9160(param_00);
}

func_F400(param_00) {
  level.var_10964.var_8E1F = param_00;
}

func_F49E(param_00, param_01) {
  level.player endon("damage");
  if(isDefined(param_01)) {
    wait(param_01);
  }

  level.var_10964.var_BFAA = param_00;
}

func_F52C(param_00) {
  param_00 = clamp(param_00, 1, level.player.maxhealth);
  level.player setnormalhealth(param_00 / level.player.maxhealth);
}

func_F52F(param_00) {
  if(!isDefined(level.var_10964.helmet)) {
    return;
  }

  if(param_00) {
    level.var_10964.helmet show();
    return;
  }

  level.var_10964.helmet hide();
}

func_F530(param_00) {
  level.var_10964.var_98EC = param_00;
  func_F53C(param_00);
  level.var_10964.jackalhelmetcrackfade = param_00;
  func_F3FF(!param_00);
  if(param_00) {
    level.var_10964 notify("in_jackal");
    return;
  }

  level.var_10964 notify("out_of_jackal");
}

func_F531(param_00) {
  level.player specialist_allow_invulnerability(1);
  wait(param_00);
  level.player specialist_allow_invulnerability(0);
}

specialist_allow_invulnerability(param_00) {
  if(!isDefined(level.var_10964.allowinvulnerability)) {
    level.var_10964.allowinvulnerability = 0;
  }

  if(param_00) {
    level.var_10964.allowinvulnerability++;
    self getrankinfoxpamt();
    return;
  }

  level.var_10964.allowinvulnerability--;
  if(level.var_10964.allowinvulnerability == 0) {
    self _meth_80A1();
  }
}

func_F53C(param_00) {
  level.player.var_8C0F = param_00;
}

func_1381A() {
  if(!level.var_10964.var_58DE) {
    return;
  }

  level.var_10964 waittill("tutorial_over");
}

func_137D1() {
  if(!func_2C95()) {
    return;
  }

  level.var_10964 waittill("helmet_off");
}

func_137D2() {
  if(func_2C95()) {
    return;
  }

  level.var_10964 waittill("helmet_on");
}

func_137D3() {
  if(func_2C97()) {
    return;
  }

  level.var_10964 waittill("in_jackal");
}

func_137E4() {
  if(!func_2C97()) {
    return;
  }

  level.var_10964 waittill("out_of_jackal");
}

func_137D0() {
  if(!func_2C98()) {
    return;
  }

  level.player waittill("nanoshot_healing");
}

func_137F1() {
  while(!func_2C98()) {
    wait(0.05);
  }
}

spawn_nanoshot() {
  if(level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity")) {
    return 0;
  }

  if(isDefined(level.last_nanoshot_drop) && gettime() - level.last_nanoshot_drop < 5000) {
    return 0;
  }

  if(randomint(100) > 10) {
    return 0;
  }

  level.last_nanoshot_drop = gettime();
  var_00 = vectornormalize(level.player.origin - self.origin);
  var_00 = scripts\engine\utility::flatten_vector(var_00);
  var_01 = anglesToForward((randomintrange(-90, -75), 0, 0));
  var_02 = var_00 + var_01;
  var_03 = self gettagorigin("j_head") + (0, 0, 10);
  var_04 = spawn("weapon_nanoshot", var_03);
  var_04 setModel("equipment_mp_nanoshot_wm");
  var_04 scripts\sp\utility::func_9196(3, 1, 1, "new_weapon");
  var_04 thread nanoshot_pickup();
  var_04 thread lib_0B77::add_to_grenade_cache("axis");
  var_04 physicslaunchserveritem(var_04.origin, var_02 * randomintrange(100, 200));
  return 1;
}

nanoshot_pickup() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(self);
  self.var_9027 = var_00;
  var_00 lib_0E46::func_48C4(undefined, undefined, &"EQUIPMENT_PICKUP_NANOSHOT", 40, 300, undefined, undefined, undefined, 0, &"hud_interaction_prompt_center_equipment");
  var_00 makeunusable();
  if(!scripts\sp\utility::func_D0BD("nanoshot", 1)) {
    var_00 makeusable();
  }

  nanoshot_waittill_trigger_or_delete(var_00);
  var_00 delete();
  if(!isDefined(self)) {
    return;
  }

  var_01 = 0;
  if(level.player.var_110BD == "") {
    var_01 = 1;
  }

  var_02 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7BD6());
  var_03 = scripts\sp\utility::func_7BD7();
  level.player giveweapon("nanoshot");
  level.player setweaponammostock("nanoshot", 1);
  self delete();
  if(var_01) {
    return;
  }

  if(var_03 <= 0) {
    return;
  }

  thread drop_equipment_crate(var_02, var_03);
}

drop_equipment_crate(param_00, param_01) {
  var_02 = spawn("script_model", level.player.origin + (0, 0, 45));
  var_02 setModel("mil_grenade_box_dynamic");
  var_02 scripts\sp\utility::func_9196(3, 1, 1);
  var_02.dont_spawn_models = 1;
  var_02.script_noteworthy = param_00;
  var_02.var_EDE7 = param_01;
  var_02 thread lib_0B04::func_4842("equipment");
  var_02 thread lib_0B77::add_to_grenade_cache("axis");
  var_02 scripts\engine\utility::delaycall(0.05, ::physicslaunchserver, var_02.origin, anglesToForward(level.player.angles) * 250);
  var_02.var_99F7 linkto(var_02);
  var_03 = var_02.var_99F7;
  crate_waittill_delete(var_03);
  if(isDefined(var_03)) {
    var_03 notify("remove_pickup_cache");
    var_03 delete();
  }

  if(isDefined(var_02)) {
    var_02 delete();
  }
}

nanoshot_waittill_trigger_or_delete(param_00) {
  self endon("entitydeleted");
  param_00 waittill("trigger");
}

crate_waittill_delete(param_00) {
  self endon("entitydeleted");
  param_00 waittill("entitydeleted");
}

nanoshot_pickup_watcher() {
  if(!isDefined(level._meth_8580) || !isDefined(level._meth_8580["axis"])) {
    level._meth_8581["axis"] = 0;
    level._meth_8580["axis"] = [];
  }

  for(;;) {
    while(scripts\sp\utility::func_D0BD("nanoshot", 1)) {
      nanoshot_near_pickup_check();
      wait(0.15);
    }

    foreach(var_01 in level._meth_8580["axis"]) {
      if(isDefined(var_01) && var_01.classname == "weapon_nanoshot") {
        var_01.var_9027 makeusable();
      }
    }

    while(!scripts\sp\utility::func_D0BD("nanoshot", 1)) {
      nanoshot_near_pickup_check();
      wait(0.15);
    }

    foreach(var_01 in level._meth_8580["axis"]) {
      if(isDefined(var_01) && var_01.classname == "weapon_nanoshot") {
        var_01.var_9027 makeunusable();
      }
    }
  }
}

nanoshot_near_pickup_check() {
  var_00 = scripts\sp\utility::func_7CAF();
  if(!isDefined(var_00) || var_00 != "nanoshot") {
    return;
  }

  foreach(var_02 in level._meth_8580["axis"]) {
    if(!isDefined(var_02) || var_02.classname != "weapon_nanoshot") {
      continue;
    }

    if(distancesquared(var_02.origin, level.player.origin) > 1600) {
      continue;
    }

    var_03 = weaponmaxammo("nanoshot");
    if(scripts\sp\utility::func_7CB0() >= var_03) {
      continue;
    }

    level.player.var_110BE++;
    var_02 delete();
  }
}

spawn_specialist_crates() {
  var_00 = scripts\engine\utility::get_template_script_MAYBE();
  var_01 = 13;
  switch (var_00) {
    case "europa":
      lib_0B04::spawn_equipment_crate("helmet", (34469.1, -12214.8, -455.859), (0, 132, 0), 1);
      lib_0B04::spawn_equipment_crate("nanoshot", (34440, -12225, -455.859), (0, -64, 0), 3);
      break;

    case "phstreets":
      lib_0B04::spawn_equipment_crate("helmet", (50434.4, 29394.1, -34280.9), (0, 132, 0));
      lib_0B04::spawn_equipment_crate("nanoshot", (68113, 40290, -34416), (0, 274, 0), 2);
      break;

    case "titan":
      lib_0B04::spawn_equipment_crate("nanoshot", (-59090.7, -34205, -64624.4), (0, 132, 0), 3);
      lib_0B04::spawn_equipment_crate("nanoshot", (-47402.7, -39197.5, -64154.3), (0, 132, 0), 2);
      lib_0B04::spawn_equipment_crate("nanoshot", (-47482.1, -41287.1, -64375.9), (0, 132, 0), 3);
      lib_0B04::spawn_equipment_crate("helmet", (-47487.9, -41254.2, -64375.9), (0, 120, 0), 1);
      lib_0B04::spawn_equipment_crate("nanoshot", (-35701.4, -41712, -64787.9), (0, 132, 0), 2);
      lib_0B04::spawn_equipment_crate("nanoshot", (-34911.9, -42124.9, -64955.9), (0, -15, 0), 1);
      lib_0B04::spawn_equipment_crate("helmet", (-30218.4, -41231.9, -64988.4), (0, -15, 0), 1);
      lib_0B04::spawn_equipment_crate("nanoshot", (-29564.7, -42645, -64988.9), (0, 132, 0), 2);
      break;

    case "titanjackal":
      lib_0B04::spawn_equipment_crate("helmet", (41986.3, 75867.2, -64930.4), (0, 132, 0), 1);
      lib_0B04::spawn_equipment_crate("nanoshot", (41940.8, 74503.1, -64930.4), (0, 132, 0), 2);
      break;

    case "prisoner":
      lib_0B04::spawn_equipment_crate("helmet", (-4685, -14638, 585), (0, 0, 0), 1);
      lib_0B04::spawn_equipment_crate("helmet", (912.4, -9570.7, -1774.7), (7.38483, 270.432, -1.433), 1);
      break;

    case "heist":
      lib_0B04::spawn_equipment_crate("nanoshot", (-11407, 16389, -85536), (0, 270, 0), 2);
      break;

    case "yard":
      lib_0B04::spawn_equipment_crate("helmet", (385, 25919, 1856.14), (0, 0, 0), 1);
      lib_0B04::spawn_equipment_crate("nanoshot", (463, 25005, 2000.12), (0, 65, 0), 2);
      break;

    case "sa_assassination":
      lib_0B04::spawn_equipment_crate("helmet", (-160, -1326, -51 + var_01), (0, 59.9999, 0));
      break;

    case "sa_empambush":
      break;

    case "sa_moon":
      lib_0B04::spawn_equipment_crate("helmet", (1449.3, 628.471, 64.0938), (0, 345, 0));
      break;

    case "sa_vips":
      lib_0B04::spawn_equipment_crate("helmet", (-142, -1322, -79), (0, 183, 0));
      lib_0B04::spawn_equipment_crate("nanoshot", (-146, -1280, -79), (0, 194, 0));
      lib_0B04::spawn_equipment_crate("helmet", (4438, -907, 192), (0, 263, 0));
      lib_0B04::spawn_equipment_crate("helmet", (422, -423, -54), (0, 167, 0));
      lib_0B04::spawn_equipment_crate("helmet", (816, -1477.6, -142.906), (0, 183, 0));
      break;

    case "sa_wounded":
      lib_0B04::spawn_equipment_crate("nanoshot", (157, -177, -171), (0, 76, 0));
      lib_0B04::spawn_equipment_crate("helmet", (129, -175, -171), (0, 91, 0));
      break;
  }
}

move_specialist_crates() {
  wait(0.05);
  var_00 = scripts\engine\utility::get_template_script_MAYBE();
  switch (var_00) {
    case "europa":
      specialist_crate_move("helmet", (29209, -5997.5, -76), (29095, -7658, -53.8869));
      break;

    case "phstreets":
      specialist_crate_move("nanoshot", (52106, 30285, -34663), (52184.9, 29902.6, -34601), undefined, 3);
      specialist_crate_move("nanoshot", (57470, 32429, -34432), (57520.6, 32740.7, -34520.4));
      specialist_crate_move("helmet", (57457.5, 32408, -34432), (57520.6, 32779.3, -34520.2), undefined, 2);
      specialist_crate_move("helmet", (59335, 32407.5, -34408), (59472.9, 32698.5, -34407.9));
      specialist_crate_move("nanoshot", (59312, 32405.5, -34408), (59468.2, 32667.1, -34407.9), (0, 90, 0));
      specialist_crate_move("nanoshot", (64669.7, 40194.3, -34352), (65053.3, 40130.1, -34352.5));
      specialist_crate_move("helmet", (66061, 40092, -34216), (66015.1, 40111.5, -34212));
      specialist_crate_move("nanoshot", (65030.5, 38658.5, -34088.5), (64308.4, 38627.5, -34088));
      specialist_crate_move("nanoshot", (62835, 36424, -34073), (63063.1, 36480.7, -34078.1));
      specialist_crate_move("nanoshot", (69272, 43712, -34532), (69435.9, 43885.4, -34531.4));
      specialist_crate_move("helmet", (69281, 43690, -34532), (69412.3, 43873.3, -34531.4));
      break;

    case "moon_port":
      specialist_crate_move("helmet", (5773.65, 9054.83, -54584), (5714.62, 9173.35, -54583.9));
      specialist_crate_move("helmet", (9244.27, 9918.77, -54504), (9441.8, 10121.2, -54503.9));
      specialist_crate_move("nanoshot", (9021.34, 10880.6, -54335), (9064.3, 10664.3, -54333.9));
      break;

    case "prisoner":
      specialist_crate_move("nanoshot", (-1622.6, -13669.7, -1757), (-1238, -13988, -1685), undefined, 3);
      break;

    case "marsbase":
      specialist_crate_move("nanoshot", (29648, 18802, -11512), (31392, 18503.8, -11535.9));
      specialist_crate_move("helmet", (29680, 18794, -11512), (31382.9, 18477, -11535.9));
      break;

    case "yard":
      specialist_crate_move("nanoshot", (118.5, 19241.5, 702.5), (136, 19241.6, 702.6));
      break;
  }
}

delete_specialist_crates() {
  wait(0.05);
  var_00 = scripts\engine\utility::get_template_script_MAYBE();
  switch (var_00) {
    case "phstreets":
      specialist_crate_delete((55514, 28810, -34608.5));
      specialist_crate_delete((61964, 34582, -34184));
      specialist_crate_delete((61990, 34582, -34184));
      break;

    case "moon_port":
      specialist_crate_delete((5760.82, 9076.98, -54584));
      specialist_crate_delete((9047.96, 10888.6, -54335));
      specialist_crate_delete((9220.76, 9902.43, -54504));
      break;

    case "marsbase":
      specialist_crate_delete((31926, 20838, -11464));
      specialist_crate_delete((32854, 19813, -11316));
      specialist_crate_delete((32822, 19794, -11316));
      break;
  }
}

specialist_crate_move(param_00, param_01, param_02, param_03, param_04) {
  var_05 = (0, 0, 13);
  param_01 = param_01 + var_05;
  var_06 = scripts\engine\utility::getstructarray("equipment_pickup", "targetname");
  var_07 = scripts\engine\utility::getclosest(param_01, var_06);
  if(!isDefined(param_03)) {
    param_03 = var_07.angles;
  }

  if(!isDefined(param_04) && isDefined(var_07.var_EDE7)) {
    param_04 = var_07.var_EDE7;
  }

  var_08 = getEntArray("specialist_mode_only", "targetname");
  var_09 = sortbydistance(var_08, var_07.origin);
  var_0A = undefined;
  var_0B = undefined;
  foreach(var_0D in var_09) {
    if(!isDefined(var_0A) && var_0D.classname == "script_model") {
      var_0A = var_0D;
    } else if(!isDefined(var_0B) && var_0D.classname == "script_brushmodel") {
      var_0B = var_0D;
    }

    if(isDefined(var_0A) && isDefined(var_0B)) {
      break;
    }
  }

  if(isDefined(var_07.var_99F7.var_6698)) {
    foreach(var_10 in var_07.var_99F7.var_6698) {
      if(isDefined(var_10)) {
        var_10 delete();
      }
    }
  }

  var_07.var_99F7 notify("remove_pickup_cache");
  var_07.var_99F7 delete();
  var_0B delete();
  var_0A delete();
  var_07 = undefined;
  thread lib_0B04::spawn_equipment_crate(param_00, param_02, param_03, param_04);
}

specialist_crate_delete(param_00) {
  var_01 = (0, 0, 13);
  param_00 = param_00 + var_01;
  var_02 = scripts\engine\utility::getstructarray("equipment_pickup", "targetname");
  var_03 = scripts\engine\utility::getclosest(param_00, var_02);
  var_04 = getEntArray("specialist_mode_only", "targetname");
  var_05 = sortbydistance(var_04, var_03.origin);
  var_06 = undefined;
  var_07 = undefined;
  foreach(var_09 in var_05) {
    if(!isDefined(var_06) && var_09.classname == "script_model") {
      var_06 = var_09;
    } else if(!isDefined(var_07) && var_09.classname == "script_brushmodel") {
      var_07 = var_09;
    }

    if(isDefined(var_06) && isDefined(var_07)) {
      break;
    }
  }

  if(isDefined(var_03.var_99F7.var_6698)) {
    foreach(var_0C in var_03.var_99F7.var_6698) {
      if(isDefined(var_0C)) {
        var_0C delete();
      }
    }
  }

  var_03.var_99F7 notify("remove_pickup_cache");
  var_03.var_99F7 delete();
  var_07 delete();
  var_06 delete();
  var_03 = undefined;
}